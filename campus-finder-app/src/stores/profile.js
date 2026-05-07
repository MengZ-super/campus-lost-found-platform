import { defineStore } from 'pinia'
import { ref } from 'vue'
import { getProfileApi, updateProfileApi } from '@/api/user.js'
import { useAuthStore } from './auth.js'

export const useProfileStore = defineStore('profile', () => {
  const profile = ref(null)
  const loading = ref(false)
  const error = ref(null)

  async function fetchProfile() {
    loading.value = true
    error.value = null
    try {
      profile.value = await getProfileApi()
    } catch (err) {
      error.value = err.message || '获取资料失败'
      throw err
    } finally {
      loading.value = false
    }
  }

  async function updateProfile(data) {
    loading.value = true
    error.value = null
    try {
      const updated = await updateProfileApi(data)
      profile.value = updated
      // sync to auth store
      const authStore = useAuthStore()
      authStore.setUser({ ...authStore.user, ...updated })
      return updated
    } catch (err) {
      error.value = err.message || '更新资料失败'
      throw err
    } finally {
      loading.value = false
    }
  }

  return { profile, loading, error, fetchProfile, updateProfile }
})