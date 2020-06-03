<template>
  <section class="page-photos-list">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Photos</h2>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none">
      <div class="card-body">
        <div id="block-upload">
          <form @submit="uploadPhoto" enctype="multipart/form-data">
            <div class="form-row">
              <div class="col">
                <div class="custom-file">
                  <strong>Image:</strong>
                  <input
                    type="file"
                    class="form-control custom-file-input"
                    v-on:change="onImageChange"
                    style="position: absolute;top: 0;"
                  />
                  <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
              </div>
              <div class="col-auto">
                <button class="btn btn-success">Submit</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none">
      <div class="card-body">
        <ul class="list-photos">
          <li v-for="photo in photos.data" :key="photo.id">
            <img :src="'/images/'+photo.url" class="img-fluid" />
          </li>
        </ul>
      </div>
      <div class="card-footer">
        <pagination :data="photos" @pagination-change-page="getData"></pagination>
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
      photos: {},
      image: "",
      searchText: ""
    };
  },
  created() {
    this.getData(1);
  },
  methods: {
    uploadPhoto(e) {
      e.preventDefault();
      const config = {
        headers: { "content-type": "multipart/form-data" }
      };
      let formData = new FormData();
      formData.append("image", this.image);
      axios
        .post("/auth/photos", formData, config)
        .then(response => {
          this.photos.data.unshift(response.data.success);
          toastr.success("Thành công", "Upload thành công");
        })
        .catch(function(error) {
          console.log(error);
          toastr.error("Lỗi", "Upload không thành công");
        });
    },
    onImageChange(e) {
      console.log(e.target.files[0]);
      this.image = e.target.files[0];
    },
    getData(page) {
      let paramsData = {};
      if (typeof page === "undefined") {
        paramsData["page"] = 1;
      } else {
        paramsData["page"] = page;
      }
      paramsData["per_page"] = 30;
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

<style lang="scss">
.page-photos-list {
  .list-photos {
    padding-left: 0px;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    li {
      list-style: none;
      width: 150px;
      img {
        width: 150px;
        height: 150px;
        object-fit: cover;
        padding: 5px;
      }
    }
  }
}
</style>
