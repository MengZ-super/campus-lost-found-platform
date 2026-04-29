<script setup>
import { ref } from 'vue'
import logoImg from '@/assets/images/logo.png'

const count = ref(0)
</script>

<template>
  <section id="center">
    <div class="hero">
      <img :src="logoImg" class="base" width="200" height="60" alt="Campus Finder Logo" />
    </div>
    <div>
      <h1>校园失物招领平台</h1>
      <p>让失物回到主人手中</p>
    </div>
    <button class="counter" @click="count++">Count is {{ count }}</button>
  </section>
</template>
