<template>
  <view
    class="item-card"
    @click="handleClick"
  >
    <view class="card-body">
      <image
        v-if="item.images?.length"
        class="thumbnail"
        :src="item.images[0]"
        mode="aspectFill"
      />
      <view
        v-else
        class="placeholder-img"
      >
        <text>📷</text>
      </view>

      <view class="info">
        <view class="title-row">
          <text class="title">
            {{ item.title }}
          </text>
          <status-badge :status="item.status" />
        </view>

        <view class="meta">
          <text
            class="type-tag"
            :class="item.itemType === 'lost' ? 'type-lost' : 'type-found'"
          >
            {{ item.itemType === 'lost' ? '失物' : '招领' }}
          </text>
          <text class="location">
            {{ item.location }}
          </text>
        </view>

        <view class="footer">
          <text class="time">
            {{ timeText }}
          </text>
          <view class="stats">
            <text class="stat">
              👁 {{ item.viewCount || 0 }}
            </text>
            <text class="stat">
              ⭐ {{ item.favoriteCount || 0 }}
            </text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { computed } from 'vue'
import { relativeTime } from '@/utils/date.js'
import StatusBadge from './status-badge.vue'

const props = defineProps({
  item: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['click'])

const timeText = computed(() => relativeTime(props.item.createdAt || props.item.happenedTime))

function handleClick() {
  emit('click', props.item)
}
</script>

<style scoped>
.item-card {
  background: $bg-white;
  border-radius: $radius-md;
  margin-bottom: $spacing-sm;
  overflow: hidden;
}

.card-body {
  display: flex;
  padding: $spacing-md;
}

.thumbnail {
  width: 180rpx;
  height: 180rpx;
  border-radius: $radius-sm;
  flex-shrink: 0;
}

.placeholder-img {
  width: 180rpx;
  height: 180rpx;
  border-radius: $radius-sm;
  background: $bg-color;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 60rpx;
  flex-shrink: 0;
}

.info {
  flex: 1;
  margin-left: $spacing-md;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.title {
  font-size: $font-lg;
  font-weight: 600;
  color: $text-primary;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  margin-right: $spacing-xs;
}

.meta {
  display: flex;
  align-items: center;
  gap: $spacing-sm;
  margin-top: $spacing-xs;
}

.type-tag {
  font-size: $font-sm;
  padding: 2rpx 12rpx;
  border-radius: $radius-sm;
}

.type-lost {
  background: #fff1f0;
  color: $danger-color;
}

.type-found {
  background: #e6f7ff;
  color: #1890ff;
}

.location {
  font-size: $font-sm;
  color: $text-secondary;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: $spacing-xs;
}

.time {
  font-size: $font-sm;
  color: $text-placeholder;
}

.stats {
  display: flex;
  gap: $spacing-sm;
}

.stat {
  font-size: $font-sm;
  color: $text-placeholder;
}
</style>
