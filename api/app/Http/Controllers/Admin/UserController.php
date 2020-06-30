<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Support\Facades\Redis;

class UserController extends BaseController
{
    /**
     * @api {get} admin/User/info 获取用户信息
     *
     */
    public function info(){
        $adminToken = Redis::get('AdminLogin:' . $this->adminToken);
        if (empty($adminToken)){
            return $this->error('登录已超时,请重新登录', 503);
        }
        return $this->success(json_decode($adminToken, true));
    }
}
