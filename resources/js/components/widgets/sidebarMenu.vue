<template>
  <nav class="mt-2">
    <ul
      class="nav nav-pills nav-sidebar flex-column"
      data-widget="treeview"
      role="menu"
      data-accordion="false"
    >
      <li class="nav-item has-treeview" @click="toggleMenu">
        <a href="#" class="nav-link">
          <i class="fal fa-users"></i>
          <p>
            Bài viết
            <i class="fas fa-angle-left right"></i>
          </p>
        </a>
        <ul class="nav nav-treeview">
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'post-list' }"
              v-if="this.$can('post-list')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Danh sách bài viết</p>
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'post-create' }"
              v-if="this.$can('post-create')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Thêm bài viết</p>
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'category-list' }"
              v-if="this.$can('category-list')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Chuyên mục</p>
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'tag-list' }"
              v-if="this.$can('tag-list')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Tags</p>
            </router-link>
          </li>
        </ul>
      </li>
      <li class="nav-item" v-if="this.$can('photo-list')">
        <router-link class="nav-link" :to="{ name: 'photo.list' }">
          <i class="fas fa-photo-video"></i>
          <p>Thư viện</p>
        </router-link>
      </li>
      <li class="nav-item has-treeview" @click="toggleMenu">
        <a href="#" class="nav-link">
          <i class="fal fa-users"></i>
          <p>
            Thành viên
            <i class="fas fa-angle-left right"></i>
          </p>
        </a>
        <ul class="nav nav-treeview">
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'user-list' }"
              v-if="this.$can('user-list')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Danh sách thành viên</p>
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'user-create' }"
              v-if="this.$can('user-create')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Thêm thành viên</p>
            </router-link>
          </li>
        </ul>
      </li>
      <!-- <li class="nav-header">PHÂN QUYỀN</li> -->
      <li class="nav-item has-treeview" @click="toggleMenu">
        <a href="#" class="nav-link">
          <i class="fal fa-users"></i>
          <p>
            Vai trò
            <i class="fas fa-angle-left right"></i>
          </p>
        </a>
        <ul class="nav nav-treeview">
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'role-list' }"
              v-if="this.$can('role-list')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Danh sách vai trò</p>
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              exact
              class="nav-link"
              :to="{ name: 'role-create' }"
              v-if="this.$can('role-create')"
            >
              <i class="far fa-circle nav-icon"></i>
              <p>Thêm vai trò</p>
            </router-link>
          </li>
        </ul>
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  methods: {
    toggleMenu(e) {
      var menu = e.currentTarget; // Using a class instead, see note below.
      menu.classList.add("menu-open");
      // var x = e.currentTarget.querySelector("ul");
      // if (x.style.display === "none") {
      //   x.style.display = "block";
      // } else {
      //   x.style.display = "none";
      // }
    }
  },
  created() {}
};
</script>

<style></style>
