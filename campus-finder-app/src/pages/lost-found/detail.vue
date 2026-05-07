<template>
  <view class="detail-page">
    <!-- 加载状态 -->
    <view
      v-if="loading"
      class="loading-wrapper"
    >
      <text>加载中...</text>
    </view>

    <!-- 错误状态 -->
    <view
      v-else-if="error"
      class="error-wrapper"
    >
      <text>{{ error }}</text>
      <button
        size="mini"
        @click="loadDetail"
      >
        重试
      </button>
    </view>

    <!-- 详情内容 -->
    <scroll-view
      v-else-if="detail.id"
      class="detail-content"
      scroll-y
    >
      <!-- 图片轮播 -->
      <image-carousel
        v-if="detail.images && detail.images.length > 0"
        :images="detail.images"
      />
      <view
        v-else
        class="no-image"
      >
        <text>暂无图片</text>
      </view>

      <!-- 基本信息 -->
      <view class="info-section">
        <view class="title-row">
          <text class="title">
            {{ detail.title }}
          </text>
          <status-badge :status="detail.status" />
        </view>

        <view class="type-tag-row">
          <text :class="['type-tag', detail.itemType]">
            {{ detail.itemType === 'lost' ? '失物' : '招领' }}
          </text>
        </view>
      </view>

      <!-- 物品信息 -->
      <view class="info-card">
        <view class="info-title">
          物品信息
        </view>
        <view class="info-grid">
          <view class="info-item">
            <text class="info-label">
              分类
            </text>
            <text class="info-value">
              {{ detail.categoryName || '未分类' }}
            </text>
          </view>
          <view class="info-item">
            <text class="info-label">
              地点
            </text>
            <text class="info-value">
              {{ detail.location || '未知地点' }}
            </text>
          </view>
          <view class="info-item">
            <text class="info-label">
              时间
            </text>
            <text class="info-value">
              {{ detail.happenedTime ? formatDate(detail.happenedTime) : '未知时间' }}
            </text>
          </view>
          <view
            v-if="detail.campus"
            class="info-item"
          >
            <text class="info-label">
              校区
            </text>
            <text class="info-value">
              {{ detail.campus }}
            </text>
          </view>
        </view>
      </view>

      <!-- 描述 -->
      <view
        v-if="detail.description"
        class="info-card"
      >
        <view class="info-title">
          详细描述
        </view>
        <text class="description">
          {{ detail.description }}
        </text>
      </view>

      <!-- 物品特征 -->
      <view
        v-if="detail.features"
        class="info-card"
      >
        <view class="info-title">
          物品特征
        </view>
        <text class="features">
          {{ detail.features }}
        </text>
      </view>

      <!-- 时间信息 -->
      <view class="info-card">
        <view class="info-grid">
          <view class="info-item">
            <text class="info-label">
              发生时间
            </text>
            <text class="info-value">
              {{ detail.happenedTime ? formatDate(detail.happenedTime) : '-' }}
            </text>
          </view>
          <view class="info-item">
            <text class="info-label">
              发布时间
            </text>
            <text class="info-value">
              {{ detail.createTime ? relativeTime(detail.createTime) : '-' }}
            </text>
          </view>
        </view>
      </view>

      <!-- 发布者信息 -->
      <view class="info-card publisher-card">
        <view class="publisher-info">
          <image
            v-if="detail.publisherAvatar"
            :src="detail.publisherAvatar"
            class="publisher-avatar"
            mode="aspectFill"
          />
          <view
            v-else
            class="publisher-avatar placeholder"
          >
            <text>U</text>
          </view>
          <view class="publisher-detail">
            <text class="publisher-name">
              {{ detail.publisherNickname || '匿名用户' }}
            </text>
            <text class="publisher-label">
              发布者
            </text>
          </view>
        </view>
      </view>

      <!-- 统计数据 -->
      <view class="stats-row">
        <view class="stat-item">
          <text class="stat-value">
            {{ detail.viewCount || 0 }}
          </text>
          <text class="stat-label">
            浏览
          </text>
        </view>
        <view class="stat-item">
          <text class="stat-value">
            {{ detail.favoriteCount || 0 }}
          </text>
          <text class="stat-label">
            收藏
          </text>
        </view>
      </view>

      <!-- 底部占位，防止内容被底部导航遮挡 -->
      <view class="bottom-placeholder" />
    </scroll-view>

    <!-- 空状态 -->
    <view
      v-else
      class="empty-wrapper"
    >
      <text>未找到该物品</text>
    </view>

    <!-- 底部操作栏 -->
    <view
      v-if="detail.id"
      class="bottom-bar"
    >
      <view class="action-left">
        <view
          class="action-item"
          @click="toggleFavorite"
        >
          <text :class="['iconfont', isFavorited ? 'icon-star-filled' : 'icon-star']">
            ☆
          </text>
          <text>{{ isFavorited ? '已收藏' : '收藏' }}</text>
        </view>
      </view>
      <view class="action-right">
        <button
          v-if="showClaimButton"
          class="claim-btn"
          @click="handleClaim"
        >
          认领
        </button>
      </view>
    </view>

    <!-- 认领申请弹窗 -->
    <uni-popup
      ref="claimPopupRef"
      type="bottom"
      background-color="#fff"
    >
      <view class="claim-popup">
        <view class="popup-header">
          <text class="popup-title">
            提交认领申请
          </text>
          <view
            class="popup-close"
            @click="closeClaimPopup"
          >
            <text>x</text>
          </view>
        </view>

        <scroll-view
          class="popup-body"
          scroll-y
        >
          <!-- 认领类型 -->
          <view class="form-section">
            <text class="form-label">
              认领类型
            </text>
            <view class="radio-group">
              <view
                :class="['radio-item', claimForm.claimType === 'claim' ? 'active' : '']"
                @click="claimForm.claimType = 'claim'"
              >
                <text class="radio-icon">
                  ○
                </text>
                <text class="radio-text">
                  认领
                </text>
              </view>
              <view
                :class="['radio-item', claimForm.claimType === 'clue' ? 'active' : '']"
                @click="claimForm.claimType = 'clue'"
              >
                <text class="radio-icon">
                  ○
                </text>
                <text class="radio-text">
                  提供线索
                </text>
              </view>
            </view>
          </view>

          <!-- 描述 -->
          <view class="form-section">
            <text class="form-label">
              描述 <text class="required">
                *
              </text>
            </text>
            <textarea
              v-model="claimForm.description"
              class="form-textarea"
              placeholder="请描述物品特征或您的线索"
              maxlength="500"
            />
          </view>

          <!-- 物品特征 -->
          <view class="form-section">
            <text class="form-label">
              物品特征
            </text>
            <input
              v-model="claimForm.features"
              class="form-input"
              placeholder="请描述物品的具体特征"
              maxlength="200"
            >
          </view>

          <!-- 联系方式 -->
          <view class="form-section">
            <text class="form-label">
              联系方式 <text class="required">
                *
              </text>
            </text>
            <input
              v-model="claimForm.contact"
              class="form-input"
              placeholder="请输入手机号或其他联系方式"
              maxlength="100"
            >
          </view>

          <!-- 凭证图片 -->
          <view class="form-section">
            <text class="form-label">
              凭证图片
            </text>
            <imagePicker
              v-model="claimForm.proofImages"
              :max="3"
            />
          </view>
        </scroll-view>

        <view class="popup-footer">
          <button
            class="submit-btn"
            :disabled="claimSubmitting"
            @click="submitClaim"
          >
            {{ claimSubmitting ? '提交中...' : '提交申请' }}
          </button>
        </view>
      </view>
    </uni-popup>
  </view>
</template>

<script setup>
import { ref, computed, onLoad } from '@dcloudio/uni-app'
import { useAuthStore } from '@/stores/auth'
import { getItemDetailApi, addFavoriteApi, removeFavoriteApi } from '@/api/lost-found'
import { submitClaimApi } from '@/api/claim'
import { formatDate, relativeTime } from '@/utils/date'
import statusBadge from '@/components/status-badge.vue'
import imageCarousel from '@/components/image-carousel.vue'
import imagePicker from '@/components/image-picker.vue'

const authStore = useAuthStore()

const loading = ref(false)
const error = ref(null)
const detail = ref({})
const isFavorited = ref(false)

// Claim popup
const claimPopupRef = ref(null)
const claimForm = ref({
  claimType: 'claim',
  description: '',
  features: '',
  contact: '',
  proofImages: []
})
const claimSubmitting = ref(false)

onLoad((options) => {
  if (options.id) {
    loadDetail(options.id)
  }
})

const loadDetail = async (id) => {
  loading.value = true
  error.value = null
  try {
    const res = await getItemDetailApi(id)
    detail.value = res
    isFavorited.value = res.isFavorited || false
  } catch (err) {
    error.value = err.message || '加载失败'
  } finally {
    loading.value = false
  }
}

const toggleFavorite = async () => {
  if (!authStore.isLoggedIn) {
    uni.showToast({ title: '请先登录', icon: 'none' })
    uni.navigateTo({ url: '/pages/auth/login' })
    return
  }

  try {
    if (isFavorited.value) {
      await removeFavoriteApi(detail.value.id)
      isFavorited.value = false
      detail.value.favoriteCount = Math.max(0, (detail.value.favoriteCount || 1) - 1)
      uni.showToast({ title: '已取消收藏', icon: 'success' })
    } else {
      await addFavoriteApi(detail.value.id)
      isFavorited.value = true
      detail.value.favoriteCount = (detail.value.favoriteCount || 0) + 1
      uni.showToast({ title: '收藏成功', icon: 'success' })
    }
  } catch (err) {
    uni.showToast({ title: err.message || '操作失败', icon: 'none' })
  }
}

const showClaimButton = computed(() => {
  if (!detail.value.id) return false
  if (detail.value.status !== 'pending') return false
  if (detail.value.userId === authStore.user?.userId) return false
  return true
})

const handleClaim = () => {
  if (!authStore.isLoggedIn) {
    uni.showToast({ title: '请先登录', icon: 'none' })
    uni.navigateTo({ url: '/pages/auth/login' })
    return
  }
  showClaimPopup()
}

const showClaimPopup = () => {
  claimForm.value = {
    claimType: 'claim',
    description: '',
    features: '',
    contact: '',
    proofImages: []
  }
  claimPopupRef.value?.open()
}

const closeClaimPopup = () => {
  claimPopupRef.value?.close()
}

const submitClaim = async () => {
  if (!claimForm.value.contact) {
    uni.showToast({ title: '请输入联系方式', icon: 'none' })
    return
  }
  if (!claimForm.value.description) {
    uni.showToast({ title: '请输入描述', icon: 'none' })
    return
  }

  claimSubmitting.value = true
  try {
    await submitClaimApi({
      lostFoundId: detail.value.id,
      claimType: claimForm.value.claimType,
      description: claimForm.value.description,
      features: claimForm.value.features,
      contact: claimForm.value.contact,
      proofImages: claimForm.value.proofImages
    })
    uni.showToast({ title: '提交成功', icon: 'success' })
    closeClaimPopup()
    loadDetail(detail.value.id)
  } catch (err) {
    uni.showToast({ title: err.message || '提交失败', icon: 'none' })
  } finally {
    claimSubmitting.value = false
  }
}
</script>

<style scoped>
.detail-page {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background: #f5f5f5;
}

.loading-wrapper,
.error-wrapper,
.empty-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100rpx;
}

.detail-content {
  flex: 1;
  height: calc(100vh - 110rpx);
}

.no-image {
  width: 100%;
  height: 400rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f0f0f0;
  color: #999;
}

.info-section {
  padding: 24rpx;
  background: #ffffff;
  margin-bottom: 20rpx;
}

.title-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16rpx;
}

.title {
  font-size: 36rpx;
  font-weight: 700;
  color: #333;
  flex: 1;
  margin-right: 16rpx;
}

.type-tag-row {
  margin-top: 12rpx;
}

.type-tag {
  display: inline-block;
  padding: 6rpx 20rpx;
  border-radius: 8rpx;
  font-size: 24rpx;
}

.type-tag.lost {
  background: #fff7e6;
  color: #fa8c16;
}

.type-tag.found {
  background: #e6f7ff;
  color: #1890ff;
}

.info-card {
  padding: 24rpx;
  background: #ffffff;
  margin-bottom: 20rpx;
}

.info-title {
  font-size: 28rpx;
  font-weight: 600;
  color: #333;
  margin-bottom: 20rpx;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 24rpx;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 8rpx;
}

.info-label {
  font-size: 24rpx;
  color: #999;
}

.info-value {
  font-size: 28rpx;
  color: #333;
}

.description,
.features {
  font-size: 28rpx;
  color: #666;
  line-height: 1.6;
}

.features {
  padding: 20rpx;
  background: #f9f9f9;
  border-radius: 8rpx;
}

.publisher-card {
  display: flex;
  align-items: center;
}

.publisher-info {
  display: flex;
  align-items: center;
  gap: 20rpx;
}

.publisher-avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
}

.publisher-avatar.placeholder {
  background: #ddd;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  font-size: 32rpx;
}

.publisher-detail {
  display: flex;
  flex-direction: column;
  gap: 6rpx;
}

.publisher-name {
  font-size: 28rpx;
  font-weight: 500;
  color: #333;
}

.publisher-label {
  font-size: 22rpx;
  color: #999;
}

.stats-row {
  display: flex;
  justify-content: center;
  gap: 80rpx;
  padding: 32rpx 24rpx;
  background: #ffffff;
  margin-bottom: 20rpx;
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8rpx;
}

.stat-value {
  font-size: 32rpx;
  font-weight: 600;
  color: #333;
}

.stat-label {
  font-size: 24rpx;
  color: #999;
}

.bottom-placeholder {
  height: 120rpx;
}

.bottom-bar {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  height: 100rpx;
  background: #ffffff;
  border-top: 1rpx solid #eee;
  display: flex;
  align-items: center;
  padding: 0 24rpx;
  padding-bottom: env(safe-area-inset-bottom);
}

.action-left {
  flex: 1;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4rpx;
  font-size: 20rpx;
  color: #666;
}

.iconfont {
  font-size: 40rpx;
  color: #fa8c16;
}

.icon-star-filled {
  color: #fa8c16;
}

.action-right {
  display: flex;
  align-items: center;
}

.claim-btn {
  padding: 16rpx 60rpx;
  background: #1890ff;
  color: #ffffff;
  font-size: 28rpx;
  border-radius: 40rpx;
  border: none;
}

/* Claim Popup */
.claim-popup {
  display: flex;
  flex-direction: column;
  max-height: 80vh;
  padding-bottom: env(safe-area-inset-bottom);
}

.popup-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24rpx;
  border-bottom: 1rpx solid #eee;
}

.popup-title {
  font-size: 32rpx;
  font-weight: 600;
  color: #333;
}

.popup-close {
  width: 48rpx;
  height: 48rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  font-size: 32rpx;
}

.popup-body {
  flex: 1;
  max-height: 60vh;
  padding: 24rpx;
}

.popup-footer {
  padding: 24rpx;
  border-top: 1rpx solid #eee;
}

.form-section {
  margin-bottom: 32rpx;
}

.form-label {
  font-size: 28rpx;
  color: #333;
  margin-bottom: 12rpx;
  display: block;
}

.required {
  color: #ff4d4f;
}

.radio-group {
  display: flex;
  gap: 32rpx;
}

.radio-item {
  display: flex;
  align-items: center;
  gap: 8rpx;
  padding: 12rpx 24rpx;
  border: 1rpx solid #ddd;
  border-radius: 8rpx;
  background: #fafafa;
}

.radio-item.active {
  border-color: #1890ff;
  background: #e6f7ff;
}

.radio-icon {
  font-size: 28rpx;
  color: #999;
}

.radio-item.active .radio-icon {
  color: #1890ff;
}

.radio-text {
  font-size: 28rpx;
  color: #666;
}

.radio-item.active .radio-text {
  color: #1890ff;
}

.form-input {
  width: 100%;
  padding: 16rpx 20rpx;
  border: 1rpx solid #ddd;
  border-radius: 8rpx;
  font-size: 28rpx;
  background: #fafafa;
  box-sizing: border-box;
}

.form-textarea {
  width: 100%;
  padding: 16rpx 20rpx;
  border: 1rpx solid #ddd;
  border-radius: 8rpx;
  font-size: 28rpx;
  background: #fafafa;
  min-height: 160rpx;
  box-sizing: border-box;
}

.submit-btn {
  width: 100%;
  padding: 24rpx;
  background: #1890ff;
  color: #ffffff;
  font-size: 32rpx;
  border-radius: 44rpx;
  border: none;
}

.submit-btn[disabled] {
  background: #ccc;
}
</style>