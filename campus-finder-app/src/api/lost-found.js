import { get, post, put, del } from './request.js'

export function publishItemApi(data) {
  return post('/lost/publish', data)
}

export function updateItemApi(id, data) {
  return put(`/lost/${id}`, data)
}

export function deleteItemApi(id) {
  return del(`/lost/${id}`)
}

export function getItemDetailApi(id) {
  return get(`/lost/${id}`)
}

export function getItemListApi(params) {
  return get('/lost/list', params)
}

export function getMyItemsApi() {
  return get('/lost/my')
}

export function searchItemsApi(keyword) {
  return get('/lost/search', { keyword })
}

export function addFavoriteApi(id) {
  return post(`/lost/${id}/favorite`)
}

export function removeFavoriteApi(id) {
  return del(`/lost/${id}/favorite`)
}

export function getFavoritesApi() {
  return get('/lost/favorites')
}

export function closeItemApi(id, reason) {
  return post(`/lost/${id}/close`, { reason })
}

export function reopenItemApi(id) {
  return post(`/lost/${id}/reopen`)
}
