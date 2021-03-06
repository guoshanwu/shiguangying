<?php

namespace App\Http\Controllers\Admin;

use App\Models\SystemUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redis;

class LoginController extends BaseController
{
    /**
     * @api {post} admin/Login/login 登录
     *
     * @apiParam {string} username    用户名
     * @apiParam {string} password    密码
     *
     */
    public function login(Request $request){
        if (!$request->has(['username', 'password'])) return $this->error('用户名或密码不能为空!');
        $username = $request->input('username');
        $password = $request->input('password');
        $user = SystemUsers::where(['username' => $username, 'status' => 1])->first();
        if (empty($user)) return $this->error('用户不存在');
        if ($password != decrypt($user->password)) return $this->error('登录密码错误');
        SystemUsers::where(['id' => $user->id])->update(['ip' => $request->ip()]);
        $this->userRole($user['id']);
        //设置缓存
        $adminToken = md5(uniqid() . time());
        //用户redis
        $userRedis = ['name' => $user['username'], 'avatar' => $user['avatar'], 'roles' => ['admin']];
        Redis::setex('AdminLogin:' . $adminToken, env('REDIS_TIMEOUT'), json_encode($userRedis));
        Redis::setex('AdminLogin:' . $user->id, env('REDIS_TIMEOUT'), $adminToken);
        return $this->success(['admin_token' => $adminToken]);
    }

    /**
     * @api {get} admin/Login/logout 退出登录
     *
     */
    public function logout(){
        Redis::del('AdminLogin:' . $this->adminToken);
        Redis::del('AdminLogin:' . $this->userInfo['id']);
        return $this->success('退出登录');
    }

}
