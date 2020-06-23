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
Route::prefix('Login')->group(function(){
    Route::post('index', 'LoginController@index');  //登录
});

//验证token
Route::middleware(['api.verfig_token'])->group(function(){
    Route::prefix('Login')->group(function(){
        Route::post('logout', 'LoginController@logout');  //退出
    });
});
