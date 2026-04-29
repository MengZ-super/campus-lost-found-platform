import request from '@/utils/request'

export const authApi = {
  /** 用户注册 */
  register(data) {
    return request.post('/auth/register', data)
  },

  /** 用户登录 */
  login(data) {
    return request.post('/auth/login', data)
  },

  /** 退出登录 */
  logout() {
    return request.post('/auth/logout')
  },

  /** 刷新 Token */
  refresh(refreshToken) {
    return request.post('/auth/refresh', { refreshToken })
  },

  /** 获取当前用户信息 */
  me() {
    return request.get('/auth/me')
  }
}

export const userApi = {
  /** 获取个人资料 */
  getProfile() {
    return request.get('/user/profile')
  },

  /** 更新个人资料 */
  updateProfile(data) {
    return request.put('/user/profile', data)
  },

  /** 修改密码 */
  changePassword(data) {
    return request.put('/user/password', data)
  }
}

export const categoryApi = {
  /** 获取分类列表 */
  getList() {
    return request.get('/lost/category/list')
  }
}

export const lostFoundApi = {
  /** 发布失物招领 */
  publish(data) {
    return request.post('/lost/publish', data)
  },

  /** 更新记录 */
  update(id, data) {
    return request.put(`/lost/${id}`, data)
  },

  /** 删除记录 */
  delete(id) {
    return request.delete(`/lost/${id}`)
  },

  /** 获取详情 */
  getDetail(id) {
    return request.get(`/lost/${id}`)
  },

  /** 分页列表（支持筛选） */
  getList(params) {
    return request.get('/lost/list', { params })
  },

  /** 搜索 */
  search(keyword) {
    return request.get('/lost/search', { params: { keyword } })
  },

  /** 我的发布 */
  getMyList() {
    return request.get('/lost/my')
  },

  /** 关闭记录 */
  close(id, reason) {
    return request.post(`/lost/${id}/close`, { reason })
  },

  /** 重新开启 */
  reopen(id) {
    return request.post(`/lost/${id}/reopen`)
  },

  /** 收藏 */
  favorite(id) {
    return request.post(`/lost/${id}/favorite`)
  },

  /** 取消收藏 */
  unfavorite(id) {
    return request.delete(`/lost/${id}/favorite`)
  },

  /** 我的收藏 */
  getFavorites() {
    return request.get('/lost/favorites')
  }
}

export const claimApi = {
  /** 提交认领申请 */
  apply(data) {
    return request.post('/lost/claim/apply', data)
  },

  /** 取消申请 */
  cancel(id) {
    return request.post(`/lost/claim/${id}/cancel`)
  },

  /** 获取申请详情 */
  getDetail(id) {
    return request.get(`/lost/claim/${id}`)
  },

  /** 我的申请 */
  getMyList() {
    return request.get('/lost/claim/my')
  },

  /** 获取物品的申请列表 */
  getByLostFound(lostFoundId) {
    return request.get(`/lost/claim/lost-found/${lostFoundId}`)
  },

  /** 审核申请 */
  review(id, data) {
    return request.post(`/lost/claim/${id}/review`, data)
  }
}
