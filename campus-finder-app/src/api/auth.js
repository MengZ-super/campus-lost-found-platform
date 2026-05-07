import { get, post } from './request.js'

export function loginApi(data) {
  return post('/auth/login', data)
}

export function registerApi(data) {
  return post('/auth/register', data)
}

export function logoutApi() {
  return post('/auth/logout')
}

export function refreshApi(refreshToken) {
  return post('/auth/refresh', { refreshToken })
}

export function meApi() {
  return get('/auth/me')
}
