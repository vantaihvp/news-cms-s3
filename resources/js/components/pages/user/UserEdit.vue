<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Chỉnh sửa thành viên #{{ id }}</h2>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card shadow-none border-0">
          <div class="card-body" id="user-create">
            <div class="error" v-if="errors.length">
              <div class="alert alert-danger" role="alert">
                <span v-for="(err, index) in errors" :key="index">{{ err }}</span>
                <hr />
              </div>
            </div>
            <form action method="POST" @submit.prevent="submitEditUser">
              <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label class="lable-required">Họ tên:</label>
                    <input type="text" v-model="name" name="name" class="form-control" required />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Bút danh:</label>
                    <input type="text" v-model="pseudonym" name="pseudonym" class="form-control" />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label class="lable-required">Email:</label>
                    <input type="email" v-model="email" name="email" class="form-control" disabled />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Mật khẩu:</label>
                    <input type="password" v-model="password" name="password" class="form-control" />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Nhập lại Mật khẩu:</label>
                    <input
                      type="password"
                      v-model="confirmPassword"
                      name="confirm-password"
                      class="form-control"
                    />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label class="lable-required">Điện thoại:</label>
                    <input
                      type="tel"
                      v-model="phoneNumber"
                      name="phone_number"
                      class="form-control"
                      required
                    />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Vai trò:</label>
                    <select name="roles" class="form-control" v-model="form.role">
                      <option
                        v-for="role in roles"
                        v-bind:key="role.id"
                        v-bind:value="role.name"
                        :selected="role.name==roleName"
                      >{{ role.name }}</option>
                    </select>
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label>Mô tả thêm</label>
                    <textarea
                      class="form-control"
                      v-model="description"
                      name="description"
                      rows="3"
                    ></textarea>
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 text-right">
                  <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
              </div>
            </form>
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
  props: ["id"],
  data() {
    return {
      form: [role => ""],
      name: "",
      pseudonym: "",
      email: "",
      password: "",
      confirmPassword: "",
      phoneNumber: "",
      description: "",
      roleName: "",
      roles: [],
      errors: []
    };
  },
  methods: {
    getRoles() {
      axios
        .get("/auth/roles")
        .then(rs => {
          if (rs.status === 200) {
            this.roles = rs.data;
          }
        })
        .catch(error => {
          this.errors = error;
          console.log(error);
        });
    },
    getUser() {
      axios
        .get("/auth/users/" + this.id)
        .then(response => {
          this.name = response.data.success.user.name;
          this.pseudonym = response.data.success.user.pseudonym;
          this.email = response.data.success.user.email;
          this.phoneNumber = response.data.success.user.phone_number;
          this.description = response.data.success.user.description;
          this.roleName = Object.keys(response.data.success.userRole)[0];
          this.form.role = this.roleName;
        })
        .catch(error => {
          console.log(error);
        });
    },
    submitEditUser(event) {
      // let formData = new FormData(event.currentTarget);
      let dataForm = {
        name: this.name,
        pseudonym: this.pseudonym,
        email: this.email,
        password: this.password,
        "confirm-password": this.confirmPassword,
        phone_number: this.phoneNumber,
        roles: this.form.role,
        description: this.description
      };
      axios
        .put("/auth/users/" + this.id, dataForm)
        .then(rs => {
          toastr.success("Thành công", "Chỉnh sửa thành công");
          this.$router.push({
            path: "/admin/user"
          });
        })
        .catch(error => {
          console.log("--------");
          this.errors = error.response.data.errors;
          console.log(error.response.data.errors);
          toastr.error("Lỗi!", "Chỉnh sửa không thành công");
          // console.log(error);
        });
    }
  },
  created() {
    this.getRoles();
    this.getUser();
  }
};
</script>

<style></style>
