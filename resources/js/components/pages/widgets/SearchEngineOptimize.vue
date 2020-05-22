<template>
  <div class="card shadow-none card-seo">
    <div class="card-header">
      <div class="float-left">
        <h4 class="card-title">Search Engine Optimize</h4>
      </div>
      <div class="card-tools">
        <button type="button" class="btn btn-tool" data-card-widget="collapse">
          <i class="fas fa-minus"></i>
        </button>
      </div>
    </div>
    <div class="card-body">
      <div class="form-group">
        <label>SEO Title</label>
        <input
          type="text"
          name="seo-title"
          class="form-control"
          placeholder="SEO Title"
          aria-describedby="helpId"
          v-model="title"
        />
      </div>
      <div class="form-group">
        <label>SEO description</label>
        <textarea
          class="form-control"
          name="seo-description"
          rows="3"
          aria-placeholder="SEO description"
          placeholder="SEO description"
          v-model="description"
        ></textarea>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "SearchEngineOptimize",
  props: {
    id: {
      type: [String, Number]
    },
    obj_title: {
      type: String
    },
    obj_description: {
      type: String
    }
  },
  data() {
    return {
      title: "",
      description: ""
    };
  },
  methods: {
    getData() {
      if (this.id) {
        axios
          .get("auth/seo/" + this.id)
          .then(response => {
            this.title = response.data.success.title;
            this.description = response.data.success.description;
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    updateSeo() {
      let dataForm = {
        id: this.id,
        title: this.title,
        description: this.description
      };
      return axios
        .put("auth/seo/" + this.id, dataForm)
        .then(response => {
          return response.data.success;
        })
        .catch(error => {
          console.log(error);
        });
    },
    createSeo() {
      let dataForm = {
        title: this.title.length ? this.title : this.obj_title,
        description: this.description.length
          ? this.description
          : this.obj_description
      };
      return axios
        .post("/auth/seo", dataForm)
        .then(rs => {
          return rs.data.success;
        })
        .catch(error => {
          return error;
        });
    }
  },
  created() {
    this.getData();
  }
};
</script>

<style></style>
