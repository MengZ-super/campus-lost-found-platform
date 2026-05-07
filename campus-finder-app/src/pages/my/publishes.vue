<template>
  <view class="publishes-page">
    <!-- Tab Filters -->
    <view class="tabs">
      <view
        v-for="tab in tabs"
        :key="tab.value"
        :class="['tab', { active: currentTab === tab.value }]"
        @click="onTabChange(tab.value)"
      >
        <text>{{ tab.label }}</text>
      </view>
    </view>

    <!-- Item List -->
    <scroll-view
      class="item-list"
      scroll-y
      :refresher-enabled="true"
      :refresher-triggered="refreshing"
      @refresherrefresh="onRefresh"
      @scrolltolower="onLoadMore"
    >
      <view
        v-if="items.length"
        class="list-content"
      >
        <view
          v-for="item in items"
          :key="item.id"
          class="item-wrapper"
        >
          <item-card
            :item="item"
            @click="goToDetail(item)"
          />
          <view class="item-actions">
            <view
              v-if="item.status === 'pending'"
              class="action-btn action-close"
              @click="onClose(item)"
            >
              <text>关闭</text>
            </view>
            <view
              v-if="item.status === 'closed'"
              class="action-btn action-reopen"
              @click="onReopen(item)"
            >
              <text>重开</text>
            </view>
            <view
              class="action-btn action-delete"
              @click="onDelete(item)"
            >
              <text>删除</text>
            </view>
          </view>
        </view>

        <!-- Load More -->
        <view
          v-if="loadingMore"
          class="loading-more"
        >
          <text>加载中...</text>
        </view>
        <view
          v-else-if="!hasMore && items.length"
          class="no-more"
        >
          <text>没有更多了</text>
        </view>
      </view>

      <!-- Empty State -->
      <empty-state
        v-else
        icon="📋"
        message="暂无发布记录"
      />
    </scroll-view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { getMyItemsApi, closeItemApi, reopenItemApi, deleteItemApi } from '@/api/lost-found.js'
import ItemCard from '@/components/item-card.vue'
import EmptyState from '@/components/empty-state.vue'

const tabs = [
  { label: '全部', value: '' },
  { label: '待认领', value: 'pending' },
  { label: '已认领', value: 'claimed' },
  { label: '已关闭', value: 'closed' }
]

const currentTab = ref('')
const items = ref([])
const currentPage = ref(0)
const totalPages = ref(0)
const total = ref(0)
const hasMore = ref(false)
const loading = ref(false)
const loadingMore = ref(false)
const refreshing = ref(false)

const pageSize = 10

async function loadList() {
  if (loading.value) return
  loading.value = true
  try {
    const res = await getMyItemsApi({
      pageNum: 1,
      pageSize,
      status: currentTab.value || undefined
    })
    items.value = res.records || []
    currentPage.value = res.current || 1
    totalPages.value = res.pages || 0
    total.value = res.total || 0
    hasMore.value = currentPage.value < totalPages.value
  } catch (err) {
    uni.showToast({ title: err.message || '加载失败', icon: 'none' })
  } finally {
    loading.value = false
  }
}

async function loadMore() {
  if (!hasMore.value || loadingMore.value || loading.value) return
  loadingMore.value = true
  try {
    const res = await getMyItemsApi({
      pageNum: currentPage.value + 1,
      pageSize,
      status: currentTab.value || undefined
    })
    items.value = [...items.value, ...(res.records || [])]
    currentPage.value = res.current || currentPage.value + 1
    totalPages.value = res.pages || 0
    total.value = res.total || 0
    hasMore.value = currentPage.value < totalPages.value
  } catch (err) {
    uni.showToast({ title: err.message || '加载失败', icon: 'none' })
  } finally {
    loadingMore.value = false
  }
}

async function onRefresh() {
  refreshing.value = true
  await loadList()
  refreshing.value = false
}

function onLoadMore() {
  loadMore()
}

function onTabChange(value) {
  currentTab.value = value
  loadList()
}

function goToDetail(item) {
  uni.navigateTo({ url: `/pages/lost-found/detail?id=${item.id}` })
}

function onClose(item) {
  uni.showModal({
    title: '关闭物品',
    editable: true,
    placeholderText: '请输入关闭原因',
    success: async (res) => {
      if (res.confirm) {
        const reason = res.content || ''
        try {
          await closeItemApi(item.id, reason)
          uni.showToast({ title: '已关闭', icon: 'success' })
          loadList()
        } catch (err) {
          uni.showToast({ title: err.message || '操作失败', icon: 'none' })
        }
      }
    }
  })
}

function onReopen(item) {
  uni.showModal({
    title: '确认重开',
    content: '确定要重新开放该物品吗？',
    success: async (res) => {
      if (res.confirm) {
        try {
          await reopenItemApi(item.id)
          uni.showToast({ title: '已重开', icon: 'success' })
          loadList()
        } catch (err) {
          uni.showToast({ title: err.message || '操作失败', icon: 'none' })
        }
      }
    }
  })
}

function onDelete(item) {
  uni.showModal({
    title: '确认删除',
    content: '删除后无法恢复，确定要删除吗？',
    success: async (res) => {
      if (res.confirm) {
        try {
          await deleteItemApi(item.id)
          uni.showToast({ title: '已删除', icon: 'success' })
          loadList()
        } catch (err) {
          uni.showToast({ title: err.message || '操作失败', icon: 'none' })
        }
      }
    }
  })
}

loadList()
</script>

<style scoped>
.publishes-page {
  min-height: 100vh;
  background: $bg-color;
}

.tabs {
  display: flex;
  background: $bg-white;
  padding: 0 $spacing-md;
  border-bottom: 1rpx solid $border-color;
  position: sticky;
  top: 0;
  z-index: 10;
}

.tab {
  flex: 1;
  text-align: center;
  padding: $spacing-md 0;
  font-size: $font-md;
  color: $text-secondary;
  position: relative;
}

.tab.active {
  color: $primary-color;
  font-weight: 600;
}

.tab.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 48rpx;
  height: 4rpx;
  background: $primary-color;
  border-radius: 2rpx;
}

.item-list {
  height: calc(100vh - 100rpx);
}

.list-content {
  padding: $spacing-md;
}

.item-wrapper {
  margin-bottom: $spacing-md;
}

.item-actions {
  display: flex;
  gap: $spacing-sm;
  justify-content: flex-end;
  margin-top: -$spacing-sm;
  padding: 0 $spacing-md $spacing-sm;
}

.action-btn {
  padding: 8rpx 24rpx;
  border-radius: $radius-sm;
  font-size: $font-sm;
}

.action-close {
  background: #fff1f0;
  color: $danger-color;
}

.action-reopen {
  background: #e6f7ff;
  color: #1890ff;
}

.action-delete {
  background: #f5f5f5;
  color: $text-secondary;
}

.loading-more,
.no-more {
  text-align: center;
  padding: $spacing-md 0;
  font-size: $font-sm;
  color: $text-placeholder;
}
</style>
