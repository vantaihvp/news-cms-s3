<template>
  <div class="user-create">
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Thêm thành viên</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link :to="{ name: 'user-list' }" class="btn btn-primary">Danh sách</router-link>
          </div>
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
            <form action method="POST" @submit.prevent="submitCreateUser">
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
                    <input type="email" v-model="email" name="email" class="form-control" required />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label class="lable-required">Mật khẩu:</label>
                    <input
                      type="password"
                      v-model="password"
                      name="password"
                      class="form-control"
                      required
                    />
                  </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                  <div class="form-group">
                    <label class="lable-required">Nhập lại Mật khẩu:</label>
                    <input
                      type="password"
                      v-model="confirmPassword"
                      name="confirm-password"
                      class="form-control"
                      required
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
                    <select v-model="roles" name="roles" class="form-control">
                      <option
                        v-for="role in roles_data"
                        v-bind:key="role.id"
                        v-bind:value="role.id"
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
                  <button type="submit" class="btn btn-primary">Thêm</button>
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
export default {
  data() {
    return {
      name: "",
      pseudonym: "",
      email: "",
      password: "",
      confirmPassword: "",
      phoneNumber: "",
      roles: "",
      description: "",
      roles_data: [],
      errors: []
    };
  },
  methods: {
    getRoles() {
      axios
        .get("auth/roles")
        .then(rs => {
          if (rs.status === 200) {
            this.roles_data = rs.data;
            this.roles = rs.data[0].id;
          }
        })
        .catch(error => {
          this.errors = error;
          console.log(error);
        });
    },
    submitCreateUser(event) {
      let dataForm = {
        name: this.name,
        pseudonym: this.pseudonym,
        email: this.email,
        password: this.password,
        "confirm-password": this.confirmPassword,
        phone_number: this.phoneNumber,
        roles: this.roles,
        description: this.description
      };
      console.log(dataForm);
      axios
        .post("auth/users", dataForm)
        .then(rs => {
          this.$router.push({
            path: "/admin/user",
            params: { message: "Thêm thành công" }
          });
        })
        .catch(error => {
          this.errors = error.response.data.errors;
        });
    }
  },
  created() {
    this.getRoles();
  }
};
</script>

<style></style>
