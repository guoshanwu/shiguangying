import request from '@/utils/request'

// 登录
export function login(data) {
  return request({
    url: 'admin/Login/index',
    method: 'post',
    data
  })
}

// 获取用户信息
export function getInfo() {
  return request({
    url: 'admin/User/info',
    method: 'get'
  })
}

// 退出
export function logout() {
  return request({
    url: 'admin/Login/logout',
    method: 'get'
  })
}
