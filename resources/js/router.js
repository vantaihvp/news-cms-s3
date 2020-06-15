import VueRouter from "vue-router";

// Pages
import Home from "./components/pages/Home";
import Register from "./components/pages/Register";
import Login from "./components/pages/Login";
import AdminDashboard from "./components/pages/AdminDashboard";
import UserDashboard from "./components/pages/user/UserDashboard";
import UserList from "./components/pages/user/UserList";
import UserCreate from "./components/pages/user/UserCreate";
import UserEdit from "./components/pages/user/UserEdit";
import RoleDashboard from "./components/pages/role/RoleDashboard";
import RoleList from "./components/pages/role/RoleList";
import RoleCreate from "./components/pages/role/RoleCreate";
import RoleEdit from "./components/pages/role/RoleEdit";
//Category
import CategoryDashboard from "./components/pages/category/CategoryDashboard";
import CategoryList from "./components/pages/category/CategoryList";
import CategoryEdit from "./components/pages/category/CategoryEdit";
import CategoryCreate from "./components/pages/category/CategoryCreate";
//Tags
import tagDashboard from "./components/pages/tag/tagDashboard";
import tagList from "./components/pages/tag/tagList";
import tagEdit from "./components/pages/tag/tagEdit";
import tagCreate from "./components/pages/tag/tagCreate";
//posts
import postDashboard from "./components/pages/posts/postDashboard";
import postList from "./components/pages/posts/postList";
import postEdit from "./components/pages/posts/postEdit";
import postCreate from "./components/pages/posts/postCreate";
//Photos
import photoDashboard from "./components/pages/photo/photoDashboard";
import photoList from "./components/pages/photo/photoList";
//Ads banner
import adsBannerDashboard from "./components/pages/ads/adsBanner/adsBannerDashboard";
import adsBannerList from "./components/pages/ads/adsBanner/adsBannerList";
import adsBannerCreate from "./components/pages/ads/adsBanner/adsBannerCreate";
//Ads zone
import adsZoneDashboard from "./components/pages/ads/adsZone/adsZoneDashboard";
import adsZoneList from "./components/pages/ads/adsZone/adsZoneList";
import adsZoneCreate from "./components/pages/ads/adsZone/adsZoneCreate";
// Routes
const routes = [{
        path: "/",
        name: "home",
        component: Home,
        meta: {
            auth: undefined
        }
    },
    {
        path: "/register",
        name: "register",
        component: Register,
        meta: {
            auth: false
        }
    },
    {
        path: "/login",
        name: "login",
        component: Login,
        meta: {
            auth: false
        }
    },
    // ADMIN ROUTES
    {
        path: "/admin",
        name: "admin-dashboard",
        component: AdminDashboard,
        meta: {
            auth: true
        },
        children: [{
                path: "categories",
                name: "category-dashboard",
                component: CategoryDashboard,
                children: [{
                        path: "",
                        name: "category-list",
                        component: CategoryList
                    },
                    {
                        path: "create",
                        name: "category-create",
                        component: CategoryCreate
                    },
                    {
                        path: "edit/:id",
                        name: "category-edit",
                        component: CategoryEdit,
                        props: true
                    }
                ]
            },
            {
                path: "tags",
                name: "tag-dashboard",
                component: tagDashboard,
                children: [{
                        path: "",
                        name: "tag-list",
                        component: tagList
                    },
                    {
                        path: "create",
                        name: "tag-create",
                        component: tagCreate
                    },
                    {
                        path: "edit/:id",
                        name: "tag-edit",
                        component: tagEdit,
                        props: true
                    }
                ]
            },
            {
                path: "posts",
                name: "post-dashboard",
                component: postDashboard,
                children: [{
                        path: "",
                        name: "post-list",
                        component: postList
                    },
                    {
                        path: "create",
                        name: "post-create",
                        component: postCreate
                    },
                    {
                        path: "edit/:id",
                        name: "post-edit",
                        component: postEdit,
                        props: true
                    }
                ]
            },
            {
                path: "photos",
                name: "photo.dashboard",
                component: photoDashboard,
                children: [{
                    path: "",
                    name: "photo.list",
                    component: photoList
                }, ]
            },
            {
                path: "ads-banner",
                name: "ads-banner-dashboard",
                component: adsBannerDashboard,
                children: [{
                        path: "",
                        name: "ads-banner-list",
                        component: adsBannerList
                    },
                    {
                        path: "create",
                        name: "ads-banner-create",
                        component: adsBannerCreate
                    },
                    {
                        path: "edit/:id",
                        name: "ads-banner-edit",
                        component: adsBannerCreate,
                        props: true
                    }
                ]
            },
            {
                path: "ads-zone",
                name: "ads-zone-dashboard",
                component: adsZoneDashboard,
                children: [{
                        path: "",
                        name: "ads-zone-list",
                        component: adsZoneList
                    },
                    {
                        path: "create",
                        name: "ads-zone-create",
                        component: adsZoneCreate
                    },
                    {
                        path: "edit/:id",
                        name: "ads-zone-edit",
                        component: adsZoneCreate,
                        props: true
                    }
                ]
            },
            {
                path: "users",
                name: "user-dashboard",
                component: UserDashboard,
                children: [{
                        path: "",
                        name: "user-list",
                        component: UserList
                    },
                    {
                        path: "create",
                        name: "user-create",
                        component: UserCreate
                    },
                    {
                        path: "edit/:id",
                        name: "user-edit",
                        component: UserEdit,
                        props: true
                    }
                ]
            },
            {
                path: "roles",
                name: "role-dashboard",
                component: RoleDashboard,
                children: [{
                        path: "",
                        name: "role-list",
                        component: RoleList
                    },
                    {
                        path: "create",
                        name: "role-create",
                        component: RoleCreate
                    },
                    {
                        path: "edit/:id",
                        name: "role-edit",
                        component: RoleEdit,
                        props: true
                    }
                ]
            }
        ]
    }
];
const router = new VueRouter({
    history: true,
    mode: "history",
    linkExactActiveClass: 'active',
    routes
});
export default router;
