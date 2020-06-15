<template>
  <div class="ads-banner-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm banner</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link :to="{ name: 'ads-banner-list' }" class="btn btn-primary">Danh sách</router-link>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-4">
        <div class="card border-0">
          <div class="card-body" id="ads-banner-create">
            <div class="error" v-if="errors.length">
              <div class="alert alert-danger" role="alert">
                <span v-for="(err, index) in errors" :key="index">{{ err }}</span>
                <hr />
              </div>
            </div>
            <div class="form-group">
              <label class="lable-required">Title:</label>
              <input type="text" v-model="title" name="tieu_de" class="form-control" required />
            </div>
            <div class="form-group">
              <label>Status</label>
              <select class="form-control" v-model="status">
                <option value="active">Active</option>
                <option value="expired">Expired</option>
                <option value="draft">Draft</option>
                <option value="review">Pending Review</option>
                <option value="on-hold">On Hold</option>
              </select>
            </div>
            <div class="form-group">
              <label>Url</label>
              <input type="url" class="form-control" v-model="url" />
            </div>
            <div class="form-group">
              <label for>Target</label>
              <select class="form-control" v-model="target">
                <option value="_blank">_blank, Load in a new window.</option>
                <option value="_self">_self, Load in the same frame as it was clicked.</option>
                <option value="_parent">_parent, Load in the parent frameset.</option>
                <option value="_top">_top, Load in the full body of the window.</option>
              </select>
            </div>
            <div class="form-group">
              <label for>Banner Alignment</label>
              <select class="form-control" v-model="align">
                <option value="left">Left</option>
                <option value="center">Center</option>
                <option value="right">Right</option>
              </select>
            </div>
            <div class="form-group">
              <label for>Enable stats</label>
              <select class="form-control" v-model="enable_stats">
                <option value="1">True</option>
                <option value="0">False</option>
              </select>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-8">
        <div class="card border-0">
          <div class="card-body">
            <div class="row">
              <div class="col-6">
                <div class="form-group">
                  <label for>Width</label>
                  <input
                    type="number"
                    class="form-control"
                    v-model="width"
                    aria-describedby="helpId"
                  />
                </div>
              </div>
              <div class="col-6">
                <div class="form-group">
                  <label for>Height</label>
                  <input
                    type="number"
                    class="form-control"
                    v-model="height"
                    aria-describedby="helpId"
                  />
                </div>
              </div>
            </div>
            <div class="form-group">
              <label>Banner Content</label>
              <textarea class="form-control" v-model="banner_content" rows="3"></textarea>
              <small class="help-text">Banner HTML content</small>
            </div>
            <div class="review" v-html="banner_content"></div>
          </div>
          <div class="card-footer text-right">
            <button
              class="btn btn-primary"
              type="button"
              v-if="id"
              @click.prevent="submitFormBanner"
            >Lưu</button>
            <button
              class="btn btn-primary"
              type="button"
              v-else
              @click.prevent="submitFormBanner"
            >Thêm</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    id: {
      type: [String, Number]
    }
  },
  data() {
    return {
      title: "",
      status: "draft",
      url: "",
      target: "_blank",
      align: "left",
      enable_stats: "0",
      banner_content: "",
      width: 300,
      height: 300,
      roles_data: [],
      errors: []
    };
  },
  methods: {
    getData(id) {
      if (id) {
        axios
          .get("auth/ads-banner/" + id)
          .then(rs => {
            let data = rs.data.success;
            this.title = data.title;
            this.status = data.status;
            this.url = data.url;
            this.target = data.target;
            this.align = data.align;
            this.enable_stats = data.enable_stats;
            this.width = data.width;
            this.height = data.height;
            this.banner_content = data.banner_content;
          })
          .catch(error => {});
      }
    },
    submitFormBanner() {
      let dataForm = {
        title: this.title,
        status: this.status,
        url: this.url,
        target: this.target,
        align: this.align,
        enable_stats: this.enable_stats,
        banner_content: this.banner_content,
        width: this.width,
        height: this.height
      };
      if (this.id) {
        axios
          .put("/auth/ads-banner/" + this.id, dataForm)
          .then(rs => {
            toastr.success("Thành công", "Chỉnh sửa thành công");
            this.$router.push({
              path: "/admin/ads-banner"
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
            console.log(error.response.data.errors);
            toastr.error("Lỗi!", "Chỉnh sửa không thành công");
          });
      } else {
        axios
          .post("auth/ads-banner", dataForm)
          .then(rs => {
            this.$router.push({
              path: "/admin/ads-banner",
              params: { message: "Thêm thành công" }
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
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
