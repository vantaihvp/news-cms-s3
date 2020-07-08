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
          ref="inputTitle"
          :value="value.title"
          @input="updateData()"
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
          ref="inputDescription"
          :value="value.description"
          @input="updateData()"
        ></textarea>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "SearchEngineOptimize",
  props: ["value"],
  data() {
    return {
      title: "",
      description: ""
    };
  },
  methods: {
    updateData() {
      this.$emit("input", {
        title: this.$refs.inputTitle.value,
        description: this.$refs.inputDescription.value
      });
    }
  }
};
</script>

<style></style>
