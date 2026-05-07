import { defineStore } from 'pinia'
import { ref, reactive } from 'vue'
import { getItemListApi, addFavoriteApi } from '@/api/lost-found.js'

export const useLostFoundStore = defineStore('lost-found', () => {
  const items = ref([])
  const loading = ref(false)
  const error = ref(null)
  const keyword = ref('')
  const currentPage = ref(0)
  const totalPages = ref(0)
  const total = ref(0)
  const hasMore = ref(true)

  const filters = reactive({
    itemType: '',
    status: '',
    categoryId: '',
    sortBy: 'newest'
  })

  const pageSize = 10

  async function loadList(params) {
    loading.value = true
    error.value = null
    try {
      const query = {
        pageNum: 1,
        pageSize,
        keyword: keyword.value,
        ...filters,
        ...params
      }
      const res = await getItemListApi(query)
      items.value = res.records || []
      currentPage.value = res.current || 1
      totalPages.value = res.pages || 0
      total.value = res.total || 0
      hasMore.value = currentPage.value < totalPages.value
    } catch (err) {
      error.value = err.message
    } finally {
      loading.value = false
    }
  }

  async function loadMore(params) {
    if (!hasMore.value || loading.value) return
    loading.value = true
    error.value = null
    try {
      const query = {
        pageNum: currentPage.value + 1,
        pageSize,
        keyword: keyword.value,
        ...filters,
        ...params
      }
      const res = await getItemListApi(query)
      items.value = [...items.value, ...(res.records || [])]
      currentPage.value = res.current || currentPage.value + 1
      totalPages.value = res.pages || 0
      total.value = res.total || 0
      hasMore.value = currentPage.value < totalPages.value
    } catch (err) {
      error.value = err.message
    } finally {
      loading.value = false
    }
  }

  function setKeyword(value) {
    keyword.value = value
  }

  function setFilter(filterObj) {
    Object.assign(filters, filterObj)
  }

  async function toggleFavorite(id) {
    await addFavoriteApi(id)
    const item = items.value.find((i) => i.id === id)
    if (item) {
      item.favoriteCount = (item.favoriteCount || 0) + 1
      item.isFavorited = true
    }
  }

  return {
    items, loading, error, keyword, currentPage, totalPages, total, hasMore, filters,
    loadList, loadMore, setKeyword, setFilter, toggleFavorite
  }
})
