// Vitest global setup
// Mock uni-app APIs for testing environment
global.uni = {
  getStorageSync: vi.fn(),
  setStorageSync: vi.fn(),
  removeStorageSync: vi.fn(),
  request: vi.fn(),
  switchTab: vi.fn(),
  redirectTo: vi.fn(),
  navigateTo: vi.fn(),
  showToast: vi.fn(),
  showLoading: vi.fn(),
  hideLoading: vi.fn(),
  compressImage: vi.fn(),
  previewImage: vi.fn(),
  uploadFile: vi.fn(),
  getLocation: vi.fn(),
  chooseLocation: vi.fn()
}

global.uniapp = {}
