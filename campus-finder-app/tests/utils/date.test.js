import { describe, it, expect, vi, afterEach } from 'vitest'

const { formatDate, relativeTime } = await import('@/utils/date.js')

describe('utils/date', () => {
  afterEach(() => {
    vi.useRealTimers()
  })

  describe('formatDate', () => {
    it('格式化为 YYYY-MM-DD', () => {
      expect(formatDate('2025-03-15T10:30:00')).toBe('2025-03-15')
    })

    it('Date 对象也能格式化', () => {
      expect(formatDate(new Date(2025, 0, 5))).toBe('2025-01-05')
    })

    it('null/undefined 返回空字符串', () => {
      expect(formatDate(null)).toBe('')
      expect(formatDate(undefined)).toBe('')
    })
  })

  describe('relativeTime', () => {
    it('30 秒内返回"刚刚"', () => {
      vi.useFakeTimers()
      vi.setSystemTime(new Date('2025-03-15T12:00:30'))
      expect(relativeTime('2025-03-15T12:00:00')).toBe('刚刚')
    })

    it('5 分钟前', () => {
      vi.useFakeTimers()
      vi.setSystemTime(new Date('2025-03-15T12:05:00'))
      expect(relativeTime('2025-03-15T12:00:00')).toBe('5分钟前')
    })

    it('3 小时前', () => {
      vi.useFakeTimers()
      vi.setSystemTime(new Date('2025-03-15T15:00:00'))
      expect(relativeTime('2025-03-15T12:00:00')).toBe('3小时前')
    })

    it('2 天前', () => {
      vi.useFakeTimers()
      vi.setSystemTime(new Date('2025-03-17T12:00:00'))
      expect(relativeTime('2025-03-15T12:00:00')).toBe('2天前')
    })

    it('超过 30 天显示完整日期', () => {
      vi.useFakeTimers()
      vi.setSystemTime(new Date('2025-05-01T12:00:00'))
      expect(relativeTime('2025-03-15T12:00:00')).toBe('2025-03-15')
    })
  })
})
