<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm Menu</h2>
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
          <div class="card-body">
            <div class="row"></div>
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
                  <input
                    type="text"
                    name
                    id
                    class="form-control"
                    placeholder
                    aria-describedby="helpId"
                  />
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
      title: "",
      status: "draft",
      description: ""
    };
  },
  methods: {
    getData(id) {
      if (id) {
      }
    }
  },
  created() {
    this.getData(this.id);
  }
};
</script>

<style></style>
