import { describe, it, expect } from 'vitest'

const { required, minLength, maxLength, phone, studentId } = await import('@/utils/validator.js')

describe('utils/validator', () => {
  describe('required', () => {
    it('空字符串返回错误', () => {
      expect(required('')).toBe('此项为必填')
    })
    it('null 返回错误', () => {
      expect(required(null)).toBe('此项为必填')
    })
    it('有值返回空字符串', () => {
      expect(required('hello')).toBe('')
    })
  })

  describe('minLength', () => {
    const min3 = minLength(3)
    it('不足长度返回错误', () => {
      expect(min3('ab')).toBe('至少 3 个字符')
    })
    it('满足长度返回空', () => {
      expect(min3('abc')).toBe('')
      expect(min3('abcdef')).toBe('')
    })
  })

  describe('maxLength', () => {
    const max5 = maxLength(5)
    it('超出长度返回错误', () => {
      expect(max5('123456')).toBe('最多 5 个字符')
    })
    it('满足长度返回空', () => {
      expect(max5('12345')).toBe('')
    })
  })

  describe('phone', () => {
    it('有效手机号返回空', () => {
      expect(phone('13800138000')).toBe('')
    })
    it('无效手机号返回错误', () => {
      expect(phone('123456')).toBe('请输入正确的手机号')
      expect(phone('abcdefghijk')).toBe('请输入正确的手机号')
    })
  })

  describe('studentId', () => {
    it('有效学号返回空', () => {
      expect(studentId('2021001')).toBe('')
    })
    it('过短返回错误', () => {
      expect(studentId('123')).toBe('学号至少 5 位')
    })
  })
})
