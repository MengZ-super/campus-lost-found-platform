<template>
  <view class="publish-page">
    <uni-forms
      ref="formRef"
      :model-value="formData"
      :rules="rules"
    >
      <!-- 物品类型 -->
      <view class="type-section">
        <text class="section-label">
          物品类型
        </text>
        <view class="type-chips">
          <view
            class="chip"
            :class="{ active: formData.itemType === 'lost' }"
            @click="formData.itemType = 'lost'"
          >
            <text class="chip-icon">
              😢
            </text>
            <text class="chip-text">
              寻物
            </text>
          </view>
          <view
            class="chip"
            :class="{ active: formData.itemType === 'found' }"
            @click="formData.itemType = 'found'"
          >
            <text class="chip-icon">
              😄
            </text>
            <text class="chip-text">
              招领
            </text>
          </view>
        </view>
      </view>

      <!-- 分类 -->
      <uni-forms-item
        name="categoryId"
        class="form-item"
      >
        <view class="item-header">
          <text class="label">
            分类
          </text>
          <text class="required">
            *
          </text>
        </view>
        <uni-data-select
          v-model="formData.categoryId"
          :localdata="categoryOptions"
          placeholder="请选择分类"
          class="data-select"
          @change="onCategoryChange"
        />
      </uni-forms-item>

      <!-- 标题 -->
      <uni-forms-item
        name="title"
        class="form-item"
      >
        <view class="item-header">
          <text class="label">
            标题
          </text>
          <text class="required">
            *
          </text>
        </view>
        <uni-easyinput
          v-model="formData.title"
          placeholder="请输入标题"
          maxlength="50"
          class="input"
        />
      </uni-forms-item>

      <!-- 描述 -->
      <uni-forms-item
        name="description"
        class="form-item"
      >
        <view class="item-header">
          <text class="label">
            描述
          </text>
          <text class="required">
            *
          </text>
        </view>
        <uni-easyinput
          v-model="formData.description"
          type="textarea"
          placeholder="请详细描述物品特征"
          :maxlength="500"
          class="textarea"
        />
      </uni-forms-item>

      <!-- 特征 -->
      <uni-forms-item
        name="features"
        class="form-item"
      >
        <view class="item-header">
          <text class="label">
            特征
          </text>
        </view>
        <uni-easyinput
          v-model="formData.features"
          placeholder="颜色、品牌等特征"
          maxlength="200"
          class="input"
        />
      </uni-forms-item>

      <!-- 图片 -->
      <view class="form-item">
        <view class="item-header">
          <text class="label">
            图片
          </text>
        </view>
        <image-picker
          v-model="formData.images"
          :max="9"
        />
      </view>

      <!-- 位置 -->
      <view class="form-item">
        <view class="item-header">
          <text class="label">
            位置
          </text>
          <text class="required">
            *
          </text>
        </view>
        <uni-easyinput
          v-model="formData.location"
          placeholder="请输入丢失/捡到地点"
          maxlength="100"
          class="input"
        />
        <map-picker
          v-model="locationData"
          class="map-picker"
        />
      </view>

      <!-- 发生时间 -->
      <uni-forms-item
        name="happenedTime"
        class="form-item"
      >
        <view class="item-header">
          <text class="label">
            发生时间
          </text>
          <text class="required">
            *
          </text>
        </view>
        <uni-datetime-picker
          v-model="formData.happenedTime"
          type="datetime"
          placeholder="请选择时间"
          :max-date="Date.now()"
          class="datetime-picker"
        />
      </uni-forms-item>

      <!-- 校区 -->
      <uni-forms-item
        name="campus"
        class="form-item"
      >
        <view class="item-header">
          <text class="label">
            校区
          </text>
          <text class="required">
            *
          </text>
        </view>
        <uni-easyinput
          v-model="formData.campus"
          placeholder="如：南湖校区、东湖校区"
          maxlength="50"
          class="input"
        />
      </uni-forms-item>
    </uni-forms>

    <view class="submit-area">
      <button
        class="submit-btn"
        type="primary"
        :loading="loading"
        @click="handleSubmit"
      >
        提交发布
      </button>
    </view>
  </view>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { publishItemApi } from '@/api/lost-found.js'
import { getCategoryListApi } from '@/api/category.js'
import imagePicker from '@/components/image-picker.vue'
import mapPicker from '@/components/map-picker.vue'

const formRef = ref(null)
const loading = ref(false)
const categoryList = ref([])

// 监听分类选择，清除验证错误
function onCategoryChange(e) {
  if (formData.categoryId) {
    formRef.value?.clearValidate('categoryId')
  }
}

const formData = reactive({
  itemType: 'lost',
  categoryId: '',
  title: '',
  description: '',
  features: '',
  images: [],
  location: '',
  latitude: null,
  longitude: null,
  happenedTime: '',
  campus: ''
})

const locationData = computed({
  get() {
    if (formData.latitude && formData.longitude) {
      return {
        latitude: formData.latitude,
        longitude: formData.longitude,
        name: formData.location,
        address: ''
      }
    }
    return {}
  },
  set(val) {
    if (val && val.latitude) {
      formData.latitude = val.latitude
      formData.longitude = val.longitude
    } else {
      formData.latitude = null
      formData.longitude = null
    }
  }
})

const categoryOptions = computed(() => {
  return categoryList.value.map(cat => ({
    value: cat.categoryId,
    text: cat.name
  }))
})

const rules = {
  categoryId: { rules: [{ required: true, errorMessage: '请选择分类' }] },
  title: { rules: [{ required: true, errorMessage: '请输入标题' }] },
  description: { rules: [{ required: true, errorMessage: '请输入描述' }] },
  location: { rules: [{ required: true, errorMessage: '请输入位置' }] },
  happenedTime: { rules: [{ required: true, errorMessage: '请选择时间' }] },
  campus: { rules: [{ required: true, errorMessage: '请输入校区' }] }
}

onMounted(async () => {
  try {
    const res = await getCategoryListApi()
    categoryList.value = res || []
  } catch (err) {
    console.error('加载分类失败', err)
  }
})

async function handleSubmit() {
  try {
    await formRef.value?.validate()
  } catch {
    return
  }

  loading.value = true
  try {
    const submitData = {
      categoryId: Number(formData.categoryId),
      itemType: formData.itemType,
      title: formData.title,
      description: formData.description,
      features: formData.features,
      location: formData.location,
      latitude: formData.latitude,
      longitude: formData.longitude,
      happenedTime: formData.happenedTime,
      campus: formData.campus,
      images: formData.images
    }
    await publishItemApi(submitData)
    uni.showToast({ title: '发布成功', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  } catch (err) {
    uni.showToast({ title: err.message || '发布失败', icon: 'none' })
  } finally {
    loading.value = false
  }
}
</script>

<style scoped lang="scss">
.publish-page {
  padding: $spacing-md;
  padding-bottom: 160rpx;
  background: $bg-white;
  min-height: 100vh;
}

.type-section {
  margin-bottom: $spacing-lg;
}

.section-label {
  font-size: $font-md;
  color: $text-primary;
  font-weight: 500;
  display: block;
  margin-bottom: $spacing-sm;
}

.type-chips {
  display: flex;
  gap: $spacing-md;
}

.chip {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: $spacing-xs;
  padding: 24rpx;
  border-radius: $radius-md;
  background: $bg-color;
  border: 2rpx solid $border-color;
  transition: all 0.2s;
}

.chip.active {
  background: rgba(74, 144, 217, 0.1);
  border-color: $primary-color;
}

.chip-icon {
  font-size: $font-xl;
}

.chip-text {
  font-size: $font-md;
  color: $text-secondary;
}

.chip.active .chip-text {
  color: $primary-color;
  font-weight: 500;
}

.form-item {
  margin-bottom: $spacing-lg;
  padding: 0;
}

.item-header {
  display: flex;
  align-items: center;
  margin-bottom: $spacing-sm;
}

.label {
  font-size: $font-md;
  color: $text-primary;
  font-weight: 500;
}

.required {
  color: $danger-color;
  margin-left: 4rpx;
}

.data-select {
  width: 100%;
}

.input {
  width: 100%;
}

.textarea {
  width: 100%;
}

.map-picker {
  margin-top: $spacing-sm;
}

.datetime-picker {
  width: 100%;
}

.submit-area {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  padding: $spacing-md;
  padding-bottom: calc($spacing-md + env(safe-area-inset-bottom));
  background: $bg-white;
  border-top: 1rpx solid $border-color;
}

.submit-btn {
  width: 100%;
  height: 88rpx;
  line-height: 88rpx;
  background: $primary-color;
  color: #fff;
  font-size: $font-lg;
  border-radius: $radius-md;
  border: none;
}
</style>