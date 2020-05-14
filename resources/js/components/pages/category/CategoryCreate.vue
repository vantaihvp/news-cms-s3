<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm chuyên mục</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link :to="{ name: 'category-list' }" class="btn btn-primary">Danh sách</router-link>
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
            <form action method="POST" @submit.prevent="submitCreateCategory">
              <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label class="lable-required">Tiêu đề:</label>
                    <input type="text" v-model="title" name="title" class="form-control" required />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Slug:</label>
                    <input type="text" v-model="slug" name="slug" class="form-control" />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Chuyên mục cha:</label>
                    <select class="form-control" v-model="parent_id" name="parent_id">
                      <option value="0">--Trống--</option>
                      <option
                        v-for="category in categories"
                        :key="category.id"
                        v-bind:value="category.id"
                      >{{category.title}}</option>
                    </select>
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Mô tả thêm</label>
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
  data() {
    return {
      title: "",
      slug: "",
      parent_id: 0,
      categories: {},
      description: "",
      errors: []
    };
  },
  methods: {
    getTaxonomy() {
      axios.get("auth/categories/get-categories").then(data => {
        this.categories = data.data.success;
      });
    },
    submitCreateCategory(event) {
      let dataForm = {
        title: this.title,
        slug: this.slug,
        parent_id: this.parent_id,
        description: this.description
      };
      console.log(dataForm);
      axios
        .post("auth/categories", dataForm)
        .then(rs => {
          toastr.success("Thành công", "Thêm thành công");
          this.$router.push({
            path: "/admin/categories"
          });
        })
        .catch(error => {
          this.errors = error.response.data.errors;
          toastr.success("Lỗi", "Thêm không thành công");
        });
    }
  },
  created() {
    this.getTaxonomy();
  }
};
</script>

<style></style>
