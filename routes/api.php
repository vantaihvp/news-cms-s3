<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::resource('posts','API\PostController');
Route::get('posts-popular', 'API\PostsPopularController@index');
Route::get('slider-banner','API\SliderController@index');
Route::get('categories', 'API\CategoryController@getCategories');
Route::get('categories/{id}', 'API\CategoryController@show');
Route::get('tags', 'API\CategoryController@getTags');
Route::get('tags/{id}', 'API\CategoryController@show');
Route::resource('ads-banner','API\AdsBannerController');
Route::resource('menu','API\MenuController');
Route::resource('users', 'API\UserController');
Route::prefix('auth')->group(function () {
    Route::post('register', 'AuthController@register');
    Route::post('login', 'AuthController@login');
    Route::get('refresh', 'AuthController@refresh');
    Route::group(['middleware' => 'auth:api'], function(){
        Route::get('user', 'AuthController@user');
        Route::get('get-all-permissions','API\UserController@getAllPermissionsAttribute');
        Route::post('logout', 'AuthController@logout');
        Route::get('categories/get-all', 'API\CategoryController@getAll');
        Route::get('categories/get-categories', 'API\CategoryController@getCategories');
        Route::get('tags/get-tags', 'API\CategoryController@getTags');
        Route::resource('categories', 'API\CategoryController');
        Route::resource('photos', 'API\PhotoController');
        Route::post('photos/import','API\PhotoController@store_api');
        Route::resource('users', 'API\UserController');
        Route::resource('roles','RoleController');
        Route::get('permissions','RoleController@getAllPermissions');
        //Post
        Route::put('posts/restore-revision/{id}','API\PostController@restoreRevision');
        Route::resource('posts-popular', 'API\PostsPopularController');
        Route::post('posts/get-slug/','API\PostController@getSlug');
        Route::post('posts/import','API\PostController@store_api');
        Route::post('posts/set-popular','API\PostController@setPopular');
        Route::post('posts/restore','API\PostController@restore');
        Route::get('posts/revision/{id}','API\PostRevisionController@getByPostId');
        Route::post('posts/user-editing/','API\PostController@setUserEditing');
        //End post
        //Post Revision
        Route::resource('revision', 'API\PostRevisionController');
        //Post Revision
        Route::resource('posts','API\PostController');
        Route::resource('seo','API\SeoController');
        Route::resource('ads-banner','API\AdsBannerController');
        Route::resource('ads-zone','API\AdsZoneController');
        //Slider
        Route::resource('category-slider','API\CategorySliderController');
        Route::resource('slider-banner','API\SliderController');
        //End slider
    });
});