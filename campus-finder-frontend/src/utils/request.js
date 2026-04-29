import axios from 'axios'
import { ElMessage } from 'element-plus'
import { useAuthStore } from '@/stores/auth'
import router from '@/router'

const request = axios.create({
  baseURL: '/api',
  timeout: 10000
})

// 请求拦截器：自动附加 Token
request.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('accessToken')
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

// 是否正在刷新 Token
let isRefreshing = false
// 等待刷新的请求队列
let refreshSubscribers = []

function subscribeTokenRefresh(callback) {
  refreshSubscribers.push(callback)
}

function onTokenRefreshed(newToken) {
  refreshSubscribers.forEach((cb) => cb(newToken))
  refreshSubscribers = []
}

// 响应拦截器：处理 Token 过期自动刷新
request.interceptors.response.use(
  (response) => {
    const res = response.data
    if (res.code !== 200) {
      // 业务错误 — 抛出 message 供调用方 catch 处理
      return Promise.reject(new Error(res.message || '请求失败'))
    }
    // 成功时只返回 data 部分
    return res.data
  },
  async (error) => {
    const originalRequest = error.config

    // Token 过期，尝试刷新
    if (error.response?.status === 401 && !originalRequest._retry) {
      const refreshToken = localStorage.getItem('refreshToken')

      if (!refreshToken) {
        // 无 refreshToken，跳转登录
        localStorage.clear()
        router.push('/login')
        return Promise.reject(error)
      }

      if (isRefreshing) {
        // 已在刷新中，排队等待
        return new Promise((resolve) => {
          subscribeTokenRefresh((newToken) => {
            originalRequest.headers['Authorization'] = `Bearer ${newToken}`
            resolve(request(originalRequest))
          })
        })
      }

      originalRequest._retry = true
      isRefreshing = true

      try {
        const res = await axios.post('/api/auth/refresh', { refreshToken })
        const { accessToken, refreshToken: newRefreshToken } = res.data.data
        localStorage.setItem('accessToken', accessToken)
        if (newRefreshToken) localStorage.setItem('refreshToken', newRefreshToken)

        const authStore = useAuthStore()
        authStore.setTokens(accessToken, newRefreshToken || refreshToken)

        onTokenRefreshed(accessToken)
        originalRequest.headers['Authorization'] = `Bearer ${accessToken}`
        return request(originalRequest)
      } catch (refreshError) {
        // 刷新失败，登出
        localStorage.clear()
        router.push('/login')
        return Promise.reject(refreshError)
      } finally {
        isRefreshing = false
      }
    }

    const msg = error.response?.data?.message || '网络错误，请稍后重试'
    ElMessage.error(msg)
    return Promise.reject(error)
  }
)

export default request
