<template>
    <div class="container">
        <div class="user-login">
            <div class="logout">
                <a href="#" @click.prevent="logout">Logout</a>
            </div>
        </div>
        <div class="main-content">
            <router-view></router-view>
        </div>
    </div>
</template>

<script>
    export default {
        methods: {
            logout:function(){
                axios.post('logout').then(response => {
                    
                }).catch(error => {
                    if (error.status === 302 || 401) {
                        document.location.href = '/login'
                    }
                    else {
                        // throw error and go to catch block
                    }
                })
            },
        }
    }
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