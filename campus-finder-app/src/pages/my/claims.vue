<template>
  <view class="claims-page">
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

    <!-- Claim List -->
    <scroll-view
      class="claim-list"
      scroll-y
      :refresher-enabled="true"
      :refresher-triggered="refreshing"
      @refresherrefresh="onRefresh"
      @scrolltolower="onLoadMore"
    >
      <view
        v-if="claims.length"
        class="list-content"
      >
        <view
          v-for="item in claims"
          :key="item.id"
          class="claim-card"
          @click="goToDetail(item.lostFoundId)"
        >
          <!-- Card Header -->
          <view class="card-header">
            <view class="item-info">
              <text class="item-title">
                {{ item.lostFoundTitle || '物品' }}
              </text>
              <view :class="['status-badge', `status-${item.status}`]">
                <text>
                  {{ getStatusText(item.status) }}
                </text>
              </view>
            </view>
          </view>

          <!-- Card Body -->
          <view class="card-body">
            <view class="description">
              <text>{{ item.description || '暂无描述' }}</text>
            </view>

            <view class="meta-row">
              <text class="meta-item">
                申请时间：{{ formatTime(item.createTime) }}
              </text>
            </view>

            <!-- Review Result -->
            <view
              v-if="item.status === 'approved'"
              class="result-row success"
            >
              <text>
                审核通过，请等待发布者联系您
              </text>
            </view>
            <view
              v-if="item.status === 'rejected' && item.remark"
              class="result-row error"
            >
              <text>
                拒绝原因：{{ item.remark }}
              </text>
            </view>
          </view>

          <!-- Card Footer / Actions -->
          <view class="card-footer">
            <view
              class="action-btn action-detail"
              @click.stop="goToDetail(item.lostFoundId)"
            >
              <text>查看物品</text>
            </view>
            <view
              v-if="item.status === 'pending'"
              class="action-btn action-cancel"
              @click.stop="onCancel(item.id)"
            >
              <text>取消申请</text>
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
          v-else-if="!hasMore && claims.length"
          class="no-more"
        >
          <text>没有更多了</text>
        </view>
      </view>

      <!-- Empty State -->
      <empty-state
        v-else
        icon="📋"
        message="暂无申请记录"
      />
    </scroll-view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getMyClaimsApi, cancelClaimApi } from '@/api/claim.js'
import EmptyState from '@/components/empty-state.vue'

const tabs = [
  { label: '全部', value: '' },
  { label: '待审核', value: 'pending' },
  { label: '已通过', value: 'approved' },
  { label: '已拒绝', value: 'rejected' },
  { label: '已取消', value: 'cancelled' }
]

const currentTab = ref('')
const claims = ref([])
const currentPage = ref(0)
const totalPages = ref(0)
const hasMore = ref(false)
const loading = ref(false)
const loadingMore = ref(false)
const refreshing = ref(false)

const pageSize = 10

const statusTextMap = {
  pending: '待审核',
  reviewed: '已审核',
  approved: '已通过',
  rejected: '已拒绝',
  cancelled: '已取消'
}

function getStatusText(status) {
  return statusTextMap[status] || status || ''
}

async function loadList() {
  if (loading.value) return
  loading.value = true
  try {
    const res = await getMyClaimsApi({
      pageNum: 1,
      pageSize,
      status: currentTab.value || undefined
    })
    // Handle both array response and paginated response
    if (Array.isArray(res)) {
      claims.value = currentTab.value
        ? res.filter(item => item.status === currentTab.value)
        : res
      hasMore.value = false
    } else {
      claims.value = res.records || []
      currentPage.value = res.current || 1
      totalPages.value = res.pages || 0
      hasMore.value = currentPage.value < totalPages.value
    }
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
    const res = await getMyClaimsApi({
      pageNum: currentPage.value + 1,
      pageSize,
      status: currentTab.value || undefined
    })
    if (Array.isArray(res)) {
      claims.value = [...claims.value, ...res]
      hasMore.value = false
    } else {
      claims.value = [...claims.value, ...(res.records || [])]
      currentPage.value = res.current || currentPage.value + 1
      totalPages.value = res.pages || 0
      hasMore.value = currentPage.value < totalPages.value
    }
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

function goToDetail(lostFoundId) {
  uni.navigateTo({ url: `/pages/lost-found/detail?id=${lostFoundId}` })
}

function onCancel(id) {
  uni.showModal({
    title: '确认取消',
    content: '确定要取消该申请吗？',
    success: async (res) => {
      if (res.confirm) {
        try {
          await cancelClaimApi(id)
          uni.showToast({ title: '已取消', icon: 'success' })
          loadList()
        } catch (err) {
          uni.showToast({ title: err.message || '操作失败', icon: 'none' })
        }
      }
    }
  })
}

function formatTime(time) {
  if (!time) return ''
  const d = new Date(time)
  return `${d.getMonth() + 1}/${d.getDate()} ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`
}

onMounted(() => loadList())
</script>

<style scoped>
.claims-page {
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

.claim-list {
  height: calc(100vh - 100rpx);
}

.list-content {
  padding: $spacing-md;
}

.claim-card {
  background: $bg-white;
  border-radius: $radius-md;
  margin-bottom: $spacing-md;
  overflow: hidden;
}

.card-header {
  padding: $spacing-md $spacing-md $spacing-sm;
  border-bottom: 1rpx solid $border-color;
}

.item-info {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.item-title {
  font-size: $font-lg;
  font-weight: 600;
  color: $text-primary;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  margin-right: $spacing-sm;
}

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

.status-reviewed {
  background: #e6f7ff;
  color: #1890ff;
}

.status-approved {
  background: #f6ffed;
  color: $success-color;
}

.status-rejected {
  background: #fff1f0;
  color: $danger-color;
}

.status-cancelled {
  background: #f5f5f5;
  color: $text-placeholder;
}

.card-body {
  padding: $spacing-md;
}

.description {
  font-size: $font-md;
  color: $text-secondary;
  line-height: 1.6;
  margin-bottom: $spacing-sm;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.meta-row {
  display: flex;
  gap: $spacing-md;
  font-size: $font-sm;
  color: $text-placeholder;
}

.result-row {
  margin-top: $spacing-sm;
  padding: $spacing-sm $spacing-md;
  border-radius: $radius-sm;
  font-size: $font-sm;
}

.result-row.success {
  background: #f6ffed;
  color: $success-color;
}

.result-row.error {
  background: #fff1f0;
  color: $danger-color;
}

.card-footer {
  display: flex;
  justify-content: flex-end;
  gap: $spacing-sm;
  padding: $spacing-sm $spacing-md $spacing-md;
  border-top: 1rpx solid $border-color;
}

.action-btn {
  padding: 8rpx 24rpx;
  border-radius: $radius-sm;
  font-size: $font-sm;
}

.action-detail {
  background: #e6f7ff;
  color: #1890ff;
}

.action-cancel {
  background: #fff1f0;
  color: $danger-color;
}

.loading-more,
.no-more {
  text-align: center;
  padding: $spacing-md 0;
  font-size: $font-sm;
  color: $text-placeholder;
}
</style>