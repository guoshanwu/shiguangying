<?php

namespace App\Http\Middleware\Api;

use Closure;

class VerfigToken
{
    /**
     * 获取Token
     */
    public function handle($request, Closure $next)
    {
        $apiToken = $request->header('Api-Token');
        if (empty($apiToken)){
            return response()->json(['code' => -1, 'msg' => '缺少Api-Token', 'data' => []]);
        }
        return $next($request);
    }
}
