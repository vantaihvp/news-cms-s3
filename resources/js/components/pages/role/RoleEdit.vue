<template>
    <div class="user-create">
        <div class="row mb-4">
            <div class="col-lg-12 margin-tb">
                <div class="float-left">
                    <h2>Chỉnh sửa vai trò</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="card shadow-none border-0">
                    <div class="card-body" id="user-create">
                        <div class="error" v-if="errors.length">
                            <div class="alert alert-danger" role="alert">
                                <span
                                    v-for="(err, index) in errors"
                                    :key="index"
                                    >{{ err }}</span
                                >
                                <hr />
                            </div>
                        </div>
                        <form
                            action
                            method="POST"
                            @submit.prevent="submitEditRole"
                        >
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12">
                                    <div class="form-group">
                                        <label class="lable-required"
                                            >Tên:</label
                                        >
                                        <input
                                            type="text"
                                            v-bind:value="role.name"
                                            name="name"
                                            class="form-control"
                                            required
                                        />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Permissions:</label>
                                        <table
                                            class="table table-striped table-bordered permissions_table"
                                        >
                                            <tr
                                                v-for="(group,
                                                index) in permissions.groups"
                                                :key="group.index"
                                            >
                                                <td>
                                                    <h6
                                                        class="mb-2 font-weight-bold"
                                                    >
                                                        <label>{{
                                                            permissions.groups[
                                                                index
                                                            ].name
                                                        }}</label>
                                                    </h6>
                                                    <div>
                                                        <label
                                                            class="mr-4"
                                                            v-for="p in permissions
                                                                .groups[index]
                                                                .permissions"
                                                            :key="p.id"
                                                        >
                                                            <input
                                                                type="checkbox"
                                                                v-bind:name="
                                                                    p.name
                                                                "
                                                                :checked="
                                                                    hasPermission(
                                                                        p.name
                                                                    )
                                                                "
                                                            />
                                                            {{ p.name }}
                                                        </label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div
                                    class="col-xs-12 col-sm-12 col-md-12 text-right"
                                >
                                    <button
                                        type="submit"
                                        class="btn btn-primary"
                                    >
                                        Cập nhật
                                    </button>
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
            role: {},
            permissions: {},
            rolePermissions: {},
            errors: []
        };
    },
    methods: {
        getData() {
            axios
                .get("auth/roles/" + this.id + "/edit")
                .then(rs => {
                    if (rs.status === 200) {
                        this.role = rs.data.role;
                        this.permissions = rs.data;
                        this.rolePermissions = rs.data.role.permissions;
                    }
                })
                .catch(error => {
                    this.errors = error;
                    console.log(error);
                });
        },
        submitEditRole(event) {
            let dataForm = new FormData(event.currentTarget);
            var object = {};
            dataForm.forEach((value, key) => {
                object[key] = value;
            });
            var json = JSON.stringify(object);
            axios
                .put("auth/roles/" + this.id, json, {
                    headers: {
                        "Content-Type": "application/json"
                    }
                })
                .then(rs => {
                    toastr.success("Thành công", "Chỉnh sửa thành công");
                    this.$router.push({
                        path: "/admin/roles"
                    });
                })
                .catch(error => {
                    toastr.error("Lỗi!", "Chỉnh sửa không thành công");
                    console.log("--------");
                    this.errors = error.response.data.errors;
                    console.log(error.response.data.errors);
                });
        },
        hasPermission(permission) {
            let isHas = false;
            this.rolePermissions.forEach(p => {
                if (p.name === permission) {
                    isHas = true;
                }
            });
            return isHas;
        }
    },
    created() {
        this.getData();
    }
};
</script>

<style></style>
