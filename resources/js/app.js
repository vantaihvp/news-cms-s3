require("./bootstrap");
import "es6-promise/auto";
import axios from "axios";
import Vue from "vue";
import VueAuth from "@websanova/vue-auth";
import VueAxios from "vue-axios";
import VueRouter from "vue-router";
import Index from "./components/Index";
import auth from "./auth";
import router from "./router";
import sidebarMenu from "./components/widgets/sidebarMenu";
import Permissions from "./components/admin/mixins/Permissions";

Vue.mixin(Permissions);
// Set Vue globally
window.Vue = Vue;
// Set Vue router
Vue.router = router;
Vue.use(VueRouter);
// Set Vue authentication
Vue.use(VueAxios, axios);
axios.defaults.baseURL = `${process.env.MIX_APP_URL}/api`;
Vue.use(VueAuth, auth);

// Load Index
Vue.component("index", Index);
Vue.component("sidebarMenu", sidebarMenu);
Vue.component('pagination', require('laravel-vue-pagination'));
const app = new Vue({
    el: "#app",
    router
});
