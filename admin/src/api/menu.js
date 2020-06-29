import request from '@/utils/request'

export function getUserRoutes(params) {
  return request({
    url: 'admin/Menu/index',
    method: 'get',
    params
  })
}
