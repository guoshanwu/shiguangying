<?php

namespace App\Http\Controllers\Admin;


use App\Models\SystemMenu;

class MenuController extends BaseController
{
    /**
     * @api {get} admin/Menu/index 获取用户对应的菜单
     *
     */
    public function index(){
        $result = SystemMenu::all();
        return $this->success($result);
    }
}
