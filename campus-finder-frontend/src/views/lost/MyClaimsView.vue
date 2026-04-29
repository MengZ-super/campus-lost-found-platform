<template>
  <div class="my-claims-page">
    <div class="page-header">
      <h2>我的申请</h2>
    </div>

    <!-- 筛选 -->
    <el-card class="filter-card" shadow="never">
      <el-radio-group v-model="query.status" @change="loadList" size="small">
        <el-radio-button label="">全部</el-radio-button>
        <el-radio-button label="pending">待审核</el-radio-button>
        <el-radio-button label="approved">已通过</el-radio-button>
        <el-radio-button label="rejected">已拒绝</el-radio-button>
        <el-radio-button label="cancelled">已取消</el-radio-button>
      </el-radio-group>
    </el-card>

    <!-- 列表 -->
    <div v-loading="loading">
      <div v-if="list.length === 0 && !loading" class="empty-state">
        <el-empty description="暂无申请记录" />
      </div>

      <!-- 申请卡片 -->
      <el-card
        v-for="item in list"
        :key="item.id"
        class="claim-card"
        shadow="hover"
      >
        <!-- 物品信息（可点击跳转） -->
        <div class="claim-main">
          <div class="claim-image">
            <el-image
              :src="(item.lostFoundImages && item.lostFoundImages[0]) || defaultImage"
              fit="cover"
              style="width: 100px; height: 100px; border-radius: 8px"
            >
              <template #error>
                <div style="width:100px;height:100px;background:#f5f7fa;display:flex;align-items:center;justify-content:center;border-radius:8px;color:#c0c4cc;font-size:28px">
                  <el-icon><Picture /></el-icon>
                </div>
              </template>
            </el-image>
          </div>

          <div class="claim-info">
            <div class="title-row">
              <span class="lost-found-title" @click="goToDetail(item.lostFoundId)">
                {{ item.lostFoundTitle || '物品' }}
              </span>
              <el-tag
                :type="statusType(item.status)"
                size="small"
                effect="light"
              >
                {{ item.statusText }}
              </el-tag>
            </div>
            
            <p class="desc">{{ item.description }}</p>

            <div class="meta-row">
              <span>地点：{{ item.lostFoundLocation }}</span>
              <span>申请时间：{{ formatTime(item.createTime) }}</span>
            </div>

            <!-- 审核结果 -->
            <div v-if="item.status === 'approved'" class="result-row success">
              <el-icon><CircleCheck /></el-icon> 审核通过，请等待发布者联系您
            </div>
            <div v-if="item.status === 'rejected' && item.remark" class="result-row error">
              <el-icon><CircleClose /></el-icon> 拒绝原因：{{ item.remark }}
            </div>
          </div>
        </div>

        <!-- 操作按钮 -->
        <div class="actions">
          <el-button link type="primary" size="small" @click="goToDetail(item.lostFoundId)">
            查看物品
          </el-button>
          <el-button
            v-if="item.status === 'pending'"
            link
            type="warning"
            size="small"
            @click="handleCancel(item.id)"
          >
            取消申请
          </el-button>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Picture, CircleCheck, CircleClose } from '@element-plus/icons-vue'
import { claimApi } from '@/api'

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
    const res = await claimApi.getMyList()
    // 前端过滤状态
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

// 取消申请
const handleCancel = async (id) => {
  try {
    await ElMessageBox.confirm('确定取消该申请吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await claimApi.cancel(id)
    ElMessage.success('已取消')
    loadList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '操作失败')
    }
  }
}

// 跳转到详情
const goToDetail = (id) => router.push(`/lost-found/${id}`)

// 状态类型映射
const statusType = (status) => ({
  pending: '',
  approved: 'success',
  rejected: 'danger',
  cancelled: 'info'
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
.my-claims-page {
  padding-bottom: 24px;
}

.page-header {
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

.claim-card {
  margin-bottom: 16px;
}

.claim-main {
  display: flex;
  gap: 16px;
}

.claim-info {
  flex: 1;
}

.title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.lost-found-title {
  font-size: 16px;
  font-weight: 600;
  color: #409eff;
  cursor: pointer;

  &:hover {
    text-decoration: underline;
  }

  /* 截断过长文本 */
  max-width: 350px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  display: inline-block;
  vertical-align: bottom;
}

.desc {
  margin: 0 0 12px;
  font-size: 14px;
  color: #606266;
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.meta-row {
  display: flex;
  gap: 16px;
  font-size: 13px;
  color: #909399;
  margin-bottom: 10px;
}

.result-row {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 12px;
  border-radius: 6px;
  font-size: 13px;
}

.result-row.success {
  background: #f0f9eb;
  color: #67c23a;
}

.result-row.error {
  background: #fef0f0;
  color: #f56c6c;
}

.actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  padding-top: 12px;
  border-top: 1px solid #ebeef5;
}
</style>
