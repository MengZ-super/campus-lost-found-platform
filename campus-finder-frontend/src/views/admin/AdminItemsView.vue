<template>
  <div class="admin-items">
    <h2>物品管理</h2>

    <el-form :inline="true" :model="query" class="search-bar">
      <el-form-item>
        <el-input v-model="query.keyword" placeholder="搜索标题/描述" clearable @clear="search" @keyup.enter="search" />
      </el-form-item>
      <el-form-item>
        <el-select v-model="query.itemType" placeholder="类型" clearable @change="search" style="width: 100px">
          <el-option label="丢失" value="lost" />
          <el-option label="捡到" value="found" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-select v-model="query.status" placeholder="状态" clearable @change="search" style="width: 110px">
          <el-option label="待认领" value="pending" />
          <el-option label="已认领" value="claimed" />
          <el-option label="已关闭" value="closed" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-select v-model="query.categoryId" placeholder="分类" clearable @change="search" style="width: 130px">
          <el-option v-for="c in categories" :key="c.id" :label="c.name" :value="c.id" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search">搜索</el-button>
        <el-button @click="reset">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="tableData" stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="title" label="标题" min-width="180" show-overflow-tooltip />
      <el-table-column prop="itemType" label="类型" width="80">
        <template #default="{ row }">
          <el-tag :type="row.itemType === 'lost' ? 'danger' : 'success'" size="small">
            {{ row.itemType === 'lost' ? '丢失' : '捡到' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="statusText" label="状态" width="90" />
      <el-table-column prop="location" label="地点" width="120" show-overflow-tooltip />
      <el-table-column prop="viewCount" label="浏览" width="70" />
      <el-table-column prop="claimCount" label="申请" width="70" />
      <el-table-column prop="createTime" label="发布时间" width="170" />
      <el-table-column label="操作" width="160" fixed="right">
        <template #default="{ row }">
          <el-button v-if="row.status !== 'closed'" text type="warning" size="small" @click="handleClose(row)">关闭</el-button>
          <el-popconfirm title="确定删除该物品？" @confirm="handleDelete(row)">
            <template #reference>
              <el-button text type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div class="pagination-wrap">
      <el-pagination
        v-model:current-page="pageNum"
        v-model:page-size="pageSize"
        :total="total"
        layout="total, prev, pager, next"
        @current-change="fetchData"
        @size-change="fetchData"
      />
    </div>

    <el-dialog v-model="closeVisible" title="强制关闭" width="420px">
      <el-form :model="closeForm">
        <el-form-item label="关闭原因">
          <el-input v-model="closeForm.reason" type="textarea" :rows="3" placeholder="请输入关闭原因" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="closeVisible = false">取消</el-button>
        <el-button type="primary" :loading="closeLoading" @click="confirmClose">确认关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { adminApi } from '@/api'
import { categoryApi } from '@/api'

const query = reactive({ keyword: '', itemType: '', status: '', categoryId: null })
const tableData = ref([])
const loading = ref(false)
const pageNum = ref(1)
const pageSize = ref(10)
const total = ref(0)
const categories = ref([])

const closeVisible = ref(false)
const closeLoading = ref(false)
const closeForm = reactive({ reason: '', itemId: null })

onMounted(async () => {
  categories.value = await categoryApi.getList()
  fetchData()
})

async function fetchData() {
  loading.value = true
  try {
    const res = await adminApi.listItems({
      pageNum: pageNum.value,
      pageSize: pageSize.value,
      keyword: query.keyword || undefined,
      itemType: query.itemType || undefined,
      status: query.status || undefined,
      categoryId: query.categoryId || undefined
    })
    tableData.value = res.records
    total.value = res.total
  } finally {
    loading.value = false
  }
}

function search() {
  pageNum.value = 1
  fetchData()
}

function reset() {
  query.keyword = ''
  query.itemType = ''
  query.status = ''
  query.categoryId = null
  search()
}

function handleClose(row) {
  closeForm.itemId = row.id
  closeForm.reason = ''
  closeVisible.value = true
}

async function confirmClose() {
  closeLoading.value = true
  try {
    await adminApi.forceCloseItem(closeForm.itemId, { reason: closeForm.reason || '管理员强制关闭' })
    ElMessage.success('已关闭')
    closeVisible.value = false
    fetchData()
  } finally {
    closeLoading.value = false
  }
}

async function handleDelete(row) {
  await adminApi.forceDeleteItem(row.id)
  ElMessage.success('已删除')
  fetchData()
}
</script>

<style scoped>
.admin-items h2 { margin: 0 0 20px; font-size: 20px; color: #303133; }
.search-bar { background: #fff; padding: 16px 16px 0; border-radius: 8px; margin-bottom: 16px; }
.pagination-wrap { display: flex; justify-content: flex-end; margin-top: 16px; }
</style>
