import { get, post } from './request.js'

/**
 * 提交认领申请
 * @param {Object} data - { lostFoundId, claimType, description, features, contact, proofImages[] }
 */
export function submitClaimApi(data) {
  return post('/lost/claim/apply', data)
}

/**
 * 获取当前用户的认领申请列表
 */
export function getMyClaimsApi() {
  return get('/lost/claim/my')
}

/**
 * 获取认领申请详情
 * @param {number} id - 认领申请ID
 */
export function getClaimDetailApi(id) {
  return get(`/lost/claim/${id}`)
}

/**
 * 取消认领申请
 * @param {number} id - 认领申请ID
 */
export function cancelClaimApi(id) {
  return post(`/lost/claim/${id}/cancel`)
}

/**
 * 获取物品的所有认领申请（物品主人查看）
 * @param {number} lostFoundId - 物品ID
 */
export function getClaimsByItemApi(lostFoundId) {
  return get(`/lost/claim/lost-found/${lostFoundId}`)
}