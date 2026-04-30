<template>
  <div class="dashboard">
    <h2>仪表盘</h2>

    <el-row :gutter="20" class="stat-row">
      <el-col :span="6">
        <el-card shadow="hover">
          <div class="stat-card">
            <div class="stat-label">用户总数</div>
            <div class="stat-value">{{ dash.totalUsers }}</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <div class="stat-card">
            <div class="stat-label">物品总数</div>
            <div class="stat-value">{{ dash.totalItems }}</div>
            <div class="stat-sub">待认领 {{ dash.pendingItems }} / 已认领 {{ dash.claimedItems }} / 已关闭 {{ dash.closedItems }}</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <div class="stat-card">
            <div class="stat-label">认领申请总数</div>
            <div class="stat-value">{{ dash.totalClaims }}</div>
            <div class="stat-sub">待审核 {{ dash.pendingClaims }} / 已通过 {{ dash.approvedClaims }} / 已拒绝 {{ dash.rejectedClaims }}</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover">
          <div class="stat-card">
            <div class="stat-label">待处理</div>
            <div class="stat-value warn">{{ dash.pendingItems + dash.pendingClaims }}</div>
            <div class="stat-sub">物品 + 认领</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-card class="recent-card">
      <template #header><span>最新物品</span></template>
      <el-table :data="dash.recentItems" stripe v-loading="loading">
        <el-table-column prop="id" label="ID" width="60" />
        <el-table-column prop="title" label="标题" min-width="200" show-overflow-tooltip />
        <el-table-column prop="itemType" label="类型" width="80">
          <template #default="{ row }">
            <el-tag :type="row.itemType === 'lost' ? 'danger' : 'success'" size="small">
              {{ row.itemType === 'lost' ? '丢失' : '捡到' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="statusType(row.status)" size="small">{{ statusText(row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="publisherName" label="发布者" width="120" />
        <el-table-column prop="createTime" label="时间" width="170" />
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { adminApi } from '@/api'

const dash = ref({
  totalUsers: 0,
  totalItems: 0, pendingItems: 0, claimedItems: 0, closedItems: 0,
  totalClaims: 0, pendingClaims: 0, approvedClaims: 0, rejectedClaims: 0,
  recentItems: []
})
const loading = ref(false)

onMounted(async () => {
  loading.value = true
  try {
    dash.value = await adminApi.getDashboard()
  } finally {
    loading.value = false
  }
})

function statusType(status) {
  return { pending: 'warning', claimed: 'success', closed: 'info', expired: 'info' }[status] || 'info'
}
function statusText(status) {
  return { pending: '待认领', claimed: '已认领', closed: '已关闭', expired: '已过期' }[status] || status
}
</script>

<style scoped>
.dashboard h2 { margin: 0 0 20px; font-size: 20px; color: #303133; }
.stat-row { margin-bottom: 24px; }
.stat-card { text-align: center; padding: 8px 0; }
.stat-label { font-size: 14px; color: #909399; margin-bottom: 8px; }
.stat-value { font-size: 32px; font-weight: 700; color: #303133; }
.stat-value.warn { color: #e6a23c; }
.stat-sub { font-size: 12px; color: #c0c4cc; margin-top: 6px; }
.recent-card { margin-top: 0; }
</style>
