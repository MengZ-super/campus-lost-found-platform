<template>
  <div class="layout">
    <!-- 侧边导航 -->
    <aside class="sidebar">
      <div class="sidebar-brand" @click="router.push('/home')">
        <img :src="logoImg" alt="Logo" class="sidebar-logo" />
        <span class="sidebar-title">失物招领</span>
      </div>

      <nav class="sidebar-nav">
        <router-link to="/home" class="sidebar-link" active-class="active">
          <el-icon><HomeFilled /></el-icon>
          <span>首页</span>
        </router-link>
        <router-link to="/lost-found" class="sidebar-link" :class="{ active: route.path === '/lost-found' && route.query.type !== 'lost' }">
          <el-icon><Search /></el-icon>
          <span>失物招领</span>
        </router-link>
        <router-link to="/lost-found?type=lost" class="sidebar-link" :class="{ active: route.path === '/lost-found' && route.query.type === 'lost' }">
          <el-icon><Location /></el-icon>
          <span>寻物启事</span>
        </router-link>
        <router-link to="/lost-found/my-publish" class="sidebar-link" active-class="active">
          <el-icon><Document /></el-icon>
          <span>我的发布</span>
        </router-link>
        <router-link v-if="authStore.isAdmin" to="/admin/dashboard" class="sidebar-link admin-link" active-class="active">
          <el-icon><Setting /></el-icon>
          <span>管理后台</span>
        </router-link>
      </nav>

      <div class="sidebar-footer">
        <el-dropdown @command="handleCommand" trigger="click" placement="right-start">
          <div class="sidebar-user">
            <el-avatar :size="32" :src="authStore.avatar || defaultAvatar">
              {{ authStore.nickname?.charAt(0)?.toUpperCase() || 'U' }}
            </el-avatar>
            <span class="sidebar-username">{{ authStore.nickname }}</span>
          </div>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item command="profile" :icon="User">个人资料</el-dropdown-item>
              <el-dropdown-item command="my-publish" :icon="Document">我的发布</el-dropdown-item>
              <el-dropdown-item command="my-claims" :icon="ChatDotRound">我的申请</el-dropdown-item>
              <el-dropdown-item v-if="authStore.isAdmin" command="admin" :icon="Setting" divided>管理后台</el-dropdown-item>
              <el-dropdown-item command="logout" :icon="SwitchButton" divided>退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </aside>

    <!-- 内容区 -->
    <main class="content">
      <router-view v-slot="{ Component }">
        <transition name="fade" mode="out-in">
          <component :is="Component" />
        </transition>
      </router-view>
    </main>
  </div>
</template>

<script setup>
import { useRouter, useRoute } from 'vue-router'
import { ElMessageBox, ElMessage } from 'element-plus'
import { useAuthStore } from '@/stores/auth'
import { User, SwitchButton, Document, ChatDotRound, HomeFilled, Search, Location, Setting } from '@element-plus/icons-vue'
import logoImg from '@/assets/images/logo.png'
import defaultAvatar from '@/assets/images/avatar-default.png'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

async function handleCommand(command) {
  if (command === 'profile') {
    router.push('/profile')
  } else if (command === 'my-publish') {
    router.push('/lost-found/my-publish')
  } else if (command === 'my-claims') {
    router.push('/lost-found/my-claims')
  } else if (command === 'admin') {
    router.push('/admin/dashboard')
  } else if (command === 'logout') {
    await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await authStore.logout()
    ElMessage.success('已退出登录')
    router.push('/login')
  }
}
</script>

<style scoped>
.layout {
  display: flex;
  min-height: 100vh;
  background: #f5f6f8;
}

.sidebar {
  width: 220px;
  background: #fff;
  border-right: 1px solid #ebeef5;
  display: flex;
  flex-direction: column;
  position: sticky;
  top: 0;
  height: 100vh;
  z-index: 10;
}

.sidebar-brand {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 20px 20px 28px;
  cursor: pointer;
}

.sidebar-logo {
  height: 28px;
  width: auto;
}

.sidebar-title {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  letter-spacing: 0.5px;
}

.sidebar-nav {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 0 12px;
}

.sidebar-link {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 14px;
  border-radius: 6px;
  font-size: 14px;
  color: #606266;
  text-decoration: none;
  transition: all 0.15s;
}

.sidebar-link:hover {
  background: #f5f7fa;
  color: #303133;
}

.sidebar-link.active {
  background: #ecf5ff;
  color: #409eff;
}

.sidebar-link .el-icon {
  font-size: 18px;
}

.sidebar-footer {
  padding: 16px 12px;
  border-top: 1px solid #ebeef5;
}

.sidebar-user {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 10px;
  border-radius: 6px;
  cursor: pointer;
  transition: background 0.15s;
}

.sidebar-user:hover {
  background: #f5f7fa;
}

.sidebar-username {
  font-size: 13px;
  color: #606266;
  max-width: 110px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.content {
  flex: 1;
  padding: 24px 32px;
  max-width: 1100px;
  width: 100%;
  box-sizing: border-box;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.15s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
