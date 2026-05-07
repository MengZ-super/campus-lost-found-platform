const BASE_URL = 'http://localhost:8080/api'

let isRefreshing = false
let refreshQueue = []

function subscribeRefresh(callback) {
  refreshQueue.push(callback)
}

function onRefreshed(newToken) {
  refreshQueue.forEach((cb) => cb(newToken))
  refreshQueue = []
}

function getToken() {
  return uni.getStorageSync('token') || ''
}

function getRefreshToken() {
  return uni.getStorageSync('refreshToken') || ''
}

function setTokens(accessToken, refreshToken) {
  uni.setStorageSync('token', accessToken)
  if (refreshToken) {
    uni.setStorageSync('refreshToken', refreshToken)
  }
}

function clearTokens() {
  uni.removeStorageSync('token')
  uni.removeStorageSync('refreshToken')
}

function redirectToLogin() {
  uni.redirectTo({ url: '/pages/auth/login' })
}

function refreshToken() {
  return new Promise((resolve, reject) => {
    uni.request({
      url: `${BASE_URL}/auth/refresh`,
      method: 'POST',
      data: { refreshToken: getRefreshToken() },
      success: (res) => {
        if (res.data?.code === 200) {
          const { accessToken, refreshToken: newRefresh } = res.data.data
          setTokens(accessToken, newRefresh)
          resolve(accessToken)
        } else {
          reject(new Error('refresh failed'))
        }
      },
      fail: (err) => reject(err)
    })
  })
}

function doRequest(url, method, data, header) {
  return new Promise((resolve, reject) => {
    uni.request({
      url: `${BASE_URL}${url}`,
      method,
      data,
      header,
      success: (res) => {
        const body = res.data
        if (body?.code === 200) {
          resolve(body.data)
        } else {
          reject(new Error(body?.message || '请求失败'))
        }
      },
      fail: reject
    })
  })
}

async function handle401(url, method, data, header) {
  if (isRefreshing) {
    return new Promise((resolve, reject) => {
      subscribeRefresh((newToken) => {
        header.Authorization = `Bearer ${newToken}`
        doRequest(url, method, data, header).then(resolve, reject)
      })
    })
  }

  isRefreshing = true
  try {
    const newToken = await refreshToken()
    onRefreshed(newToken)
    header.Authorization = `Bearer ${newToken}`
    return await doRequest(url, method, data, header)
  } catch {
    clearTokens()
    redirectToLogin()
    throw new Error('登录已过期')
  } finally {
    isRefreshing = false
  }
}

function request({ url, method = 'GET', data, header = {} }) {
  const token = getToken()
  const requestHeader = { ...header }
  if (token) {
    requestHeader.Authorization = `Bearer ${token}`
  }

  return new Promise((resolve, reject) => {
    uni.request({
      url: `${BASE_URL}${url}`,
      method,
      data,
      header: requestHeader,
      success: async (res) => {
        if (res.statusCode === 401) {
          try {
            const result = await handle401(url, method, data, requestHeader)
            resolve(result)
          } catch (err) {
            reject(err)
          }
          return
        }
        const body = res.data
        if (body?.code === 200) {
          resolve(body.data)
        } else {
          reject(new Error(body?.message || '请求失败'))
        }
      },
      fail: async (err) => {
        if (err?.statusCode === 401) {
          try {
            const result = await handle401(url, method, data, requestHeader)
            resolve(result)
          } catch (refreshErr) {
            reject(refreshErr)
          }
          return
        }
        reject(err)
      }
    })
  })
}

export function get(url, params) {
  // Convert params object to query string
  let finalUrl = url
  if (params) {
    const qs = Object.entries(params)
      .filter(([, v]) => v !== undefined && v !== null)
      .map(([k, v]) => `${encodeURIComponent(k)}=${encodeURIComponent(v)}`)
      .join('&')
    if (qs) finalUrl += `?${qs}`
  }
  return request({ url: finalUrl, method: 'GET' })
}

export function post(url, data) {
  return request({ url, method: 'POST', data })
}

export function put(url, data) {
  return request({ url, method: 'PUT', data })
}

export function del(url) {
  return request({ url, method: 'DELETE' })
}
