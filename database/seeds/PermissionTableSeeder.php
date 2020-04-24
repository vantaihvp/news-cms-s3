<?php

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;

class PermissionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $permissions = array(
            ['name' => 'role-list', 'display_name' => 'List', 'group_name' => 'Roles', 'group_slug' => 'roles', 'guard_name' => 'web'],
            ['name' => 'role-create', 'display_name' => 'Create', 'group_name' => 'Roles', 'group_slug' => 'roles', 'guard_name' => 'web'],
            ['name' => 'role-edit', 'display_name' => 'Edit', 'group_name' => 'Roles', 'group_slug' => 'roles', 'guard_name' => 'web'],
            ['name' => 'role-delete', 'display_name' => 'Delete', 'group_name' => 'Roles', 'group_slug' => 'roles', 'guard_name' => 'web'],
        );
        Permission::insert($permissions);
    }
}
