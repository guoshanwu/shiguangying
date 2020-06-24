import request from '@/utils/request'

export function login(data) {
  return request({
    url: 'admin/Login/index',
    method: 'post',
    data
  })
}

export function getInfo(admin_token) {
  return request({
    url: 'admin/User/info',
    method: 'get',
    params: { admin_token }
  })
}

export function logout() {
  return request({
    url: '/vue-admin-template/user/logout',
    method: 'post'
  })
}
