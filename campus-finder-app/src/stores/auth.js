import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { loginApi, logoutApi, meApi } from '@/api/auth.js'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(uni.getStorageSync('token') || '')
  const user = ref(null)

  const isLoggedIn = computed(() => !!token.value)
  const username = computed(() => user.value?.username || '')
  const nickname = computed(() => user.value?.nickname || username.value)
  const avatar = computed(() => user.value?.avatar || '')
  const role = computed(() => user.value?.role || 'user')

  function setTokens(accessToken, refreshToken) {
    token.value = accessToken
    uni.setStorageSync('token', accessToken)
    if (refreshToken) {
      uni.setStorageSync('refreshToken', refreshToken)
    }
  }

  function setUser(info) {
    user.value = info
  }

  async function login(data) {
    const res = await loginApi(data)
    const { accessToken, refreshToken, userId, username: un, nickname: nn, avatar: av, role: r } = res
    setTokens(accessToken, refreshToken)
    setUser({ userId, username: un, nickname: nn, avatar: av, role: r || 'user' })
    return res
  }

  async function logout() {
    try {
      await logoutApi()
    } catch {
      // ignore logout API errors
    } finally {
      clearAuth()
    }
  }

  async function checkAuth() {
    const stored = uni.getStorageSync('token')
    if (!stored) return
    token.value = stored
    try {
      const info = await meApi()
      setUser(info)
    } catch {
      clearAuth()
    }
  }

  function clearAuth() {
    token.value = ''
    user.value = null
    uni.removeStorageSync('token')
    uni.removeStorageSync('refreshToken')
  }

  return {
    token, user,
    isLoggedIn, username, nickname, avatar, role,
    setTokens, setUser, login, logout, checkAuth, clearAuth
  }
})
