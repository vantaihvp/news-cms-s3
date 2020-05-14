<template>
  <section>
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Photos</h2>
        </div>
        <div class="float-right">
          <div class="d-flex">
            <div class="button-box">
              <router-link
                :to="{ name: 'category-create' }"
                class="btn btn-primary"
                v-if="this.$can('category-create')"
              >Thêm mới</router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none">
      <div class="card-body">
        <div id="block-upload">
          <div v-if="success != ''" class="alert alert-success" role="alert">{{success}}</div>
          <form @submit="uploadPhoto" enctype="multipart/form-data">
            <div class="custom-file">
              <strong>Image:</strong>
              <input type="file" class="form-control custom-file-input" v-on:change="onImageChange" />
              <label class="custom-file-label" for="customFile">Choose file</label>
            </div>
            <button class="btn btn-success">Submit</button>
          </form>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none">
      <div class="card-body">
        <div class="row">
          <div class="col-md-2 col-lg-1" v-for="photo in photos" :key="photo.id">
            <img :src="'/images/'+photo.url" class="img-fluid" />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import toastr from "toastr";
import "toastr/build/toastr.min.css";
export default {
  props: {
    message: "",
    status: ""
  },
  data() {
    return {
      error: {},
      photos: {},
      image: "",
      success: "",
      searchText: ""
    };
  },
  created() {
    this.getData();
  },
  methods: {
    uploadPhoto(e) {
      e.preventDefault();
      let currentObj = this;
      const config = {
        headers: { "content-type": "multipart/form-data" }
      };
      let formData = new FormData();
      formData.append("image", this.image);
      axios
        .post("/auth/photos", formData, config)
        .then(function(response) {
          currentObj.success = response.data.success;
          this.getData();
        })
        .catch(function(error) {
          currentObj.output = error;
        });
    },
    onImageChange(e) {
      console.log(e.target.files[0]);
      this.image = e.target.files[0];
    },
    getData() {
      let paramsData = {};
      if (this.searchText) {
        paramsData["s"] = this.searchText;
      }
      axios.get("auth/photos", { params: paramsData }).then(data => {
        this.photos = data.data.success;
      });
    }
  }
};
</script>

<style></style>
