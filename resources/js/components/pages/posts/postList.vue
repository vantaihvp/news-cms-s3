<template>
  <section>
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Danh sách chuyên mục</h2>
        </div>
        <div class="float-right">
          <div class="d-flex">
            <form method="get" class="form-inline mr-3" @submit.prevent="getResults(1)">
              <div class="input-group input-group">
                <input type="text" class="form-control" v-model="searchText" />
                <span class="input-group-append">
                  <button
                    type="button"
                    class="btn btn-danger"
                    v-if="searchText"
                    @click="resetData()"
                  >X</button>
                  <button type="submit" class="btn btn-primary">Tìm</button>
                </span>
              </div>
            </form>
            <div class="button-box">
              <router-link
                :to="{ name: 'category-create' }"
                class="btn btn-primary"
                v-if="this.$can('category-create')"
              >Thêm mới</router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none">
      <div class="card-body">
        <div class="error" v-if="error.message.length">
          <div class="alert alert-danger" role="alert">{{ error.message }}</div>
        </div>
        <div class="success" v-if="status === 'success'">
          <div class="alert alert-success" role="alert">{{ message }}</div>
        </div>
        <div class="table-responsive">
          <table class="table table-borderless table-striped">
            <thead>
              <tr>
                <th scope="col">Tiêu đề</th>
                <th scope="col">Mô tả</th>
                <th scope="col">Slug</th>
                <th scope="col" class="text-center">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="category in categories" :key="category.id">
                <td scope="col">{{category.title}}</td>
                <td scope="col">{{category.description}}</td>
                <td scope="col">{{category.slug}}</td>
                <td scope="col" class="text-center">
                  <router-link
                    :to="{
                      name: 'category-edit',
                      params: { id: category.id }
                    }"
                    v-if="$can('category-edit')"
                    class="btn btn-warning"
                  >
                    <i class="far fa-pencil"></i>
                  </router-link>
                  <button
                    class="btn btn-danger"
                    @click="deleteCategory(category.id)"
                    v-if="$can('category-delete')"
                  >
                    <i class="far fa-trash"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import toastr from "toastr";
import "toastr/build/toastr.min.css";
export default {
  props: {
    message: String,
    status: ""
  },
  data() {
    return {
      categories: {},
      searchText: "",
      error: {
        message: ""
      }
    };
  },
  created() {
    this.getResults();
  },
  methods: {
    resetData() {
      this.searchText = "";
      this.getResults();
    },
    getResults() {
      let paramsData = {};
      if (this.searchText) {
        paramsData["s"] = this.searchText;
      }
      axios
        .get("auth/categories/get-categories", { params: paramsData })
        .then(data => {
          this.categories = data.data.success;
          console.log(data.data.success);
        });
    },
    deleteCategory(categoryId) {
      var result = confirm("Bán muốn xóa chuyên mục?");
      if (result) {
        axios
          .delete("/auth/categories/" + categoryId)
          .then(rs => {
            toastr.success("Thành công", "Xóa thành công");
            this.getResults();
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  }
};
</script>

<style></style>
