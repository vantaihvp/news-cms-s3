<template>
  <section class="page-photos-list">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Photos</h2>
        </div>
        <div class="float-right">
          <form class="form-inline" @submit.prevent="getData(1)">
            <div class="form-group">
              <input type="text" class="form-control rounded-0" v-model="searchText" />
              <span class="input-group-append">
                <button
                  type="button"
                  class="btn btn-danger rounded-0"
                  @click="resetData()"
                  v-if="searchText"
                >X</button>
                <button type="submit" class="btn btn-primary rounded-0">Tìm</button>
              </span>
            </div>
          </form>
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
                  <label class="custom-file-label" for="customFile">Chọn tập tin</label>
                </div>
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
            <img
              :src="'/images/'+photo.url"
              class="img-fluid"
              v-on:click="detailThumbnail(photo.id)"
            />
          </li>
        </ul>
      </div>
      <div class="card-footer">
        <pagination :data="photos" @pagination-change-page="getData"></pagination>
      </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="photoPageModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Chi tiết hình ảnh</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="block-detail-photo">
              <div class="row">
                <div class="col-md-7">
                  <img
                    src="/images/admin/placeholder.png"
                    class="img-fluid img-thumbnail"
                    v-if="thumbnailSelected.url==''"
                  />
                  <img
                    :src="thumbnailSelected.url"
                    class="img-fluid img-thumbnail"
                    v-if="thumbnailSelected.url"
                  />
                </div>
                <div class="col-md-5">
                  <div class="form-group">
                    <label for>Title</label>
                    <input
                      type="text"
                      name="title"
                      class="form-control"
                      v-model="thumbnailSelected.title"
                    />
                  </div>
                  <div class="form-group">
                    <label for>Alt</label>
                    <input
                      type="text"
                      name="alt"
                      class="form-control"
                      v-model="thumbnailSelected.alt"
                    />
                  </div>
                  <div class="form-group">
                    <label for>Caption</label>
                    <input
                      type="text"
                      name="caption"
                      class="form-control"
                      v-model="thumbnailSelected.caption"
                    />
                  </div>
                  <div class="form-group">
                    <label for>Description</label>
                    <textarea
                      name="description"
                      rows="1"
                      class="form-control"
                      v-model="thumbnailSelected.description"
                    ></textarea>
                  </div>
                  <div class="form-group">
                    <label>Url</label>
                    <input
                      type="url"
                      readonly="readonly"
                      class="form-control"
                      v-model="thumbnailSelected.url"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn btn-danger" @click="deletePhoto">Delete</button>
            <div>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button
                type="button"
                class="btn btn-primary"
                @click.prevent="updateDataPhoto"
              >Save changes</button>
            </div>
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
  data() {
    return {
      photos: {},
      image: "",
      searchText: "",
      thumbnailSelected: {
        id: "",
        name: "",
        title: "",
        alt: "",
        caption: "",
        description: "",
        url: ""
      }
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
      this.uploadPhoto(e);
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
    },
    detailThumbnail(id) {
      $("#photoPageModal").modal("show");
      this.thumbnailSelected.id = id;
      axios.get("auth/photos/" + this.thumbnailSelected.id).then(data => {
        let thumbnail = data.data.success;
        this.thumbnailSelected.name = thumbnail.name;
        this.thumbnailSelected.title = thumbnail.title;
        this.thumbnailSelected.alt = thumbnail.alt;
        this.thumbnailSelected.caption = thumbnail.caption;
        this.thumbnailSelected.description = thumbnail.description;
        this.thumbnailSelected.url = urlWeb + "/images" + thumbnail.url;
      });
    },
    updateDataPhoto() {
      let dataForm = this.thumbnailSelected;
      axios
        .put("auth/photos/" + dataForm.id, dataForm)
        .then(response => {
          if (response.data.success) {
            this.$toastr.success("Thành công", "Cập nhật thành công");
          } else {
            this.$toastr.error("Thất bại", "Cập nhật không thành công");
          }
        })
        .catch(error => {
          this.$toastr.error("Thất bại", "Cập nhật không thành công");
        });
    },
    deletePhoto() {
      let cf = confirm("Bán muốn xóa ảnh này?");
      if (cf) {
        axios
          .delete("auth/photos/" + this.thumbnailSelected.id)
          .then(rs => {
            if (rs.data.success) {
              this.$toastr.success("Thành công", "Xóa thành công");
              this.getData(1);
              this.thumbnailSelected = {
                id: "",
                name: "",
                title: "",
                alt: "",
                caption: "",
                description: "",
                url: ""
              };
              $("#photoPageModal").modal("hide");
            }
          })
          .catch(error => {
            console.log(error);
            this.$toastr.error("Lỗi", "Xóa không thành công");
          });
      }
    },
    resetData() {
      this.searchText = "";
      this.getData();
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
        cursor: pointer;
      }
    }
  }
  .block-detail-photo {
    .img-thumbnail {
      width: 100%;
    }
  }
}
</style>
