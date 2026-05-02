import { describe, it, expect, vi, beforeEach } from 'vitest'

vi.stubGlobal('uni', {
  uploadFile: vi.fn(),
  getStorageSync: vi.fn(),
  showToast: vi.fn()
})

const { uploadImage } = await import('@/api/upload.js')

describe('api/upload', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('成功上传返回 URL', async () => {
    uni.getStorageSync.mockReturnValue('test-token')
    uni.uploadFile.mockImplementation(({ success }) => {
      success({
        statusCode: 200,
        data: JSON.stringify({ code: 200, message: 'ok', data: 'http://cdn.test/img.jpg' })
      })
    })

    const url = await uploadImage('/tmp/photo.jpg')
    expect(url).toBe('http://cdn.test/img.jpg')
  })

  it('携带 Authorization header', async () => {
    uni.getStorageSync.mockReturnValue('my-token')
    uni.uploadFile.mockImplementation(({ success }) => {
      success({
        statusCode: 200,
        data: JSON.stringify({ code: 200, message: 'ok', data: 'url' })
      })
    })

    await uploadImage('/tmp/photo.jpg')

    expect(uni.uploadFile).toHaveBeenCalledWith(
      expect.objectContaining({
        header: { Authorization: 'Bearer my-token' }
      })
    )
  })

  it('无 token 时不携带 Authorization', async () => {
    uni.getStorageSync.mockReturnValue('')
    uni.uploadFile.mockImplementation(({ success }) => {
      success({
        statusCode: 200,
        data: JSON.stringify({ code: 200, message: 'ok', data: 'url' })
      })
    })

    await uploadImage('/tmp/photo.jpg')

    const callArgs = uni.uploadFile.mock.calls[0][0]
    expect(callArgs.header).toEqual({})
  })

  it('name 字段为 file', async () => {
    uni.getStorageSync.mockReturnValue('')
    uni.uploadFile.mockImplementation(({ success }) => {
      success({
        statusCode: 200,
        data: JSON.stringify({ code: 200, message: 'ok', data: 'url' })
      })
    })

    await uploadImage('/tmp/photo.jpg')

    expect(uni.uploadFile).toHaveBeenCalledWith(
      expect.objectContaining({ name: 'file' })
    )
  })

  it('服务端返回非 200 code 时抛错', async () => {
    uni.getStorageSync.mockReturnValue('')
    uni.uploadFile.mockImplementation(({ success }) => {
      success({
        statusCode: 200,
        data: JSON.stringify({ code: 400, message: '文件过大', data: null })
      })
    })

    await expect(uploadImage('/tmp/big.jpg')).rejects.toThrow('文件过大')
  })

  it('HTTP 401 时抛出登录过期', async () => {
    uni.getStorageSync.mockReturnValue('')
    uni.uploadFile.mockImplementation(({ success }) => {
      success({ statusCode: 401, data: '' })
    })

    await expect(uploadImage('/tmp/photo.jpg')).rejects.toThrow('登录已过期')
  })

  it('网络失败时抛错', async () => {
    uni.getStorageSync.mockReturnValue('')
    uni.uploadFile.mockImplementation(({ fail }) => {
      fail({ errMsg: 'request:fail timeout' })
    })

    await expect(uploadImage('/tmp/photo.jpg')).rejects.toThrow('request:fail timeout')
  })

  it('JSON 解析失败时抛错', async () => {
    uni.getStorageSync.mockReturnValue('')
    uni.uploadFile.mockImplementation(({ success }) => {
      success({ statusCode: 200, data: 'not json' })
    })

    await expect(uploadImage('/tmp/photo.jpg')).rejects.toThrow('响应解析失败')
  })

  it('注册 onProgressUpdate 回调', async () => {
    const mockTask = { onProgressUpdate: vi.fn() }
    uni.getStorageSync.mockReturnValue('')
    uni.uploadFile.mockReturnValue(mockTask)
    uni.uploadFile.mockImplementation(() => {
      return mockTask
    })

    const onProgress = vi.fn()
    uploadImage('/tmp/photo.jpg', onProgress)

    expect(mockTask.onProgressUpdate).toHaveBeenCalled()
  })
})
