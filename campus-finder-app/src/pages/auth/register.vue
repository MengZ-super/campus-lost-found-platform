<template>
  <view class="register-page">
    <view class="header">
      <text class="title">
        注册新账号
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
            placeholder="用户名"
          />
        </uni-forms-item>
        <uni-forms-item name="nickname">
          <uni-easyinput
            v-model="formData.nickname"
            placeholder="昵称"
          />
        </uni-forms-item>
        <uni-forms-item name="password">
          <uni-easyinput
            v-model="formData.password"
            type="password"
            placeholder="密码"
          />
        </uni-forms-item>
        <uni-forms-item name="confirmPassword">
          <uni-easyinput
            v-model="formData.confirmPassword"
            type="password"
            placeholder="确认密码"
          />
        </uni-forms-item>
        <uni-forms-item name="phone">
          <uni-easyinput
            v-model="formData.phone"
            placeholder="手机号"
          />
        </uni-forms-item>
        <uni-forms-item name="studentId">
          <uni-easyinput
            v-model="formData.studentId"
            placeholder="学号"
          />
        </uni-forms-item>
      </uni-forms>

      <button
        class="register-btn"
        type="primary"
        :loading="loading"
        @click="handleRegister"
      >
        注册
      </button>

      <view
        class="login-link"
        @click="goLogin"
      >
        <text>已有账号？</text>
        <text class="link">
          去登录
        </text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { registerApi } from '@/api/auth.js'

const formRef = ref(null)
const loading = ref(false)

const formData = reactive({
  username: '',
  nickname: '',
  password: '',
  confirmPassword: '',
  phone: '',
  studentId: ''
})

const rules = {
  username: { rules: [{ required: true, errorMessage: '请输入用户名' }] },
  nickname: { rules: [{ required: true, errorMessage: '请输入昵称' }] },
  password: { rules: [{ required: true, errorMessage: '请输入密码' }, { minLength: 6, errorMessage: '密码至少 6 位' }] },
  confirmPassword: {
    rules: [
      { required: true, errorMessage: '请确认密码' },
      {
        validateFunction: (rule, value, data, callback) => {
          if (value !== data.password) {
            callback('两次密码不一致')
          }
          return true
        }
      }
    ]
  },
  phone: {
    rules: [
      { required: true, errorMessage: '请输入手机号' },
      { pattern: /^1[3-9]\d{9}$/, errorMessage: '手机号格式不正确' }
    ]
  }
}

async function handleRegister() {
  try {
    await formRef.value?.validate()
  } catch {
    return
  }

  loading.value = true
  try {
    await registerApi({
      username: formData.username,
      nickname: formData.nickname,
      password: formData.password,
      phone: formData.phone,
      studentId: formData.studentId
    })
    uni.showToast({ title: '注册成功', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  } catch (err) {
    uni.showToast({ title: err.message || '注册失败', icon: 'none' })
  } finally {
    loading.value = false
  }
}

function goLogin() {
  uni.navigateBack()
}
</script>

<style scoped>
.register-page {
  padding: 60rpx 48rpx;
  min-height: 100vh;
  background: #fff;
}

.header {
  margin-bottom: 60rpx;
}

.title {
  font-size: 44rpx;
  font-weight: bold;
  color: $text-primary;
}

.form-area {
  margin-top: 20rpx;
}

.register-btn {
  margin-top: 40rpx;
  background-color: $primary-color;
  border-radius: $radius-md;
  height: 88rpx;
  line-height: 88rpx;
  font-size: 32rpx;
}

.login-link {
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
