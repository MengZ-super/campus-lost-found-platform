import { get } from './request.js'

export function getCategoryListApi() {
  return get('/lost/category/list')
}
