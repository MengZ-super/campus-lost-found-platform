<template>
  <view class="image-carousel">
    <swiper
      class="swiper"
      :indicator-dots="true"
      :autoplay="true"
      :interval="3000"
      :circular="true"
      :indicator-color="indicatorColor"
      :indicator-active-color="indicatorActiveColor"
      @change="onChange"
    >
      <swiper-item
        v-for="(image, index) in images"
        :key="index"
        class="swiper-item"
        @click="previewImage(index)"
      >
        <image
          :src="image"
          mode="aspectFill"
          class="carousel-image"
          :lazy-load="true"
        />
      </swiper-item>
    </swiper>
    <view v-if="images.length > 1" class="image-counter">
      <text>{{ currentIndex + 1 }} / {{ images.length }}</text>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  images: {
    type: Array,
    default: () => []
  },
  indicatorColor: {
    type: String,
    default: 'rgba(255, 255, 255, 0.5)'
  },
  indicatorActiveColor: {
    type: String,
    default: '#ffffff'
  }
})

const currentIndex = ref(0)

const onChange = (e) => {
  currentIndex.value = e.detail.current
}

const previewImage = (index) => {
  if (props.images && props.images.length > 0) {
    uni.previewImage({
      current: index,
      urls: props.images
    })
  }
}
</script>

<style scoped>
.image-carousel {
  position: relative;
  width: 100%;
  height: 500rpx;
  background: #f5f5f5;
}

.swiper {
  width: 100%;
  height: 100%;
}

.swiper-item {
  width: 100%;
  height: 100%;
}

.carousel-image {
  width: 100%;
  height: 100%;
}

.image-counter {
  position: absolute;
  right: 24rpx;
  bottom: 24rpx;
  padding: 8rpx 20rpx;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 20rpx;
  font-size: $font-sm;
  color: #ffffff;
}
</style>