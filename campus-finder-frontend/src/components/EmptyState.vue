<template>
  <div class="empty-state">
    <img :src="emptyImg" alt="暂无数据" class="empty-img" />
    <h3 v-if="title">{{ title }}</h3>
    <p v-if="description">{{ description }}</p>
    <el-button v-if="actionText" type="primary" @click="$emit('action')">
      {{ actionText }}
    </el-button>
  </div>
</template>

<script setup>
import emptyImg from '@/assets/images/empty-state.png'

defineProps({
  title: {
    type: String,
    default: '暂无数据'
  },
  description: {
    type: String,
    default: '这里还没有任何内容哦~'
  },
  actionText: {
    type: String,
    default: ''
  }
})

defineEmits(['action'])
</script>

<style scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 48px 24px;
  text-align: center;
}

.empty-img {
  width: 200px;
  height: auto;
  max-width: 100%;
  opacity: 0.7;
  margin-bottom: 16px;
}

.empty-state h3 {
  font-size: 16px;
  font-weight: 600;
  color: #606266;
  margin: 0 0 8px;
}

.empty-state p {
  font-size: 14px;
  color: #909399;
  margin: 0 0 16px;
}
</style>
