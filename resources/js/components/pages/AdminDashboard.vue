<template>
  <div class="content-app">
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
      <!-- Left navbar links -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#" role="button">
            <i class="fas fa-bars"></i>
          </a>
        </li>
      </ul>
      <!-- Right navbar links -->
      <ul class="navbar-nav ml-auto">
        <li class="dropdown user user-menu">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
            <img src="/images/admin/logo.png" class="user-image" alt="User Image" />
            <span class="hidden-xs">{{ this.$auth.user().user.name }}</span>
          </a>
          <ul class="dropdown-menu" style="width: 150px">
            <a href="#" class="dropdown-item">
              <i class="fal fa-user"></i> Xem hồ sơ
            </a>
            <a href="#" @click.prevent="logout()" class="dropdown-item">
              <i class="fal fa-power-off"></i> Thoát
            </a>
          </ul>
        </li>
      </ul>
    </nav>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
      <!-- Brand Logo -->
      <a href="/admin" class="brand-link">
        <img
          src="/images/admin/AdminLTELogo.png"
          alt="AdminLTE Logo"
          class="brand-image img-circle elevation-3"
          style="opacity: .8"
        />
        <span class="brand-text font-weight-light">Admin Billboard</span>
      </a>

      <!-- Sidebar -->
      <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
          <div class="image">
            <img
              src="/images/admin/user2-160x160.jpg"
              class="img-circle elevation-2"
              alt="User Image"
            />
          </div>
          <div class="info">
            <a href="#" class="d-block">{{ this.$auth.user().user.name }}</a>
          </div>
        </div>
        <!-- Sidebar Menu -->
        <sidebarMenu></sidebarMenu>
        <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <section class="content pt-3">
        <div class="container-fluid">
          <router-view></router-view>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    logout: function() {
      axios
        .post("/auth/logout")
        .then(response => {
          if (response.data.status === "success") {
            document.location.href = "/login";
          }
        })
        .catch(error => {
          if (error.status === 302 || 401) {
            document.location.href = "/login";
          } else {
            // throw error and go to catch block
          }
        });
    }
  },
  created() {
    window.Permissions = this.$auth.user().permissions;
    console.log("quyền User Login: " + this.$auth.user().permissions);
  }
};
</script>

<style lang="scss" scoped>
.container {
  margin-top: 50px;
  .user-login {
    text-align: right;
  }
  .main-content {
    margin-top: 50px;
  }
}
</style>
