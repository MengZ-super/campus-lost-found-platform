<template>
  <view class="my-page">
    <!-- Login Required -->
    <view
      v-if="!authStore.isLoggedIn"
      class="login-prompt"
    >
      <text class="login-icon">👤</text>
      <text class="login-text">未登录</text>
      <text class="login-hint">登录后可查看您的个人中心</text>
      <view
        class="login-btn"
        @click="goToLogin"
      >
        <text>立即登录</text>
      </view>
    </view>

    <!-- User Info -->
    <view
      v-else
      class="user-section"
    >
      <view class="user-card">
        <image
          v-if="authStore.avatar"
          class="avatar"
          :src="authStore.avatar"
          mode="aspectFill"
        />
        <view
          v-else
          class="avatar avatar-placeholder"
        >
          <text>👤</text>
        </view>
        <view class="user-info">
          <text class="nickname">{{ authStore.nickname || '用户' }}</text>
          <text class="username">@{{ authStore.username || 'unknown' }}</text>
        </view>
      </view>
    </view>

    <!-- Menu List -->
    <view class="menu-list">
      <view
        class="menu-item"
        @click="goToPage('/pages/my/publishes')"
      >
        <text class="menu-icon">📋</text>
        <text class="menu-text">我的发布</text>
        <text class="menu-arrow">›</text>
      </view>

      <view
        class="menu-item"
        @click="goToPage('/pages/my/claims')"
      >
        <text class="menu-icon">🎯</text>
        <text class="menu-text">我的认领</text>
        <text class="menu-arrow">›</text>
      </view>

      <view
        class="menu-item"
        @click="goToPage('/pages/profile/edit')"
      >
        <text class="menu-icon">✏️</text>
        <text class="menu-text">编辑资料</text>
        <text class="menu-arrow">›</text>
      </view>

      <view
        class="menu-item menu-item-danger"
        @click="handleLogout"
      >
        <text class="menu-icon">🚪</text>
        <text class="menu-text">退出登录</text>
        <text class="menu-arrow">›</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { useAuthStore } from '@/stores/auth.js'

const authStore = useAuthStore()

function goToLogin() {
  uni.navigateTo({ url: '/pages/auth/login' })
}

function goToPage(url) {
  uni.navigateTo({ url })
}

async function handleLogout() {
  await authStore.logout()
  uni.reLaunch({ url: '/pages/auth/login' })
}
</script>

<style scoped>
.my-page {
  min-height: 100vh;
  background: $bg-color;
  padding-bottom: $spacing-lg;
}

.login-prompt {
  background: $bg-white;
  margin: $spacing-md;
  border-radius: $radius-md;
  padding: $spacing-xl 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: $spacing-sm;
}

.login-icon {
  font-size: 80rpx;
}

.login-text {
  font-size: $font-xl;
  font-weight: 600;
  color: $text-primary;
}

.login-hint {
  font-size: $font-md;
  color: $text-placeholder;
}

.login-btn {
  background: $primary-color;
  color: #fff;
  padding: $spacing-sm $spacing-xl;
  border-radius: $radius-round;
  margin-top: $spacing-sm;
}

.login-btn text {
  font-size: $font-md;
  font-weight: 500;
}

.user-section {
  padding: $spacing-md;
}

.user-card {
  background: $bg-white;
  border-radius: $radius-md;
  padding: $spacing-md;
  display: flex;
  align-items: center;
  gap: $spacing-md;
}

.avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  flex-shrink: 0;
}

.avatar-placeholder {
  background: $bg-color;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 60rpx;
}

.user-info {
  display: flex;
  flex-direction: column;
  gap: $spacing-xs;
}

.nickname {
  font-size: $font-xl;
  font-weight: 600;
  color: $text-primary;
}

.username {
  font-size: $font-sm;
  color: $text-placeholder;
}

.menu-list {
  margin: $spacing-md;
  background: $bg-white;
  border-radius: $radius-md;
  overflow: hidden;
}

.menu-item {
  display: flex;
  align-items: center;
  padding: $spacing-md;
  border-bottom: 1rpx solid $border-color;
}

.menu-item:last-child {
  border-bottom: none;
}

.menu-icon {
  font-size: 40rpx;
  margin-right: $spacing-md;
}

.menu-text {
  flex: 1;
  font-size: $font-md;
  color: $text-primary;
}

.menu-arrow {
  font-size: $font-lg;
  color: $text-placeholder;
}

.menu-item-danger .menu-text {
  color: $danger-color;
}
</style>
