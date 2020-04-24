<template>
  <section>
    <div class="row mb-4">
      <div class="col-lg-12 margin-tb">
        <div class="float-left">
          <h2>Danh sách vai trò</h2>
        </div>
        <div class="float-right">
          <div class="button-box">
            <router-link
              :to="{ name: 'role-create' }"
              class="btn btn-primary"
              v-if="$can('role-create')"
            >Thêm mới</router-link>
          </div>
        </div>
      </div>
    </div>
    <div class="card border-0 shadow-none">
      <div class="card-body">
        <div class="error" v-if="error.message.length">
          <div class="alert alert-danger" role="alert">{{ error.message }}</div>
        </div>
        <div class="success" v-if="status === 'success'">
          <div class="alert alert-success" role="alert">{{ message }}</div>
        </div>
        <div>
          <table class="table table-bordered">
            <thead>
              <tr>
                <th scope="col">ID</th>
                <th scope="col">Tên</th>
                <th scope="col" class="text-center">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(role, index) in roles" :key="'role-' + index">
                <th scope="row">{{ role.id }}</th>
                <td>{{ role.name }}</td>
                <td class="text-center" width="160px">
                  <button class="btn btn-success">
                    <i class="far fa-eye"></i>
                  </button>
                  <router-link
                    :to="{name: 'role-edit', params: { id: role.id }}"
                    v-if="$can('role-edit')"
                    class="btn btn-warning"
                  >
                    <i class="far fa-pencil"></i>
                  </router-link>
                  <button
                    class="btn btn-danger"
                    @click="deleteRole(role.id)"
                    v-if="$can('role-delete')"
                  >
                    <i class="far fa-trash"></i>
                  </button>
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
export default {
  props: {
    message: String,
    status: ""
  },
  data() {
    return {
      roles: [],
      error: {
        message: ""
      }
    };
  },
  created() {
    this.getRoles();
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
    deleteRole(roleId) {
      let url = "/auth/roles/" + roleId;
      if (confirm("Bạn đang muốn xóa")) {
        axios
          .delete(url)
          .then(rs => {
            this.getRoles();
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  }
};
</script>

<style>
</style>
