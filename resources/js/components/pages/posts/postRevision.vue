<template>
  <section>
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Lịch sử bài viết</h2>
        </div>
      </div>
    </div>
    <div class="card text-left shadow-none">
      <div class="card-header">
        <h4 class="card-title">Chọn để so sánh</h4>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <form method="GET" id="form-revision-post" @submit.prevent="submitRevisionForm">
            <table class="table table-borderless table-striped table-data">
              <thead class="thead-light">
                <th scope="col">Lựa chọn</th>
                <th scope="col">Tiêu đề</th>
                <th scope="col">Tác giả</th>
                <th scope="col">Trạng thái</th>
                <th scope="col">Date</th>
                <th scope="col">Hành động</th>
              </thead>
              <tbody>
                <tr>
                  <td scope="col">
                    <input
                      class="post-id"
                      type="checkbox"
                      name="post_id"
                      value="0"
                      v-model="id_check"
                      @change="checkPost($event)"
                    />
                  </td>
                  <td scope="col">{{post_main.title }} (*)</td>
                  <td scope="col">{{ post_main.user_name }}</td>
                  <td scope="col">{{ post_main.status }}</td>
                  <td scope="col">{{ post_main.date }}</td>
                  <td scope="col"></td>
                </tr>
                <tr v-for="post in posts_revision" :key="post.id">
                  <td scope="col">
                    <input
                      class="post-id"
                      type="checkbox"
                      name="post_id"
                      v-bind:value="post.id"
                      v-model="id_check"
                      @change="checkPost($event)"
                    />
                  </td>
                  <td scope="col">{{ post.title }}</td>
                  <td scope="col">{{ post.user_name }}</td>
                  <td scope="col">{{ post.status }}</td>
                  <td scope="col">{{ post.date }}</td>
                  <td scope="col">
                    <button class="btn btn-primary" type="button" @click="restore(post)">Khôi phục</button>
                  </td>
                </tr>
              </tbody>
            </table>
            <div class="button-so-sanh">
              <button class="btn btn-primary" type="submit">So sánh</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none" style="overflow: auto;">
      <div class="card-body" id="card-compare">
        <div class="block-title">
          <h3>Tiêu đề</h3>
          <hr />
          <div class="row">
            <div class="col-md-6">
              <div class="after">
                <div class="title-post-compare title-after"></div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="before">
                <div class="title-post-compare title-before"></div>
              </div>
            </div>
          </div>
        </div>
        <hr />
        <div class="block-excerpt">
          <h3>Tóm tắt</h3>
          <hr />
          <div class="row">
            <div class="col-md-6">
              <div class="after">
                <div class="excerpt-post-compare excerpt-after"></div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="before">
                <div class="excerpt-post-compare excerpt-before"></div>
              </div>
            </div>
          </div>
        </div>
        <hr />
        <div class="block-status">
          <h3>Trạng thái</h3>
          <hr />
          <div class="row">
            <div class="col-md-6">
              <div class="after">
                <div class="status-post-compare status-after"></div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="before">
                <div class="status-post-compare status-before"></div>
              </div>
            </div>
          </div>
        </div>
        <hr />
        <div class="block-description">
          <h3>Nội dung</h3>
          <hr />
          <div class="row">
            <div class="col-md-6">
              <div class="after">
                <div class="description-post-compare description-after"></div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="before">
                <div class="description-post-compare description-before"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import toastr from "toastr";
// require("colors");
var jsdiff = require("diff");
import "toastr/build/toastr.min.css";
export default {
  props: {
    id: {
      require: true,
    },
  },
  data() {
    return {
      ids: {},
      id_check: [],
      post_main: {},
      posts_revision: {},
      post_before: {},
      post_after: {},
    };
  },
  methods: {
    getPostsRevision(id) {
      let dataForm = {
        post_id: this.id,
      };
      axios
        .get("/auth/revision/", { params: dataForm })
        .then((response) => {
          this.posts_revision = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getPost(id) {
      axios
        .get("/auth/posts/" + id)
        .then((response) => {
          if (response.data.success) {
            this.post_main = response.data.success;
          } else {
            this.$toastr.error("Lỗi", response.data.errors);
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getPostsCompare(ids) {
      let dataForm = {
        include: ids,
      };
      axios
        .get("/auth/revision", { params: dataForm })
        .then((response) => {
          let diff_title = "",
            diff_excerpt = "",
            diff_status = "",
            diff_description = "";
          // compare
          if (response.data.length == 2) {
            diff_title = this.diff(
              response.data[1].title,
              response.data[0].title
            );
            // excerpt-post-compare
            diff_excerpt = this.diff(
              response.data[1].excerpt,
              response.data[0].excerpt
            );
            // status-post-compare
            diff_status = this.diff(
              response.data[1].status,
              response.data[0].status
            );
            // description-post-compare
            diff_description = this.diff(
              response.data[1].description,
              response.data[0].description
            );
          } else {
            Object.assign(this.post_after, this.post_main);
            this.post_before = response.data[0];
            //
            diff_title = this.diff(
              response.data[0].title,
              this.post_after.title
            );
            // excerpt-post-compare
            diff_excerpt = this.diff(
              response.data[0].excerpt,
              this.post_after.excerpt
            );
            // status-post-compare
            diff_status = this.diff(
              response.data[0].status,
              this.post_after.status
            );
            // description-post-compare
            diff_description = this.diff(
              response.data[0].description,
              this.post_after.description
            );
          }
          // title-post-compare show
          this.diffShow(
            ".title-before",
            ".title-after",
            diff_title.before,
            diff_title.after
          );
          // excerpt-post-compare show
          this.diffShow(
            ".excerpt-before",
            ".excerpt-after",
            diff_excerpt.before,
            diff_excerpt.after
          );
          // status-post-compare show
          this.diffShow(
            ".status-before",
            ".status-after",
            diff_status.before,
            diff_status.after
          );
          // description-post-compare show
          this.diffShow(
            ".description-before",
            ".description-after",
            diff_description.before,
            diff_description.after
          );
        })
        .catch((error) => {
          console.log(error);
        });
    },
    checkPost(e) {
      // if (this.id_check.length == 2) {
      //   document
      //     .querySelectorAll('input[type="checkbox"]:not(:checked)')
      //     .setAttribute("disabled", "true");
      // } else {
      //   document
      //     .querySelectorAll('input[type="checkbox"]:not(:checked)')
      //     .setAttribute("disabled", "false");
      // }
    },
    submitRevisionForm(e) {
      let ids = [];
      let post_id_checked = document.querySelectorAll(".post-id:checked");
      for (let i = 0; i < post_id_checked.length; i++) {
        if (post_id_checked[i].value != 0) {
          ids.push(post_id_checked[i].value);
        }
      }
      this.getPostsCompare(ids.toString());
    },
    diff(before, after) {
      var fragment = document.createDocumentFragment(),
        fragment2 = document.createDocumentFragment();
      var span1 = null,
        span2 = null;
      var result = {
        before: "",
        after: "",
      };
      if (before == null || after == null) {
        span1 = document.createElement("span");
        span2 = document.createElement("span");
        span1.appendChild(document.createTextNode(after));
        fragment.appendChild(span1);
        span2.appendChild(document.createTextNode(before));
        fragment2.appendChild(span2);
        result.before = fragment;
        result.after = fragment2;
        return result;
      }
      var diff = jsdiff.diffWords(before, after);
      diff.forEach(function (part) {
        span1 = document.createElement("span");
        span2 = document.createElement("span");
        if (part.removed) {
          span1.style.color = "orange";
          span1.style.fontWeight = "bold";
          span1.appendChild(document.createTextNode(part.value));
          fragment.appendChild(span1);
        } else if (part.added) {
          span2.style.color = "red";
          span2.style.fontWeight = "bold";
          span2.appendChild(document.createTextNode(part.value));
          fragment2.appendChild(span2);
        } else {
          span1.appendChild(document.createTextNode(part.value));
          fragment.appendChild(span1);
          span2.appendChild(document.createTextNode(part.value));
          fragment2.appendChild(span2);
        }
      });
      result.before = fragment;
      result.after = fragment2;
      return result;
    },
    diffShow(classBefore, classAfter, dataBefore, dataAfter) {
      document.querySelector(classBefore).innerHTML = "";
      document.querySelector(classAfter).innerHTML = "";
      document.querySelector(classBefore).appendChild(dataBefore);
      document.querySelector(classAfter).appendChild(dataAfter);
    },
    restore(post) {
      let dataForm = post;
      axios
        .put("auth/posts/restore-revision/" + post.id, dataForm)
        .then((rs) => {
          let post_id = rs.data.success.id;
          this.$toastr.success("Thành công", "Khôi phục thành công");
          this.getPostsRevision(this.id);
          this.getPost(this.id);
        })
        .catch((error) => {
          let list_error = "";
          Object.values(error.response.data.errors).forEach(
            (e) => (list_error += `<li>${e}</li>`)
          );
          this.errors = error.response.data.errors;
          this.$toastr.error(list_error, "Lỗi");
        });
    },
  },
  created() {
    this.getPostsRevision(this.id);
    this.getPost(this.id);
  },
};
</script>
