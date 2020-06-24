<?php

namespace App\Http\Controllers\Admin;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redis;

class UserController extends BaseController
{
    /**
     * @api {get} admin/User/info 获取用户信息
     *
     * @apiParam {string} Admin-Token    token
     *
     */
    public function info(Request $request){
        if (!$request->has('admin_token')){
            return $this->error('缺少Admin-Token值');
        }
        $adminToken = Redis::get('AdminLogin:' . $request->input('admin_token'));
        if (empty($adminToken)){
            return $this->error('登录已超时,请重新登录', 503);
        }
        return $this->success(json_decode($adminToken, true));
    }
}
