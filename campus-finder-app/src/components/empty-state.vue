<template>
  <view class="empty-state">
    <text class="icon">
      {{ icon }}
    </text>
    <text class="message">
      {{ message }}
    </text>
  </view>
</template>

<script setup>
defineProps({
  icon: {
    type: String,
    default: '📭'
  },
  message: {
    type: String,
    default: '暂无数据'
  }
})
</script>

<style scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 120rpx 0;
}

.icon {
  font-size: 80rpx;
  margin-bottom: 24rpx;
}

.message {
  font-size: $font-md;
  color: $text-placeholder;
}
</style>
