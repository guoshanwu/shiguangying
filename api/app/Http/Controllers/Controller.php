<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    /**
     * 成功
     */
    public function success($data = [], $code = 1, $msg = 'success'){
        return response()->json([
            'code' => $code,
            'msg' => $msg,
            'data' => $data
        ]);
    }

    /**
     * 错误
     */
    public function error($msg, $code = -1, $data = []){
        return response()->json([
            'code' => $code,
            'msg' => $msg,
            'data' => $data
        ]);
    }

}
