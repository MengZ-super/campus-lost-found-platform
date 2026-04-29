<template>
  <div class="detail-page">
    <div class="page-header">
      <el-button link @click="goBack">
        <el-icon><ArrowLeft /></el-icon>
        返回列表
      </el-button>
      <div style="flex: 1"></div>
      <!-- 操作按钮（仅发布者可见） -->
      <template v-if="isOwner">
        <el-button v-if="detail.status === 'pending'" type="warning" size="small" @click="showCloseDialog">
          关闭记录
        </el-button>
        <el-button v-if="detail.status === 'claimed'" type="success" size="small" @click="handleReopen">
          重新开放
        </el-button>
        <el-button type="primary" size="small" @click="goToEdit">编辑</el-button>
      </template>
    </div>

    <div v-loading="loading" class="content-wrapper">
      <template v-if="detail.id">
        <!-- 图片展示 -->
        <div class="image-gallery" v-if="detail.images && detail.images.length > 0">
          <el-carousel :interval="5000" arrow="always" height="400px">
            <el-carousel-item v-for="(img, index) in detail.images" :key="index">
              <el-image :src="img" fit="contain" style="height: 100%" />
            </el-carousel-item>
          </el-carousel>
        </div>

        <!-- 基本信息 -->
        <el-card class="info-card">
          <div class="title-row">
            <h1>{{ detail.title }}</h1>
            <el-tag :type="statusTagType" effect="dark">{{ detail.statusText }}</el-tag>
          </div>

          <div class="meta-info">
            <span class="meta-item">
              <el-icon><User /></el-icon>
              {{ detail.publisherNickname }}
            </span>
            <span class="meta-item">
              <el-icon><Clock /></el-icon>
              {{ formatTime(detail.createTime) }} 发布
            </span>
            <span class="meta-item">
              <el-icon><View /></el-icon>
              {{ detail.viewCount || 0 }} 次浏览
            </span>
          </div>

          <el-divider />

          <div class="info-section">
            <h4>物品信息</h4>
            <div class="info-grid">
              <div class="info-cell">
                <label>分类</label>
                <span>{{ detail.categoryName }}</span>
              </div>
              <div class="info-cell">
                <label>类型</label>
                <span>{{ detail.itemType === 'lost' ? '丢失物品' : '捡到物品' }}</span>
              </div>
              <div class="info-cell">
                <label>地点</label>
                <span>{{ detail.location }}</span>
              </div>
              <div class="info-cell">
                <label>时间</label>
                <span>{{ formatDateTime(detail.happenedTime) }}</span>
              </div>
              <div class="info-cell" v-if="detail.campus">
                <label>校区</label>
                <span>{{ detail.campus }}</span>
              </div>
            </div>
          </div>

          <el-divider />

          <div class="info-section">
            <h4>详细描述</h4>
            <p class="description">{{ detail.description }}</p>
          </div>

          <div class="info-section" v-if="detail.features">
            <h4>物品特征</h4>
            <p class="features-text">{{ detail.features }}</p>
          </div>
        </el-card>

        <!-- 认领信息 -->
        <el-card v-if="detail.status === 'claimed'" class="claim-info-card">
          <template #header>
            <span>认领信息</span>
          </template>
          <div class="claim-info">
            <div class="claim-item">
              <label>认领者</label>
              <span>{{ detail.claimedByNickname || '已认领' }}</span>
            </div>
            <div class="claim-item" v-if="detail.claimedTime">
              <label>认领时间</label>
              <span>{{ formatDateTime(detail.claimedTime) }}</span>
            </div>
          </div>
        </el-card>

        <!-- 操作按钮区 -->
        <el-card class="action-card">
          <div class="actions">
            <el-button
              :type="isFavorited ? 'warning' : 'default'"
              @click="handleFavorite"
            >
              <el-icon><Star /></el-icon>
              {{ isFavorited ? '已收藏' : '收藏' }} ({{ detail.favoriteCount }})
            </el-button>
            <el-button
              v-if="detail.status === 'pending'"
              type="primary"
              @click="showClaimDialog"
            >
              <el-icon><ChatDotRound /></el-icon>
              申请认领
            </el-button>
          </div>
        </el-card>

        <!-- 申请记录 -->
        <el-card v-if="claims.length > 0" class="claims-card">
          <template #header>
            <span>认领申请 ({{ claims.length }})</span>
          </template>
          <div
            v-for="claim in claims"
            :key="claim.id"
            class="claim-item"
          >
            <div class="claim-header">
              <div class="applicant">
                <el-avatar :size="32" :src="claim.applicantAvatar" />
                <span class="name">{{ claim.applicantNickname }}</span>
              </div>
              <el-tag
                :type="claimStatusType(claim.status)"
                size="small"
              >
                {{ claim.statusText }}
              </el-tag>
            </div>
            <p class="claim-desc">{{ claim.description }}</p>
            <div class="claim-actions" v-if="isOwner && claim.status === 'pending'">
              <el-button type="success" size="small" @click="handleApprove(claim.id)">
                通过
              </el-button>
              <el-button type="danger" size="small" @click="handleReject(claim.id)">
                拒绝
              </el-button>
            </div>
          </div>
        </el-card>
      </template>
    </div>

    <!-- 认领申请弹窗 -->
    <el-dialog v-model="claimDialogVisible" title="申请认领" width="500px">
      <el-form ref="claimFormRef" :model="claimForm" :rules="claimRules" label-position="top">
        <el-form-item label="认领说明" prop="description">
          <el-input
            v-model="claimForm.description"
            type="textarea"
            :rows="3"
            placeholder="请说明为什么认为这是您的物品"
            maxlength="1000"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="物品特征" prop="features">
          <el-input
            v-model="claimForm.features"
            placeholder="描述您对物品的了解，用于验证身份"
            maxlength="500"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="联系方式" prop="contact">
          <el-input v-model="claimForm.contact" placeholder="手机号或微信号" maxlength="100" />
        </el-form-item>
        <el-form-item label="证明材料（可选）">
          <el-upload
            action="/api/upload"
            list-type="picture-card"
            :limit="5"
            :on-success="handleClaimUploadSuccess"
            :headers="uploadHeaders"
            accept=".jpg,.jpeg,.png"
          >
            <el-icon><Plus /></el-icon>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="claimDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitClaim" :loading="claimLoading">提交申请</el-button>
      </template>
    </el-dialog>

    <!-- 关闭确认弹窗 -->
    <el-dialog v-model="closeDialogVisible" title="关闭记录" width="400px">
      <el-form label-position="top">
        <el-form-item label="关闭原因" required>
          <el-input v-model="closeReason" type="textarea" placeholder="请输入关闭原因" maxlength="500" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="closeDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleClose" :loading="closeLoading">确认关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ArrowLeft, User, Clock, View, Star, ChatDotRound, Plus } from '@element-plus/icons-vue'
import { lostFoundApi, claimApi } from '@/api'
import { useUserStore } from '@/stores/user'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()

// 数据
const loading = ref(false)
const detail = ref({})
const claims = ref([])
const isFavorited = ref(false)

// 弹窗状态
const claimDialogVisible = ref(false)
const closeDialogVisible = ref(false)
const closeReason = ref('')
const closeLoading = ref(false)
const claimLoading = ref(false)
const uploadHeaders = { Authorization: `Bearer ${localStorage.getItem('accessToken')}` }

// 表单引用
const formRef = ref()
const claimFormRef = ref()

// 是否是发布者
const isOwner = computed(() => {
  return detail.value.userId === userStore.userInfo?.id
})

// 状态标签类型
const statusTagType = computed(() => {
  const map = {
    pending: '',
    claimed: 'success',
    closed: 'info',
    expired: 'warning'
  }
  return map[detail.value.status] || ''
})

// 认领表单
const claimForm = reactive({
  lostFoundId: null,
  claimType: '',
  description: '',
  features: '',
  contact: '',
  proofImages: []
})

const claimRules = {
  description: [{ required: true, message: '请输入说明', trigger: 'blur' }],
  contact: [{ required: true, message: '请输入联系方式', trigger: 'blur' }]
}

// 加载详情
const loadDetail = async () => {
  const id = route.params.id
  if (!id) return

  loading.value = true
  try {
    const res = await lostFoundApi.getDetail(id)
    detail.value = res
    isFavorited.value = res.favorited || false

    // 设置认领表单的物品ID和类型
    claimForm.lostFoundId = id
    claimForm.claimType = res.itemType

    // 加载申请列表
    loadClaims(id)

    // 增加浏览次数
    await lostFoundApi.incrementViewCount?.(id) || null
  } catch (error) {
    ElMessage.error('加载详情失败')
  } finally {
    loading.value = false
  }
}

// 加载申请列表
const loadClaims = async (id) => {
  try {
    claims.value = await claimApi.getByLostFound(id)
  } catch (error) {
    console.error('加载申请失败:', error)
  }
}

// 收藏/取消收藏
const handleFavorite = async () => {
  try {
    if (isFavorited.value) {
      await lostFoundApi.unfavorite(detail.value.id)
      ElMessage.success('取消收藏')
      isFavorited.value = false
      detail.value.favoriteCount--
    } else {
      await lostFoundApi.favorite(detail.value.id)
      ElMessage.success('收藏成功')
      isFavorited.value = true
      detail.value.favoriteCount++
    }
  } catch (error) {
    ElMessage.error(error.message || '操作失败')
  }
}

// 显示认领弹窗
const showClaimDialog = () => {
  // 检查是否登录
  if (!userStore.isLoggedIn) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }
  // 不能认领自己的物品
  if (isOwner.value) {
    ElMessage.warning('不能认领自己发布的物品')
    return
  }
  claimDialogVisible.value = true
}

// 提交认领申请
const submitClaim = async () => {
  const valid = await claimFormRef.value.validate().catch(() => false)
  if (!valid) return

  claimLoading.value = true
  try {
    await claimApi.apply(claimForm)
    ElMessage.success('申请提交成功')
    claimDialogVisible.value = false
    // 重置表单
    Object.assign(claimForm, { description: '', features: '', contact: '', proofImages: [] })
    loadClaims(detail.value.id)
  } catch (error) {
    ElMessage.error(error.message || '提交失败')
  } finally {
    claimLoading.value = false
  }
}

// 审核通过
const handleApprove = async (id) => {
  try {
    await ElMessageBox.confirm('确定通过该认领申请？', '审核确认', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await claimApi.review(id, { action: 'approve' })
    ElMessage.success('已通过')
    loadDetail()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '操作失败')
    }
  }
}

// 审核拒绝
const handleReject = async (id) => {
  try {
    const { value } = await ElMessageBox.prompt('请输入拒绝原因', '拒绝申请', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      inputPlaceholder: '可选填'
    })
    await claimApi.review(id, { action: 'reject', remark: value })
    ElMessage.success('已拒绝')
    loadClaims(detail.value.id)
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '操作失败')
    }
  }
}

// 显示关闭弹窗
const showCloseDialog = () => {
  closeReason.value = ''
  closeDialogVisible.value = true
}

// 关闭记录
const handleClose = async () => {
  if (!closeReason.value.trim()) {
    ElMessage.warning('请输入关闭原因')
    return
  }

  closeLoading.value = true
  try {
    await lostFoundApi.close(detail.value.id, closeReason.value)
    ElMessage.success('已关闭')
    closeDialogVisible.value = false
    loadDetail()
  } catch (error) {
    ElMessage.error(error.message || '关闭失败')
  } finally {
    closeLoading.value = false
  }
}

// 重新开启
const handleReopen = async () => {
  try {
    await ElMessageBox.confirm('确定重新开放该物品的认领吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await lostFoundApi.reopen(detail.value.id)
    ElMessage.success('已重新开放')
    loadDetail()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '操作失败')
    }
  }
}

// 编辑
const goToEdit = () => {
  router.push(`/lost-found/edit/${detail.value.id}`)
}

// 返回
const goBack = () => {
  router.back()
}

// 上传证明图片
const handleClaimUploadSuccess = (response) => {
  if (response.code === 200) {
    claimForm.proofImages.push(response.data)
  }
}

// 状态类型映射
const claimStatusType = (status) => {
  const map = { pending: '', approved: 'success', rejected: 'danger', cancelled: 'info' }
  return map[status] || ''
}

// 格式化时间
const formatTime = (time) => {
  if (!time) return ''
  const d = new Date(time)
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
}

const formatDateTime = (time) => {
  if (!time) return ''
  const d = new Date(time)
  return `${d.getMonth() + 1}月${d.getDate()}日 ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`
}

onMounted(() => {
  loadDetail()
})
</script>

<style scoped>
.detail-page {
  padding-bottom: 24px;
}

.page-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.content-wrapper {
  max-width: 900px;
}

/* 图片展示 */
.image-gallery {
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 20px;
  background: #f5f7fa;
}

/* 信息卡片 */
.info-card {
  margin-bottom: 20px;
}

.title-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 16px;
  margin-bottom: 16px;
}

.title-row h1 {
  margin: 0;
  font-size: 24px;
  font-weight: 700;
  color: #303133;
  flex: 1;
}

.meta-info {
  display: flex;
  gap: 20px;
  color: #909399;
  font-size: 14px;
  margin-bottom: 8px;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 6px;
}

.info-section h4 {
  margin: 0 0 12px;
  font-size: 15px;
  font-weight: 600;
  color: #303133;
}

.description,
.features-text {
  margin: 0;
  line-height: 1.8;
  color: #606266;
}

.features-text {
  background: #f5f7fa;
  padding: 12px 16px;
  border-radius: 8px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 16px;
}

.info-cell {
  padding: 10px 14px;
  background: #fafafa;
  border-radius: 8px;
}

.info-cell label {
  display: block;
  font-size: 12px;
  color: #909399;
  margin-bottom: 4px;
}

.info-cell span {
  font-size: 14px;
  color: #303133;
  font-weight: 500;
}

/* 认领信息卡片 */
.claim-info-card {
  margin-bottom: 20px;
}

.claim-info {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}

.claim-item {
  padding: 12px;
  background: #f6ffed;
  border-radius: 8px;
}

.claim-item label {
  display: block;
  font-size: 12px;
  color: #52c41a;
  margin-bottom: 4px;
}

.claim-item span {
  font-size: 15px;
  color: #303133;
  font-weight: 600;
}

/* 操作卡片 */
.action-card {
  margin-bottom: 20px;
}

.actions {
  display: flex;
  gap: 12px;
}

/* 申请记录 */
.claims-card {
  margin-bottom: 20px;
}

.claim-item {
  padding: 16px;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  margin-bottom: 12px;
}

.claim-item:last-child {
  margin-bottom: 0;
}

.claim-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.applicant {
  display: flex;
  align-items: center;
  gap: 8px;
}

.applicant .name {
  font-weight: 500;
  color: #303133;
}

.claim-desc {
  margin: 0 0 12px;
  color: #606266;
  line-height: 1.6;
}

.claim-actions {
  display: flex;
  gap: 8px;
}
</style>
