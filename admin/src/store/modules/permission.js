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
        alwaysShow: true,
        path: '/' + menu.path,
        component: Layout,
        name: menu.title,
        meta: {
          id: menu.id,
          title: menu.title,
          icon: menu.icon,
          pullPath: '/' + menu.path
        }
      }
      menuRoutes.push(modult)
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
    if (m.pid && m.pid === router.meta.id) {
      if (!router.children) {
        router.children = []
      }
      let viewpath = router.meta.fullPath + '/' + m.path
      let menu = {
        path: m.path,
        name: m.title,
        component: () => import('@/views/' + m.path),
        meta: {
          id: m.id,
          title: m.title,
          icon: m.icon,
          fullPath: viewpath
        }
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
