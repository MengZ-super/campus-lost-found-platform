import { get, put } from './request.js'

export function getProfileApi() {
  return get('/user/profile')
}

export function updateProfileApi(data) {
  return put('/user/profile', data)
}