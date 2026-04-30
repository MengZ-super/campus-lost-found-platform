<template>
  <div class="admin-layout">
    <aside class="admin-sidebar">
      <div class="admin-brand" @click="router.push('/admin/dashboard')">
        <span class="brand-title">管理后台</span>
      </div>
      <nav class="admin-nav">
        <router-link to="/admin/dashboard" class="nav-link" active-class="active">
          <el-icon><DataAnalysis /></el-icon><span>仪表盘</span>
        </router-link>
        <router-link to="/admin/users" class="nav-link" active-class="active">
          <el-icon><User /></el-icon><span>用户管理</span>
        </router-link>
        <router-link to="/admin/items" class="nav-link" active-class="active">
          <el-icon><Goods /></el-icon><span>物品管理</span>
        </router-link>
        <router-link to="/admin/claims" class="nav-link" active-class="active">
          <el-icon><ChatDotSquare /></el-icon><span>认领管理</span>
        </router-link>
        <router-link to="/admin/categories" class="nav-link" active-class="active">
          <el-icon><Collection /></el-icon><span>分类管理</span>
        </router-link>
      </nav>
      <div class="admin-footer">
        <router-link to="/home" class="nav-link">
          <el-icon><Back /></el-icon><span>返回前台</span>
        </router-link>
      </div>
    </aside>
    <main class="admin-content">
      <router-view />
    </main>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { DataAnalysis, User, Goods, ChatDotSquare, Collection, Back } from '@element-plus/icons-vue'

const router = useRouter()
</script>

<style scoped>
.admin-layout {
  display: flex;
  min-height: 100vh;
  background: #f0f2f5;
}

.admin-sidebar {
  width: 220px;
  background: #001529;
  display: flex;
  flex-direction: column;
  position: sticky;
  top: 0;
  height: 100vh;
  z-index: 10;
}

.admin-brand {
  padding: 22px 20px;
  text-align: center;
  cursor: pointer;
}

.brand-title {
  color: #fff;
  font-size: 18px;
  font-weight: 600;
  letter-spacing: 1px;
}

.admin-nav {
  flex: 1;
  padding: 0 12px;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 14px;
  border-radius: 6px;
  color: rgba(255, 255, 255, 0.65);
  text-decoration: none;
  font-size: 14px;
  transition: all 0.15s;
}

.nav-link:hover {
  color: #fff;
  background: rgba(255, 255, 255, 0.08);
}

.nav-link.active {
  color: #fff;
  background: #1890ff;
}

.admin-footer {
  padding: 16px 12px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.admin-content {
  flex: 1;
  padding: 24px;
  overflow-x: auto;
  max-width: 1200px;
  width: 100%;
  box-sizing: border-box;
}
</style>
