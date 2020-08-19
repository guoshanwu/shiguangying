import request from '@/utils/request'

// 菜单
export function getUserRoutes() {
  return request({
    url: 'admin/Menu/menuList',
    method: 'get'
  })
}
