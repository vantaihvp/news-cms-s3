<template>
  <section class="slider-list">
    <div class="card card-outline card-primary shadow-none card-posts">
      <div class="card-header">
        <div class="float-left">
          <h3 class="card-title">
            <i class="fas fa-edit"></i>
            Danh sách slider
          </h3>
        </div>
        <div class="card-tools">
          <router-link :to="{ name: 'slider.create' }" class="btn btn-primary">Thêm mới</router-link>
        </div>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-borderless table-striped table-data">
            <thead class="thead-light">
              <tr>
                <th scope="col" class="col-thumbnail">Thumbnail</th>
                <th scope="col">Tiêu đề</th>
                <th scope="col">Danh mục</th>
                <th scope="col">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="slider in sliders.data" :key="slider.id">
                <td scope="col">
                  <div class="col-img">
                    <img :src="slider.thumbnail" class="img-thumbnail" />
                  </div>
                </td>
                <td scope="col">{{ slider.title }}</td>
                <td scope="col">{{ slider.category }}</td>
                <td style="width: 100px">
                  <div style="width: 100px">
                    <router-link
                      :to="{
                        name: 'slider.edit',
                        params: { id: slider.id }
                    }"
                      class="btn btn-warning"
                    >
                      <i class="far fa-pencil"></i>
                    </router-link>
                    <button class="btn btn-danger" @click="deleteSlider(slider.id)">Xóa</button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="card-footer">
        <pagination :data="sliders" @pagination-change-page="getData" :limit="4"></pagination>
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
      sliders: {}
    };
  },
  created() {
    this.getData(1);
  },
  methods: {
    getData(page) {
      let paramsData = {};
      paramsData.paginate = 1;
      if (typeof page === "undefined") {
        paramsData["page"] = 1;
      } else {
        paramsData["page"] = page;
      }
      axios.get("auth/slider-banner", { params: paramsData }).then(data => {
        this.sliders = data.data.success;
      });
    },
    deleteSlider(id) {
      var result = confirm("Bán muốn xóa bài viết này?");
      if (result) {
        axios
          .delete("/auth/slider-banner/" + id)
          .then(rs => {
            toastr.success("Thành công", "Xóa thành công");
            this.getData(1);
          })
          .catch(error => {
            console.log(error);
          });
      }
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
