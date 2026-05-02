export function required(value) {
  if (value === null || value === undefined || value === '') {
    return '此项为必填'
  }
  return ''
}

export function minLength(min) {
  return (value) => {
    if (value && value.length < min) {
      return `至少 ${min} 个字符`
    }
    return ''
  }
}

export function maxLength(max) {
  return (value) => {
    if (value && value.length > max) {
      return `最多 ${max} 个字符`
    }
    return ''
  }
}

export function phone(value) {
  if (!value) return ''
  if (!/^1[3-9]\d{9}$/.test(value)) {
    return '请输入正确的手机号'
  }
  return ''
}

export function studentId(value) {
  if (!value) return ''
  if (value.length < 5) {
    return '学号至少 5 位'
  }
  return ''
}
