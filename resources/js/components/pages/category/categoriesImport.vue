<template>
  <section>
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Import categories</h2>
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
              if (element.name) {
                let dataForm = {
                  id: element.id,
                  slug: element.slug,
                  title: element.name,
                  description: element.description,
                  parent_id: element.parent
                };
                axios
                  .post("auth/categories", dataForm)
                  .then(rs => {
                    toastr.success("Thành công", "Thêm thành công");
                  })
                  .catch(error => {
                    this.errors = error.response.data.errors;
                    toastr.error("Lỗi", "Thêm không thành công");
                    console.log(dataForm);
                    console.log(index);
                  });
              }
            }, 500 * index);
          });
          //   console.log(dataForm);
        });
    }
  }
};
</script>

<style></style>
