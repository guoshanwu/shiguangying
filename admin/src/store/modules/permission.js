import { getUserRoutes } from '@/api/menu'
import Layout from '@/layout'
import { constantRoutes } from '@/router'
import { Message } from 'element-ui'

export const componentsMap = {}
const state = {
  //用户名
  userName: '',
  //用户头像
  avatar: '',
  //最终生成的路由
  routes: [],
  //根据用户信息添加的路由
  addRoutes: [],
  //用户所拥有的按钮
  bntPermissions: []
}

const mutations = {
  SET_USER_NAME : (state, userName) => {
    state.userName = userName
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_ROUTES: (state, routes) => {
    state.addRoutes = routes
    state.routes = constantRoutes.concat(routes)
  },
  SET_BNTPERMISSIONS: (state, bntPermissions) => {
    state.bntpermissions = bntPermissions
  },
  RESET_PERMISSION: (state) => {
    state.routes = []
    state.addRoutes = []
    state.menuList = []
    state.bntPermissions = []
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

async function getRoutes(commit){
  let ret = await getUserRoutes()
  let result = ret.data.result
  let resultKeys = Object.keys(result)
  if(resultKeys.length == 0){
    Message({
      message: '当前用户没有任何权限，请分配权限后在登录！',
      type: 'error',
      duration: 10 * 1000,
      showClose: true
    })
    throw '当前用户没有任何权限，请分配权限后在登录！'
  }
  let menuList = result.menuList
  //设置state数据
  commit('SET_BNTPREMISSION', result.bntList)
  commit('SET_USER_NAME', result.user.userName)
  commit('SET_AVATAR', process.env.VUE_APP_BASE_API + result.user.avatar)

  let menuRoutes = []
  let menu
  for(let i = 0; i < menuList.length; i++){
    menu = menuList[i]
    if(!menu.pid){
      let modult = {
        alwaysShow: true,
        path: '/' + menu.url,
        component: Layout,
        name: menu.menuCode,
        meta: {
          id: menu.menuId,
          title: menu.menuName,
          icon: menu.icon,
          fullPath: '/' + menu.url
        }
      }
      menuRoutes.push(module)
      menuList.splice(i--, 1)
    }
  }

  let removeMenuList = []
  for (let i = 0; i < menuRoutes.length; i++){
    convertTree(menuList, menuRoues[i], removeMenuList)
    let removeIds = removeMenuList.map(item => item.menuId)
    menuList = menuList.filter(item => {
      return !removeIds.includes(item.menuId)
    })
    removeMenuList = []
  }
  //添加最终匹配 404 page
  menuRoutes.push({
    path: '*',
    redirect: '/404',
    hidden: tru
  })
  return menuRoutes
}

//递归中组装树结构
function convertTree(menuList, route, removeMenuList) {
  menuList.forEach((m, i) => {
    if(m.pid && m.pid == router.meta.id) {
      if(!router.children) {
        router.children = []
      }
      let viewpath = router.meta.fullPath + '/' + m.url
      let menu = {
        path: m.url,
        name: m.menuCode,
        component: () => import(`@/views${viewpath}`),
        meta: {
          id: m.menuId,
          title: m.menuName,
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
