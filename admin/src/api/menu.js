import request from '@/utils/request'

export function getUserRoutes() {
  return request({
    url: 'admin/Menu/index',
    method: 'get'
  })
}
