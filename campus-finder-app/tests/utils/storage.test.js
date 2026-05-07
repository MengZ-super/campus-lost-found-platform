import { describe, it, expect, vi, beforeEach } from 'vitest'

vi.stubGlobal('uni', {
  getStorageSync: vi.fn(),
  setStorageSync: vi.fn(),
  removeStorageSync: vi.fn()
})

const { get, set, remove } = await import('@/utils/storage.js')

describe('utils/storage', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('get 调用 uni.getStorageSync 并返回值', () => {
    uni.getStorageSync.mockReturnValue('bar')
    expect(get('foo')).toBe('bar')
    expect(uni.getStorageSync).toHaveBeenCalledWith('foo')
  })

  it('get key 不存在时返回 null', () => {
    uni.getStorageSync.mockReturnValue('')
    expect(get('missing')).toBeNull()
  })

  it('set 调用 uni.setStorageSync', () => {
    set('foo', { a: 1 })
    expect(uni.setStorageSync).toHaveBeenCalledWith('foo', { a: 1 })
  })

  it('remove 调用 uni.removeStorageSync', () => {
    remove('foo')
    expect(uni.removeStorageSync).toHaveBeenCalledWith('foo')
  })
})
