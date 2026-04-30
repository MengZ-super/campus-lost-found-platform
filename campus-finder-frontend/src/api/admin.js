import request from '@/utils/request'

export const adminApi = {
  /** 仪表盘 */
  getDashboard() {
    return request.get('/admin/dashboard')
  },

  /** 用户列表 */
  listUsers(params) {
    return request.get('/admin/users', { params })
  },

  /** 用户详情 */
  getUserDetail(id) {
    return request.get(`/admin/users/${id}`)
  },

  /** 切换用户状态 */
  toggleUserStatus(id) {
    return request.put(`/admin/users/${id}/status`)
  },

  /** 物品列表 */
  listItems(params) {
    return request.get('/admin/items', { params })
  },

  /** 强制关闭物品 */
  forceCloseItem(id, data) {
    return request.post(`/admin/items/${id}/close`, data)
  },

  /** 强制删除物品 */
  forceDeleteItem(id) {
    return request.delete(`/admin/items/${id}`)
  },

  /** 认领列表 */
  listClaims(params) {
    return request.get('/admin/claims', { params })
  },

  /** 审核认领 */
  reviewClaim(id, data) {
    return request.post(`/admin/claims/${id}/review`, data)
  },

  /** 全部分类 */
  listCategories() {
    return request.get('/admin/categories')
  },

  /** 创建分类 */
  createCategory(data) {
    return request.post('/admin/categories', data)
  },

  /** 更新分类 */
  updateCategory(id, data) {
    return request.put(`/admin/categories/${id}`, data)
  },

  /** 删除分类 */
  deleteCategory(id) {
    return request.delete(`/admin/categories/${id}`)
  }
}
