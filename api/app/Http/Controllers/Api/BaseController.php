<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redis;

class BaseController extends Controller
{
    public function __construct(Request $request){
        $apiToken = $request->header('Api-Token');
        if ($apiToken){
            $this->userInfo = json_decode(Redis::get('ApiLogin:' . $apiToken), true);
        }
    }
}
