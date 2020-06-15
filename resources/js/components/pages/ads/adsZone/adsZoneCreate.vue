<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm Zone</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link :to="{ name: 'ads-zone-list' }" class="btn btn-primary">Danh sách</router-link>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-4">
        <div class="card border-0">
          <div class="card-body" id="zone-create">
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
                <option value="draft">Draft</option>
                <option value="on-hold">On Hold</option>
              </select>
            </div>
            <div class="form-group">
              <label for="description">Description</label>
              <textarea
                class="form-control"
                name="description"
                id="description"
                rows="3"
                v-model="description"
              ></textarea>
            </div>
            <div class="form-group">
              <label>Campaigns</label>
              <multiselect
                v-model="campaigns_id"
                label="title"
                track-by="id"
                placeholder="Nhập để tìm"
                open-direction="bottom"
                :options="campaignOptions"
                :multiple="false"
                :searchable="true"
                :loading="isLoadingCampaign"
                :internal-search="true"
                :clear-on-select="true"
                :close-on-select="true"
                :options-limit="300"
                :max-height="600"
                :show-no-results="false"
                :hide-selected="true"
                @search-change="getCampaign"
              ></multiselect>
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
              <label>Banner List</label>
              <multiselect
                v-model="banner_id"
                label="title"
                track-by="id"
                placeholder="Nhập để tìm"
                open-direction="bottom"
                :options="bannerOptions"
                :multiple="true"
                :searchable="true"
                :loading="isLoadingBanner"
                :internal-search="true"
                :clear-on-select="true"
                :close-on-select="true"
                :options-limit="300"
                :max-height="600"
                :show-no-results="false"
                :hide-selected="true"
                @search-change="getBanner"
              ></multiselect>
            </div>
            <!-- <div class="review" v-html="banner_content"></div> -->
            <div class="form-group">
              <label for="ramdon">Ramdom</label>
              <select class="form-control" name="ramdon" id="ramdon" v-model="random">
                <option value="1">Yes</option>
                <option value="0">No</option>
              </select>
              <small class="help-text">Load banners in random order.</small>
            </div>
          </div>
          <div class="card-footer text-right">
            <button
              class="btn btn-primary"
              type="button"
              v-if="id"
              @click.prevent="submitFormZone"
            >Lưu</button>
            <button
              class="btn btn-primary"
              type="button"
              v-else
              @click.prevent="submitFormZone"
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
      description: "",
      campaigns_id: [],
      width: 300,
      height: 300,
      banner_id: [],
      random: 0,
      bannerOptions: [],
      isLoadingBanner: false,
      selectedCampaign: [],
      campaignOptions: [],
      isLoadingCampaign: false,
      errors: []
    };
  },
  methods: {
    getData(id) {
      if (id) {
        axios
          .get("auth/ads-zone/" + id)
          .then(rs => {
            let data = rs.data.success;
            this.title = data.title;
            this.status = data.status;
            this.description = data.description;
            this.width = data.width;
            this.height = data.height;
            this.random = data.random;
            this.getBannerOption(data.banner_id);
          })
          .catch(error => {});
      }
    },
    getBannerOption(arr_banners) {
      let banners = JSON.parse(arr_banners);
      banners.forEach(el => {
        axios.get("/auth/ads-banner/" + el).then(rs => {
          this.banner_id.push({
            id: rs.data.success.id,
            title: rs.data.success.title
          });
        });
      });
    },
    getBanner(query) {
      if (query.length >= 2) {
        this.isLoading = true;
        let paramsData = {};
        paramsData["s"] = query;
        paramsData["per_page"] = 100;
        axios.get("auth/ads-banner", { params: paramsData }).then(response => {
          this.bannerOptions = response.data.success.data;
          this.isLoading = false;
        });
      }
    },
    getCampaign(query) {},
    submitFormZone() {
      let dataForm = {
        title: this.title,
        status: this.status,
        width: this.width,
        height: this.height,
        description: this.description,
        random: this.random
      };
      let bannerArray = [];
      this.banner_id.forEach(e => {
        bannerArray.push(e.id);
      });
      dataForm.banner_id = bannerArray;
      let campaigns = "";
      this.campaigns_id.forEach(e => {
        campaigns = e.id;
      });
      dataForm.campaigns_id = campaigns;
      if (this.id) {
        axios
          .put("/auth/ads-zone/" + this.id, dataForm)
          .then(rs => {
            toastr.success("Thành công", "Chỉnh sửa thành công");
            this.$router.push({
              path: "/admin/ads-zone"
            });
          })
          .catch(error => {
            this.errors = error.response.data.errors;
            console.log(error.response.data.errors);
            toastr.error("Lỗi!", "Chỉnh sửa không thành công");
          });
      } else {
        axios
          .post("auth/ads-zone", dataForm)
          .then(rs => {
            this.$router.push({
              path: "/admin/ads-zone",
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
