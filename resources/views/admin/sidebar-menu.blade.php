<nav class="mt-2">
    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
        
        <li  class="nav-item has-treeview">
            <a href="#" class="nav-link">
                <i class="fal fa-users"></i>
                <p>
                    Thành viên
                    <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
                <li class="nav-item">
                    <router-link exact class="nav-link" to="/user"><i class="far fa-circle nav-icon"></i><p>Danh sách thành viên</p></router-link>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="far fa-circle nav-icon"></i>
                        <p>Thêm thành viên</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="pages/layout/fixed-topnav.html" class="nav-link">
                        <i class="far fa-circle nav-icon"></i>
                        <p>Hồ sơ của bạn</p>
                    </a>
                </li>
            </ul>
        </li>
        <li class="nav-header">PHÂN QUYỀN</li>
        <li  class="nav-item has-treeview">
            <a href="#" class="nav-link">
                <i class="fal fa-users"></i>
                <p>
                    Role
                    <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="far fa-circle nav-icon"></i>
                        <p>Danh sách quyền</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="far fa-circle nav-icon"></i>
                        <p>Thêm quyền</p>
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</nav>
