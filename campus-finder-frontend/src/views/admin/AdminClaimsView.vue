<template>
  <div class="admin-claims">
    <h2>认领管理</h2>

    <el-form :inline="true" :model="query" class="search-bar">
      <el-form-item>
        <el-select v-model="query.status" placeholder="状态" clearable @change="search" style="width: 120px">
          <el-option label="待审核" value="pending" />
          <el-option label="已通过" value="approved" />
          <el-option label="已拒绝" value="rejected" />
          <el-option label="已取消" value="cancelled" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search">搜索</el-button>
        <el-button @click="reset">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="tableData" stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="lostFoundId" label="物品ID" width="80" />
      <el-table-column prop="description" label="认领说明" min-width="200" show-overflow-tooltip />
      <el-table-column prop="statusText" label="状态" width="90" />
      <el-table-column prop="contact" label="联系方式" width="120" />
      <el-table-column prop="remark" label="备注" width="150" show-overflow-tooltip />
      <el-table-column prop="createTime" label="申请时间" width="170" />
      <el-table-column label="操作" width="140" fixed="right">
        <template #default="{ row }">
          <template v-if="row.status === 'pending'">
            <el-button text type="success" size="small" :loading="row._reviewing" @click="handleReview(row, 'approve')">通过</el-button>
            <el-button text type="danger" size="small" @click="handleReject(row)">拒绝</el-button>
          </template>
          <span v-else class="no-action">-</span>
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

    <el-dialog v-model="rejectVisible" title="拒绝申请" width="420px">
      <el-form :model="rejectForm">
        <el-form-item label="拒绝原因">
          <el-input v-model="rejectForm.remark" type="textarea" :rows="3" placeholder="请输入拒绝原因" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="rejectVisible = false">取消</el-button>
        <el-button type="primary" :loading="rejectLoading" @click="confirmReject">确认拒绝</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { adminApi } from '@/api'

const query = reactive({ status: '' })
const tableData = ref([])
const loading = ref(false)
const pageNum = ref(1)
const pageSize = ref(10)
const total = ref(0)

const rejectVisible = ref(false)
const rejectLoading = ref(false)
const rejectForm = reactive({ claimId: null, remark: '' })

onMounted(() => fetchData())

async function fetchData() {
  loading.value = true
  try {
    const res = await adminApi.listClaims({
      pageNum: pageNum.value,
      pageSize: pageSize.value,
      status: query.status || undefined
    })
    tableData.value = res.records.map(r => ({ ...r, _reviewing: false }))
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
  query.status = ''
  search()
}

async function handleReview(row, action) {
  row._reviewing = true
  try {
    await adminApi.reviewClaim(row.id, { action })
    ElMessage.success('审核通过')
    fetchData()
  } finally {
    row._reviewing = false
  }
}

function handleReject(row) {
  rejectForm.claimId = row.id
  rejectForm.remark = ''
  rejectVisible.value = true
}

async function confirmReject() {
  rejectLoading.value = true
  try {
    await adminApi.reviewClaim(rejectForm.claimId, { action: 'reject', remark: rejectForm.remark })
    ElMessage.success('已拒绝')
    rejectVisible.value = false
    fetchData()
  } finally {
    rejectLoading.value = false
  }
}
</script>

<style scoped>
.admin-claims h2 { margin: 0 0 20px; font-size: 20px; color: #303133; }
.search-bar { background: #fff; padding: 16px 16px 0; border-radius: 8px; margin-bottom: 16px; }
.pagination-wrap { display: flex; justify-content: flex-end; margin-top: 16px; }
.no-action { color: #c0c4cc; }
</style>
