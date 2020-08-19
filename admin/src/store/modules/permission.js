import { constantRoutes } from '@/router'
import { getUserRoutes } from '@/api/menu'
import { Message } from 'element-ui'
import Layout from '@/layout'

const state = {
  routes: [],
  addRoutes: []
}

const mutations = {
  SET_ROUTES: (state, routes) => {
    state.addRoutes = routes
    state.routes = constantRoutes.concat(routes)
  },
  RESET_PERMISSSION: (state) => {
    state.routes = []
    state.addRoutes = []
    state.menuList = []
  }
}

const actions = {
  generateRoutes({ commit }) {
    return new Promise((resolve, reject) => {
      getRoutes(commit).then(accessedRoutes => {
        commit('SET_ROUTES', accessedRoutes)
        resolve(accessedRoutes)
      }).catch(error => {
        reject(error)
      })
    })
  }
}

async function getRoutes(commit) {
  let ret = await getUserRoutes()
  let menuList = ret.data
  let menuListKeys = Object.keys(menuList)
  if (menuListKeys.length === 0) {
    Message({
      message: '当前用户没有任何权限，请分配权限后在登录！',
      type: 'error',
      duration: 10 * 1000,
      showClose: true
    })
  }

  // 主菜单
  let menuRoutes = []
  let menu
  for (let i = 0; i < menuList.length; i++) {
    menu = menuList[i]
    if (menu.pid === 0) {
      let modult = {
        alwaysShow: false,
        path: '/' + menu.path,
        component: Layout,
        id: menu.id,
        children: [{
          path: '', // 一级导航为空
          name: menu.title,
          component(resolve) {
            require(['@/views/' + menu.path + '/index.vue'], resolve)
          },
          meta: { title: menu.title, icon: menu.icon }
        }]
      }
      menuRoutes.push(modult)
      console.log(menuRoutes)
      menuList.splice(i--, 1)
    }
  }

  let removeMenuList = []
  for (let i = 0; i < menuRoutes.length; i++) {
    convertTree(menuList, menuRoutes[i], removeMenuList)
    let removeIds = removeMenuList.map(item => item.id)
    menuList = menuList.filter(item => {
      return !removeIds.includes(item.id)
    })
    removeMenuList = []
  }

  // 添加最终匹配 404 page
  menuRoutes.push({
    path: '*',
    redirect: '/404',
    hidden: true
  })
  return menuRoutes
}

// 递归中组装树结构
function convertTree(menuList, router, removeMenuList) {
  menuList.forEach((m, i) => {
    if (m.pid && m.pid === router.id) {
      if (!router.children) {
        router.children = []
      }
      let menu = {
        path: '/' + m.path,
        component: Layout,
        id: m.id,
        children: [{
          path: m.path,
          name: m.title,
          component(resolve) {
            require(['@/views/' + m.path + '/index.vue'], resolve)
          },
          meta: { title: m.title }
        }]
      }
      router.children.push(convertTree(menuList, menu, removeMenuList))
      removeMenuList.push(m)
    }
  })
  return router
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
