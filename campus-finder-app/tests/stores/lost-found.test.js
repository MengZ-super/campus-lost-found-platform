import { describe, it, expect, vi, beforeEach } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'

vi.stubGlobal('uni', {
  getStorageSync: vi.fn().mockReturnValue(''),
  setStorageSync: vi.fn(),
  removeStorageSync: vi.fn(),
  request: vi.fn(),
  showToast: vi.fn()
})

vi.mock('@/api/request.js', () => ({
  get: vi.fn(),
  post: vi.fn(),
  put: vi.fn(),
  del: vi.fn()
}))

const { get, post } = await import('@/api/request.js')
const { useLostFoundStore } = await import('@/stores/lost-found.js')

describe('stores/lost-found', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
    vi.clearAllMocks()
  })

  describe('loadList', () => {
    it('加载列表后更新 items 和分页状态', async () => {
      get.mockResolvedValue({
        records: [{ id: 1, title: '丢失钱包' }, { id: 2, title: '捡到钥匙' }],
        current: 1,
        pages: 1,
        total: 2
      })

      const store = useLostFoundStore()
      await store.loadList()

      expect(store.items).toHaveLength(2)
      expect(store.currentPage).toBe(1)
      expect(store.hasMore).toBe(false)
      expect(store.loading).toBe(false)
    })

    it('加载失败设置 error', async () => {
      get.mockRejectedValue(new Error('网络错误'))

      const store = useLostFoundStore()
      await store.loadList()

      expect(store.error).toBe('网络错误')
      expect(store.loading).toBe(false)
    })
  })

  describe('loadMore', () => {
    it('追加下一页数据到 items', async () => {
      get.mockResolvedValueOnce({
        records: [{ id: 1 }],
        current: 1,
        pages: 2,
        total: 3
      }).mockResolvedValueOnce({
        records: [{ id: 2 }, { id: 3 }],
        current: 2,
        pages: 2,
        total: 3
      })

      const store = useLostFoundStore()
      await store.loadList()
      expect(store.items).toHaveLength(1)

      await store.loadMore()
      expect(store.items).toHaveLength(3)
      expect(store.hasMore).toBe(false)
    })

    it('没有更多数据时不发起请求', async () => {
      get.mockResolvedValueOnce({
        records: [{ id: 1 }],
        current: 1,
        pages: 1,
        total: 1
      })

      const store = useLostFoundStore()
      await store.loadList()
      expect(store.hasMore).toBe(false)

      await store.loadMore()
      // get should only have been called once (loadList)
      expect(get).toHaveBeenCalledTimes(1)
    })
  })

  describe('setKeyword', () => {
    it('更新关键词', () => {
      const store = useLostFoundStore()
      store.setKeyword('钱包')
      expect(store.keyword).toBe('钱包')
    })
  })

  describe('setFilter', () => {
    it('更新筛选条件', () => {
      const store = useLostFoundStore()
      store.setFilter({ itemType: 'lost', status: 'pending' })
      expect(store.filters.itemType).toBe('lost')
      expect(store.filters.status).toBe('pending')
    })
  })

  describe('toggleFavorite', () => {
    it('调用收藏 API 并更新本地计数', async () => {
      post.mockResolvedValue({})

      const store = useLostFoundStore()
      store.items = [{ id: 1, title: 'test', favoriteCount: 3, isFavorited: false }]

      await store.toggleFavorite(1)
      expect(post).toHaveBeenCalledWith('/lost/1/favorite')
      expect(store.items[0].favoriteCount).toBe(4)
      expect(store.items[0].isFavorited).toBe(true)
    })
  })
})
