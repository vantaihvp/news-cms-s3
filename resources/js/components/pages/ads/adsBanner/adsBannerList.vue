<template>
  <section>
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Danh sách Banner</h2>
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
                :to="{ name: 'ads-banner-create' }"
                class="btn btn-primary"
                v-if="this.$can('ads-banner-create')"
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
          <table class="table table-bordered table-striped">
            <thead>
              <tr>
                <th scope="col">ID</th>
                <th scope="col">Title</th>
                <th scope="col">Size</th>
                <th scope="col">Status</th>
                <th scope="col">Enable stats</th>
                <th scope="col" class="text-center">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="banner in adsBanners.data" :key="banner.id">
                <td scope="col">{{banner.id}}</td>
                <td scope="col">{{banner.title}}</td>
                <td scope="col">{{banner.width}}x{{banner.height}}</td>
                <td scope="col">{{banner.status}}</td>
                <td scope="col">{{banner.enable_stats}}</td>
                <td scope="col" class="text-center">
                  <router-link
                    :to="{
                        name: 'ads-banner-edit',
                        params: { id: banner.id }
                    }"
                    v-if="$can('ads-banner-edit')"
                    class="btn btn-warning"
                  >
                    <i class="far fa-pencil"></i>
                  </router-link>
                  <button
                    class="btn btn-danger"
                    @click="deleteBanner(banner.id)"
                    v-if="$can('ads-banner-delete')"
                  >
                    <i class="far fa-trash"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
          <pagination :data="adsBanners" @pagination-change-page="getResults"></pagination>
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
      adsBanners: {},
      searchText: "",
      error: {
        message: ""
      }
    };
  },
  created() {
    this.getResults(1);
  },
  methods: {
    resetData() {
      this.searchText = "";
      this.getResults(1);
    },
    getResults(page) {
      let paramsData = {};
      if (typeof page === "undefined") {
        paramsData["page"] = 1;
      } else {
        paramsData["page"] = page;
      }
      if (this.searchText) {
        paramsData["s"] = this.searchText;
      }
      axios.get("auth/ads-banner", { params: paramsData }).then(data => {
        this.adsBanners = data.data.success;
      });
    },
    deleteBanner(bannerId) {
      var result = confirm("Bán muốn xóa?");
      if (result) {
        axios
          .delete("/auth/ads-banner/" + bannerId)
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
