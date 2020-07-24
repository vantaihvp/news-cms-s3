<?php

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
class AddPermissionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $permissions = array(
            ['name' => 'slider-banner-access', 'display_name' => 'Access', 'group_name' => 'SliderBanner', 'group_slug' => 'slider-banner', 'guard_name' => 'api'],
            ['name' => 'slider-banner-list', 'display_name' => 'List', 'group_name' => 'SliderBanner', 'group_slug' => 'slider-banner', 'guard_name' => 'api'],
            ['name' => 'slider-banner-add', 'display_name' => 'Add', 'group_name' => 'SliderBanner', 'group_slug' => 'slider-banner', 'guard_name' => 'api'],
            ['name' => 'slider-banner-edit', 'display_name' => 'Edit', 'group_name' => 'SliderBanner', 'group_slug' => 'slider-banner', 'guard_name' => 'api'],
            ['name' => 'slider-banner-delete', 'display_name' => 'Delete', 'group_name' => 'SliderBanner', 'group_slug' => 'slider-banner', 'guard_name' => 'api'],
            ['name' => 'post-popular-access', 'display_name' => 'Access', 'group_name' => 'PostPopular', 'group_slug' => 'post-popular', 'guard_name' => 'api'],
            ['name' => 'post-popular-list', 'display_name' => 'List', 'group_name' => 'PostPopular', 'group_slug' => 'post-popular', 'guard_name' => 'api'],
            ['name' => 'post-popular-add', 'display_name' => 'Add', 'group_name' => 'PostPopular', 'group_slug' => 'post-popular', 'guard_name' => 'api'],
            ['name' => 'post-popular-edit', 'display_name' => 'Edit', 'group_name' => 'PostPopular', 'group_slug' => 'post-popular', 'guard_name' => 'api'],
            ['name' => 'post-popular-delete', 'display_name' => 'Delete', 'group_name' => 'PostPopular', 'group_slug' => 'post-popular', 'guard_name' => 'api'],
        );
        Permission::insert($permissions);
    }
}
