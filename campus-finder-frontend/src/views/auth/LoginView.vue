<template>
  <div class="auth-page" :style="{ backgroundImage: `url(${authBgImg})` }">
    <div class="auth-overlay"></div>
    <div class="auth-card">
      <!-- Logo -->
      <div class="auth-header">
        <img :src="logoImg" alt="Campus Finder" class="logo-img" />
        <h1>校园失物招领</h1>
        <p class="subtitle">Campus Finder</p>
      </div>

      <!-- 登录表单 -->
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        size="large"
        @keyup.enter="handleLogin"
      >
        <el-form-item prop="username">
          <el-input
            v-model="form.username"
            placeholder="用户名 / 手机号"
            :prefix-icon="User"
            clearable
          />
        </el-form-item>

        <el-form-item prop="password">
          <el-input
            v-model="form.password"
            type="password"
            placeholder="密码"
            :prefix-icon="Lock"
            show-password
            clearable
          />
        </el-form-item>

        <el-button
          type="primary"
          :loading="loading"
          class="submit-btn"
          @click="handleLogin"
        >
          登录
        </el-button>
      </el-form>

      <div class="auth-footer">
        <span>还没有账号？</span>
        <router-link to="/register" class="link">立即注册</router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Lock } from '@element-plus/icons-vue'
import { useAuthStore } from '@/stores/auth'
import logoImg from '@/assets/images/logo.png'
import authBgImg from '@/assets/images/校园失物招领平台登录背景图生成.png'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

const formRef = ref()
const loading = ref(false)

const form = reactive({
  username: '',
  password: ''
})

const rules = {
  username: [{ required: true, message: '请输入用户名或手机号', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

async function handleLogin() {
  const valid = await formRef.value?.validate().catch(() => false)
  if (!valid) return

  loading.value = true
  try {
    const res = await authStore.login(form)
    ElMessage.success('登录成功')
    if (res.role === 'admin') {
      router.push('/admin/dashboard')
    } else {
      const redirect = route.query.redirect || '/home'
      router.push(redirect)
    }
  } catch (err) {
    // 错误已由 request 拦截器处理
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
  padding: 40px 36px;
  width: 100%;
  max-width: 400px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
  position: relative;
  z-index: 1;
}

.auth-header {
  text-align: center;
  margin-bottom: 32px;
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
  margin-top: 8px;
  height: 44px;
  font-size: 15px;
  border-radius: 8px;
}

.auth-footer {
  text-align: center;
  margin-top: 20px;
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

:deep(.el-input__wrapper) {
  border-radius: 8px;
}
</style>
