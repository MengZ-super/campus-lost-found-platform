<template>
  <view class="home-page">
    <!-- Header -->
    <view class="header">
      <text class="app-name">校园失物招领</text>
      <text class="welcome">欢迎使用</text>
    </view>

    <!-- Search Bar -->
    <view
      class="search-bar"
      @click="goToSearch"
    >
      <text class="search-placeholder">搜索失物招领...</text>
    </view>

    <!-- Quick Actions -->
    <view class="quick-actions">
      <view
        class="action-btn action-lost"
        @click="goToPublish('lost')"
      >
        <text class="action-icon">📦</text>
        <text class="action-text">发布失物</text>
      </view>
      <view
        class="action-btn action-found"
        @click="goToPublish('found')"
      >
        <text class="action-icon">📢</text>
        <text class="action-text">发布招领</text>
      </view>
    </view>

    <!-- Latest Items -->
    <view class="section">
      <view class="section-header">
        <text class="section-title">最新物品</text>
      </view>

      <view
        v-if="lostFoundStore.loading && lostFoundStore.items.length === 0"
        class="loading"
      >
        <text>加载中...</text>
      </view>

      <view
        v-else-if="lostFoundStore.items.length === 0"
        class="empty"
      >
        <empty-state
          icon="📭"
          message="暂无物品信息"
        />
      </view>

      <view
        v-else
        class="item-list"
      >
        <item-card
          v-for="item in lostFoundStore.items"
          :key="item.id"
          :item="item"
          @click="goToDetail(item)"
        />
      </view>
    </view>
  </view>
</template>

<script setup>
import { onMounted } from 'vue'
import { useLostFoundStore } from '@/stores/lost-found.js'
import ItemCard from '@/components/item-card.vue'
import EmptyState from '@/components/empty-state.vue'

const lostFoundStore = useLostFoundStore()

onMounted(() => {
  lostFoundStore.loadList({ pageSize: 10 })
})

function goToSearch() {
  uni.navigateTo({ url: '/pages/lost-found/index' })
}

function goToPublish(_itemType) {
  uni.navigateTo({ url: '/pages/lost-found/publish' })
}

function goToDetail(item) {
  uni.navigateTo({ url: `/pages/lost-found/detail?id=${item.id}` })
}
</script>

<style scoped>
.home-page {
  min-height: 100vh;
  background: $bg-color;
  padding-bottom: $spacing-lg;
}

.header {
  background: linear-gradient(135deg, $primary-color, $primary-light);
  padding: $spacing-lg $spacing-md;
  padding-top: calc(env(safe-area-inset-top) + 20px);
  color: #fff;
}

.app-name {
  font-size: $font-xxl;
  font-weight: 700;
  display: block;
}

.welcome {
  font-size: $font-md;
  opacity: 0.9;
  margin-top: $spacing-xs;
  display: block;
}

.search-bar {
  margin: $spacing-md;
  background: $bg-white;
  border-radius: $radius-round;
  padding: $spacing-sm $spacing-md;
  display: flex;
  align-items: center;
  box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.06);
}

.search-placeholder {
  color: $text-placeholder;
  font-size: $font-md;
}

.quick-actions {
  display: flex;
  gap: $spacing-md;
  padding: 0 $spacing-md;
  margin-bottom: $spacing-md;
}

.action-btn {
  flex: 1;
  background: $bg-white;
  border-radius: $radius-md;
  padding: $spacing-md;
  display: flex;
  align-items: center;
  gap: $spacing-sm;
  box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.04);
}

.action-icon {
  font-size: 40rpx;
}

.action-text {
  font-size: $font-md;
  font-weight: 600;
  color: $text-primary;
}

.action-lost .action-text {
  color: $danger-color;
}

.action-found .action-text {
  color: $primary-color;
}

.section {
  padding: 0 $spacing-md;
}

.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: $spacing-sm;
}

.section-title {
  font-size: $font-lg;
  font-weight: 600;
  color: $text-primary;
}

.item-list {
  display: flex;
  flex-direction: column;
  gap: $spacing-sm;
}

.loading,
.empty {
  background: $bg-white;
  border-radius: $radius-md;
  padding: $spacing-xl 0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: $text-placeholder;
}
</style>
