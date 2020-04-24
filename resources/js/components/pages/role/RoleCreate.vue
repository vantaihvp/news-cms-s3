<template>
    <div class="user-create">
        <div class="row mb-4">
            <div class="col-lg-12 margin-tb">
                <div class="float-left">
                    <h2>Thêm vai trò</h2>
                </div>
                <div class="float-right">
                    <div class="button-box">
                        <router-link
                            :to="{ name: 'role-list' }"
                            class="btn btn-primary"
                            >Danh sách</router-link
                        >
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
                            @submit.prevent="submitCreateRole"
                        >
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12">
                                    <div class="form-group">
                                        <label class="lable-required"
                                            >Tên:</label
                                        >
                                        <input
                                            type="text"
                                            v-model="name"
                                            name="name"
                                            class="form-control"
                                            required
                                        />
                                    </div>
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
                                        Thêm
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
export default {
    data() {
        return {
            name: "",
            permissions: {},
            errors: []
        };
    },
    methods: {
        getPermissions() {
            axios
                .get("auth/roles/create")
                .then(rs => {
                    this.permissions = rs.data;
                    console.log(this.permissions);
                })
                .catch(error => {});
        },
        submitCreateRole(event) {
            let formData = new FormData(event.currentTarget);
            console.log(formData);
            axios
                .post("auth/roles", formData)
                .then(rs => {
                    this.$router.push({
                        path: "/admin/roles",
                        params: { message: "Thêm thành công" }
                    });
                })
                .catch(error => {
                    console.log("--------");
                    this.errors = error.response.data.errors;
                    console.log(error.response.data.errors);
                });
        }
    },
    created() {
        this.getPermissions();
    }
};
</script>

<style></style>
