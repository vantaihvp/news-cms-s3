<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Sửa chuyên mục #{{title}}</h2>
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
        <div class="card shadow-none">
          <div class="card-body" id="user-create">
            <div class="error" v-if="errors.length">
              <div class="alert alert-danger" role="alert">
                <span v-for="(err, index) in errors" :key="index">{{ err }}</span>
                <hr />
              </div>
            </div>
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
                  <textarea class="form-control" v-model="description" name="description" rows="3"></textarea>
                </div>
              </div>
              <div class="col-md-12">
                <search-engine-optimize
                  ref="seoForm"
                  v-if="seo_id"
                  :id="seo_id"
                  :obj_title="title"
                  :obj_description="description"
                />
              </div>
            </div>
          </div>
          <div class="card-footer">
            <div class="col-xs-12 col-sm-12 col-md-12 text-right">
              <button type="button" class="btn btn-primary" @click.prevent="updateData">Cập nhật</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import SearchEngineOptimize from "./../widgets/SearchEngineOptimize";
import toastr from "toastr";
import "toastr/build/toastr.min.css";
export default {
  props: ["id"],
  components: {
    SearchEngineOptimize
  },
  data() {
    return {
      categories: {},
      parent_id: 0,
      title: "",
      description: "",
      slug: "",
      seo_id: "",
      errors: []
    };
  },
  methods: {
    getTaxonomy() {
      axios.get("auth/categories/get-categories").then(data => {
        this.categories = data.data.success.filter(item => item.id != this.id);
      });
    },
    getData() {
      axios
        .get("/auth/categories/" + this.id)
        .then(response => {
          let data = response.data.success;
          this.title = data.title;
          this.slug = data.slug;
          this.parent_id = data.parent_id;
          this.description = data.description;
          this.seo_id = data.seo_id;
        })
        .catch(error => {
          console.log(error);
        });
    },
    updateData() {
      let dataForm = {
        title: this.title,
        slug: this.slug,
        parent_id: this.parent_id,
        description: this.description,
        seo_id: this.seo_id
      };
      let rs_seo = this.$refs.seoForm.updateSeo();
      rs_seo.then(rs => {
        axios
          .put("auth/categories/" + this.id, dataForm)
          .then(rs => {
            toastr.success("Thành công", "Cập nhật thành công");
            this.$router.push({
              path: "/admin/categories"
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
            toastr.error("Lỗi", "Cập nhật không thành công");
          });
      });
    }
  },
  created() {
    this.getData();
    this.getTaxonomy();
  }
};
</script>

<style></style>
