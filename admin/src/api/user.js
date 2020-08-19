import request from '@/utils/request'

// 登录
export function login(data) {
  return request({
    url: 'admin/Login/login',
    method: 'post',
    data
  })
}

// 获取用户信息
export function getInfo() {
  return request({
    url: 'admin/User/userInfo',
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
