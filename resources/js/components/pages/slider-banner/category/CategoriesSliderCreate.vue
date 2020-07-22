<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm Danh mục slider</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link :to="{ name: 'categoriesslider.list' }" class="btn btn-primary">Danh sách</router-link>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card shadow-none border-0">
          <div class="card-body" id="user-create">
            <div class="error" v-if="errors.length">
              <div class="alert alert-danger" role="alert">
                <span v-for="(err, index) in errors" :key="index">{{ err }}</span>
                <hr />
              </div>
            </div>
            <form action method="POST" @submit.prevent="submitCategorySlider">
              <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label class="lable-required">Tiêu đề:</label>
                    <input type="text" v-model="title" name="title" class="form-control" required />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Mô tả</label>
                    <textarea
                      class="form-control"
                      v-model="description"
                      name="description"
                      rows="3"
                    ></textarea>
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 text-right">
                  <button type="submit" class="btn btn-primary">Thêm</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import toastr from "toastr";
import "toastr/build/toastr.min.css";
export default {
  props: {
    id: {
      type: [String, Number]
    }
  },
  data() {
    return {
      title: "",
      description: "",
      errors: []
    };
  },
  methods: {
    getData(id) {
      if (id) {
        axios
          .get("auth/category-slider/" + id)
          .then(rs => {
            let data = rs.data.success;
            this.title = data.title;
            this.description = data.description;
          })
          .catch(error => {
            toastr.error("Lỗi!", "Load Data không thành công");
          });
      }
    },
    submitCategorySlider(event) {
      let dataForm = {
        title: this.title,
        description: this.description
      };
      if (this.id) {
        axios
          .put("/auth/category-slider/" + this.id, dataForm)
          .then(rs => {
            toastr.success("Thành công", "Chỉnh sửa thành công");
            this.$router.push({
              path: "/admin/categoy-slider"
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
            console.log(error.response.data.errors);
            toastr.error("Lỗi!", "Chỉnh sửa không thành công");
          });
      } else {
        axios
          .post("auth/category-slider", dataForm)
          .then(rs => {
            toastr.success("Thành công", "Thêm thành công");
            this.$router.push({
              path: "/admin/categoy-slider"
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
            toastr.error("Lỗi", "Thêm không thành công");
          });
      }
    }
  },
  created() {
    this.getData(this.id);
  }
};
</script>

<style></style>
