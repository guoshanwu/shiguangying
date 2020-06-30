<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redis;

class BaseController extends Controller
{
    public function __construct(Request $request){
        $this->adminToken = $request->header('Admin-Token');
        if ($this->adminToken){
            $this->userInfo = json_decode(Redis::get('ApiLogin:' . $this->adminToken), true);
        }
    }
}
