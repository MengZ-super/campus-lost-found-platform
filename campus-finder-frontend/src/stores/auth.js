import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { authApi } from '@/api'

export const useAuthStore = defineStore('auth', () => {
  const accessToken = ref(localStorage.getItem('accessToken') || '')
  const refreshToken = ref(localStorage.getItem('refreshToken') || '')
  const userInfo = ref(JSON.parse(localStorage.getItem('userInfo') || 'null'))

  const isLoggedIn = computed(() => !!accessToken.value)
  const username = computed(() => userInfo.value?.username || '')
  const nickname = computed(() => userInfo.value?.nickname || username.value)
  const avatar = computed(() => userInfo.value?.avatar || '')

  /** 设置 Tokens */
  function setTokens(access, refresh) {
    accessToken.value = access
    refreshToken.value = refresh
    localStorage.setItem('accessToken', access)
    if (refresh) localStorage.setItem('refreshToken', refresh)
  }

  /** 设置用户信息 */
  function setUserInfo(info) {
    userInfo.value = info
    localStorage.setItem('userInfo', JSON.stringify(info))
  }

  /** 登录 */
  async function login(data) {
    const res = await authApi.login(data)
    // 拦截器已返回 res.data，直接解构
    const { accessToken: at, refreshToken: rt, userId, username: un, nickname: nn, avatar: av } = res
    setTokens(at, rt)
    setUserInfo({ userId, username: un, nickname: nn, avatar: av })
    return res
  }

  /** 注册 */
  async function register(data) {
    const res = await authApi.register(data)
    // 拦截器已返回 res.data，直接解构
    const { accessToken: at, refreshToken: rt, userId, username: un, nickname: nn, avatar: av } = res
    setTokens(at, rt)
    setUserInfo({ userId, username: un, nickname: nn, avatar: av })
    return res
  }

  /** 退出登录 */
  async function logout() {
    try {
      await authApi.logout()
    } catch {
      // 忽略退出错误
    } finally {
      clearAuth()
    }
  }

  /** 清除认证信息 */
  function clearAuth() {
    accessToken.value = ''
    refreshToken.value = ''
    userInfo.value = null
    localStorage.removeItem('accessToken')
    localStorage.removeItem('refreshToken')
    localStorage.removeItem('userInfo')
  }

  return {
    accessToken, refreshToken, userInfo,
    isLoggedIn, username, nickname, avatar,
    setTokens, setUserInfo, login, register, logout, clearAuth
  }
})
