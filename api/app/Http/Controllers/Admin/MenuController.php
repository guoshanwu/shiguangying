<?php

namespace App\Http\Controllers\Admin;


use App\Models\SystemMenus;
use App\Models\SystemUsers;

class MenuController extends BaseController
{
    /**
     * @api {get} admin/Menu/index 获取用户对应的菜单
     *
     */
    public function index(){
        $result = SystemMenus::all();
        return $this->success($result);
    }
}
