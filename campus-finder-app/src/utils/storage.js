export function get(key) {
  const val = uni.getStorageSync(key)
  return val || null
}

export function set(key, value) {
  uni.setStorageSync(key, value)
}

export function remove(key) {
  uni.removeStorageSync(key)
}
