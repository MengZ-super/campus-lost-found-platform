<template>
  <view :class="['status-badge', `status-${status}`]">
    <text>{{ label }}</text>
  </view>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  status: {
    type: String,
    required: true,
    validator: (v) => ['pending', 'claimed', 'closed'].includes(v)
  }
})

const labelMap = {
  pending: '待认领',
  claimed: '已认领',
  closed: '已关闭'
}

const label = computed(() => labelMap[props.status] || props.status)
</script>

<style scoped>
.status-badge {
  display: inline-flex;
  align-items: center;
  padding: 4rpx 16rpx;
  border-radius: $radius-round;
  font-size: $font-sm;
}

.status-pending {
  background: #fff7e6;
  color: $warning-color;
}

.status-claimed {
  background: #f6ffed;
  color: $success-color;
}

.status-closed {
  background: #f5f5f5;
  color: $text-placeholder;
}
</style>
