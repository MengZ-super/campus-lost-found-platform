<template>
  <view class="login-page">
    <!-- 顶部装饰区域 -->
    <view class="header-decoration">
      <view class="icon-container">
        <uni-icons type="gift" size="48" color="#fff" />
      </view>
    </view>

    <view class="content-wrapper">
      <view class="logo-area">
        <text class="title">
          校园失物招领
        </text>
        <text class="subtitle">
          登录你的账号
        </text>
      </view>

      <!-- 表单卡片 -->
      <view class="form-card">
        <uni-forms
          ref="formRef"
          :model-value="formData"
          :rules="rules"
        >
          <uni-forms-item name="username">
            <uni-easyinput
              v-model="formData.username"
              placeholder="请输入学号/工号"
              prefix-icon="person"
            />
          </uni-forms-item>
          <uni-forms-item name="password">
            <uni-easyinput
              v-model="formData.password"
              type="password"
              placeholder="请输入密码"
              prefix-icon="locked"
            />
          </uni-forms-item>
        </uni-forms>

        <button
          class="login-btn"
          type="primary"
          :loading="loading"
          @click="handleLogin"
        >
          登录
        </button>

        <view
          class="register-link"
          @click="goRegister"
        >
          <text>还没有账号？</text>
          <text class="link">
            立即注册
          </text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useAuthStore } from '@/stores/auth.js'

const authStore = useAuthStore()
const formRef = ref(null)
const loading = ref(false)

const formData = reactive({
  username: '',
  password: ''
})

const rules = {
  username: { rules: [{ required: true, errorMessage: '请输入学号/工号' }] },
  password: { rules: [{ required: true, errorMessage: '请输入密码' }] }
}

async function handleLogin() {
  try {
    await formRef.value?.validate()
  } catch {
    return
  }

  loading.value = true
  try {
    await authStore.login(formData)
    uni.switchTab({ url: '/pages/index/index' })
  } catch (err) {
    uni.showToast({ title: err.message || '登录失败', icon: 'none' })
  } finally {
    loading.value = false
  }
}

function goRegister() {
  uni.navigateTo({ url: '/pages/auth/register' })
}
</script>

<style scoped lang="scss">
.login-page {
  min-height: 100vh;
  background: $bg-color;
}

.header-decoration {
  height: 400rpx;
  background: linear-gradient(135deg, $primary-color 0%, $primary-light 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

.header-decoration::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 60rpx;
  background: $bg-color;
  border-radius: 60rpx 60rpx 0 0;
}

.icon-container {
  width: 120rpx;
  height: 120rpx;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.content-wrapper {
  padding: 0 48rpx;
  margin-top: -60rpx;
  position: relative;
  z-index: 1;
}

.logo-area {
  text-align: center;
  margin-bottom: 48rpx;
}

.title {
  display: block;
  font-size: 48rpx;
  font-weight: bold;
  color: $primary-color;
  margin-bottom: 16rpx;
}

.subtitle {
  display: block;
  font-size: 28rpx;
  color: $text-secondary;
}

.form-card {
  background: $bg-white;
  border-radius: $radius-lg;
  padding: 48rpx 32rpx;
  box-shadow: 0 4rpx 24rpx rgba(0, 0, 0, 0.08);
}

.form-card :deep(.uni-forms-item) {
  margin-bottom: 32rpx;
}

.form-card :deep(.uni-easyinput) {
  height: 88rpx;
}

.login-btn {
  margin-top: 16rpx;
  background-color: $primary-color;
  border-radius: $radius-md;
  height: 88rpx;
  line-height: 88rpx;
  font-size: 32rpx;
  transition: background-color 0.2s ease;
}

.login-btn:hover {
  background-color: $primary-dark;
}

.register-link {
  text-align: center;
  margin-top: 32rpx;
  font-size: 28rpx;
  color: $text-secondary;
}

.link {
  color: $primary-color;
  margin-left: 8rpx;
}
</style>
