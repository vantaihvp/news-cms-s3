<template>
    <section>
        <div class="row mb-4">
            <div class="col-lg-12 margin-tb">
                <div class="float-left">
                    <h2>Danh sách thành viên</h2>
                </div>
                <div class="float-right">
                    <div class="d-flex">
                        <form
                            method="get"
                            class="form-inline mr-3"
                            @submit.prevent="getResults(1)"
                        >
                            <div class="input-group input-group">
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="searchText"
                                />
                                <span class="input-group-append">
                                    <button
                                        type="button"
                                        class="btn btn-danger"
                                        v-if="searchText"
                                        @click="resetData()"
                                    >
                                        X
                                    </button>
                                    <button
                                        type="submit"
                                        class="btn btn-primary"
                                    >
                                        Tìm
                                    </button>
                                </span>
                            </div>
                        </form>
                        <div class="button-box">
                            <router-link
                                :to="{ name: 'user-create' }"
                                class="btn btn-primary"
                                v-if="this.$can('user-create')"
                                >Thêm mới</router-link
                            >
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card border-0 shadow-none">
            <div class="card-body">
                <div class="error" v-if="error.message.length">
                    <div class="alert alert-danger" role="alert">
                        {{ error.message }}
                    </div>
                </div>
                <div class="success" v-if="status === 'success'">
                    <div class="alert alert-success" role="alert">
                        {{ message }}
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Họ tên</th>
                                <th scope="col">Bút danh</th>
                                <th scope="col">Email</th>
                                <th scope="col">Phone</th>
                                <th scope="col">Vai trò</th>
                                <th scope="col" class="text-center">
                                    Hành động
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="user in users.data" :key="user.id">
                                <th scope="row">{{ user.id }}</th>
                                <td>{{ user.name }}</td>
                                <td>{{ user.pseudonym }}</td>
                                <td>{{ user.email }}</td>
                                <td>{{ user.phone_number }}</td>
                                <td>
                                    <label
                                        class="badge badge-success"
                                        v-for="(role, index) in user.role"
                                        :key="'role-' + index"
                                        >{{ role }}</label
                                    >
                                </td>
                                <td class="text-center" width="160px">
                                    <router-link
                                        :to="{
                                            name: 'user-edit',
                                            params: { id: user.id }
                                        }"
                                        v-if="$can('user-edit')"
                                        class="btn btn-warning"
                                    >
                                        <i class="far fa-pencil"></i>
                                    </router-link>
                                    <button
                                        class="btn btn-danger"
                                        @click="deleteUser(user.id)"
                                        v-if="$can('user-delete')"
                                    >
                                        <i class="far fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <pagination
                        :data="users"
                        @pagination-change-page="getResults"
                    ></pagination>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import toastr from "toastr";
import "toastr/build/toastr.min.css";
export default {
    props: {
        message: String,
        status: ""
    },
    data() {
        return {
            users: {},
            searchText: "",
            error: {
                message: ""
            }
        };
    },
    created() {
        this.getResults();
    },
    methods: {
        resetData() {
            this.searchText = "";
            this.getResults(1);
        },
        getResults(page) {
            let paramsData = {};
            if (typeof page === "undefined") {
                paramsData["page"] = 1;
            } else {
                paramsData["page"] = page;
            }
            if (this.searchText) {
                paramsData["s"] = this.searchText;
            }
            axios.get("auth/users", { params: paramsData }).then(data => {
                this.users = data.data.success;
            });
        },
        deleteUser(userId) {
            var result = confirm("Bán muốn xóa thành viên?");
            if (result) {
                axios
                    .delete("/auth/users/" + userId)
                    .then(rs => {
                        toastr.success("Thành công", "Xóa thành công");
                        this.getResults();
                    })
                    .catch(error => {
                        console.log(error);
                    });
            }
        }
    }
};
</script>

<style></style>
