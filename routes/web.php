<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
// $middlewares = ['auth'];
// Route::get('/', function () {
//     $user = request()->user(); //lấy kèm với role của user (dùng cho vue router sau này)
//     // return $user;
//     return view('admin.dashboard', ['user' => $user]);
// })->middleware('auth');

// Route::group(['middleware' => ['auth']], function () {
//     Route::resource('roles','RoleController');
//     Route::resource('users','UserController');
// });

// Route::get('/users', 'UserController@index');

// Auth::routes();

// Route::get('/home', 'HomeController@index')->name('home');
// Route to handle page reload in Vue except for api routes
Route::get('/{any?}', function (){
    return view('welcome');
})->where('any', '^(?!api\/)[\/\w\.-]*');