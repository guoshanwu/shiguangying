<?php

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
Route::post('Login/index', 'LoginController@index');  //登录

Route::get('User/info', 'UserController@info');  //获取用户信息

//验证token
Route::middleware(['admin.verfig_token'])->group(function(){
    Route::prefix('Login')->group(function(){
        Route::get('logout', 'LoginController@logout');  //退出
    });
    Route::prefix('Menu')->group(function(){
        Route::get('index', 'MenuController@index');  //获取用户对应的菜单
    });
});
