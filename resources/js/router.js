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
                path: "user",
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
