<template>
  <section>
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Import Posts</h2>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none">
      <div class="card-body">
        <form @submit.prevent="submitCreateTag">
          <input type="url" v-model="url" required />
          <button type="submit" class="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>
  </section>
</template>

<script>
import toastr from "toastr";
import "toastr/build/toastr.min.css";
export default {
  data() {
    return {
      url: ""
    };
  },
  created() {},
  methods: {
    submitCreateTag(event) {
      fetch(this.url)
        .then(rs => rs.json())
        .then(data => {
          data.forEach(function(element, index) {
            setTimeout(function() {
              let dataForm = {
                id: element.id,
                title: element.title.rendered,
                slug: element.slug,
                excerpt: element.content.rendered
                  .split("</p>")[0]
                  .replace(/(<([^>]+)>)/gi, ""),
                format: element.format,
                thumbnail_id: element.featured_media,
                date: element.date,
                description: element.content.rendered,
                url_video: element.url_video.td_video,
                categories_id: element.categories,
                tags_id: element.tags,
                user_id: 1
              };
              axios
                .post("auth/posts/import", dataForm)
                .then(rs => {
                  console.log(rs);
                  toastr.success("Thành công", "Thêm thành công");
                })
                .catch(error => {
                  this.errors = error.response.data.errors;
                  toastr.error("Lỗi", "Thêm không thành công");
                  console.log(dataForm);
                  console.log(index);
                });
            }, 500 * index);
          });
          //   console.log(dataForm);
        });
    }
  }
};
</script>

<style></style>
