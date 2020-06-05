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
import ThumbnailModal from "./components/pages/widgets/ThumbnailModal";
import Permissions from "./components/admin/mixins/Permissions";
import Multiselect from "vue-multiselect";
import DatePicker from "vue2-datepicker";
import "vue2-datepicker/index.css";
import VueToastr2 from "vue-toastr-2";
import "vue-toastr-2/dist/vue-toastr-2.min.css";
window.toastr = require("toastr");
window.urlWeb = `${process.env.MIX_APP_URL}`;
import tinymce from 'vue-tinymce-editor';
Vue.mixin(Permissions);
// Set Vue globally
window.Vue = Vue;
// Set Vue router
Vue.router = router;
Vue.component('tinymce', tinymce)
Vue.use(VueRouter);
Vue.use(VueToastr2);
Vue.use(DatePicker);
// Set Vue authentication
Vue.use(VueAxios, axios);
axios.defaults.baseURL = `${process.env.MIX_APP_URL}/api`;
Vue.use(VueAuth, auth);

// Load Index
Vue.component("index", Index);
Vue.component("sidebarMenu", sidebarMenu);
Vue.component("ThumbnailModal", ThumbnailModal);
Vue.component("pagination", require("laravel-vue-pagination"));
Vue.component("multiselect", Multiselect);
const app = new Vue({
    el: "#app",
    router
});
