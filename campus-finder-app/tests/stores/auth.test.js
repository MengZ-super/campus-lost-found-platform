import { describe, it, expect, vi, beforeEach } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'

vi.stubGlobal('uni', {
  getStorageSync: vi.fn(),
  setStorageSync: vi.fn(),
  removeStorageSync: vi.fn(),
  redirectTo: vi.fn(),
  switchTab: vi.fn(),
  request: vi.fn(),
  showToast: vi.fn()
})

// Mock api/request module
vi.mock('@/api/request.js', () => ({
  get: vi.fn(),
  post: vi.fn(),
  put: vi.fn(),
  del: vi.fn()
}))

const { post } = await import('@/api/request.js')
const { useAuthStore } = await import('@/stores/auth.js')

describe('stores/auth', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
    vi.clearAllMocks()
    uni.getStorageSync.mockReturnValue('')
  })

  describe('initial state', () => {
    it('初始状态未登录', () => {
      const store = useAuthStore()
      expect(store.isLoggedIn).toBe(false)
      expect(store.user).toBeNull()
    })
  })

  describe('login', () => {
    it('登录成功后更新 token 和 user', async () => {
      post.mockResolvedValue({
        accessToken: 'at-123',
        refreshToken: 'rt-456',
        userId: 1,
        username: 'testuser',
        nickname: 'Test',
        avatar: '',
        role: 'user'
      })

      const store = useAuthStore()
      await store.login({ username: 'testuser', password: '123456' })

      expect(store.isLoggedIn).toBe(true)
      expect(store.user.username).toBe('testuser')
      expect(uni.setStorageSync).toHaveBeenCalledWith('token', 'at-123')
      expect(uni.setStorageSync).toHaveBeenCalledWith('refreshToken', 'rt-456')
    })

    it('登录失败抛出错误', async () => {
      post.mockRejectedValue(new Error('密码错误'))

      const store = useAuthStore()
      await expect(store.login({ username: 'test', password: 'wrong' })).rejects.toThrow('密码错误')
      expect(store.isLoggedIn).toBe(false)
    })
  })

  describe('logout', () => {
    it('登出后清除状态', async () => {
      post.mockResolvedValueOnce({
        accessToken: 'at',
        refreshToken: 'rt',
        userId: 1,
        username: 'test',
        nickname: 'Test',
        avatar: '',
        role: 'user'
      }).mockResolvedValue(undefined) // logout call

      const store = useAuthStore()
      await store.login({ username: 'test', password: '123456' })
      expect(store.isLoggedIn).toBe(true)

      await store.logout()
      expect(store.isLoggedIn).toBe(false)
      expect(store.user).toBeNull()
      expect(uni.removeStorageSync).toHaveBeenCalledWith('token')
    })
  })

  describe('checkAuth', () => {
    it('有 token 时调用 /auth/me 验证', async () => {
      uni.getStorageSync.mockImplementation((key) => {
        if (key === 'token') return 'existing-token'
        return ''
      })
      const { get } = await import('@/api/request.js')
      get.mockResolvedValue({ userId: 1, username: 'test', nickname: 'Test', role: 'user' })

      const store = useAuthStore()
      await store.checkAuth()

      expect(get).toHaveBeenCalledWith('/auth/me')
      expect(store.isLoggedIn).toBe(true)
      expect(store.user.username).toBe('test')
    })

    it('无 token 时跳过验证', async () => {
      uni.getStorageSync.mockReturnValue('')
      const store = useAuthStore()
      await store.checkAuth()
      expect(store.isLoggedIn).toBe(false)
    })
  })
})
