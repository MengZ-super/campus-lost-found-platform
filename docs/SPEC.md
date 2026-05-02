# UniApp 移动端开发规范

> 本规范基于 [docs/ideas/uniapp-migration.md](docs/ideas/uniapp-migration.md) 方案，指导 campus-finder-app 的实现。

## 1. Objective

用 UniApp 替代 Flutter，为校园失物招领平台交付 App 端（Android/iOS），验证后扩展微信小程序。

**目标用户：** 校园师生——发布失物/招领信息、搜索浏览、认领物品、管理个人发布。

**成功标准：**
- MVP 覆盖 Flutter 端全部核心功能（认领审核、推送除外）
- App 真机运行流畅，UI 达到中等水准
- 代码结构清晰，后续可直接扩展小程序端

## 2. Commands

### 开发环境

```bash
# 安装依赖（在 campus-finder-app/ 目录下）
npm install

# 运行到 Android 真机/模拟器
npm run dev:app-android

# 运行到 iOS 真机/模拟器（macOS）
npm run dev:app-ios

# 运行到微信小程序（后续扩展）
npm run dev:mp-weixin
```

### 构建打包

```bash
# 构建 Android App
npm run build:app-android

# 构建 iOS App
npm run build:app-ios

# 构建微信小程序（后续扩展）
npm run build:mp-weixin
```

### 代码质量

```bash
# ESLint 检查
npm run lint

# 运行单元测试
npm run test
```

## 3. Project Structure

```
campus-finder-app/                  # UniApp 项目根目录
├── src/
│   ├── pages/                      # 页面（按功能模块组织）
│   │   ├── index/                  # 首页（Tab 1）
│   │   │   └── index.vue
│   │   ├── lost-found/             # 失物招领列表（Tab 2）
│   │   │   ├── index.vue           # 列表页
│   │   │   ├── detail.vue          # 详情页
│   │   │   ├── publish.vue         # 发布页
│   │   │   └── edit.vue            # 编辑页
│   │   ├── my/                     # 我的（Tab 3）
│   │   │   ├── index.vue           # 个人中心
│   │   │   ├── publishes.vue       # 我的发布
│   │   │   └── claims.vue          # 我的认领
│   │   ├── auth/                   # 认证
│   │   │   ├── login.vue
│   │   │   └── register.vue
│   │   └── profile/                # 个人资料
│   │       └── edit.vue
│   ├── components/                 # 通用组件
│   │   ├── item-card.vue           # 物品卡片
│   │   ├── status-badge.vue        # 状态标签
│   │   ├── image-carousel.vue      # 图片轮播
│   │   ├── image-picker.vue        # 图片选择器
│   │   ├── empty-state.vue         # 空状态
│   │   └── map-picker.vue          # 地图选址
│   ├── api/                        # API 封装
│   │   ├── request.js              # uni.request 封装（JWT 拦截器）
│   │   ├── auth.js                 # 认证 API
│   │   ├── lost-found.js           # 失物招领 API
│   │   ├── claim.js                # 认领 API
│   │   ├── user.js                 # 用户 API
│   │   └── upload.js               # 上传 API
│   ├── stores/                     # Pinia 状态管理
│   │   ├── auth.js                 # 认证状态（token、用户信息）
│   │   ├── lost-found.js           # 失物招领列表/详情
│   │   └── profile.js              # 个人资料
│   ├── utils/                      # 工具函数
│   │   ├── storage.js              # uni.setStorageSync 封装
│   │   ├── date.js                 # 日期格式化
│   │   └── validator.js            # 表单校验
│   ├── static/                     # 静态资源
│   ├── App.vue                     # 应用入口
│   ├── main.js                     # 主入口
│   ├── pages.json                  # 页面路由配置
│   ├── manifest.json               # 应用配置
│   └── uni.scss                    # 全局样式变量
├── tests/                          # 测试
│   ├── api/                        # API 层测试
│   ├── stores/                     # Pinia store 测试
│   └── components/                 # 关键组件交互测试
├── package.json
├── vite.config.js
└── eslint.config.js
```

### 关键约定

- **页面文件命名**：kebab-case，与路由路径一致（`pages/lost-found/detail.vue` → `/pages/lost-found/detail`）
- **组件文件命名**：kebab-case（`item-card.vue`）
- **Store 命名**：与页面模块对应（`stores/auth.js`、`stores/lost-found.js`）
- **API 命名**：按后端模块对应（`api/auth.js`、`api/lost-found.js`）

## 4. Code Style

### Vue 组件规范

```vue
<template>
  <!-- 使用 uni-ui 组件，class 用 kebab-case -->
  <view class="lost-found-list">
    <uni-search-bar @confirm="onSearch" />
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useLostFoundStore } from '@/stores/lost-found'

// store
const store = useLostFoundStore()

// 本地状态
const keyword = ref('')

// 方法
const onSearch = (e) => {
  store.setKeyword(e.value)
  store.loadList()
}

// 生命周期
onMounted(() => {
  store.loadList()
})
</script>

<style scoped>
/* 使用 rpx 单位适配多端 */
.lost-found-list {
  padding: 24rpx;
}
</style>
```

### 规范要点

- **Composition API + `<script setup>`**：统一使用，不用 Options API
- **单位**：用 `rpx` 做响应式布局，不用 `px`
- **状态管理**：用 Pinia，不用 Vuex
- **条件编译**：用 `#ifdef` / `#ifndef` 处理平台差异，集中在少量文件中
- **API 调用**：统一通过 `api/` 目录封装，页面不直接调用 `uni.request`
- **错误处理**：API 层统一 catch，页面通过 store 的 error 状态展示
- **注释**：不写显而易见的注释，只在非直觉逻辑处说明 why

### 与后端对接

- Base URL 配置在 `api/request.js`，通过环境变量切换
- JWT token 存储在 `uni.setStorageSync('token', ...)`
- 401 响应自动刷新 token，刷新失败跳转登录页
- 接口格式：`{ code, message, data, timestamp }`（与现有后端一致）

## 5. Testing Strategy

### 测试框架

- **Vitest**：单元测试运行器（与 Vite 生态一致）
- **@vue/test-utils**：Vue 组件测试
- **pinia testing**：store 测试（`@pinia/testing`）

### 测试范围

| 层级 | 覆盖什么 | 优先级 |
|------|---------|--------|
| API 层 | 请求封装、token 注入、401 刷新、错误处理 | 高 |
| Store | 状态流转、列表加载/翻页/筛选、认领/收藏操作 | 高 |
| 组件交互 | 关键用户流程（登录、发布、认领提交） | 中 |
| UI 测试 | 不做 | — |

### 测试示例

```js
// tests/stores/lost-found.test.js
import { describe, it, expect, vi } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'
import { useLostFoundStore } from '@/stores/lost-found'

describe('lost-found store', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
  })

  it('加载列表后更新 items 和分页状态', async () => {
    const store = useLostFoundStore()
    vi.spyOn(store, 'fetchList').mockResolvedValue({
      records: [{ id: 1, title: '丢失钱包' }],
      current: 1, pages: 1, total: 1
    })
    await store.loadList()
    expect(store.items).toHaveLength(1)
    expect(store.hasMore).toBe(false)
  })
})
```

## 6. Boundaries

### Always（始终做）

- 所有 API 调用通过 `api/` 封装层，不裸用 `uni.request`
- 用 Pinia 管理跨页面共享状态，不用全局变量
- 图片上传前做压缩（`uni.compressImage`），控制在 1MB 以内
- 表单提交前做前端校验，不依赖后端校验
- 页面使用 `onPullDownRefresh` / `onReachBottom` 处理下拉刷新和无限滚动
- 样式用 scoped，避免全局污染

### Ask First（先问再做）

- 需要条件编译（`#ifdef`）处理平台差异时，先确认影响范围
- 引入新的 npm 依赖（非 uni-ui 内置）时，先评估包大小和多端兼容性
- 修改 `pages.json` 路由配置时，先确认对 Tab 导航的影响
- 涉及原生插件（地图、推送）时，先做 POC 验证

### Never（不做）

- 不在页面中直接调用 `uni.request`，必须通过 API 层
- 不用 Options API（`data()`、`methods`、`computed` 写法），统一 `<script setup>`
- 不引入 uView Plus 或其他 UI 框架，统一用 uni-ui
- 不写 UI 自动化测试（MVP 阶段）
- 不做小程序条件编译优化（MVP 阶段只关注 App 端）
- 不在前端做复杂业务逻辑计算，复杂逻辑留给后端
