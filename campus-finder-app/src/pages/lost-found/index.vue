<template>
  <view class="lost-found-page">
    <!-- Search Bar -->
    <view class="search-area">
      <uni-search-bar
        v-model="searchValue"
        placeholder="搜索失物招领"
        :focus="false"
        @confirm="handleSearch"
        @clear="handleClear"
      />
    </view>

    <!-- Filter Tabs -->
    <view class="filter-tabs">
      <view
        class="tab-chip"
        :class="{ active: currentFilter === '' }"
        @click="handleFilterChange('')"
      >
        <text>全部</text>
      </view>
      <view
        class="tab-chip"
        :class="{ active: currentFilter === 'lost' }"
        @click="handleFilterChange('lost')"
      >
        <text>失物</text>
      </view>
      <view
        class="tab-chip"
        :class="{ active: currentFilter === 'found' }"
        @click="handleFilterChange('found')"
      >
        <text>招领</text>
      </view>
    </view>

    <!-- Content List -->
    <scroll-view
      class="content-scroll"
      scroll-y
      :refresher-enabled="true"
      :refresher-triggered="isRefreshing"
      @refresherrefresh="handlePullDownRefresh"
      @scrolltolower="handleScrollToLower"
    >
      <!-- Loading State -->
      <view
        v-if="store.loading && store.items.length === 0"
        class="loading-area"
      >
        <uni-load-more
          status="loading"
          :content-text="{ contentrefresh: '加载中...' }"
        />
      </view>

      <!-- Error State -->
      <view
        v-else-if="store.error && store.items.length === 0"
        class="error-area"
      >
        <text class="error-text">
          {{ store.error }}
        </text>
        <button
          class="retry-btn"
          size="mini"
          @click="handleRetry"
        >
          重试
        </button>
      </view>

      <!-- Empty State -->
      <empty-state
        v-else-if="store.items.length === 0"
        icon="🔍"
        message="暂无相关物品"
      />

      <!-- Item List -->
      <view
        v-else
        class="item-list"
      >
        <item-card
          v-for="item in store.items"
          :key="item.id"
          :item="item"
          @click="handleItemClick(item)"
        />
      </view>

      <!-- Load More -->
      <uni-load-more
        v-if="store.items.length > 0"
        class="load-more"
        :status="loadMoreStatus"
        :content-text="loadMoreText"
      />
    </scroll-view>
  </view>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useLostFoundStore } from '@/stores/lost-found.js'
import ItemCard from '@/components/item-card.vue'
import EmptyState from '@/components/empty-state.vue'

const store = useLostFoundStore()

const searchValue = ref('')
const currentFilter = ref('')
const isRefreshing = ref(false)

// Load more status
const loadMoreStatus = computed(() => {
  if (store.loading) return 'loading'
  if (!store.hasMore) return 'noMore'
  return 'more'
})

const loadMoreText = {
  contentdown: '上拉加载更多',
  contentrefresh: '加载中...',
  contentnomore: '没有更多了'
}

// Search
function handleSearch() {
  store.setKeyword(searchValue.value)
  store.loadList()
}

// Clear search
function handleClear() {
  searchValue.value = ''
  store.setKeyword('')
  store.loadList()
}

// Filter change
function handleFilterChange(type) {
  if (currentFilter.value === type) return
  currentFilter.value = type
  store.setFilter({ itemType: type })
  store.loadList()
}

// Pull down refresh
async function handlePullDownRefresh() {
  isRefreshing.value = true
  try {
    await store.loadList()
  } finally {
    isRefreshing.value = false
  }
}

// Scroll to lower (load more)
function handleScrollToLower() {
  if (store.hasMore && !store.loading) {
    store.loadMore()
  }
}

// Retry
function handleRetry() {
  store.loadList()
}

// Item click
function handleItemClick(item) {
  uni.navigateTo({ url: `/pages/lost-found/detail?id=${item.id}` })
}

// Initial load
store.loadList()
</script>

<style scoped>
.lost-found-page {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background: $page-bg;
}

.search-area {
  background: #fff;
  padding: 0 8rpx;
}

.filter-tabs {
  display: flex;
  gap: 24rpx;
  padding: 24rpx 32rpx;
  background: #fff;
  border-bottom: 1rpx solid $border-color;
}

.tab-chip {
  padding: 12rpx 32rpx;
  border-radius: 32rpx;
  background: $bg-color;
  font-size: $font-md;
  color: $text-secondary;
  transition: all 0.2s;
}

.tab-chip.active {
  background: $primary-color;
  color: #fff;
}

.content-scroll {
  flex: 1;
  height: 0; /* Important for scroll-view */
}

.loading-area,
.error-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 120rpx 0;
}

.error-text {
  color: $text-placeholder;
  font-size: $font-md;
  margin-bottom: 24rpx;
}

.retry-btn {
  background: $primary-color;
  color: #fff;
}

.item-list {
  padding: 24rpx 32rpx;
}

.load-more {
  padding: 24rpx 0;
}
</style>