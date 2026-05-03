<template>
  <view class="edit-page">
    <view class="avatar-section">
      <view
        class="avatar-wrapper"
        @click="handleAvatarClick"
      >
        <image
          class="avatar-img"
          :src="formData.avatar || defaultAvatar"
          mode="aspectFill"
        />
        <view class="avatar-mask">
          <text class="avatar-tip">
            点击更换
          </text>
        </view>
      </view>
      <view
        v-if="uploadingAvatar"
        class="avatar-progress"
      >
        <view class="progress-bar">
          <view
            class="progress-fill"
            :style="{ width: uploadProgress + '%' }"
          />
        </view>
        <text class="progress-text">
          {{ uploadProgress }}%
        </text>
      </view>
    </view>

    <uni-forms
      ref="formRef"
      :model-value="formData"
      :rules="rules"
    >
      <uni-forms-item name="nickname">
        <uni-easyinput
          v-model="formData.nickname"
          placeholder="请输入昵称"
          prefix-icon="person"
        />
      </uni-forms-item>

      <uni-forms-item name="phone">
        <uni-easyinput
          v-model="formData.phone"
          placeholder="请输入手机号"
          prefix-icon="phone"
          type="number"
          maxlength="11"
        />
      </uni-forms-item>

      <uni-forms-item name="email">
        <uni-easyinput
          v-model="formData.email"
          placeholder="请输入邮箱"
          prefix-icon="email"
          type="text"
        />
      </uni-forms-item>

      <uni-forms-item name="gender">
        <view class="gender-options">
          <view
            v-for="item in genderOptions"
            :key="item.value"
            class="gender-item"
            :class="{ active: formData.gender === item.value }"
            @click="formData.gender = item.value"
          >
            <text>{{ item.label }}</text>
          </view>
        </view>
      </uni-forms-item>
    </uni-forms>

    <button
      class="save-btn"
      type="primary"
      :loading="saving"
      :disabled="saving"
      @click="handleSave"
    >
      保存
    </button>
  </view>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useProfileStore } from '@/stores/profile.js'
import { uploadImage } from '@/api/upload.js'

const profileStore = useProfileStore()
const formRef = ref(null)
const saving = ref(false)
const uploadingAvatar = ref(false)
const uploadProgress = ref(0)
const defaultAvatar = 'https://cdn-icons-png.flaticon.com/512/149/149071.png'

const formData = reactive({
  nickname: '',
  avatar: '',
  phone: '',
  email: '',
  gender: 0
})

const genderOptions = [
  { label: '未设置', value: 0 },
  { label: '男', value: 1 },
  { label: '女', value: 2 }
]

const rules = {
  nickname: { rules: [{ required: true, errorMessage: '请输入昵称' }] },
  phone: {
    rules: [
      { pattern: /^1[3-9]\d{9}$/, errorMessage: '请输入正确的手机号' }
    ]
  },
  email: {
    rules: [
      { format: 'email', errorMessage: '请输入正确的邮箱' }
    ]
  }
}

onMounted(async () => {
  try {
    await profileStore.fetchProfile()
    const p = profileStore.profile || {}
    formData.nickname = p.nickname || ''
    formData.avatar = p.avatar || ''
    formData.phone = p.phone || ''
    formData.email = p.email || ''
    formData.gender = p.gender ?? 0
  } catch (err) {
    uni.showToast({ title: err.message || '加载资料失败', icon: 'none' })
  }
})

function handleAvatarClick() {
  uni.chooseImage({
    count: 1,
    sizeType: ['compressed'],
    sourceType: ['album', 'camera'],
    success: (res) => {
      const filePath = res.tempFilePaths[0]
      doUploadAvatar(filePath)
    }
  })
}

function doUploadAvatar(filePath) {
  uploadingAvatar.value = true
  uploadProgress.value = 0

  uni.compressImage({
    src: filePath,
    quality: 80,
    success: (compressed) => {
      uploadAvatarFile(compressed.tempFilePath)
    },
    fail: () => {
      uploadAvatarFile(filePath)
    }
  })
}

function uploadAvatarFile(filePath) {
  uploadImage(filePath, (percent) => {
    uploadProgress.value = percent
  })
    .then((url) => {
      formData.avatar = url
      uploadingAvatar.value = false
    })
    .catch((err) => {
      uploadingAvatar.value = false
      uni.showToast({ title: err.message || '头像上传失败', icon: 'none' })
    })
}

async function handleSave() {
  try {
    await formRef.value?.validate()
  } catch {
    return
  }

  saving.value = true
  try {
    await profileStore.updateProfile({
      nickname: formData.nickname,
      avatar: formData.avatar,
      phone: formData.phone,
      email: formData.email,
      gender: formData.gender
    })
    uni.showToast({ title: '保存成功', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  } catch (err) {
    uni.showToast({ title: err.message || '保存失败', icon: 'none' })
  } finally {
    saving.value = false
  }
}
</script>

<style scoped>
.edit-page {
  padding: 32rpx 48rpx;
  min-height: 100vh;
  background: #fff;
}

.avatar-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 48rpx;
}

.avatar-wrapper {
  position: relative;
  width: 160rpx;
  height: 160rpx;
  border-radius: 80rpx;
  overflow: hidden;
}

.avatar-img {
  width: 100%;
  height: 100%;
}

.avatar-mask {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.2s;
}

.avatar-wrapper:active .avatar-mask {
  opacity: 1;
}

.avatar-tip {
  font-size: 24rpx;
  color: #fff;
}

.avatar-progress {
  margin-top: 16rpx;
  width: 160rpx;
}

.progress-bar {
  height: 4rpx;
  background: $border-color;
  border-radius: 2rpx;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: $primary-color;
  transition: width 0.2s;
}

.progress-text {
  display: block;
  text-align: center;
  font-size: 20rpx;
  color: $text-placeholder;
  margin-top: 4rpx;
}

.gender-options {
  display: flex;
  gap: 24rpx;
}

.gender-item {
  padding: 12rpx 32rpx;
  border: 2rpx solid $border-color;
  border-radius: $radius-md;
  font-size: 28rpx;
  color: $text-secondary;
}

.gender-item.active {
  border-color: $primary-color;
  color: $primary-color;
  background: rgba(74, 144, 217, 0.08);
}

.save-btn {
  margin-top: 48rpx;
  background-color: $primary-color;
  border-radius: $radius-md;
  height: 88rpx;
  line-height: 88rpx;
  font-size: 32rpx;
}
</style>