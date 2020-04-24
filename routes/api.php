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
// Route::post('login', 'API\UserController@login');
// Route::post('register', 'API\UserController@register');
// Route::group(['middleware' => 'auth:api'], function(){
//     Route::get('user/current','API\UserController@getPermission');
//     Route::resource('user', 'API\UserController');
// });

// Route::prefix('v1')->group(function () {
//     Route::prefix('auth')->group(function () {
//         // Below mention routes are public, user can access those without any restriction.
//         // Create New User
//         Route::post('register', 'AuthController@register');
//         // Login User
//         Route::post('login', 'AuthController@login');
        
//         // Refresh the JWT Token
//         Route::get('refresh', 'AuthController@refresh');
        
//         // Below mention routes are available only for the authenticated users.
//         Route::middleware('auth:api')->group(function () {            // Get user info
//             Route::get('user', 'AuthController@user');
//             Route::resource('users', 'API\UserController');
//             // Logout user from application
//             Route::post('logout', 'AuthController@logout');
//         });
//     });
// });

Route::prefix('auth')->group(function () {
    Route::post('register', 'AuthController@register');
    Route::post('login', 'AuthController@login');
    Route::get('refresh', 'AuthController@refresh');
    Route::group(['middleware' => 'auth:api'], function(){
        Route::get('user', 'AuthController@user');
        Route::get('get-all-permissions','API\UserController@getAllPermissionsAttribute');
        Route::post('logout', 'AuthController@logout');
        Route::resource('users', 'API\UserController');
        Route::resource('roles','RoleController');
        Route::get('permissions','RoleController@getAllPermissions');
    });
});