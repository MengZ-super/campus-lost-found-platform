<template>
  <div class="auth-page" :style="{ backgroundImage: `url(${authBgImg})` }">
    <div class="auth-overlay"></div>
    <div class="auth-card">
      <!-- Logo -->
      <div class="auth-header">
        <img :src="logoImg" alt="Campus Finder" class="logo-img" />
        <h1>注册账号</h1>
        <p class="subtitle">加入校园失物招领平台</p>
      </div>

      <!-- 注册表单 -->
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        size="large"
        label-position="top"
      >
        <el-form-item label="用户名" prop="username">
          <el-input
            v-model="form.username"
            placeholder="3-50 个字符"
            :prefix-icon="User"
            clearable
          />
        </el-form-item>

        <el-form-item label="手机号" prop="phone">
          <el-input
            v-model="form.phone"
            placeholder="11 位手机号"
            :prefix-icon="Phone"
            clearable
          />
        </el-form-item>

        <el-form-item label="学号（选填）" prop="studentId">
          <el-input
            v-model="form.studentId"
            placeholder="填写学号便于认证"
            :prefix-icon="Ticket"
            clearable
          />
        </el-form-item>

        <el-form-item label="昵称（选填）" prop="nickname">
          <el-input
            v-model="form.nickname"
            placeholder="你的昵称"
            :prefix-icon="ChatDotRound"
            clearable
          />
        </el-form-item>

        <el-form-item label="密码" prop="password">
          <el-input
            v-model="form.password"
            type="password"
            placeholder="6-20 位，包含字母和数字"
            :prefix-icon="Lock"
            show-password
            clearable
          />
        </el-form-item>

        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input
            v-model="form.confirmPassword"
            type="password"
            placeholder="再次输入密码"
            :prefix-icon="Lock"
            show-password
            clearable
          />
        </el-form-item>

        <el-button
          type="primary"
          :loading="loading"
          class="submit-btn"
          @click="handleRegister"
        >
          注册
        </el-button>
      </el-form>

      <div class="auth-footer">
        <span>已有账号？</span>
        <router-link to="/login" class="link">立即登录</router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Lock, Phone, Ticket, ChatDotRound } from '@element-plus/icons-vue'
import { useAuthStore } from '@/stores/auth'
import logoImg from '@/assets/images/logo.png'
import authBgImg from '@/assets/images/校园失物招领平台登录背景图生成.png'

const router = useRouter()
const authStore = useAuthStore()

const formRef = ref()
const loading = ref(false)

const form = reactive({
  username: '',
  phone: '',
  studentId: '',
  nickname: '',
  password: '',
  confirmPassword: ''
})

const validateConfirmPwd = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请再次输入密码'))
  } else if (value !== form.password) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const validatePassword = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请输入密码'))
  } else if (value.length < 6 || value.length > 20) {
    callback(new Error('密码长度在 6-20 个字符'))
  } else if (!/[a-zA-Z]/.test(value)) {
    callback(new Error('密码必须包含字母'))
  } else if (!/\d/.test(value)) {
    callback(new Error('密码必须包含数字'))
  } else {
    callback()
  }
}

const rules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 50, message: '用户名长度在 3-50 个字符', trigger: 'blur' },
    { pattern: /^[a-zA-Z0-9_]+$/, message: '用户名只能包含字母、数字和下划线', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '手机号格式不正确', trigger: 'blur' }
  ],
  studentId: [
    { min: 5, max: 20, message: '学号长度在 5-20 个字符', trigger: 'blur' }
  ],
  nickname: [
    { min: 1, max: 20, message: '昵称长度在 1-20 个字符', trigger: 'blur' }
  ],
  password: [
    { validator: validatePassword, trigger: 'blur' }
  ],
  confirmPassword: [
    { validator: validateConfirmPwd, trigger: 'blur' }
  ]
}

async function handleRegister() {
  const valid = await formRef.value?.validate().catch(() => false)
  if (!valid) return

  loading.value = true
  try {
    const data = { ...form }
    if (!data.studentId) delete data.studentId
    if (!data.nickname) delete data.nickname

    await authStore.register(data)
    ElMessage.success('注册成功，欢迎加入！')
    router.push('/home')
  } catch (err) {
    // 错误信息已由拦截器 ElMessage 提示，这里只需阻止页面崩溃
    console.error('注册失败:', err)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.auth-page {
  min-height: 100vh;
  background-size: cover;
  background-position: center center;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  position: relative;
  overflow: hidden;
}

/* 半透明遮罩层 */
.auth-overlay {
  position: absolute;
  inset: 0;
  background: rgba(15, 23, 42, 0.35);
  z-index: 0;
}

.auth-card {
  background: #fff;
  border-radius: 16px;
  padding: 36px 32px;
  width: 100%;
  max-width: 440px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
  position: relative;
  z-index: 1;
  max-height: 90vh;
  overflow-y: auto;
}

.auth-header {
  text-align: center;
  margin-bottom: 24px;
}

.logo-img {
  height: 48px;
  width: auto;
  margin-bottom: 12px;
  object-fit: contain;
}

.auth-header h1 {
  font-size: 22px;
  font-weight: 700;
  color: #303133;
  margin: 8px 0 4px;
}

.subtitle {
  color: #909399;
  font-size: 13px;
  margin: 0;
}

.submit-btn {
  width: 100%;
  margin-top: 4px;
  height: 44px;
  font-size: 15px;
  border-radius: 8px;
}

.auth-footer {
  text-align: center;
  margin-top: 16px;
  font-size: 14px;
  color: #606266;
}

.link {
  color: #3b82f6;
  text-decoration: none;
  font-weight: 500;
  margin-left: 4px;
}

.link:hover {
  text-decoration: underline;
}

:deep(.el-form-item__label) {
  font-weight: 500;
  color: #606266;
}

:deep(.el-input__wrapper) {
  border-radius: 8px;
}
</style>
