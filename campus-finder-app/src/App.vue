<script>
const publicPages = ['pages/auth/login', 'pages/auth/register']

export default {
  onLaunch() {
    // Route guard: redirect to login if not authenticated
    uni.addInterceptor('navigateTo', { fail: () => {} })
    uni.addInterceptor('switchTab', { fail: () => {} })

    const checkAuth = () => {
      const token = uni.getStorageSync('token')
      const pages = getCurrentPages()
      if (!pages.length) return
      const currentPage = pages[pages.length - 1]
      const route = currentPage?.route || ''
      if (!token && !publicPages.includes(route)) {
        uni.redirectTo({ url: '/pages/auth/login' })
      }
    }

    // Check on launch
    checkAuth()
  },
  onShow() {},
  onHide() {}
}
</script>

<style>
page {
  background-color: #f5f5f5;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  font-size: 28rpx;
  color: #333;
}
</style>
