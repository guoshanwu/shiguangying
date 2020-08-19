<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Support\Facades\DB;

class MenuController extends BaseController
{
    /**
     * @api {get} admin/Menu/menuList 获取用户对应的菜单
     *
     */
    public function menuList(){
        $result = DB::table('system_menus')->where('id', 1)->get();
        return $this->success($result);
    }
}
