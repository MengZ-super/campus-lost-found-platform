import { describe, it, expect, vi, beforeEach } from 'vitest'

// Mock uni module before importing request
vi.stubGlobal('uni', {
  request: vi.fn(),
  getStorageSync: vi.fn(),
  setStorageSync: vi.fn(),
  removeStorageSync: vi.fn(),
  redirectTo: vi.fn(),
  showToast: vi.fn()
})

const { get, post, put, del } = await import('@/api/request.js')

describe('api/request', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe('token injection', () => {
    it('请求自动携带 Authorization header', async () => {
      uni.getStorageSync.mockImplementation((key) => {
        if (key === 'token') return 'test-token'
        return ''
      })
      uni.request.mockImplementation(({ success }) => {
        success({ data: { code: 200, message: 'ok', data: {} } })
      })

      await get('/test')

      expect(uni.request).toHaveBeenCalledWith(
        expect.objectContaining({
          header: expect.objectContaining({
            Authorization: 'Bearer test-token'
          })
        })
      )
    })

    it('无 token 时不携带 Authorization header', async () => {
      uni.getStorageSync.mockReturnValue('')
      uni.request.mockImplementation(({ success }) => {
        success({ data: { code: 200, message: 'ok', data: {} } })
      })

      await get('/test')

      const callArgs = uni.request.mock.calls[0][0]
      expect(callArgs.header?.Authorization).toBeUndefined()
    })
  })

  describe('response parsing', () => {
    it('成功响应返回 data 字段', async () => {
      uni.getStorageSync.mockReturnValue('')
      uni.request.mockImplementation(({ success }) => {
        success({ data: { code: 200, message: 'ok', data: { id: 1 } } })
      })

      const result = await get('/test')
      expect(result).toEqual({ id: 1 })
    })

    it('非 200 code 抛出错误', async () => {
      uni.getStorageSync.mockReturnValue('')
      uni.request.mockImplementation(({ success }) => {
        success({ data: { code: 400, message: '参数错误', data: null } })
      })

      await expect(get('/test')).rejects.toThrow('参数错误')
    })
  })

  describe('HTTP methods', () => {
    beforeEach(() => {
      uni.getStorageSync.mockReturnValue('')
      uni.request.mockImplementation(({ success }) => {
        success({ data: { code: 200, message: 'ok', data: 'result' } })
      })
    })

    it('get 发送 GET 请求', async () => {
      await get('/users', { page: 1 })
      expect(uni.request).toHaveBeenCalledWith(
        expect.objectContaining({ method: 'GET' })
      )
    })

    it('post 发送 POST 请求并携带 data', async () => {
      await post('/users', { name: 'test' })
      expect(uni.request).toHaveBeenCalledWith(
        expect.objectContaining({ method: 'POST', data: { name: 'test' } })
      )
    })

    it('put 发送 PUT 请求', async () => {
      await put('/users/1', { name: 'updated' })
      expect(uni.request).toHaveBeenCalledWith(
        expect.objectContaining({ method: 'PUT' })
      )
    })

    it('del 发送 DELETE 请求', async () => {
      await del('/users/1')
      expect(uni.request).toHaveBeenCalledWith(
        expect.objectContaining({ method: 'DELETE' })
      )
    })
  })

  describe('401 token refresh', () => {
    it('401 时自动刷新 token 并重试原请求', async () => {
      let callCount = 0
      uni.getStorageSync.mockImplementation((key) => {
        if (key === 'token') return callCount === 0 ? 'expired-token' : 'new-token'
        if (key === 'refreshToken') return 'refresh-token'
        return ''
      })

      uni.request.mockImplementation(({ url, success, fail }) => {
        callCount++
        if (url.includes('/auth/refresh')) {
          success({ data: { code: 200, message: 'ok', data: { accessToken: 'new-token', refreshToken: 'new-refresh' } } })
        } else if (callCount === 1) {
          // First call returns 401
          fail({ statusCode: 401 })
        } else {
          success({ data: { code: 200, message: 'ok', data: 'retried' } })
        }
      })

      const result = await get('/protected')
      expect(result).toBe('retried')
      expect(uni.setStorageSync).toHaveBeenCalledWith('token', 'new-token')
    })

    it('刷新失败时清除 token 并跳转登录', async () => {
      uni.getStorageSync.mockImplementation((key) => {
        if (key === 'token') return 'expired-token'
        if (key === 'refreshToken') return 'refresh-token'
        return ''
      })

      uni.request.mockImplementation(({ url, fail }) => {
        if (url.includes('/auth/refresh')) {
          fail({ statusCode: 401 })
        } else {
          fail({ statusCode: 401 })
        }
      })

      await expect(get('/protected')).rejects.toBeDefined()
      expect(uni.removeStorageSync).toHaveBeenCalledWith('token')
      expect(uni.removeStorageSync).toHaveBeenCalledWith('refreshToken')
    })
  })
})
