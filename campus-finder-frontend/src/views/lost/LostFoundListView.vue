<template>
  <div class="lost-found-list-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2>{{ pageTitle }}</h2>
      <el-button type="primary" @click="goToPublish">
        <el-icon><Plus /></el-icon>
        发布{{ itemTypeText }}
      </el-button>
    </div>

    <!-- 搜索和筛选区域 -->
    <el-card class="filter-card" shadow="never">
      <el-row :gutter="20">
        <el-col :xs="24" :sm="12" :md="8" :lg="6">
          <el-input
            v-model="query.keyword"
            placeholder="搜索标题、描述、地点"
            clearable
            @keyup.enter="handleSearch"
          >
            <template #prefix>
              <el-icon><Search /></el-icon>
            </template>
          </el-input>
        </el-col>
        <el-col :xs="24" :sm="12" :md="8" :lg="6">
          <el-select v-model="query.categoryId" placeholder="选择分类" clearable style="width: 100%">
            <el-option
              v-for="cat in categories"
              :key="cat.id"
              :label="cat.name"
              :value="cat.id"
            />
          </el-select>
        </el-col>
        <el-col :xs="24" :sm="12" :md="8" :lg="6">
          <el-select v-model="query.status" placeholder="选择状态" clearable style="width: 100%">
            <el-option label="待认领" value="pending" />
            <el-option label="已认领" value="claimed" />
            <el-option label="已结束" value="closed" />
          </el-select>
        </el-col>
        <el-col :xs="24" :sm="12" :md="8" :lg="6">
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-col>
      </el-row>
    </el-card>

    <!-- 列表内容 -->
    <div v-loading="loading" class="list-container">
      <div v-if="list.length === 0 && !loading" class="empty-state">
        <el-empty description="暂无相关记录" />
      </div>

      <el-row v-else :gutter="20">
        <el-col
          v-for="item in list"
          :key="item.id"
          :xs="24"
          :sm="12"
          :md="8"
          :lg="6"
        >
          <div class="item-card" @click="goToDetail(item.id)">
            <div class="item-image">
              <el-image
                :src="item.images?.[0] || defaultImage"
                fit="cover"
                style="width: 100%; height: 180px"
              >
                <template #error>
                  <div class="image-placeholder">
                    <el-icon><Picture /></el-icon>
                  </div>
                </template>
              </el-image>
              <div class="item-status" :class="item.status">
                {{ item.statusText }}
              </div>
            </div>
            <div class="item-content">
              <h4 class="item-title">{{ item.title }}</h4>
              <p class="item-desc">{{ item.description }}</p>
              <div class="item-meta">
                <span class="meta-item">
                  <el-icon><Location /></el-icon>
                  {{ item.location }}
                </span>
                <span class="meta-item">
                  <el-icon><Clock /></el-icon>
                  {{ formatTime(item.happenedTime) }}
                </span>
              </div>
              <div class="item-footer">
                <div class="publisher">
                  <el-avatar :size="24" :src="item.publisherAvatar" />
                  <span>{{ item.publisherNickname }}</span>
                </div>
                <div class="stats">
                  <span><el-icon><View /></el-icon>{{ item.viewCount }}</span>
                  <span><el-icon><Star /></el-icon>{{ item.favoriteCount }}</span>
                </div>
              </div>
            </div>
          </div>
        </el-col>
      </el-row>

      <!-- 分页 -->
      <div v-if="total > 0" class="pagination-wrapper">
        <el-pagination
          v-model:current-page="query.page"
          v-model:page-size="query.size"
          :total="total"
          :page-sizes="[12, 24, 36]"
          layout="total, sizes, prev, pager, next"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Plus, Search, Picture, Location, Clock, View, Star } from '@element-plus/icons-vue'
import { lostFoundApi, categoryApi } from '@/api'

const route = useRoute()
const router = useRouter()

// 从路由参数获取类型
const itemType = computed(() => route.query.type || 'found')
const pageTitle = computed(() => itemType.value === 'lost' ? '寻物启事' : '失物招领')
const itemTypeText = computed(() => itemType.value === 'lost' ? '寻物' : '招领')

const defaultImage = '/default-item.png'
const loading = ref(false)
const list = ref([])
const total = ref(0)
const categories = ref([])

const query = reactive({
  page: 1,
  size: 12,
  keyword: '',
  categoryId: null,
  status: '',
  itemType: itemType.value
})

// 加载分类
const loadCategories = async () => {
  try {
    const res = await categoryApi.getList()
    categories.value = res
  } catch (error) {
    console.error('加载分类失败:', error)
  }
}

// 加载列表
const loadList = async () => {
  loading.value = true
  try {
    const res = await lostFoundApi.getList({
      ...query,
      itemType: itemType.value
    })
    list.value = res.records || []
    total.value = res.total || 0
  } catch (error) {
    ElMessage.error('加载列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  query.page = 1
  loadList()
}

// 重置
const resetQuery = () => {
  query.page = 1
  query.keyword = ''
  query.categoryId = null
  query.status = ''
  loadList()
}

// 分页
const handleSizeChange = (size) => {
  query.size = size
  loadList()
}

const handleCurrentChange = (page) => {
  query.page = page
  loadList()
}

// 跳转发布
const goToPublish = () => {
  router.push({
    path: '/lost-found/publish',
    query: { type: itemType.value }
  })
}

// 跳转详情
const goToDetail = (id) => {
  router.push(`/lost-found/${id}`)
}

// 格式化时间
const formatTime = (time) => {
  if (!time) return ''
  const date = new Date(time)
  return `${date.getMonth() + 1}月${date.getDate()}日`
}

// 监听类型变化
watch(() => route.query.type, () => {
  query.itemType = itemType.value
  loadList()
})

onMounted(() => {
  loadCategories()
  loadList()
})
</script>

<style scoped>
.lost-found-list-page {
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

.list-container {
  min-height: 400px;
}

.empty-state {
  padding: 60px 0;
}

.item-card {
  background: #fff;
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 20px;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

.item-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.item-image {
  position: relative;
}

.image-placeholder {
  width: 100%;
  height: 180px;
  background: #f5f7fa;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  color: #c0c4cc;
}

.item-status {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 500;
}

.item-status.pending {
  background: #e6f7ff;
  color: #1890ff;
}

.item-status.claimed {
  background: #f6ffed;
  color: #52c41a;
}

.item-status.closed {
  background: #f5f5f5;
  color: #999;
}

.item-content {
  padding: 16px;
}

.item-title {
  margin: 0 0 8px;
  font-size: 15px;
  font-weight: 600;
  color: #303133;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.item-desc {
  margin: 0 0 12px;
  font-size: 13px;
  color: #606266;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  line-height: 1.5;
  height: 39px;
}

.item-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 12px;
  font-size: 12px;
  color: #909399;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 4px;
}

.item-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 12px;
  border-top: 1px solid #ebeef5;
}

.publisher {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  color: #606266;
}

.stats {
  display: flex;
  gap: 12px;
  font-size: 12px;
  color: #909399;
}

.stats span {
  display: flex;
  align-items: center;
  gap: 4px;
}

.pagination-wrapper {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}
</style>
