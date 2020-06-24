<?php

namespace App\Http\Middleware\Admin;

use Closure;

class VerfigToken
{
    /**
     * 获取Token
     */
    public function handle($request, Closure $next)
    {
        $adminToken = $request->header('Admin-Token');
        if (empty($adminToken)){
            return response()->json(['code' => -1, 'msg' => '缺少Admin-Token', 'data' => []]);
        }
        return $next($request);
    }
}
