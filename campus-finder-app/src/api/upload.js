const BASE_URL = 'http://localhost:8080/api'

/**
 * Upload an image file to the server.
 * @param {string} filePath - local file path from uni.chooseImage
 * @param {function} [onProgress] - optional progress callback (percent: number)
 * @returns {Promise<string>} uploaded image URL
 */
export function uploadImage(filePath, onProgress) {
  return new Promise((resolve, reject) => {
    const token = uni.getStorageSync('token') || ''
    const uploadTask = uni.uploadFile({
      url: `${BASE_URL}/upload`,
      filePath,
      name: 'file',
      header: token ? { Authorization: `Bearer ${token}` } : {},
      success: (res) => {
        if (res.statusCode === 200) {
          try {
            const body = JSON.parse(res.data)
            if (body.code === 200) {
              resolve(body.data)
            } else {
              reject(new Error(body.message || '上传失败'))
            }
          } catch {
            reject(new Error('响应解析失败'))
          }
        } else if (res.statusCode === 401) {
          reject(new Error('登录已过期'))
        } else {
          reject(new Error(`上传失败 (${res.statusCode})`))
        }
      },
      fail: (err) => {
        reject(new Error(err?.errMsg || '网络错误'))
      }
    })

    if (onProgress && uploadTask) {
      uploadTask.onProgressUpdate((progress) => {
        onProgress(progress.progress)
      })
    }
  })
}
