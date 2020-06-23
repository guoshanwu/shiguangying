import request from '@/utils/request'

export function login(data) {
  return request({
    url: 'api/Login/index',
    method: 'post',
    data
  })
}

export function getInfo(token) {
  return request({
    url: 'api/User/info',
    method: 'get',
    params: { token }
  })
}

export function logout() {
  return request({
    url: '/vue-admin-template/user/logout',
    method: 'post'
  })
}
