<template>
  <section class="post-list">
    <div class="card card-outline card-info shadow-none card-search">
      <div class="card-body">
        <form @submit.prevent="getData(1)">
          <div class="row">
            <div class="col-md-2">
              <div class="form-group">
                <small class="text-muted">Thời gian</small>
                <date-picker
                  v-model="dateTime"
                  type="date"
                  :format="momentFormat"
                  range
                  placeholder="Chọn thời gian"
                ></date-picker>
              </div>
            </div>
            <div class="col-md-2">
              <div class="form-group">
                <small class="text-muted">Chuyên mục</small>
                <multiselect
                  v-model="selectedCategories"
                  label="title"
                  track-by="id"
                  placeholder="Chuyên mục"
                  open-direction="bottom"
                  :options="categoriesOptions"
                  :multiple="true"
                  :searchable="true"
                  :loading="isLoadingCategory"
                  :internal-search="false"
                  :clear-on-select="true"
                  :close-on-select="true"
                  :options-limit="300"
                  :limit="5"
                  :max-height="600"
                  :show-no-results="false"
                  :hide-selected="true"
                  @search-change="getCategories"
                ></multiselect>
              </div>
            </div>
            <div class="col-md-2">
              <div class="form-group">
                <small class="text-muted">Tác giả</small>
                <multiselect
                  v-model="selectedAuthors"
                  label="name"
                  track-by="id"
                  placeholder="Tác giả"
                  open-direction="bottom"
                  :options="authorOptions"
                  :multiple="true"
                  :searchable="true"
                  :loading="isLoadingAuthor"
                  :internal-search="false"
                  :clear-on-select="true"
                  :close-on-select="true"
                  :options-limit="300"
                  :limit="5"
                  :max-height="600"
                  :show-no-results="false"
                  :hide-selected="true"
                  @search-change="getAuthors"
                ></multiselect>
              </div>
            </div>
            <div class="col-md-2">
              <div class="form-group">
                <small class="text-muted">Bài viết của</small>
                <select class="form-control" v-model="filter_author">
                  <option v-bind:value="0">Tất cả</option>
                  <option v-bind:value="this.$auth.user().user.id">Của tôi</option>
                </select>
              </div>
            </div>
            <div class="col-md-2">
              <div class="form-group">
                <small class="text-muted">Trạng thái</small>
                <select class="form-control" v-model="post_status">
                  <option
                    v-for="option in statusOptions"
                    :key="option.value"
                    v-bind:value="option.value"
                  >{{ option.text }}</option>
                </select>
              </div>
            </div>
            <div class="col-md-2">
              <small class="text-muted">Tiêu đề</small>
              <div class="input-group input-group">
                <input type="text" class="form-control" v-model="searchText" />
                <span class="input-group-append">
                  <button type="button" class="btn btn-danger" @click="resetData()">X</button>
                  <button type="submit" class="btn btn-primary">Tìm</button>
                </span>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    <div class="card card-outline card-primary shadow-none card-posts">
      <div class="card-header">
        <div class="float-left">
          <h3 class="card-title">
            <i class="fas fa-edit"></i>
            Danh sách bài viết ({{posts.total}})
          </h3>
        </div>
        <div class="card-tools">
          <router-link
            :to="{ name: 'post-create' }"
            class="btn btn-primary"
            v-if="this.$can('post-create')"
          >Thêm mới</router-link>
        </div>
      </div>
      <div class="card-body">
        <div class="error" v-if="error.message.length">
          <div class="alert alert-danger" role="alert">{{ error.message }}</div>
        </div>
        <div class="success" v-if="status === 'success'">
          <div class="alert alert-success" role="alert">{{ message }}</div>
        </div>
        <div class="table-responsive">
          <table class="table table-borderless table-striped table-data">
            <thead>
              <tr>
                <th scope="col" class="col-thumbnail">Thumbnail</th>
                <th scope="col">Tiêu đề</th>
                <th scope="col">Tác giả</th>
                <th scope="col">Chuyên mục</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Date</th>
                <th scope="col" class="text-center">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="post in posts.data" :key="post.id">
                <td scope="col">
                  <img :src="post.thumbnail_url" class="img-thumbnail" />
                </td>
                <td scope="col">{{ post.title }}</td>
                <td scope="col">{{post.user_name}}</td>
                <td scope="col">{{post.categories_name}}</td>
                <td scope="col">{{post.status}}</td>
                <td scope="col">{{post.date}}</td>
                <td scope="col" class="text-center">
                  <router-link
                    :to="{
                        name: 'post-edit',
                        params: { id: post.id }
                    }"
                    v-if="is_edit_post(post)"
                    class="btn btn-warning"
                  >
                    <i class="far fa-pencil"></i>
                  </router-link>
                  <button
                    class="btn btn-danger"
                    @click="deletePost(post.id)"
                    v-if="is_delete_post(post)"
                  >
                    <i class="far fa-trash"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <pagination :data="posts" @pagination-change-page="getData"></pagination>
      </div>
    </div>
  </section>
</template>

<script>
import toastr from "toastr";
import "toastr/build/toastr.min.css";
var moment = require("moment");
export default {
  props: {
    message: String,
    status: ""
  },
  data() {
    return {
      posts: {},
      filter_author: 0,
      statusOptions: [
        { text: "Tất cả", value: 0 },
        { text: "Xuất bản", value: "publish" },
        { text: "Chờ duyệt", value: "pending" },
        { text: "Bản nháp", value: "draft" },
        { text: "Riêng tư", value: "private" }
      ],
      post_status: 0,
      dateTime: [],
      selectedAuthors: [],
      isLoadingAuthor: false,
      authorOptions: [],
      selectedCategories: [],
      isLoadingCategory: false,
      categoriesOptions: [],
      searchText: "",
      error: {
        message: ""
      },
      momentFormat: {
        // Date to String
        stringify: date => {
          return date ? moment(date).format("DD/MM/YYYY") : "";
        },
        // String to Date
        parse: value => {
          return value ? moment(value, "DD/MM/YYYY").toDate() : null;
        }
      }
    };
  },
  created() {
    this.getData(1);
  },
  methods: {
    resetData() {
      this.searchText = "";
      this.selectedAuthors = [];
      this.dateTime = "";
      this.filter_author = 0;
      this.post_status = 0;
      this.selectedCategories = [];
      this.getData(1);
    },
    getData(page) {
      let paramsData = {};
      let authorsID = [];
      let dateTime = {};
      this.selectedAuthors.forEach(e => {
        authorsID.push(e.id);
      });
      if (typeof page === "undefined") {
        paramsData["page"] = 1;
      } else {
        paramsData["page"] = page;
      }
      if (this.searchText) {
        paramsData.s = this.searchText;
      }
      if (authorsID.length) {
        paramsData.author_id = authorsID;
      }
      if (this.dateTime) {
        paramsData.dateTime = this.dateTime;
      }
      if (this.filter_author) {
        paramsData.author_id = [this.filter_author];
      }
      if (this.post_status) {
        paramsData.status = this.post_status;
      }
      if (this.selectedCategories.length) {
        let categories = [];
        this.selectedCategories.forEach(e => {
          categories.push(e.id);
        });
        paramsData.categories = categories;
      }
      axios.get("auth/posts", { params: paramsData }).then(data => {
        this.posts = data.data.success;
      });
    },
    deletePost(id) {
      var result = confirm("Bán muốn xóa bài viết này?");
      if (result) {
        axios
          .delete("/auth/posts/" + id)
          .then(rs => {
            toastr.success("Thành công", "Xóa thành công");
            this.getData(1);
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    getAuthors(query) {
      if (query.length > 2) {
        this.isLoadingAuthor = true;
        let paramsData = {};
        paramsData["s"] = query;
        paramsData["per_page"] = 100;
        axios.get("auth/users", { params: paramsData }).then(response => {
          this.authorOptions = response.data.success.data;
          this.isLoadingAuthor = false;
        });
      }
    },
    getCategories(query) {
      if (query.length > 2) {
        this.isLoadingCategory = true;
        let paramsData = {};
        paramsData.s = query;
        paramsData.sort = 0;
        axios
          .get("auth/categories/get-categories", { params: paramsData })
          .then(response => {
            this.categoriesOptions = response.data.success;
            this.isLoadingCategory = false;
          });
      }
    },
    is_edit_post(post) {
      if (post.status == "publish") {
        if (this.$can("publish-post-edit")) {
          return true;
        }
      } else if (this.$can("other-post-edit")) {
        return true;
      } else if (
        this.$can("post-edit") &&
        post.user_id == this.$auth.user().user.id
      ) {
        return true;
      }
      return false;
    },
    is_delete_post(post) {
      if (post.status == "publish") {
        if (this.$can("publish-post-delete")) {
          return true;
        }
      } else if (this.$can("other-post-delete")) {
        return true;
      } else if (
        this.$can("post-delete") &&
        post.user_id == this.$auth.user().user.id
      ) {
        return true;
      }
      return false;
    }
  }
};
</script>

<style lang="scss">
.post-list {
  .card-search {
    .mx-datepicker-range {
      width: 100%;
    }
    .multiselect__tags {
      min-height: 37px;
      border: 1px solid #ced4da;
      .multiselect__placeholder {
        padding-top: 0px;
        margin-bottom: 0px;
      }
    }
    .form-group {
      margin-bottom: 0px;
    }
  }
  .card-posts {
    .card-title {
      line-height: 36px;
    }
  }
}
.table-data {
  .col-thumbnail {
    width: 70px;
  }
  .img-thumbnail {
    height: 70px;
    width: 70px;
  }
}
</style>
