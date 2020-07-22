<template>
    <div class="thumbnail-modal">
        <a class="chosse-image" href="#" v-on:click="showThumbnailModal()"
            >Chọn ảnh</a
        >
        <div
            class="modal upload-thumbnail-modal"
            :id="'uploadThumbnailModal-' + id"
        >
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header bg-primary">
                        <h4 class="modal-title">Chọn ảnh đại diện</h4>
                        <div class="card-tools">
                            <div class="input-group input-group">
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="searchText"
                                />
                                <span class="input-group-append">
                                    <button
                                        type="button"
                                        class="btn btn-danger"
                                        @click.prevent="resetSearch"
                                        v-if="searchText"
                                    >
                                        X
                                    </button>
                                    <button
                                        type="submit"
                                        class="btn btn-success"
                                        @click.prevent="getData(1)"
                                    >
                                        Tìm
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-9">
                                <form
                                    @submit="uploadThumbnailModal"
                                    enctype="multipart/form-data"
                                >
                                    <div class="form-row">
                                        <div class="col">
                                            <div class="custom-file">
                                                <strong>Image:</strong>
                                                <input
                                                    type="file"
                                                    class="form-control custom-file-input"
                                                    v-on:change="onImageChange"
                                                />
                                                <label
                                                    class="custom-file-label"
                                                    for="customFile"
                                                    >Chọn tập tin</label
                                                >
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="menu-item-browse">
                                    <div class="block-photos">
                                        <ul class="photos">
                                            <li
                                                v-for="photo in photos.data"
                                                :key="photo.id"
                                            >
                                                <img
                                                    :src="photo.url"
                                                    v-on:click="detailThumbnail"
                                                    :data-id="photo.id"
                                                    v-bind:class="{
                                                        active:
                                                            thumbnailSelected.id ==
                                                            photo.id,
                                                        'img-thumbnail img-fluid w-100': true
                                                    }"
                                                />
                                            </li>
                                        </ul>
                                        <pagination
                                            :data="photos"
                                            @pagination-change-page="getData"
                                            :limit="4"
                                        ></pagination>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="media-sidebar">
                                    <div class="block-detail-photo">
                                        <img
                                            src="/images/admin/placeholder.png"
                                            class="img-fluid img-thumbnail"
                                            v-if="thumbnailSelected.url == ''"
                                        />
                                        <img
                                            :src="thumbnailSelected.url"
                                            class="img-fluid img-thumbnail"
                                            v-if="thumbnailSelected.url"
                                        />
                                        <hr />
                                        <div class="form-group">
                                            <input
                                                type="text"
                                                name="title"
                                                class="form-control"
                                                placeholder="Title"
                                                v-model="
                                                    thumbnailSelected.title
                                                "
                                            />
                                        </div>
                                        <div class="form-group">
                                            <input
                                                type="text"
                                                name="alt"
                                                class="form-control"
                                                placeholder="Alt"
                                                v-model="thumbnailSelected.alt"
                                            />
                                        </div>
                                        <div class="form-group">
                                            <textarea
                                                name="caption"
                                                class="form-control"
                                                rows="2"
                                                placeholder="Caption"
                                                v-model="
                                                    thumbnailSelected.caption
                                                "
                                            ></textarea>
                                        </div>
                                        <div class="form-group">
                                            <textarea
                                                class="form-control"
                                                name="description"
                                                rows="2"
                                                placeholder="Description"
                                                v-model="
                                                    thumbnailSelected.description
                                                "
                                            ></textarea>
                                        </div>
                                        <div class="form-group">
                                            <input
                                                type="url"
                                                name="url"
                                                class="form-control"
                                                readonly
                                                v-model="thumbnailSelected.url"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button
                            type="button"
                            class="btn btn-primary"
                            @click="setThumbnail"
                        >
                            Chọn ảnh
                        </button>
                        <button
                            type="button"
                            class="btn btn-secondary"
                            @click="cancelThumbnail"
                        >
                            Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import toastr from "toastr";
import "toastr/build/toastr.min.css";
export default {
    props: {
        message: "",
        status: "",
        thumbnail_id: {
            type: [String, Number]
        },
        value: {
            type: [String, Number, Object]
        },
        id: {
            type: [String]
        }
    },
    data() {
        return {
            error: {},
            photos: {},
            image: "",
            success: "",
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
        this.getThumbnailPost();
    },
    methods: {
        showThumbnailModal(e) {
            this.getData(1);
            $("#uploadThumbnailModal-" + this.id).modal();
        },
        uploadThumbnailModal(e) {
            e.preventDefault();
            let currentObj = this;
            const config = {
                headers: { "content-type": "multipart/form-data" }
            };
            let formData = new FormData();
            formData.append("image", this.image);
            axios
                .post("/auth/photos", formData, config)
                .then(response => {
                    currentObj.success = response.data.success;
                    this.photos.data.unshift(response.data.success);
                    this.thumbnailSelected.id = response.data.success.id;
                    axios
                        .get("auth/photos/" + this.thumbnailSelected.id)
                        .then(data => {
                            let thumbnail = data.data.success;
                            this.thumbnailSelected.name = thumbnail.name;
                            this.thumbnailSelected.title = thumbnail.title;
                            this.thumbnailSelected.caption = thumbnail.caption;
                            this.thumbnailSelected.description =
                                thumbnail.description;
                            this.thumbnailSelected.url = thumbnail.url;
                        });
                })
                .catch(function(error) {
                    let str_error = "<ul>";
                    error.response.data.errors.image.forEach(element => {
                        str_error += `<li>${element}</li>`;
                    });
                    str_error += `</ul>`;
                    toastr.error(str_error);
                    currentObj.output = error;
                });
        },
        onImageChange(e) {
            this.image = e.target.files[0];
            this.uploadThumbnailModal(e);
        },
        getData(page) {
            let paramsData = {};
            if (typeof page === "undefined") {
                paramsData["page"] = 1;
            } else {
                paramsData["page"] = page;
            }
            if (this.searchText) {
                paramsData["s"] = this.searchText;
            }
            axios.get("auth/photos", { params: paramsData }).then(data => {
                this.photos = data.data.success;
            });
        },
        detailThumbnail(e) {
            this.thumbnailSelected.id = e.target.dataset.id;
            e.target.className += "active";
            axios.get("auth/photos/" + this.thumbnailSelected.id).then(data => {
                let thumbnail = data.data.success;
                this.thumbnailSelected.name = thumbnail.name;
                this.thumbnailSelected.title = thumbnail.title;
                this.thumbnailSelected.caption = thumbnail.caption;
                this.thumbnailSelected.description = thumbnail.description;
                this.thumbnailSelected.url = thumbnail.url;
            });
        },
        setThumbnail() {
            if (this.thumbnailSelected.id) {
                this.$emit("input", this.thumbnailSelected.id);
                let obj = this.thumbnailSelected;
                obj.type = this.id;
                this.$emit("changeThumbnail", obj);
                $(".upload-thumbnail-modal").modal("hide");
            } else {
                toastr.error("Lỗi", "Chưa chọn ảnh");
            }
        },
        cancelThumbnail() {
            this.thumbnailSelected = {
                id: "",
                name: "",
                title: "",
                alt: "",
                caption: "",
                description: "",
                url: ""
            };
            $(".upload-thumbnail-modal").modal("hide");
        },
        getThumbnailPost() {
            if (this.value) {
                axios.get("auth/photos/" + this.value).then(data => {
                    if (data.data.success) {
                        let thumbnail = data.data.success;
                        this.thumbnailSelected.url = thumbnail.url;
                        this.thumbnailSelected.id = this.value;
                        this.setThumbnail();
                    }
                });
            }
        },
        deletePhoto() {
            let cf = confirm("Bán muốn xóa ảnh này?");
            if (cf) {
                axios
                    .delete("auth/photos/" + this.thumbnailSelected.id)
                    .then(rs => {
                        if (rs.data.success) {
                            this.$toastr.success(
                                "Thành công",
                                "Xóa thành công"
                            );
                            this.getData(1);
                        }
                    })
                    .catch(error => {
                        console.log(error);
                        this.$toastr.error("Lỗi", "Xóa không thành công");
                    });
            }
        },
        resetSearch() {
            this.searchText = "";
            this.getData(1);
        }
    }
};
</script>

<style lang="scss">
.thumbnail-modal {
    .img-thumbnail {
        max-width: 135px;
        display: block;
        margin-bottom: 10px;
    }
}
.upload-thumbnail-modal {
    .custom-file-input {
        position: absolute;
        top: 0;
    }
    #menu-item-browse {
        .card-body {
            max-height: 700px;
            overflow: auto;
        }
    }
    .menu-item-upload {
        background: #f3f3f3;
        border: 1px solid #ddd;
    }
    .modal-lg {
        max-width: 90%;
    }
    .media-sidebar {
        padding: 15px;
        z-index: 75;
        background: #f3f3f3;
        border: 1px solid #ddd;
    }
    .photos {
        display: flex;
        list-style-type: none;
        padding-left: 0;
        flex-direction: row;
        flex-wrap: wrap;
        li {
            width: 150px;
            padding: 5px;
        }
    }
    .block-photos {
        .img-thumbnail {
            cursor: pointer;
            object-fit: cover;
            height: 150px;
            &.active {
                border: 3px solid #4db2ec;
            }
        }
    }
}
</style>
