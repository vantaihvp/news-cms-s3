<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm Menu</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link :to="{ name: 'menu-list' }" class="btn btn-primary">Danh sách</router-link>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-4">
        <div class="card border-0">
          <div class="card-body">
            <div class="form-group">
              <label for="type">Loại item</label>
              <select class="form-control" name="type" id="type" v-model="type">
                <option value="custom">Tùy chỉnh</option>
                <option value="category">Chuyên mục</option>
                <option value="tag">Tag</option>
              </select>
            </div>
            <div class="form-group" v-if="type=='custom'">
              <label for="url">Url</label>
              <input type="text" name="url" id="url" class="form-control" />
            </div>
            <div class="form-group" v-if="type=='tag'">
              <label for="tags">Tag</label>
              <multiselect
                v-model="selectedTag"
                label="title"
                track-by="id"
                placeholder="Tìm kiếm"
                open-direction="bottom"
                :options="tagOption"
                :searchable="true"
                :loading="tagLoading"
                :internal-search="false"
                :clear-on-select="true"
                :close-on-select="true"
                :options-limit="300"
                :limit="5"
                :max-height="600"
                :show-no-results="false"
                :hide-selected="true"
                @search-change="getTag"
              ></multiselect>
            </div>
            <div class="form-group" v-if="type=='category'">
              <label for="categories">Categories</label>
              <multiselect
                v-model="selectedCategory"
                label="title"
                track-by="id"
                placeholder="Tìm kiếm"
                open-direction="bottom"
                :options="categoryOption"
                :searchable="true"
                :loading="categoryLoading"
                :internal-search="false"
                :clear-on-select="true"
                :close-on-select="true"
                :options-limit="300"
                :limit="5"
                :max-height="600"
                :show-no-results="false"
                :hide-selected="true"
                @search-change="getCategory"
              ></multiselect>
            </div>
            <div class="form-group">
              <label for="title">Title</label>
              <input type="text" name="title" id="title" class="form-control" />
            </div>
            <div class="form-group">
              <label for="parent_id">Menu cha</label>
              <select class="form-control" name="parent_id" id="parent_id">
                <option value="0">Trống</option>
              </select>
            </div>
            <div class="form-group">
              <label for="position">Vị trí</label>
              <input type="number" name="position" id="position" class="form-control" value="1" />
            </div>
          </div>
          <div class="card-footer text-right">
            <button class="btn btn-primary" type="button" @click.prevent="submitItem">Thêm</button>
          </div>
        </div>
      </div>
      <div class="col-md-8">
        <div class="card border-0">
          <div class="card-body">
            <div class="row">
              <div class="col-12">
                <div class="form-group">
                  <label class="label-required">Tiêu đề</label>
                  <input type="text" class="form-control" aria-describedby="helpId" />
                </div>
              </div>
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
      type: "custom",
      title: "",
      tagOption: [],
      selectedTag: [],
      tagLoading: false,
      categoryOption: [],
      selectedCategory: [],
      categoryLoading: false
    };
  },
  methods: {
    getData(id) {
      if (id) {
      }
    },
    getCategory(query) {
      if (query.length >= 2) {
        let paramsData = {};
        if (this.searchText) {
          paramsData.s = query;
          paramsData.sort = 0;
        }
        axios
          .get("auth/categories/get-categories", { params: paramsData })
          .then(data => {
            this.categoryOption = data.data.success;
            this.categoryLoading = false;
          });
      }
    },
    getTag(query) {
      if (query.length >= 2) {
        this.tagLoading = true;
        let paramsData = {};
        paramsData["s"] = query;
        paramsData["per_page"] = 100;
        axios
          .get("auth/tags/get-tags", { params: paramsData })
          .then(response => {
            this.tagOption = response.data.success.data;
            this.tagLoading = false;
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
