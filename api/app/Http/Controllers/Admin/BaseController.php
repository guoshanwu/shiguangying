<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redis;

class BaseController extends Controller
{
    public function __construct(Request $request){
        $this->adminToken = $request->header('Admin-Token');
        if ($this->adminToken){
            $this->userInfo = json_decode(Redis::get('ApiLogin:' . $this->adminToken), true);
        }
    }

    /**
     *  获取用户对应的角色
     */
    public function userRole($userId){
        $result = DB::table('system_user_role')
            ->selectRaw('GROUP_CONCAT(DISTINCT(role_id)) AS role_id')
            ->where('user_id', 2)
            ->pluck();
        dd($result);

    }
}
