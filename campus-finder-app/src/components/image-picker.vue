<template>
  <view class="image-picker">
    <view class="grid">
      <view
        v-for="(url, index) in modelValue"
        :key="index"
        class="grid-item"
      >
        <image
          class="preview-img"
          :src="url"
          mode="aspectFill"
          @click="handlePreview(index)"
        />
        <view
          class="delete-btn"
          @click.stop="handleDelete(index)"
        >
          <text class="delete-icon">
            x
          </text>
        </view>
        <view
          v-if="uploadingMap[index] !== undefined"
          class="progress-overlay"
        >
          <view class="progress-bar">
            <view
              class="progress-fill"
              :style="{ width: uploadingMap[index] + '%' }"
            />
          </view>
          <text class="progress-text">
            {{ uploadingMap[index] }}%
          </text>
        </view>
      </view>

      <view
        v-if="modelValue.length < max"
        class="grid-item add-btn"
        @click="handleChoose"
      >
        <text class="add-icon">
          +
        </text>
        <text class="add-text">
          {{ modelValue.length }}/{{ max }}
        </text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { reactive } from 'vue'
import { uploadImage } from '@/api/upload.js'

const props = defineProps({
  max: {
    type: Number,
    default: 9
  },
  modelValue: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['update:modelValue'])

const uploadingMap = reactive({})

function handleChoose() {
  const remaining = props.max - props.modelValue.length
  if (remaining <= 0) return

  uni.chooseImage({
    count: remaining,
    sizeType: ['compressed'],
    sourceType: ['album', 'camera'],
    success: (res) => {
      const files = res.tempFilePaths
      files.forEach((filePath) => {
        compressAndUpload(filePath)
      })
    }
  })
}

function compressAndUpload(filePath) {
  const index = props.modelValue.length
  uploadingMap[index] = 0

  uni.compressImage({
    src: filePath,
    quality: 80,
    success: (compressed) => {
      doUpload(compressed.tempFilePath, index)
    },
    fail: () => {
      // fallback to original if compress fails
      doUpload(filePath, index)
    }
  })
}

function doUpload(filePath, index) {
  uploadImage(filePath, (percent) => {
    uploadingMap[index] = percent
  })
    .then((url) => {
      const newList = [...props.modelValue, url]
      emit('update:modelValue', newList)
      delete uploadingMap[index]
    })
    .catch((err) => {
      delete uploadingMap[index]
      uni.showToast({ title: err.message || '上传失败', icon: 'none' })
    })
}

function handleDelete(index) {
  uni.showModal({
    title: '提示',
    content: '确定删除这张图片吗？',
    success: (res) => {
      if (res.confirm) {
        const newList = props.modelValue.filter((_, i) => i !== index)
        emit('update:modelValue', newList)
      }
    }
  })
}

function handlePreview(index) {
  uni.previewImage({
    current: index,
    urls: props.modelValue
  })
}
</script>

<style scoped>
.image-picker {
  width: 100%;
}

.grid {
  display: flex;
  flex-wrap: wrap;
  gap: $spacing-sm;
}

.grid-item {
  position: relative;
  width: 200rpx;
  height: 200rpx;
  border-radius: $radius-md;
  overflow: hidden;
}

.preview-img {
  width: 100%;
  height: 100%;
}

.delete-btn {
  position: absolute;
  top: 0;
  right: 0;
  width: 40rpx;
  height: 40rpx;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 0 0 0 $radius-sm;
  display: flex;
  align-items: center;
  justify-content: center;
}

.delete-icon {
  color: #fff;
  font-size: 24rpx;
  line-height: 1;
}

.add-btn {
  background: $bg-color;
  border: 2rpx dashed $border-color;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.add-icon {
  font-size: $font-xxl;
  color: $text-placeholder;
  line-height: 1;
}

.add-text {
  font-size: $font-sm;
  color: $text-placeholder;
  margin-top: $spacing-xs;
}

.progress-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.45);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: $spacing-md;
}

.progress-bar {
  width: 100%;
  height: 8rpx;
  background: rgba(255, 255, 255, 0.3);
  border-radius: $radius-round;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: $primary-color;
  border-radius: $radius-round;
  transition: width 0.2s;
}

.progress-text {
  font-size: $font-sm;
  color: #fff;
  margin-top: $spacing-xs;
}
</style>
