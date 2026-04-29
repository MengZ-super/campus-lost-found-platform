<template>
  <div class="my-publish-page">
    <div class="page-header">
      <h2>我的发布</h2>
      <el-button type="primary" @click="goToPublish">
        <el-icon><Plus /></el-icon>
        发布新物品
      </el-button>
    </div>

    <!-- 筛选 -->
    <el-card class="filter-card" shadow="never">
      <el-radio-group v-model="query.status" @change="loadList" size="small">
        <el-radio-button label="">全部</el-radio-button>
        <el-radio-button label="pending">待认领</el-radio-button>
        <el-radio-button label="claimed">已认领</el-radio-button>
        <el-radio-button label="closed">已结束</el-radio-button>
      </el-radio-group>
    </el-card>

    <!-- 列表 -->
    <div v-loading="loading">
      <div v-if="list.length === 0 && !loading" class="empty-state">
        <el-empty description="暂无发布记录">
          <el-button type="primary" @click="goToPublish">立即发布</el-button>
        </el-empty>
      </div>

      <el-card
        v-for="item in list"
        :key="item.id"
        class="item-card"
        shadow="hover"
      >
        <div class="item-main">
          <!-- 图片 -->
          <div class="item-image">
            <el-image
              :src="item.images?.[0] || defaultImage"
              fit="cover"
              style="width: 120px; height: 120px; border-radius: 8px"
            >
              <template #error>
                <div class="image-placeholder">
                  <el-icon><Picture /></el-icon>
                </div>
              </template>
            </el-image>
          </div>
          
          <!-- 信息 -->
          <div class="item-info">
            <div class="title-row">
              <h3>{{ item.title }}</h3>
              <el-tag :type="statusType(item.status)" size="small">{{ item.statusText }}</el-tag>
            </div>
            <p class="desc">{{ item.description }}</p>
            <div class="meta-row">
              <span>{{ item.categoryName }}</span>
              <span>{{ item.location }}</span>
              <span>{{ formatTime(item.createTime) }}</span>
            </div>
            <div class="stats-row">
              <span><el-icon><View /></el-icon> {{ item.viewCount }}浏览</span>
              <span><el-icon><Star /></el-icon> {{ item.favoriteCount }}收藏</span>
              <span><el-icon><ChatDotRound /></el-icon> {{ item.claimCount }}申请</span>
            </div>
          </div>
        </div>

        <!-- 操作按钮 -->
        <div class="actions">
          <el-button link type="primary" size="small" @click="goToDetail(item.id)">
            查看详情
          </el-button>
          <el-button
            v-if="item.status === 'pending'"
            link
            type="warning"
            size="small"
            @click="handleClose(item)"
          >
            关闭
          </el-button>
          <el-button
            v-if="item.status === 'claimed' || item.status === 'closed'"
            link
            type="success"
            size="small"
            @click="handleReopen(item)"
          >
            重新开放
          </el-button>
          <el-popconfirm title="确定删除该记录吗？" @confirm="handleDelete(item.id)">
            <template #reference>
              <el-button link type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Picture, View, Star, ChatDotRound } from '@element-plus/icons-vue'
import { lostFoundApi } from '@/api'

const router = useRouter()
const defaultImage = '/default-item.png'

const loading = ref(false)
const list = ref([])

const query = reactive({
  status: ''
})

// 加载列表
const loadList = async () => {
  loading.value = true
  try {
    const res = await lostFoundApi.getMyList()
    // 前端过滤状态（或后端支持筛选）
    if (query.status) {
      list.value = res.filter(item => item.status === query.status)
    } else {
      list.value = res
    }
  } catch (error) {
    ElMessage.error('加载失败')
  } finally {
    loading.value = false
  }
}

// 关闭记录
const handleClose = async (item) => {
  try {
    const { value } = await ElMessageBox.prompt('请输入关闭原因', '关闭记录', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      inputPlaceholder: '如：物品已归还、已找到等',
      inputValidator: val => !val ? '请输入关闭原因' : true
    })
    await lostFoundApi.close(item.id, value)
    ElMessage.success('已关闭')
    loadList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '操作失败')
    }
  }
}

// 重新开放
const handleReopen = async (item) => {
  try {
    await ElMessageBox.confirm(`确定重新开放「${item.title}」的认领吗？`, '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await lostFoundApi.reopen(item.id)
    ElMessage.success('已重新开放')
    loadList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '操作失败')
    }
  }
}

// 删除
const handleDelete = async (id) => {
  try {
    await lostFoundApi.delete(id)
    ElMessage.success('已删除')
    loadList()
  } catch (error) {
    ElMessage.error(error.message || '删除失败')
  }
}

// 跳转
const goToDetail = (id) => router.push(`/lost-found/${id}`)
const goToPublish = () => router.push('/lost-found/publish')

// 状态类型
const statusType = (status) => ({
  pending: '',
  claimed: 'success',
  closed: 'info',
  expired: 'warning'
}[status] || '')

// 格式化时间
const formatTime = (time) => {
  if (!time) return ''
  const d = new Date(time)
  return `${d.getMonth() + 1}/${d.getDate()} ${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`
}

onMounted(() => loadList())
</script>

<style scoped>
.my-publish-page {
  padding-bottom: 24px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0;
  font-size: 20px;
  font-weight: 600;
}

.filter-card {
  margin-bottom: 20px;
}

.empty-state {
  padding: 80px 0;
}

.item-card {
  margin-bottom: 16px;
}

.item-main {
  display: flex;
  gap: 16px;
}

.image-placeholder {
  width: 120px;
  height: 120px;
  background: #f5f7fa;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  color: #c0c4cc;
  font-size: 32px;
}

.item-info {
  flex: 1;
}

.title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.title-row h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  max-width: 400px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.desc {
  margin: 0 0 10px;
  font-size: 13px;
  color: #909399;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.meta-row {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: #909399;
  margin-bottom: 8px;
}

.stats-row {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: #b0b4bc;
}

.stats-row span {
  display: flex;
  align-items: center;
  gap: 4px;
}

.actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  padding-top: 12px;
  border-top: 1px solid #ebeef5;
}
</style>
