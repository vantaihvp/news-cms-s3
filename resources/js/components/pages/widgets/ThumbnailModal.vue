<template>
    <div class="thumbnail-modal">
        <img
            src="/images/admin-lte/placeholder.png"
            class="img-fluid img-thumbnail"
            v-if="thumbnail_chosse.url == ''"
        />
        <img
            :src="'/images/' + thumbnail_chosse.url"
            class="img-fluid img-thumbnail"
            v-if="thumbnail_chosse.url"
        />
        <a class="chosse-image" href="#" v-on:click="showThumbnailModal()"
            >Chọn ảnh</a
        >
        <div class="form-group">
            <input
                type="hidden"
                class="form-control"
                name="thumbnail_id"
                id="thumbnail_id"
                aria-describedby="helpId"
                v-model="thumbnail_chosse.id"
            />
        </div>
        <div class="modal" id="uploadThumbnailModal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header bg-primary">
                        <h4 class="modal-title">Chọn ảnh đại diện</h4>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-9">
                                <div class="card shadow-none menu-item-upload">
                                    <div class="card-body">
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
                                                            v-on:change="
                                                                onImageChange
                                                            "
                                                        />
                                                        <label
                                                            class="custom-file-label"
                                                            for="customFile"
                                                            >Choose file</label
                                                        >
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <button
                                                        class="btn btn-success"
                                                    >
                                                        Upload
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="menu-item-browse">
                                    <div class="block-photos">
                                        <ul class="photos">
                                            <li
                                                v-for="photo in photos"
                                                :key="photo.id"
                                            >
                                                <img
                                                    :src="
                                                        '/images/' + photo.url
                                                    "
                                                    v-on:click="detailThumbnail"
                                                    :data-id="photo.id"
                                                    class="img-fluid img-thumbnail w-100"
                                                />
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="media-sidebar">
                                    <div class="block-detail-photo">
                                        <img
                                            src="/images/admin-lte/placeholder.png"
                                            class="img-fluid img-thumbnail"
                                            v-if="thumbnail_chosse.url == ''"
                                        />
                                        <img
                                            :src="
                                                '/images/' +
                                                    thumbnail_chosse.url
                                            "
                                            class="img-fluid img-thumbnail"
                                            v-if="thumbnail_chosse.url"
                                        />
                                        <hr />
                                        <div class="form-group">
                                            <label for>Title</label>
                                            <input
                                                type="text"
                                                name="title"
                                                class="form-control"
                                                placeholder="Title"
                                                v-model="thumbnail_chosse.title"
                                            />
                                        </div>
                                        <div class="form-group">
                                            <label for>Alt</label>
                                            <input
                                                type="text"
                                                name="alt"
                                                class="form-control"
                                                placeholder="Alt"
                                                v-model="thumbnail_chosse.alt"
                                            />
                                        </div>
                                        <div class="form-group">
                                            <label for>Caption</label>
                                            <input
                                                type="text"
                                                name="caption"
                                                class="form-control"
                                                placeholder="Caption"
                                                v-model="
                                                    thumbnail_chosse.caption
                                                "
                                            />
                                        </div>
                                        <div class="form-group">
                                            <label for>Description</label>
                                            <textarea
                                                class="form-control"
                                                name="description"
                                                rows="3"
                                                placeholder="Description"
                                                v-model="
                                                    thumbnail_chosse.description
                                                "
                                            ></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>Url</label>
                                            <input
                                                type="url"
                                                name="caption"
                                                class="form-control"
                                                readonly
                                                v-model="thumbnail_chosse.url"
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
        status: ""
    },
    data() {
        return {
            error: {},
            photos: {},
            image: "",
            success: "",
            searchText: "",
            thumbnail_chosse: {
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
        this.getData();
    },
    methods: {
        showThumbnailModal(e) {
            $("#uploadThumbnailModal").modal();
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
                    this.photos.unshift(response.data.success);
                })
                .catch(function(error) {
                    currentObj.output = error;
                });
        },
        onImageChange(e) {
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
        },
        detailThumbnail(e) {
            this.thumbnail_chosse.id = e.target.dataset.id;
            e.target.className += "active";
            axios.get("auth/photos/" + this.thumbnail_chosse.id).then(data => {
                let thumbnail = data.data.success;
                this.thumbnail_chosse.name = thumbnail.name;
                this.thumbnail_chosse.title = thumbnail.title;
                this.thumbnail_chosse.caption = thumbnail.caption;
                this.thumbnail_chosse.description = thumbnail.description;
                this.thumbnail_chosse.url = thumbnail.url;
            });
        },
        setThumbnail() {
            if (this.thumbnail_chosse.id) {
                $("#uploadThumbnailModal").modal("hide");
            } else {
                toastr.error("Lỗi", "Chưa chọn ảnh");
            }
        },
        cancelThumbnail() {
            this.thumbnail_chosse = {
                id: "",
                name: "",
                title: "",
                alt: "",
                caption: "",
                description: "",
                url: ""
            };
            $("#uploadThumbnailModal").modal("hide");
        }
    }
};
</script>

<style lang="scss">
#uploadThumbnailModal {
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
            &.active {
                background: red;
            }
        }
    }
}
</style>
