<template>
  <div class="home-page">
    <!-- 欢迎横幅（使用 hero-bg 背景） -->
    <div class="hero-banner" :style="{ backgroundImage: `url(${heroBg})` }">
      <div class="hero-overlay">
        <div class="welcome-text">
          <h2>你好，{{ authStore.nickname }} 👋</h2>
          <p>欢迎使用校园失物招领平台，让失物回到主人手中</p>
        </div>
        <div class="welcome-visual">
          <div class="visual-icon-group">
            <div class="floating-card card-1">
              <span class="card-emoji">🔍</span>
              <span class="card-text">快速查找</span>
            </div>
            <div class="floating-card card-2">
              <span class="card-emoji">📢</span>
              <span class="card-text">发布信息</span>
            </div>
            <div class="floating-card card-3">
              <span class="card-emoji">✅</span>
              <span class="card-text">失物归还</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 功能入口 -->
    <el-row :gutter="20" class="feature-row">
      <el-col :xs="12" :sm="6" v-for="item in features" :key="item.title">
        <div class="feature-card" @click="item.action?.()">
          <div class="feature-icon-wrapper" :style="{ background: item.bgColor }">
            <el-icon :size="28" color="#fff">
              <component :is="item.icon" />
            </el-icon>
          </div>
          <span class="feature-title">{{ item.title }}</span>
          <span class="feature-desc">{{ item.desc }}</span>
        </div>
      </el-col>
    </el-row>

    <!-- 快捷横幅区域 -->
    <el-row :gutter="20" class="banner-row">
      <el-col :xs="24" :sm="12">
        <div class="info-banner banner-lost" :style="{ backgroundImage: `url(${bannerLost})` }">
          <div class="info-banner-overlay">
            <h3>🔍 丢失了物品？</h3>
            <p>发布寻物启事，让全校帮你找</p>
            <el-button type="warning" size="small" round @click="router.push({ path: '/lost-found/publish', query: { type: 'lost' } })">去发布</el-button>
          </div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="12">
        <div class="info-banner banner-found" :style="{ backgroundImage: `url(${bannerFound})` }">
          <div class="info-banner-overlay">
            <h3>✅ 捡到了东西？</h3>
            <p>发布失物招领，帮它找到主人</p>
            <el-button type="success" size="small" round @click="router.push({ path: '/lost-found/publish', query: { type: 'found' } })">去发布</el-button>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { Search, DocumentAdd, Document, User } from '@element-plus/icons-vue'
import heroBg from '@/assets/images/hero-bg.png'
import bannerLost from '@/assets/images/banner-lost.png'
import bannerFound from '@/assets/images/banner-found.png'

const router = useRouter()
const authStore = useAuthStore()

const features = [
  {
    icon: DocumentAdd,
    title: '发布失物',
    desc: '上传你捡到的物品',
    bgColor: 'linear-gradient(135deg, #3b82f6, #2563eb)',
    action: () => router.push('/lost-found/publish')
  },
  {
    icon: Search,
    title: '寻找失物',
    desc: '查找丢失的物品',
    bgColor: 'linear-gradient(135deg, #10b981, #059669)',
    action: () => router.push({ path: '/lost-found', query: { type: 'lost' } })
  },
  {
    icon: Document,
    title: '我的发布',
    desc: '管理你的帖子',
    bgColor: 'linear-gradient(135deg, #f59e0b, #d97706)',
    action: () => router.push('/lost-found/my-publish')
  },
  {
    icon: User,
    title: '个人中心',
    desc: '查看和编辑资料',
    bgColor: 'linear-gradient(135deg, #ef4444, #dc2626)',
    action: () => router.push('/profile')
  }
]
</script>

<style scoped>
.home-page {
  padding-bottom: 24px;
}

/* Hero 横幅 */
.hero-banner {
  background-size: cover;
  background-position: center;
  border-radius: 16px;
  margin-bottom: 20px;
  overflow: hidden;
  min-height: 200px;
  display: flex;
  align-items: center;
  position: relative;
}

.hero-overlay {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 32px 36px;
  background: linear-gradient(90deg, rgba(15, 27, 61, 0.85) 0%, rgba(30, 58, 138, 0.6) 50%, transparent 100%);
}

.welcome-text {
  color: #fff;
}

.welcome-text h2 {
  font-size: 24px;
  font-weight: 700;
  margin: 0 0 8px;
}

.welcome-text p {
  font-size: 14px;
  opacity: 0.85;
  margin: 0;
}

/* 右侧装饰区域 */
.welcome-visual {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.visual-icon-group {
  position: relative;
  width: 180px;
  height: 120px;
}

.floating-card {
  position: absolute;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  padding: 10px 16px;
  display: flex;
  align-items: center;
  gap: 8px;
  color: #fff;
  font-size: 13px;
  font-weight: 500;
  animation: float 3s ease-in-out infinite;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.card-emoji {
  font-size: 18px;
}

.card-text {
  white-space: nowrap;
}

.card-1 {
  top: 0;
  left: 10px;
  animation-delay: 0s;
}

.card-2 {
  top: 40px;
  right: 0;
  animation-delay: 1s;
}

.card-3 {
  bottom: 0;
  left: 30px;
  animation-delay: 2s;
}

@keyframes float {

  0%,
  100% {
    transform: translateY(0px);
  }

  50% {
    transform: translateY(-8px);
  }
}

/* 功能入口 */
.feature-row {
  margin-bottom: 20px;
}

.feature-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
  margin-bottom: 12px;
}

.feature-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.feature-icon-wrapper {
  width: 56px;
  height: 56px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 4px;
}

.feature-title {
  font-size: 15px;
  font-weight: 600;
  color: #303133;
}

.feature-desc {
  font-size: 12px;
  color: #909399;
}

/* 横幅区域 */
.banner-row {
  margin-top: 8px;
}

.info-banner {
  background-size: cover;
  background-position: center;
  border-radius: 12px;
  overflow: hidden;
  min-height: 140px;
  display: flex;
  align-items: center;
  margin-bottom: 12px;
}

.info-banner-overlay {
  width: 100%;
  padding: 20px 24px;
  background: linear-gradient(90deg, rgba(0,0,0,0.5) 0%, rgba(0,0,0,0.1) 80%, transparent 100%);
}

.info-banner h3 {
  color: #fff;
  font-size: 17px;
  font-weight: 600;
  margin: 0 0 6px;
}

.info-banner p {
  color: rgba(255, 255, 255, 0.85);
  font-size: 13px;
  margin: 0 0 10px;
}
</style>
