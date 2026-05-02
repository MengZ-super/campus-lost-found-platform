<template>
  <view class="login-page">
    <view class="logo-area">
      <text class="title">
        校园失物招领
      </text>
      <text class="subtitle">
        登录你的账号
      </text>
    </view>

    <view class="form-area">
      <uni-forms
        ref="formRef"
        :model-value="formData"
        :rules="rules"
      >
        <uni-forms-item name="username">
          <uni-easyinput
            v-model="formData.username"
            placeholder="请输入用户名"
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
  username: { rules: [{ required: true, errorMessage: '请输入用户名' }] },
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

<style scoped>
.login-page {
  padding: 80rpx 48rpx;
  min-height: 100vh;
  background: #fff;
}

.logo-area {
  text-align: center;
  margin-bottom: 80rpx;
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

.form-area {
  margin-top: 40rpx;
}

.login-btn {
  margin-top: 40rpx;
  background-color: $primary-color;
  border-radius: $radius-md;
  height: 88rpx;
  line-height: 88rpx;
  font-size: 32rpx;
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
