<?php

namespace App\Http\Controllers\Api;

use App\Models\SystemUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redis;

class LoginController extends BaseController
{
    /**
     * @api {post} api/Login/index 登录
     *
     * @apiParam {string} username    用户名
     * @apiParam {string} password    密码
     *
     */
    public function index(Request $request){
        if (!$request->has(['username', 'password'])){
            return $this->error('用户名或密码不能为空!');
        }
        $username = $request->input('username');
        $password = $request->input('password');
        $user = SystemUsers::where(['username' => $username, 'status' => 1])->first();
        if (empty($user)){
            return $this->error('用户不存在');
        }
        if ($password != decrypt($user->password)){
            return $this->error('登录密码错误');
        }
        SystemUsers::where(['id' => $user->id])->update(['ip' => $request->ip()]);
        //设置缓存
        $apiToken = md5(uniqid() . time());
        Redis::setex('ApiLogin:' . $apiToken, env('REDIS_TIMEOUT'), json_encode($user));
        Redis::setex('ApiLogin:' . $user->id, env('REDIS_TIMEOUT'), $apiToken);
        return $this->success(['api_token' => $apiToken]);
    }

    /**
     * @api {post} api/Login/logout 退出登录
     *
     */
    public function logout(Request $request){
        $apiToken = $request->header('Api-Token');
        Redis::del('ApiLogin:' . $apiToken);
        Redis::del('ApiLogin:' . $this->userInfo['id']);
        return $this->success('退出登录');
    }

}
