<template>
  <div class="post-create">
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
          <div class="card-body" id="post-create-body">
            <div class="error" v-if="errors.length">
              <div class="alert alert-danger" role="alert">
                <span v-for="(err, index) in errors" :key="index">{{ err }}</span>
                <hr />
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12 col-sm-12 col-md-12">
                <div class="form-group">
                  <label class="lable-required">Tiêu đề:</label>
                  <input
                    type="text"
                    v-model="post.title"
                    name="title"
                    class="form-control"
                    required
                  />
                </div>
              </div>
              <div class="col-xs-12 col-sm-12 col-md-12">
                <div class="form-group">
                  <label>Tóm tắt</label>
                  <textarea class="form-control" v-model="post.excerpt" rows="3"></textarea>
                </div>
              </div>
              <div class="col-xs-12 col-sm-12 col-md-12">
                <div class="form-group group-content">
                  <label>Nội dung</label>
                  <MediaContent ref="mediacontent" @insertMedia="insertMedia($event)" />
                  <editor
                    id="post-content"
                    ref="tm"
                    v-model="post.description"
                    :init="{
                        content_css:
                            '/css/custom-editor.css',
                        convert_urls: true,
                        relative_urls: false,
                        remove_script_host: false,
                        toolbar2: 'embed_button',
                        plugins: [
                            'autolink lists link charmap print preview hr anchor pagebreak',
                            'searchreplace wordcount visualblocks visualchars code fullscreen',
                            'insertdatetime nonbreaking save table contextmenu directionality',
                            'template paste textcolor colorpicker textpattern toc emoticons hr codesample embed_button autoresize'
                        ],
                        toolbar:
                            'embed_button | undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent'
                    }"
                  />
                  <div class="end-tinymce"></div>
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
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
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
                v-model="post.author_name"
                aria-describedby="helpId"
              />
            </div>
            <div class="form-group">
              <label>Design/Photo</label>
              <textarea
                class="form-control"
                name="photo-design"
                rows="3"
                aria-placeholder="Design/Photo"
                placeholder="Design/Photo"
                v-model="post.design_name"
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
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="card-body">
            <ul class="layout-post">
              <li>
                <img
                  src="/images/admin/single_templates/single_template_0.png"
                  v-bind:class="{active: post.layout_name == 0,'img-thumbnail': true}"
                  data-id="0"
                  @click="setPostLayout"
                />
              </li>
              <li>
                <img
                  src="/images/admin/single_templates/single_template_1.png"
                  v-bind:class="{active: post.layout_name == 1,'img-thumbnail': true }"
                  data-id="1"
                  @click="setPostLayout"
                />
              </li>
              <li>
                <img
                  src="/images/admin/single_templates/single_template_2.png"
                  v-bind:class="{active: post.layout_name == 2,'img-thumbnail': true}"
                  data-id="2"
                  @click="setPostLayout"
                />
              </li>
              <li>
                <img
                  src="/images/admin/single_templates/single_template_3.png"
                  v-bind:class="{active: post.layout_name == 3,'img-thumbnail': true}"
                  data-id="3"
                  @click="setPostLayout"
                />
              </li>
            </ul>
          </div>
        </div>
        <search-engine-optimize
          ref="seoForm"
          v-model="seoObj"
          :my-title="post.title"
          :my-slug="post.slug"
          :my-content="post.description"
          :my-description="post.excerpt"
        />
        <div class="card shadow-none">
          <div class="card-header">
            <div class="float-left">
              <h4 class="card-title">Bài viết liên quan</h4>
            </div>
            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="card-body">
            <multiselect
              v-model="selectedRelated"
              label="title"
              track-by="id"
              placeholder="Nhập để tìm hoặc thêm mới"
              open-direction="bottom"
              :options="relatedPostsOptions"
              :multiple="true"
              :searchable="true"
              :loading="isLoadingRelated"
              :internal-search="true"
              :clear-on-select="true"
              :close-on-select="true"
              :options-limit="300"
              :limit="5"
              :limit-text="limitText"
              :max-height="600"
              :show-no-results="false"
              :hide-selected="true"
              @search-change="getPostsRelated"
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
              <label for class="col-sm-12 col-form-label">Trạng thái:</label>
              <div class="col-sm-12">
                <select
                  class="form-control"
                  name="post_status"
                  id="post_status"
                  v-model="post.status"
                >
                  <option value="draft">Bản nháp</option>
                  <option value="pending">Chờ duyệt</option>
                  <option value="private">Riêng tư</option>
                  <option value="return">Trả bài</option>
                  <option value="approved" v-if="this.$can('publish-post')">Đã duyệt</option>
                  <option value="publish" v-if="this.$can('publish-post')">Xuất bản</option>
                </select>
              </div>
            </div>
            <div class="form-group row">
              <label for class="col-sm-12 col-form-label">Đăng lúc:</label>
              <div class="col-sm-12">
                <date-picker type="datetime" v-model="post.date" :format="momentFormat"></date-picker>
              </div>
            </div>
          </div>
          <div class="card-footer text-right">
            <button class="btn btn-primary" type="button" @click.prevent="submitPost">Tạo mới</button>
          </div>
        </div>
        <div class="card shadow-none card-post-format">
          <div class="card-header">
            <div class="float-left">
              <h4 class="card-title">Định dạng</h4>
            </div>
            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
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
                      v-model="post.format"
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
                      v-model="post.format"
                    />
                    <i class="fal fa-video"></i> Video
                  </label>
                </div>
              </li>
            </ul>
          </div>
        </div>
        <div class="card shadow-none card-post-url-video" v-if="post.format == 'video'">
          <div class="card-header">
            <div class="float-left">
              <h4 class="card-title">Url Video</h4>
            </div>
            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
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
                v-model="post.url_video"
              />
            </div>
          </div>
        </div>
        <div class="card shadow-none card-post-category">
          <div class="card-header">
            <div class="float-left">
              <h4 class="card-title">Chuyên mục</h4>
            </div>
            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="card-body">
            <ul class="category-list">
              <li
                v-for="category in categories"
                :key="category.id"
                v-bind:class="[category.parent_id ? 'child' : 'parent' ]"
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
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
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
              :clear-on-select="true"
              :close-on-select="true"
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
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <div class="card-body">
            <img
              src="/images/admin/placeholder.png"
              class="img-fluid img-thumbnail"
              v-if="thumbnail.url == ''"
            />
            <img :src="thumbnail.url" class="img-fluid img-thumbnail" v-if="thumbnail.url" />
            <ThumbnailModal
              v-model="post.thumbnail_id"
              id="thumbnail"
              key="thumbnail"
              @changeThumbnail="changeThumbnail($event)"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import SearchEngineOptimize from "./../widgets/SearchEngineOptimize";
import tinymce from "vue-tinymce-editor";
var moment = require("moment");
import MediaContent from "../widgets/MediaContent";
import Editor from "@tinymce/tinymce-vue";
import "tinymce/tinymce.min.js";
import "../../../plugins/tinymce/embed_button";
export default {
  components: {
    SearchEngineOptimize,
    MediaContent,
    editor: Editor,
  },
  directive: {
    scroll: {
      inserted: function (el, binding) {
        let f = function (evt) {
          if (binding.value(evt, el)) {
            window.removeEventListener("scroll", f);
          }
        };
        window.addEventListener("scroll", f);
      },
    },
  },
  data() {
    return {
      seoObj: {
        title: "",
        description: "",
      },
      post: {
        title: "",
        slug: "",
        excerpt: "",
        is_featured: 0,
        description: "",
        author_name: "",
        design_name: "",
        layout_name: 0,
        seo_id: 0,
        status: "draft",
        date: new Date(),
        role_id: "0",
        format: "default",
        thumbnail_id: "",
        thumbnail_highlight: "",
        url_video: "",
      },
      thumbnail: {
        url: "",
      },
      categories: [],
      selectedCategories: [],
      tagOptions: [],
      selectedTags: [],
      relatedPostsOptions: [],
      selectedRelated: [],
      isLoading: false,
      isLoadingRelated: false,
      errors: [],
      value: null,
      saved: false,
      momentFormat: {
        // Date to String
        stringify: (date) => {
          return date ? moment(date).format("DD/MM/YYYY H:mm:ss") : "";
        },
        // String to Date
        parse: (value) => {
          return value ? moment(value, "DD/MM/YYYY H:mm:ss").toDate() : null;
        },
      },
    };
  },
  methods: {
    changeThumbnail(obj) {
      this.thumbnail.url = obj.url;
    },
    insertMedia(photo) {
      let tagImg = `<img src="${photo.url}" data-mce-src="${photo.url}" style="max-width:100%"/>`;
      let caption = "";
      if (photo.caption != null) {
        caption = `<p class="wp-caption-text aligncenter">${photo.caption}</p><p>&nbsp;</p>`;
      }
      this.$refs.tm.editor.insertContent(tagImg + caption);
    },
    getTaxonomy() {
      axios.get("auth/categories/get-categories").then((data) => {
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
          .then((response) => {
            this.tagOptions = response.data.success.data;
            this.isLoading = false;
          });
      }
    },
    addTag(newTag) {
      const tag = {
        title: newTag,
        id: newTag.substring(0, 2) + Math.floor(Math.random() * 10000000),
      };
      this.tagOptions.push(tag);
      this.selectedTags.push(tag);
    },
    getPostsRelated(query) {
      if (query.length > 2) {
        this.isLoadingRelated = true;
        let paramsData = {};
        paramsData["s"] = query;
        paramsData["per_page"] = 100;
        axios.get("auth/posts", { params: paramsData }).then((response) => {
          this.relatedPostsOptions = response.data.success.data;
          this.isLoadingRelated = false;
        });
      }
    },
    limitText(count) {
      return `và ${count} lựa chọn khác`;
    },
    setPostLayout(e) {
      this.post.layout_name = e.target.dataset.id;
    },
    submitPost() {
      let relatedPostArray = [];
      this.selectedRelated.forEach((e) => {
        relatedPostArray.push(e.id);
      });
      let dataForm = this.post;
      dataForm.categories_id = this.selectedCategories;
      dataForm.related_posts = relatedPostArray;
      dataForm.selectedTags = this.selectedTags;
      dataForm.seo = this.seoObj;
      axios
        .post("auth/posts", dataForm)
        .then((rs) => {
          let post_id = rs.data.success.id;
          this.$toastr.success("Thành công", "Thêm thành công");
          this.$router.push({
            path: "/admin/posts",
          });
        })
        .catch((error) => {
          let list_error = "";
          Object.values(error.response.data.errors).forEach(
            (e) => (list_error += `<li>${e}</li>`)
          );
          this.errors = error.response.data.errors;
          this.$toastr.error(list_error, "Lỗi");
        });
      this.saved = true;
    },
    handleScroll: function (evt, el) {
      let mce = document.querySelector(".mce-top-part");
      let media_content = document.querySelector(".btn-add-media");
      if (
        document.querySelector(".group-content").getBoundingClientRect().top <=
          0 &&
        document.querySelector(".end-tinymce").getBoundingClientRect().top > 300
      ) {
        mce.style.position = "fixed";
        mce.style.top = "25px";
        mce.style.width = this.getMceOffest().width - 2 + "px";
        media_content.style.position = "fixed";
        media_content.style.top = "0px";
        media_content.style.width = this.getMceOffest().width - 2 + "px";
        document.querySelector(".group-content").classList.add("fixed");
      } else {
        mce.style.position = "inherit";
        media_content.style.position = "inherit";
        document.querySelector(".group-content").classList.remove("fixed");
      }
    },
    getMceOffest() {
      return {
        height: document.querySelector(".mce-panel").offsetHeight,
        width: document.querySelector(".mce-panel").offsetWidth,
      };
    },
  },
  created() {
    window.addEventListener("scroll", this.handleScroll);
    this.getTaxonomy();
  },
  destroyed() {
    window.removeEventListener("scroll", this.handleScroll);
  },
  beforeRouteLeave(to, from, next) {
    if (!this.saved) {
      const answer = window.confirm(
        "--- Thông báo là bài viết chưa được lưu ---\nCó không giữ mất đừng tìm! Ok để rời đi"
      );
      if (answer) {
        next();
      } else {
        next(false);
      }
    } else {
      next();
    }
  },
};
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
<style lang="scss">
.post-create {
  padding-bottom: 60px;
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
    .category-list {
      .parent {
        font-weight: bold;
      }
      .child {
        padding-left: 15px;
      }
    }
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
      .img-thumbnail {
        cursor: pointer;
        &.active {
          border: 3px solid #4db2ec;
        }
      }
    }
  }
}
.media-content {
  .btn-add-media {
    background: #fff;
    z-index: 99;
  }
}
</style>
