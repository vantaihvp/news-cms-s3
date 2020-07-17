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
              </thead>
              <tbody>
                <tr>
                  <td scope="col">
                    <input class="post-id" type="checkbox" name="post_id" value="0" />
                  </td>
                  <td scope="col">{{post_main.title }} (*)</td>
                  <td scope="col">{{ post_main.user_id }}</td>
                  <td scope="col">{{ post_main.status }}</td>
                  <td scope="col">{{ post_main.date }}</td>
                </tr>
                <tr v-for="post in posts_revision" :key="post.id">
                  <td scope="col">
                    <input class="post-id" type="checkbox" name="post_id" v-bind:value="post.id" />
                  </td>
                  <td scope="col">{{ post.title }}</td>
                  <td scope="col">{{ post.user_id }}</td>
                  <td scope="col">{{ post.status }}</td>
                  <td scope="col">{{ post.date }}</td>
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
      <div class="card-body" id="card-compare" style="width: 1400px">
        <h3>Tiêu đề</h3>
        <div class="table-2">
          <table class="table table-borderless table-compare">
            <tbody>
              <tr>
                <td class="after">
                  <div style="width:700px" v-html="post_after.title"></div>
                </td>
                <td class="before">
                  <div style="width:700px" v-html="post_before.title"></div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <h3>Nội dung</h3>
        <div class="table-2">
          <table class="table table-borderless">
            <tbody>
              <tr>
                <td>
                  <div style="width:700px" v-html="post_after.description"></div>
                </td>
                <td>
                  <div style="width:700px" v-html="post_before.description"></div>
                </td>
              </tr>
            </tbody>
          </table>
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
      require: true
    }
  },
  data() {
    return {
      ids: {},
      post_main: {},
      posts_revision: {},
      post_before: {},
      post_after: {}
    };
  },
  methods: {
    getPostsRevision(id) {
      let dataForm = {
        post_id: this.id
      };
      axios
        .get("/auth/revision/", { params: dataForm })
        .then(response => {
          this.posts_revision = response.data;
        })
        .catch(error => {
          console.log(error);
        });
    },
    getPost(id) {
      axios
        .get("/auth/posts/" + id)
        .then(response => {
          if (response.data.success) {
            this.post_main = response.data.success;
          } else {
            this.$toastr.error("Lỗi", response.data.errors);
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    getPostsCompare(ids) {
      let dataForm = {
        include: ids
      };
      axios
        .get("/auth/revision", { params: dataForm })
        .then(response => {
          console.log(response);
          // compare
          if (response.data.length == 2) {
            this.post_after = response.data[0];
            this.post_before = response.data[1];
            this.post_after.title = this.diff(
              response.data[1].title,
              response.data[0].title
            );
            this.post_after.description = this.diff(
              response.data[1].description,
              response.data[0].description
            );
          } else {
            Object.assign(this.post_after, this.post_main);
            //this.post_after = this.post_main;
            this.post_before = response.data[0];
            this.post_after.title = this.diff(
              response.data[0].title,
              this.post_after.title
            );
            this.post_after.description = this.diff(
              response.data[0].description,
              this.post_after.description
            );
          }
        })
        .catch(error => {
          console.log(error);
        });
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
      var bgColor = "";
      var span = "";
      var diff = jsdiff.diffChars(before, after);
      var fragment = "";
      diff.forEach(function(part) {
        // green for additions, red for deletions
        // grey for common parts
        bgColor = part.added ? "green" : part.removed ? "red" : "white";
        let color = "black";
        let padding = "0";
        if (bgColor != "white") {
          color = "white";
          padding = "0px 5px";
        }
        span += `<span style="color: ${color}; background-color: ${bgColor};">${part.value}</span>`;
      });
      return span;
    }
  },
  created() {
    this.getPostsRevision(this.id);
    this.getPost(this.id);
  }
};
</script>
