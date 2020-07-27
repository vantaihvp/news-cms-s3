<template>
  <section class="post-list">
    <div class="card card-outline card-primary shadow-none card-posts">
      <div class="card-header">
        <div class="float-left">
          <h3 class="card-title">
            <i class="fas fa-edit"></i>
            Danh sách bài viết được quan tâm
          </h3>
        </div>
        <div class="card-tools">
          <button class="btn btn-primary btn-create" @click="openModal">Thêm mới</button>
        </div>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-borderless table-striped table-data">
            <thead class="thead-light">
              <tr>
                <th scope="col" class="col-thumbnail">Thumbnail</th>
                <th scope="col">Tiêu đề</th>
                <th scope="col">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="post in posts.data" :key="post.id">
                <td scope="col">
                  <div class="col-img">
                    <img :src="post.thumbnail_url" class="img-thumbnail" />
                  </div>
                </td>
                <td scope="col">{{ post.title }}</td>
                <td>
                  <button class="btn btn-danger" @click="deletePost(post.id)">Xóa</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="card-footer">
        <pagination :data="posts" @pagination-change-page="getData" :limit="4"></pagination>
      </div>
    </div>
    <!-- Modal -->
    <div
      class="modal fade"
      id="popularModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="popularModalLabel"
      aria-hidden="true"
    >
      <form @submit.prevent="createPopular">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="popularModalLabel">Thêm bài viết nổi bật</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <multiselect
                v-model="postsValue"
                :options="postsSearch"
                label="title"
                track-by="id"
                :show-no-results="false"
                placeholder="Nhập tên bài viết"
                @search-change="getPosts"
              ></multiselect>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
              <button type="submit" class="btn btn-primary">Thêm</button>
            </div>
          </div>
        </div>
      </form>
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
    status: "",
  },
  data() {
    return {
      posts: {},
      postsValue: null,
      postsSearch: [],
    };
  },
  created() {
    this.getData(1);
  },
  methods: {
    openModal() {
      this.postsValue = null;
      $("#popularModal").modal("show");
    },
    getPosts(query) {
      if (query.length > 5) {
        let paramsData = {
          s: query,
        };
        axios.get("auth/posts", { params: paramsData }).then((data) => {
          this.postsSearch = data.data.success.data;
        });
      }
    },
    getData(page) {
      let paramsData = {};
      if (typeof page === "undefined") {
        paramsData["page"] = 1;
      } else {
        paramsData["page"] = page;
      }
      axios.get("auth/posts-popular", { params: paramsData }).then((data) => {
        this.posts = data.data.success;
      });
    },
    createPopular() {
      let dataForm = {
        id: this.postsValue.id,
      };
      axios
        .post("auth/posts-popular", dataForm)
        .then((response) => {
          $("#popularModal").modal("hide");
          toastr.success("Thành công", "Thêm thành công");
          this.getData(1);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    deletePost(id) {
      var result = confirm("Bán muốn xóa bài viết này?");
      if (result) {
        axios
          .delete("/auth/posts-popular/" + id)
          .then((rs) => {
            toastr.success("Thành công", "Xóa thành công");
            this.getData(1);
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
    restorePost(id) {
      var result = confirm("Bán muốn khôi phục bài viết này?");
      let data = {
        id: id,
      };
      if (result) {
        axios
          .post("/auth/posts/restore/", data)
          .then((rs) => {
            toastr.success("Thành công", "Khôi phục thành công");
            this.getData(1);
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
  },
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
    .table-data {
      tr {
        .col-img {
          width: 70px;
        }
        &:hover {
          .row-actions {
            display: block;
          }
        }
      }
    }
  }
  .pagination {
    margin-bottom: 0px;
  }
  .popular {
    i {
      cursor: pointer;
      font-size: 20px;
      color: #09c;
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
    object-fit: cover;
  }
  .col-action-inner {
    width: 120px;
  }
}
</style>
