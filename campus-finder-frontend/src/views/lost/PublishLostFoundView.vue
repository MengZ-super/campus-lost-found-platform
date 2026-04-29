<template>
  <div class="publish-page">
    <div class="page-header">
      <el-button link @click="goBack">
        <el-icon><ArrowLeft /></el-icon>
        返回
      </el-button>
      <h2>发布{{ itemTypeText }}</h2>
      <div style="width: 60px"></div>
    </div>

    <el-card class="form-card">
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-position="top"
        style="max-width: 800px"
      >
        <!-- 物品类型 -->
        <el-form-item label="类型" prop="itemType">
          <el-radio-group v-model="form.itemType" size="large">
            <el-radio-button label="found">
              <el-icon><Box /></el-icon>
              我捡到了物品
            </el-radio-button>
            <el-radio-button label="lost">
              <el-icon><Search /></el-icon>
              我丢失了物品
            </el-radio-button>
          </el-radio-group>
        </el-form-item>

        <!-- 分类 -->
        <el-form-item label="物品分类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择分类" style="width: 100%">
            <el-option
              v-for="cat in categories"
              :key="cat.id"
              :label="cat.name"
              :value="cat.id"
            >
              <span style="margin-right: 8px">{{ cat.icon }}</span>
              {{ cat.name }}
            </el-option>
          </el-select>
        </el-form-item>

        <!-- 标题 -->
        <el-form-item label="标题" prop="title">
          <el-input
            v-model="form.title"
            placeholder="请简要描述物品，如：黑色钱包、蓝色雨伞"
            maxlength="100"
            show-word-limit
          />
        </el-form-item>

        <!-- 描述 -->
        <el-form-item label="详细描述" prop="description">
          <el-input
            v-model="form.description"
            type="textarea"
            :rows="4"
            placeholder="请详细描述物品的特征、品牌、颜色等信息"
            maxlength="2000"
            show-word-limit
          />
        </el-form-item>

        <!-- 图片上传 -->
        <el-form-item label="物品图片" prop="images">
          <el-upload
            v-model:file-list="fileList"
            action="/api/upload"
            list-type="picture-card"
            :limit="9"
            :on-success="handleUploadSuccess"
            :on-remove="handleRemove"
            :before-upload="beforeUpload"
            :headers="uploadHeaders"
          >
            <el-icon><Plus /></el-icon>
            <template #tip>
              <div class="upload-tip">
                最多上传9张图片，支持 JPG、PNG 格式，单张不超过 5MB
              </div>
            </template>
          </el-upload>
        </el-form-item>

        <!-- 物品特征 -->
        <el-form-item label="物品特征" prop="features">
          <el-input
            v-model="form.features"
            type="textarea"
            :rows="2"
            placeholder="描述物品的独特特征，用于认领验证"
            maxlength="500"
            show-word-limit
          />
        </el-form-item>

        <!-- 地点 -->
        <el-form-item :label="locationLabel" prop="location">
          <el-input
            v-model="form.location"
            placeholder="如：图书馆二楼、食堂门口"
            maxlength="200"
          />
        </el-form-item>

        <!-- 时间 -->
        <el-form-item :label="timeLabel" prop="happenedTime">
          <el-date-picker
            v-model="form.happenedTime"
            type="datetime"
            placeholder="选择时间"
            format="YYYY-MM-DD HH:mm"
            value-format="YYYY-MM-DD HH:mm:ss"
            style="width: 100%"
          />
        </el-form-item>

        <!-- 校区 -->
        <el-form-item label="校区" prop="campus">
          <el-input
            v-model="form.campus"
            placeholder="如：主校区、东校区"
            maxlength="50"
          />
        </el-form-item>

        <!-- 提交按钮 -->
        <el-form-item>
          <el-button type="primary" size="large" @click="handleSubmit" :loading="submitting">
            发布
          </el-button>
          <el-button size="large" @click="goBack">取消</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft, Plus, Box, Search } from '@element-plus/icons-vue'
import { lostFoundApi, categoryApi } from '@/api'

const route = useRoute()
const router = useRouter()
const formRef = ref()

const itemType = computed(() => form.itemType)
const itemTypeText = computed(() => form.itemType === 'lost' ? '寻物启事' : '失物招领')
const locationLabel = computed(() => form.itemType === 'found' ? '发现地点' : '丢失地点')
const timeLabel = computed(() => form.itemType === 'found' ? '发现时间' : '丢失时间')

const categories = ref([])
const fileList = ref([])
const submitting = ref(false)
const uploadHeaders = { Authorization: `Bearer ${localStorage.getItem('accessToken')}` }

const form = reactive({
  itemType: route.query.type || 'found',
  categoryId: null,
  title: '',
  description: '',
  images: [],
  features: '',
  location: '',
  happenedTime: '',
  campus: ''
})

const rules = {
  itemType: [{ required: true, message: '请选择类型', trigger: 'change' }],
  categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }],
  title: [
    { required: true, message: '请输入标题', trigger: 'blur' },
    { min: 2, max: 100, message: '长度在 2 到 100 个字符', trigger: 'blur' }
  ],
  description: [
    { required: true, message: '请输入描述', trigger: 'blur' },
    { min: 10, max: 2000, message: '长度在 10 到 2000 个字符', trigger: 'blur' }
  ],
  location: [{ required: true, message: '请输入地点', trigger: 'blur' }],
  happenedTime: [{ required: true, message: '请选择时间', trigger: 'change' }]
}

// 加载分类
const loadCategories = async () => {
  try {
    const res = await categoryApi.getList()
    categories.value = res
  } catch (error) {
    ElMessage.error('加载分类失败')
  }
}

// 上传成功
const handleUploadSuccess = (response, file) => {
  if (response.code === 200) {
    form.images.push(response.data)
    ElMessage.success('上传成功')
  } else {
    ElMessage.error(response.message || '上传失败')
  }
}

// 删除图片
const handleRemove = (file, fileList) => {
  const index = form.images.indexOf(file.response?.data)
  if (index > -1) {
    form.images.splice(index, 1)
  }
}

// 上传前检查
const beforeUpload = (file) => {
  const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png'
  const isLt5M = file.size / 1024 / 1024 < 5

  if (!isJpgOrPng) {
    ElMessage.error('只支持 JPG/PNG 格式!')
    return false
  }
  if (!isLt5M) {
    ElMessage.error('图片大小不能超过 5MB!')
    return false
  }
  return true
}

// 提交
const handleSubmit = async () => {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return

  submitting.value = true
  try {
    await lostFoundApi.publish(form)
    ElMessage.success('发布成功')
    router.push({
      path: '/lost-found',
      query: { type: form.itemType }
    })
  } catch (error) {
    ElMessage.error(error.message || '发布失败')
  } finally {
    submitting.value = false
  }
}

// 返回
const goBack = () => {
  router.back()
}

onMounted(() => {
  loadCategories()
})
</script>

<style scoped>
.publish-page {
  padding-bottom: 24px;
}

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0;
  font-size: 20px;
  font-weight: 600;
}

.form-card {
  max-width: 900px;
}

.upload-tip {
  font-size: 12px;
  color: #909399;
  margin-top: 8px;
}

:deep(.el-radio-button__inner) {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 12px 24px;
}
</style>
