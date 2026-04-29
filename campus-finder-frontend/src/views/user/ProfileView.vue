<template>
  <div class="profile-page">
    <el-row :gutter="20">
      <!-- 左侧：头像 + 基本信息 -->
      <el-col :xs="24" :md="8">
        <el-card class="profile-card" shadow="never">
          <div class="avatar-section">
            <el-avatar :size="80" :src="profile.avatar || defaultAvatar" class="main-avatar">
              {{ profile.nickname?.charAt(0)?.toUpperCase() || 'U' }}
            </el-avatar>
            <h3>{{ profile.nickname || profile.username }}</h3>
            <p class="username-tag">@{{ profile.username }}</p>
            <el-tag :type="profile.status === 1 ? 'success' : 'danger'" size="small">
              {{ profile.status === 1 ? '正常' : '已禁用' }}
            </el-tag>
          </div>

          <el-divider />

          <div class="info-list">
            <div class="info-item" v-if="profile.studentId">
              <el-icon><Ticket /></el-icon>
              <span>学号：{{ profile.studentId }}</span>
            </div>
            <div class="info-item" v-if="profile.phone">
              <el-icon><Phone /></el-icon>
              <span>{{ profile.phone }}</span>
            </div>
            <div class="info-item" v-if="profile.email">
              <el-icon><Message /></el-icon>
              <span>{{ profile.email }}</span>
            </div>
            <div class="info-item">
              <el-icon><Calendar /></el-icon>
              <span>注册于 {{ formatDate(profile.createTime) }}</span>
            </div>
          </div>

          <!-- 头像预览区 -->
          <div class="avatar-preview-section" v-if="profileForm.avatar">
            <el-divider content-position="left">头像预览</el-divider>
            <img :src="profileForm.avatar" alt="Avatar Preview" class="avatar-preview" @error="onImgError" />
          </div>
        </el-card>
      </el-col>

      <!-- 右侧：编辑表单 -->
      <el-col :xs="24" :md="16">
        <el-card shadow="never" class="edit-card">
          <el-tabs v-model="activeTab">
            <!-- 编辑资料 -->
            <el-tab-pane label="编辑资料" name="info">
              <el-form
                ref="profileFormRef"
                :model="profileForm"
                :rules="profileRules"
                label-width="80px"
                size="default"
                v-loading="profileLoading"
              >
                <el-form-item label="昵称" prop="nickname">
                  <el-input v-model="profileForm.nickname" placeholder="设置昵称" clearable />
                </el-form-item>

                <el-form-item label="性别" prop="gender">
                  <el-radio-group v-model="profileForm.gender">
                    <el-radio :value="0">未知</el-radio>
                    <el-radio :value="1">男</el-radio>
                    <el-radio :value="2">女</el-radio>
                  </el-radio-group>
                </el-form-item>

                <el-form-item label="手机号" prop="phone">
                  <el-input v-model="profileForm.phone" placeholder="绑定手机号" clearable />
                </el-form-item>

                <el-form-item label="邮箱" prop="email">
                  <el-input v-model="profileForm.email" placeholder="绑定邮箱" clearable />
                </el-form-item>

                <el-form-item label="头像URL" prop="avatar">
                  <el-input v-model="profileForm.avatar" placeholder="输入头像图片 URL" clearable />
                  <div class="avatar-hint">
                    <span>💡 提示：留空将使用系统默认头像</span>
                  </div>
                </el-form-item>

                <el-form-item>
                  <el-button type="primary" :loading="profileSaving" @click="saveProfile">
                    保存修改
                  </el-button>
                  <el-button @click="resetProfileForm">重置</el-button>
                </el-form-item>
              </el-form>
            </el-tab-pane>

            <!-- 修改密码 -->
            <el-tab-pane label="修改密码" name="password">
              <el-form
                ref="pwdFormRef"
                :model="pwdForm"
                :rules="pwdRules"
                label-width="100px"
                size="default"
              >
                <el-form-item label="原密码" prop="oldPassword">
                  <el-input
                    v-model="pwdForm.oldPassword"
                    type="password"
                    placeholder="输入当前密码"
                    show-password
                    clearable
                  />
                </el-form-item>

                <el-form-item label="新密码" prop="newPassword">
                  <el-input
                    v-model="pwdForm.newPassword"
                    type="password"
                    placeholder="6-20 位，包含字母和数字"
                    show-password
                    clearable
                  />
                </el-form-item>

                <el-form-item label="确认新密码" prop="confirmPassword">
                  <el-input
                    v-model="pwdForm.confirmPassword"
                    type="password"
                    placeholder="再次输入密码"
                    show-password
                    clearable
                  />
                </el-form-item>

                <el-form-item>
                  <el-button type="primary" :loading="pwdSaving" @click="savePassword">
                    修改密码
                  </el-button>
                  <el-button @click="resetPwdForm">重置</el-button>
                </el-form-item>
              </el-form>
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Ticket, Phone, Message, Calendar } from '@element-plus/icons-vue'
import { userApi } from '@/api'
import { useAuthStore } from '@/stores/auth'
import defaultAvatar from '@/assets/images/avatar-default.png'

const authStore = useAuthStore()
const activeTab = ref('info')

// 个人资料数据
const profile = reactive({
  id: null, username: '', nickname: '', avatar: '', phone: '',
  studentId: '', email: '', gender: 0, status: 1,
  lastLoginTime: '', createTime: ''
})

// 编辑表单
const profileFormRef = ref()
const profileLoading = ref(false)
const profileSaving = ref(false)
const profileForm = reactive({
  nickname: '', gender: 0, phone: '', email: '', avatar: ''
})

const profileRules = {
  phone: [{ pattern: /^1[3-9]\d{9}$/, message: '手机号格式不正确', trigger: 'blur' }],
  email: [{ type: 'email', message: '邮箱格式不正确', trigger: 'blur' }]
}

// 密码表单
const pwdFormRef = ref()
const pwdSaving = ref(false)
const pwdForm = reactive({
  oldPassword: '', newPassword: '', confirmPassword: ''
})

const validateConfirmPwd = (rule, value, callback) => {
  if (value !== pwdForm.newPassword) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const pwdRules = {
  oldPassword: [{ required: true, message: '请输入原密码', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6-20 个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请再次输入密码', trigger: 'blur' },
    { validator: validateConfirmPwd, trigger: 'blur' }
  ]
}

// 加载个人资料
async function loadProfile() {
  profileLoading.value = true
  try {
    const res = await userApi.getProfile()
    Object.assign(profile, res)
    // 同步到编辑表单
    profileForm.nickname = profile.nickname || ''
    profileForm.gender = profile.gender ?? 0
    profileForm.phone = profile.phone || ''
    profileForm.email = profile.email || ''
    profileForm.avatar = profile.avatar || ''
  } catch {
    ElMessage.error('加载资料失败')
  } finally {
    profileLoading.value = false
  }
}

// 保存资料
async function saveProfile() {
  const valid = await profileFormRef.value?.validate().catch(() => false)
  if (!valid) return

  profileSaving.value = true
  try {
    // 过滤空值
    const data = {}
    if (profileForm.nickname) data.nickname = profileForm.nickname
    if (profileForm.phone) data.phone = profileForm.phone
    if (profileForm.email) data.email = profileForm.email
    if (profileForm.avatar) data.avatar = profileForm.avatar
    data.gender = profileForm.gender

    const res = await userApi.updateProfile(data)
    Object.assign(profile, res)
    // 更新 store 中的头像和昵称
    authStore.setUserInfo({
      ...authStore.userInfo,
      nickname: profile.nickname,
      avatar: profile.avatar
    })
    ElMessage.success('资料更新成功')
  } catch {
    // 错误已由拦截器处理
  } finally {
    profileSaving.value = false
  }
}

// 修改密码
async function savePassword() {
  const valid = await pwdFormRef.value?.validate().catch(() => false)
  if (!valid) return

  pwdSaving.value = true
  try {
    await userApi.changePassword(pwdForm)
    ElMessage.success('密码修改成功')
    resetPwdForm()
  } catch {
    // 错误已由拦截器处理
  } finally {
    pwdSaving.value = false
  }
}

function resetProfileForm() {
  profileForm.nickname = profile.nickname || ''
  profileForm.gender = profile.gender ?? 0
  profileForm.phone = profile.phone || ''
  profileForm.email = profile.email || ''
  profileForm.avatar = profile.avatar || ''
}

function resetPwdForm() {
  pwdFormRef.value?.resetFields()
}

function formatDate(dateStr) {
  if (!dateStr) return '-'
  return new Date(dateStr).toLocaleDateString('zh-CN', {
    year: 'numeric', month: 'long', day: 'numeric'
  })
}

function onImgError(e) {
  e.target.src = defaultAvatar
}

onMounted(() => loadProfile())
</script>

<style scoped>
.profile-page {
  padding-bottom: 24px;
}

.profile-card {
  border-radius: 12px;
}

.avatar-section {
  text-align: center;
  padding: 8px 0 16px;
}

.main-avatar {
  font-size: 28px;
  margin-bottom: 12px;
}

.avatar-section h3 {
  font-size: 18px;
  font-weight: 600;
  color: #303133;
  margin: 0 0 4px;
}

.username-tag {
  color: #909399;
  font-size: 13px;
  margin: 0 0 10px;
}

.info-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  color: #606266;
}

.avatar-preview-section {
  text-align: center;
  margin-top: 8px;
}

.avatar-preview {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid #e4e7ed;
}

.edit-card {
  border-radius: 12px;
  min-height: 400px;
}

.avatar-hint {
  margin-top: 4px;
  color: #909399;
  font-size: 12px;
}

:deep(.el-card__body) {
  padding: 20px;
}
</style>
