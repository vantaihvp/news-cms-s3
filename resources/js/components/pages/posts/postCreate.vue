<template>
    <div class="user-create">
        <div class="row mb-1">
            <div class="col-lg-12 margin-tb">
                <div class="float-left">
                    <h2>Thêm bài viết</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-9">
                <div class="card shadow-none">
                    <div class="card-header">
                        <h4 class="card-title">Chi tiết bài viết</h4>
                    </div>
                    <div class="card-body" id="post-create">
                        <div class="error" v-if="errors.length">
                            <div class="alert alert-danger" role="alert">
                                <span
                                    v-for="(err, index) in errors"
                                    :key="index"
                                    >{{ err }}</span
                                >
                                <hr />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label class="lable-required"
                                        >Tiêu đề:</label
                                    >
                                    <input
                                        type="text"
                                        v-model="title"
                                        name="title"
                                        class="form-control"
                                        required
                                    />
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label>Tóm tắt</label>
                                    <textarea
                                        class="form-control"
                                        v-model="excerpt"
                                        rows="3"
                                    ></textarea>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label>Nội dung</label>
                                    <textarea
                                        class="form-control"
                                        v-model="description"
                                        name="description"
                                        rows="3"
                                    ></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card shadow-none">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Tùy chỉnh bài viết</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label>Tác giả</label>
                            <input
                                type="text"
                                name="tac_gia"
                                class="form-control"
                                placeholder="Tác giả"
                                aria-describedby="helpId"
                            />
                        </div>
                        <div class="form-group">
                            <label for>Design/Photo</label>
                            <textarea
                                class="form-control"
                                name="photo-design"
                                rows="3"
                                aria-placeholder="Design/Photo"
                                placeholder="Design/Photo"
                            ></textarea>
                        </div>
                    </div>
                </div>
                <div class="card shadow-none">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Layout bài viết</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <ul class="layout-post">
                            <li>
                                <img
                                    src="http://demo.billboardvietnam.vn/wp-content/plugins/td-composer/legacy/Newspaper/assets/images/panel/single_templates/single_template_0.png"
                                    class="td-visual-selector-o-img"
                                    data-uid="tdi_1_e61"
                                    data-option-value="single_template_1"
                                    data-control-wrapper="wrap_tdi_2_377"
                                    border="0"
                                />
                            </li>
                            <li>
                                <img
                                    src="https://billboardvn.vn/wp-content/plugins/td-standard-pack/Newspaper/assets/images/panel/single_templates/single_template_1.png"
                                    class="td-visual-selector-o-img"
                                    data-uid="tdi_1_e61"
                                    data-option-value="single_template_1"
                                    data-control-wrapper="wrap_tdi_2_377"
                                    border="0"
                                />
                            </li>
                            <li>
                                <img
                                    src="https://billboardvn.vn/wp-content/plugins/td-standard-pack/Newspaper/assets/images/panel/single_templates/single_template_2.png"
                                    class="td-visual-selector-o-img"
                                    data-uid="tdi_1_e61"
                                    data-option-value="single_template_2"
                                    data-control-wrapper="wrap_tdi_2_377"
                                    border="0"
                                />
                            </li>
                            <li>
                                <img
                                    src="https://billboardvn.vn/wp-content/plugins/td-standard-pack/Newspaper/assets/images/panel/single_templates/single_template_3.png"
                                    class="td-visual-selector-o-img"
                                    data-uid="tdi_1_e61"
                                    data-option-value="single_template_2"
                                    data-control-wrapper="wrap_tdi_2_377"
                                    border="0"
                                />
                            </li>
                        </ul>
                    </div>
                </div>
                <search-engine-optimize />
                <div class="card shadow-none">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Bài viết liên quan</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <multiselect
                            v-model="selectedTags"
                            label="title"
                            track-by="id"
                            placeholder="Nhập để tìm hoặc thêm mới"
                            open-direction="bottom"
                            :options="tagOptions"
                            :multiple="true"
                            :searchable="true"
                            :loading="isLoading"
                            :internal-search="false"
                            :clear-on-select="false"
                            :close-on-select="false"
                            :options-limit="300"
                            :limit="5"
                            :limit-text="limitText"
                            :max-height="600"
                            :show-no-results="false"
                            :hide-selected="true"
                            @search-change="getTags"
                            @tag="addTag"
                            :taggable="true"
                        ></multiselect>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-none card-post-category">
                    <div class="card-header">
                        <h4 class="card-title">Xuất bản</h4>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <label for class="col-sm-4 col-form-label"
                                >Trạng thái:</label
                            >
                            <div class="col-sm-8">
                                <select
                                    class="form-control"
                                    name="post_status"
                                    id="post_status"
                                    v-model="status"
                                >
                                    <option value="draft">Bản nháp</option>
                                    <option value="pending">Chờ duyệt</option>
                                    <option value="private">Riêng tư</option>
                                    <option value="publish">Công khai</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for class="col-sm-4 col-form-label"
                                >Đăng lúc:</label
                            >
                            <div class="col-sm-8">
                                <date-picker
                                    type="datetime"
                                    v-model="date"
                                    :format="momentFormat"
                                ></date-picker>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for class="col-sm-4 col-form-label"
                                >Chuyển cho:</label
                            >
                            <div class="col-sm-8">
                                <select
                                    class="form-control"
                                    name="role_id"
                                    id="role_post"
                                >
                                    <option value="0">Không chuyển</option>
                                    <option
                                        v-for="role in roles"
                                        :key="role.id"
                                        v-bind:value="role.id"
                                        >{{ role.name }}</option
                                    >
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <button
                            class="btn btn-primary"
                            type="button"
                            @click.prevent="submitPost"
                        >
                            Đăng bài viết
                        </button>
                    </div>
                </div>
                <div class="card shadow-none card-post-format">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Định dạng</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <ul>
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input
                                            type="radio"
                                            class="form-check-input"
                                            name="post_format"
                                            value="default"
                                            v-model="format"
                                        />
                                        <i class="fal fa-newspaper"></i>
                                        Chuẩn
                                    </label>
                                </div>
                            </li>
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input
                                            type="radio"
                                            class="form-check-input"
                                            name="post_format"
                                            value="video"
                                            v-model="format"
                                        />
                                        <i class="fal fa-video"></i> Video
                                    </label>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="card shadow-none card-post-category">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Chuyên mục</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <ul>
                            <li
                                v-for="category in categories"
                                :key="category.id"
                            >
                                <div class="form-check icheck-primary">
                                    <label class="form-check-label">
                                        <input
                                            type="checkbox"
                                            class="form-check-input"
                                            name="category[]"
                                            v-bind:value="category.id"
                                            v-model="selectedCategories"
                                        />
                                        {{ category.title }}
                                    </label>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="card shadow-none card-post-tags">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Tags</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <multiselect
                            v-model="selectedTags"
                            label="title"
                            track-by="id"
                            placeholder="Tìm hoặc thêm mới"
                            open-direction="bottom"
                            :options="tagOptions"
                            :multiple="true"
                            :searchable="true"
                            :loading="isLoading"
                            :internal-search="false"
                            :clear-on-select="false"
                            :close-on-select="false"
                            :options-limit="300"
                            :limit="5"
                            :limit-text="limitText"
                            :max-height="600"
                            :show-no-results="false"
                            :hide-selected="true"
                            @search-change="getTags"
                            @tag="addTag"
                            :taggable="true"
                        ></multiselect>
                    </div>
                </div>
                <div class="card shadow-none card-post-thumbnail">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Hình đại diện</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <ThumbnailModal />
                    </div>
                </div>
                <div class="card shadow-none card-post-url-video">
                    <div class="card-header">
                        <div class="float-left">
                            <h4 class="card-title">Url Video</h4>
                        </div>
                        <div class="card-tools">
                            <button
                                type="button"
                                class="btn btn-tool"
                                data-card-widget="collapse"
                            >
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <input
                                type="text"
                                name="url-video"
                                id="url-video"
                                class="form-control"
                                placeholder="Url Video"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import SearchEngineOptimize from "./../widgets/SearchEngineOptimize";
var moment = require("moment");
export default {
    components: {
        SearchEngineOptimize
    },
    data() {
        return {
            date: new Date(),
            title: "",
            excerpt: "",
            description: "",
            status: "draft",
            slug: "",
            format: "default",
            categories: [],
            selectedCategories: [],
            roles: {},
            errors: [],
            value: null,
            tagOptions: [],
            selectedTags: [],
            isLoading: false,
            momentFormat: {
                // Date to String
                stringify: date => {
                    return date
                        ? moment(date).format("DD/MM/YYYY H:mm:ss")
                        : "";
                },
                // String to Date
                parse: value => {
                    return value
                        ? moment(value, "DD/MM/YYYY H:mm:ss").toDate()
                        : null;
                }
            }
        };
    },
    methods: {
        getRoles() {
            axios
                .get("/auth/roles")
                .then(response => {
                    if (response.data.status === false) {
                        this.error.message = response.data.message;
                    } else {
                        this.roles = response.data;
                    }
                })
                .catch();
        },
        getTaxonomy() {
            axios.get("auth/categories/get-categories").then(data => {
                this.categories = data.data.success;
            });
        },
        getTags(query) {
            if (query.length >= 2) {
                this.isLoading = true;
                let paramsData = {};
                paramsData["s"] = query;
                paramsData["per_page"] = 100;
                axios
                    .get("auth/tags/get-tags", { params: paramsData })
                    .then(response => {
                        this.tagOptions = response.data.success.data;
                        this.isLoading = false;
                    });
            }
        },
        addTag(newTag) {
            const tag = {
                title: newTag,
                id:
                    newTag.substring(0, 2) +
                    Math.floor(Math.random() * 10000000)
            };
            this.tagOptions.push(tag);
            this.selectedTags.push(tag);
        },
        limitText(count) {
            return `và ${count} lựa chọn khác`;
        },
        submitCreateCategory(event) {
            let dataForm = {
                title: this.title,
                slug: this.slug,
                parent_id: this.parent_id,
                description: this.description
            };
            axios
                .post("auth/categories", dataForm)
                .then(rs => {
                    this.$toastr.success("Thành công", "Thêm thành công");
                    this.$router.push({
                        path: "/admin/categories"
                    });
                })
                .catch(error => {
                    this.errors = error.response.data.errors;
                    this.$toastr.error("Lỗi", "Thêm không thành công");
                });
        },
        submitPost() {
            let dataForm = {
                date: this.date,
                title: this.title,
                excerpt: this.excerpt,
                description: this.description,
                status: this.status,
                format: this.format,
                tag: this.selectedTags,
                categories: this.selectedCategories,
                thumbnail: this.thumbnail_chosse.id
            };
            console.log(dataForm);
            axios
                .post("auth/posts", dataForm)
                .then(rs => {
                    this.$toastr.success("Thành công", "Thêm thành công");
                    console.log(rs);
                })
                .catch(error => {
                    let list_error = "";
                    Object.values(error.response.data.errors).forEach(
                        e => (list_error += `<li>${e}</li>`)
                    );
                    this.errors = error.response.data.errors;
                    this.$toastr.error(list_error, "Lỗi");
                });
        }
    },
    created() {
        this.getTaxonomy();
        this.getRoles();
    }
};
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
<style lang="scss">
.card-title {
    float: none;
    margin-bottom: 0px;
}
.card-post-format {
    ul {
        list-style-type: none;
        padding-left: 0px;
        margin-bottom: 0px;
        li {
            padding: 2px 0px;
        }
    }
}
.card-post-category {
    ul {
        list-style-type: none;
        margin-bottom: 0px;
        padding-left: 0px;
    }
}
.img-thumbnail {
    max-width: 195px;
    display: block;
    margin-bottom: 10px;
}
.layout-post {
    display: flex;
    list-style-type: none;
    padding-left: 0;
    flex-direction: row;
    flex-wrap: wrap;
    li {
        width: 100px;
        padding: 5px;
    }
}
</style>
