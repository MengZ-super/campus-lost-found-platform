<template>
  <div class="admin-users">
    <h2>用户管理</h2>

    <el-form :inline="true" :model="query" class="search-bar">
      <el-form-item>
        <el-input v-model="query.keyword" placeholder="用户名/昵称/手机号" clearable @clear="search" @keyup.enter="search" />
      </el-form-item>
      <el-form-item>
        <el-select v-model="query.status" placeholder="状态" clearable @change="search" style="width: 120px">
          <el-option label="正常" :value="1" />
          <el-option label="禁用" :value="0" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-select v-model="query.role" placeholder="角色" clearable @change="search" style="width: 120px">
          <el-option label="普通用户" value="user" />
          <el-option label="管理员" value="admin" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search">搜索</el-button>
        <el-button @click="reset">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="tableData" stripe v-loading="loading">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="username" label="用户名" width="120" />
      <el-table-column prop="nickname" label="昵称" width="120" />
      <el-table-column prop="phone" label="手机号" width="130" />
      <el-table-column prop="role" label="角色" width="90">
        <template #default="{ row }">
          <el-tag :type="row.role === 'admin' ? 'danger' : 'info'" size="small">
            {{ row.role === 'admin' ? '管理员' : '用户' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="80">
        <template #default="{ row }">
          <el-switch
            :model-value="row.status === 1"
            :loading="row._switching"
            @change="toggleStatus(row)"
          />
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="注册时间" width="170" />
      <el-table-column prop="lastLoginTime" label="最后登录" width="170" />
      <el-table-column label="操作" width="120">
        <template #default="{ row }">
          <el-button text type="primary" size="small" @click="viewDetail(row)">详情</el-button>
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

    <el-dialog v-model="detailVisible" title="用户详情" width="500px">
      <el-descriptions v-if="detailUser" :column="2" border>
        <el-descriptions-item label="ID">{{ detailUser.id }}</el-descriptions-item>
        <el-descriptions-item label="用户名">{{ detailUser.username }}</el-descriptions-item>
        <el-descriptions-item label="昵称">{{ detailUser.nickname }}</el-descriptions-item>
        <el-descriptions-item label="手机号">{{ detailUser.phone }}</el-descriptions-item>
        <el-descriptions-item label="学号">{{ detailUser.studentId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="邮箱">{{ detailUser.email || '-' }}</el-descriptions-item>
        <el-descriptions-item label="角色">
          <el-tag :type="detailUser.role === 'admin' ? 'danger' : 'info'" size="small">
            {{ detailUser.role === 'admin' ? '管理员' : '用户' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag :type="detailUser.status === 1 ? 'success' : 'danger'" size="small">
            {{ detailUser.status === 1 ? '正常' : '禁用' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="注册时间">{{ detailUser.createTime }}</el-descriptions-item>
        <el-descriptions-item label="最后登录">{{ detailUser.lastLoginTime || '-' }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { adminApi } from '@/api'

const query = reactive({ keyword: '', status: null, role: '' })
const tableData = ref([])
const loading = ref(false)
const pageNum = ref(1)
const pageSize = ref(10)
const total = ref(0)

const detailVisible = ref(false)
const detailUser = ref(null)

onMounted(() => fetchData())

async function fetchData() {
  loading.value = true
  try {
    const res = await adminApi.listUsers({
      pageNum: pageNum.value,
      pageSize: pageSize.value,
      keyword: query.keyword || undefined,
      status: query.status,
      role: query.role || undefined
    })
    tableData.value = res.records.map(r => ({ ...r, _switching: false }))
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
  query.status = null
  query.role = ''
  search()
}

async function toggleStatus(row) {
  try {
    row._switching = true
    await adminApi.toggleUserStatus(row.id)
    ElMessage.success(row.status === 1 ? '已禁用' : '已启用')
    fetchData()
  } catch {
    // handled by interceptor
  } finally {
    row._switching = false
  }
}

async function viewDetail(row) {
  detailUser.value = await adminApi.getUserDetail(row.id)
  detailVisible.value = true
}
</script>

<style scoped>
.admin-users h2 { margin: 0 0 20px; font-size: 20px; color: #303133; }
.search-bar { background: #fff; padding: 16px 16px 0; border-radius: 8px; margin-bottom: 16px; }
.pagination-wrap { display: flex; justify-content: flex-end; margin-top: 16px; }
</style>
