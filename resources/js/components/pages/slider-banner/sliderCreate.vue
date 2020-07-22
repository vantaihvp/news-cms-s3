<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm slider</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link :to="{ name: 'slider.list' }" class="btn btn-primary">Danh sách</router-link>
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
            <form action method="POST" @submit.prevent="submitSlider">
              <div class="row">
                <div class="col-md-9">
                  <div class="form-group">
                    <label class="lable-required">Tiêu đề:</label>
                    <input type="text" v-model="title" name="title" class="form-control" required />
                  </div>
                  <div class="form-group">
                    <label class="lable-required">Url:</label>
                    <input type="url" v-model="url" name="title" class="form-control" required />
                  </div>
                  <div class="form-group">
                    <label for="slider_category_id">Danh mục</label>
                    <select
                      class="form-control"
                      name="slider_category_id"
                      id="slider_category_id"
                      v-model="slider_category_id"
                    >
                      <option
                        v-for="cat in categories"
                        :key="cat.id"
                        v-bind:value="cat.id"
                      >{{cat.title}}</option>
                    </select>
                  </div>
                </div>
                <div class="col-md-3">
                  <img
                    src="/images/admin/placeholder.png"
                    class="img-fluid img-thumbnail"
                    v-if="thumbnail.url == ''"
                  />
                  <img :src="thumbnail.url" class="img-fluid img-thumbnail" v-if="thumbnail.url" />
                  <ThumbnailModal
                    v-model="thumbnail.id"
                    id="highlight"
                    key="highlight"
                    @changeThumbnail="changeThumbnail($event)"
                  />
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 text-right">
                  <button type="submit" class="btn btn-primary" v-if="!id">Thêm</button>
                  <button type="submit" class="btn btn-primary" v-if="id">Lưu</button>
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
      url: "",
      description: "",
      categories: {},
      slider_category_id: "",
      errors: [],
      thumbnail: {
        id: "",
        url: ""
      }
    };
  },
  methods: {
    getData(id) {
      if (id) {
        axios
          .get("auth/slider-banner/" + id)
          .then(rs => {
            let data = rs.data.success;
            this.title = data.title;
            this.url = data.url;
            this.slider_category_id = data.slider_category_id;
            this.thumbnail.url = data.thumbnail;
          })
          .catch(error => {
            toastr.error("Lỗi!", "Load Data không thành công");
          });
      }
    },
    submitSlider(event) {
      let dataForm = {
        title: this.title,
        url: this.url,
        thumbnail_id: this.thumbnail.id,
        slider_category_id: this.slider_category_id,
        description: this.description
      };
      if (this.id) {
        axios
          .put("/auth/slider-banner/" + this.id, dataForm)
          .then(rs => {
            toastr.success("Thành công", "Chỉnh sửa thành công");
            this.$router.push({
              path: "/admin/slider-banner"
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
            console.log(error.response.data.errors);
            toastr.error("Lỗi!", "Chỉnh sửa không thành công");
          });
      } else {
        axios
          .post("auth/slider-banner", dataForm)
          .then(rs => {
            toastr.success("Thành công", "Thêm thành công");
            this.$router.push({
              path: "/admin/slider-banner"
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
            toastr.error("Lỗi", "Thêm không thành công");
          });
      }
    },
    changeThumbnail(obj) {
      this.thumbnail.url = obj.url;
      this.thumbnail.id = obj.id;
    },
    getCategories() {
      axios.get("auth/category-slider").then(data => {
        this.categories = data.data.success;
      });
    }
  },
  created() {
    this.getData(this.id);
    this.getCategories();
  }
};
</script>

<style></style>
