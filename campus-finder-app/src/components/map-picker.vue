<template>
  <view class="map-picker">
    <view class="map-container">
      <map
        v-if="hasLocation"
        class="map"
        :latitude="latitude"
        :longitude="longitude"
        :markers="markers"
        :scale="16"
        show-location
        disable-scroll
      />
      <view
        v-else
        class="map-placeholder"
        @tap="handleSelect"
      >
        <text class="placeholder-icon">
          📍
        </text>
        <text class="placeholder-text">
          点击选择位置
        </text>
      </view>
    </view>

    <view
      v-if="hasLocation"
      class="location-info"
    >
      <view class="info-row">
        <text class="info-label">
          位置
        </text>
        <text class="info-value">
          {{ modelValue.name || '未知地点' }}
        </text>
      </view>
      <view
        v-if="modelValue.address"
        class="info-row"
      >
        <text class="info-label">
          地址
        </text>
        <text class="info-value">
          {{ modelValue.address }}
        </text>
      </view>
    </view>

    <view class="actions">
      <button
        class="btn-select"
        @tap="handleSelect"
      >
        {{ hasLocation ? '重新选择' : '选择位置' }}
      </button>
      <button
        v-if="hasLocation"
        class="btn-clear"
        @tap="handleClear"
      >
        清除
      </button>
    </view>
  </view>
</template>

<script setup>
import { computed } from 'vue'

const DEFAULT_LATITUDE = 39.9042
const DEFAULT_LONGITUDE = 116.4074

const props = defineProps({
  modelValue: {
    type: Object,
    default: () => ({})
  }
})

const emit = defineEmits(['update:modelValue'])

const hasLocation = computed(() => {
  return props.modelValue?.latitude != null && props.modelValue?.longitude != null
})

const latitude = computed(() => props.modelValue?.latitude ?? DEFAULT_LATITUDE)
const longitude = computed(() => props.modelValue?.longitude ?? DEFAULT_LONGITUDE)

const markers = computed(() => {
  if (!hasLocation.value) return []
  return [{
    id: 1,
    latitude: props.modelValue.latitude,
    longitude: props.modelValue.longitude,
    title: props.modelValue.name || '选择的位置',
    width: 30,
    height: 30
  }]
})

function handleSelect() {
  uni.chooseLocation({
    success: (res) => {
      emit('update:modelValue', {
        latitude: res.latitude,
        longitude: res.longitude,
        name: res.name || '',
        address: res.address || ''
      })
    },
    fail: (err) => {
      if (err.errMsg && err.errMsg.includes('cancel')) return
      uni.showToast({ title: '选择位置失败', icon: 'none' })
    }
  })
}

function handleClear() {
  emit('update:modelValue', {})
}
</script>

<style scoped>
.map-picker {
  border-radius: $radius-md;
  overflow: hidden;
}

.map-container {
  width: 100%;
  height: 400rpx;
}

.map {
  width: 100%;
  height: 100%;
}

.map-placeholder {
  width: 100%;
  height: 100%;
  background: $bg-color;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.placeholder-icon {
  font-size: 80rpx;
  margin-bottom: $spacing-sm;
}

.placeholder-text {
  font-size: $font-md;
  color: $text-secondary;
}

.location-info {
  background: $bg-white;
  padding: $spacing-md;
}

.info-row {
  display: flex;
  align-items: baseline;
  margin-bottom: $spacing-xs;
}

.info-row:last-child {
  margin-bottom: 0;
}

.info-label {
  font-size: $font-sm;
  color: $text-placeholder;
  width: 80rpx;
  flex-shrink: 0;
}

.info-value {
  font-size: $font-md;
  color: $text-primary;
  flex: 1;
  word-break: break-all;
}

.actions {
  display: flex;
  gap: $spacing-sm;
  padding: $spacing-md;
  background: $bg-white;
  border-top: 1rpx solid $border-color;
}

.btn-select {
  flex: 1;
  background: $primary-color;
  color: #fff;
  font-size: $font-md;
  border-radius: $radius-md;
  padding: 16rpx 0;
  border: none;
  line-height: 1.5;
}

.btn-clear {
  flex: 1;
  background: $bg-color;
  color: $text-secondary;
  font-size: $font-md;
  border-radius: $radius-md;
  padding: 16rpx 0;
  border: none;
  line-height: 1.5;
}
</style>
