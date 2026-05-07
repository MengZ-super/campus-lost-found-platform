# Implementation Plan: UniApp 移动端替代 Flutter

## Overview

在 `campus-finder-app/` 目录下，用 UniApp + Vue 3 + uni-ui + Pinia 构建校园失物招领平台 App 端，替代现有 Flutter 实现。后端 API 已完备，前端管理端 API 层可复用，核心工作量在 UI 层重写。

## Architecture Decisions

- **请求封装**：`uni.request` + 拦截器模式，JWT token 存 `uni.setStorageSync`，401 自动刷新 + 请求队列重试
- **状态管理**：Pinia（非 Vuex），每个功能模块一个 store
- **页面路由**：`pages.json` 声明式配置，3 Tab 底部导航 + 二级页面
- **组件库**：uni-ui（不用 uView），按需引入
- **测试**：Vitest + @vue/test-utils + @pinia/testing

## Task List

### Phase 1: 项目脚手架与基础设施

---

#### Task 1: 初始化 UniApp 项目

**Description:** 用 `@dcloudio/uni-app` CLI 创建 Vue 3 项目骨架，安装核心依赖（pinia、@uni-ui/uni-ui），配置 ESLint 和 Vitest。

**Acceptance criteria:**
- [ ] `campus-finder-app/` 目录存在且可 `npm install` 成功
- [ ] `npm run dev:app-android` 可启动开发服务器（即使无页面内容）
- [ ] `npm run lint` 无报错
- [ ] `npm run test` 可执行（即使无测试用例）
- [ ] `src/pages.json` 配置了 3 个 Tab 页（首页、失物招领、我的）

**Verification:**
- [ ] `npm run dev:app-android` 启动无报错
- [ ] `npm run lint && npm run test` 通过

**Dependencies:** None

**Files likely touched:**
- `campus-finder-app/package.json`
- `campus-finder-app/vite.config.js`
- `campus-finder-app/eslint.config.js`
- `campus-finder-app/src/pages.json`
- `campus-finder-app/src/manifest.json`
- `campus-finder-app/src/App.vue`
- `campus-finder-app/src/main.js`

**Estimated scope:** Medium (3-5 files)

---

#### Task 2: API 请求封装 + JWT 拦截器

**Description:** 封装 `uni.request` 为统一请求模块，实现 JWT token 自动注入、401 自动刷新（含请求队列重试）、统一错误处理。参考前端管理端 `src/utils/request.js` 的逻辑。

**Acceptance criteria:**
- [ ] `api/request.js` 导出 `get`/`post`/`put`/`delete` 方法
- [ ] 请求自动携带 `Authorization: Bearer <token>` header
- [ ] 401 响应时自动调用 `/api/auth/refresh` 刷新 token
- [ ] 刷新期间其他请求排队，刷新后自动重试
- [ ] 刷新失败清除 token 并跳转登录页
- [ ] 接口响应统一解析 `{ code, message, data }` 格式

**Verification:**
- [ ] 单元测试：token 注入、401 刷新、队列重试（`tests/api/request.test.js`）
- [ ] 手动验证：用假 token 发请求，确认 401 处理流程

**Dependencies:** Task 1

**Files likely touched:**
- `campus-finder-app/src/api/request.js`
- `campus-finder-app/tests/api/request.test.js`

**Estimated scope:** Small (1-2 files)

---

#### Task 3: 工具函数（storage、date、validator）

**Description:** 实现三个工具模块——storage 封装（统一 get/set/remove）、日期格式化（相对时间、格式化输出）、表单校验（非空、长度、手机号等）。

**Acceptance criteria:**
- [ ] `utils/storage.js`：`get(key)` / `set(key, value)` / `remove(key)` 封装 `uni.setStorageSync`
- [ ] `utils/date.js`：`formatDate(date)` 输出 `YYYY-MM-DD`，`relativeTime(date)` 输出"刚刚/x分钟前/x小时前"
- [ ] `utils/validator.js`：`required` / `minLength` / `maxLength` / `phone` / `studentId` 校验函数
- [ ] 每个工具模块有对应单元测试

**Verification:**
- [ ] `npm run test` 全部通过

**Dependencies:** Task 1

**Files likely touched:**
- `campus-finder-app/src/utils/storage.js`
- `campus-finder-app/src/utils/date.js`
- `campus-finder-app/src/utils/validator.js`
- `campus-finder-app/tests/utils/*.test.js`

**Estimated scope:** Medium (3-5 files)

---

### Checkpoint: Foundation
- [ ] 项目可启动，Tab 导航可见
- [ ] API 请求封装完成，JWT 流程验证通过
- [ ] 工具函数测试全绿
- [ ] `npm run lint && npm run test` 通过

---

### Phase 2: 认证模块

---

#### Task 4: Auth API + Auth Store

**Description:** 实现认证相关的 API 封装（login/register/logout/refresh/me）和 Pinia auth store（token 管理、用户状态、登录/登出流程）。

**Acceptance criteria:**
- [ ] `api/auth.js` 封装 5 个认证接口
- [ ] `stores/auth.js` 管理 `token`、`refreshToken`、`user` 状态
- [ ] `login(username, password)` action：调用 API → 存储 token → 更新 user 状态
- [ ] `logout()` action：调用 API → 清除 token → 重置状态
- [ ] `checkAuth()` action：有 token 时调用 `/auth/me` 验证有效性
- [ ] store 测试覆盖登录成功、登录失败、登出、token 刷新

**Verification:**
- [ ] `tests/stores/auth.test.js` 全绿
- [ ] 手动验证：store 的 login/logout 状态流转

**Dependencies:** Task 2, Task 3

**Files likely touched:**
- `campus-finder-app/src/api/auth.js`
- `campus-finder-app/src/stores/auth.js`
- `campus-finder-app/tests/stores/auth.test.js`

**Estimated scope:** Small (1-2 files)

---

#### Task 5: 登录页 + 注册页

**Description:** 实现登录和注册页面，包含表单校验、错误提示、loading 状态、登录成功后跳转首页。

**Acceptance criteria:**
- [ ] 登录页：用户名/密码输入、表单校验、登录按钮、loading 状态、错误提示
- [ ] 注册页：用户名/密码/确认密码/手机号/学号/昵称输入、校验、注册成功跳转登录
- [ ] 登录成功后 `uni.switchTab` 跳转首页
- [ ] 未登录时访问 Tab 页自动跳转登录页（路由守卫）
- [ ] 使用 uni-ui 的 `uni-forms` / `uni-easyinput` 组件

**Verification:**
- [ ] 手动验证：登录 → 首页、注册 → 登录、未登录 → 登录页重定向
- [ ] 表单校验：空提交、密码不一致、手机号格式错误

**Dependencies:** Task 4

**Files likely touched:**
- `campus-finder-app/src/pages/auth/login.vue`
- `campus-finder-app/src/pages/auth/register.vue`
- `campus-finder-app/src/pages.json`（添加 auth 路由）

**Estimated scope:** Medium (3-5 files)

---

### Checkpoint: 认证流程
- [ ] 登录 → 首页流程通畅
- [ ] 注册 → 登录流程通畅
- [ ] token 持久化（重启 App 不丢失登录态）
- [ ] `npm run lint && npm run test` 通过

---

### Phase 3: 失物招领核心功能

---

#### Task 6: 通用组件（item-card、status-badge、empty-state）

**Description:** 实现三个通用组件，为列表和详情页做准备。

**Acceptance criteria:**
- [ ] `item-card.vue`：展示缩略图、标题、类型标签（失物/招领）、状态标签、位置、时间、统计（浏览/收藏/认领数）
- [ ] `status-badge.vue`：根据 status 值显示不同颜色标签（pending=黄、claimed=绿、closed=灰）
- [ ] `empty-state.vue`：接收 icon 和 message props，居中展示空状态
- [ ] 组件有 props 验证和默认值

**Verification:**
- [ ] 手动验证：在页面中引入组件，确认渲染正确
- [ ] 组件测试：props 传入后正确渲染（`tests/components/`）

**Dependencies:** Task 1

**Files likely touched:**
- `campus-finder-app/src/components/item-card.vue`
- `campus-finder-app/src/components/status-badge.vue`
- `campus-finder-app/src/components/empty-state.vue`
- `campus-finder-app/tests/components/item-card.test.js`

**Estimated scope:** Medium (3-5 files)

---

#### Task 7: Lost-Found API + Store（列表/详情/收藏）

**Description:** 实现失物招领的 API 封装和 Pinia store，覆盖列表加载、分页、搜索、筛选、详情获取、收藏切换。

**Acceptance criteria:**
- [ ] `api/lost-found.js` 封装列表/详情/搜索/收藏等接口
- [ ] `api/category.js` 封装分类列表接口
- [ ] `stores/lost-found.js` 管理列表状态（items、currentPage、hasMore、filters、keyword）
- [ ] `loadList()` action：加载第一页，重置分页
- [ ] `loadMore()` action：追加下一页到 items
- [ ] `setKeyword()` / `setFilter()` action：更新筛选条件并重新加载
- [ ] `toggleFavorite()` action：切换收藏状态并更新本地计数
- [ ] store 测试覆盖列表加载、分页、筛选、收藏

**Verification:**
- [ ] `tests/stores/lost-found.test.js` 全绿
- [ ] `tests/api/lost-found.test.js` 全绿

**Dependencies:** Task 2, Task 3, Task 4

**Files likely touched:**
- `campus-finder-app/src/api/lost-found.js`
- `campus-finder-app/src/api/category.js`
- `campus-finder-app/src/stores/lost-found.js`
- `campus-finder-app/tests/stores/lost-found.test.js`

**Estimated scope:** Medium (3-5 files)

---

#### Task 8: 失物招领列表页

**Description:** 实现 Tab 2 的列表页，包含搜索栏、类型筛选（失物/招领）、分类下拉、状态筛选、无限滚动列表。

**Acceptance criteria:**
- [ ] 顶部搜索栏（uni-search-bar），输入后 300ms 防抖触发搜索
- [ ] 类型筛选 chips（全部/失物/招领）
- [ ] 分类下拉选择（从 API 加载分类列表）
- [ ] 状态筛选 chips（全部/待认领/已认领/已关闭）
- [ ] 列表使用 item-card 组件，点击跳转详情页
- [ ] 触底自动加载更多（`onReachBottom`）
- [ ] 下拉刷新（`onPullDownRefresh`）
- [ ] 无数据时显示 empty-state

**Verification:**
- [ ] 手动验证：搜索、筛选、翻页、下拉刷新、触底加载
- [ ] 空状态展示正确

**Dependencies:** Task 6, Task 7

**Files likely touched:**
- `campus-finder-app/src/pages/lost-found/index.vue`

**Estimated scope:** Small (1-2 files)

---

#### Task 9: 物品详情页

**Description:** 实现详情页，展示物品完整信息、图片轮播、收藏按钮、认领申请入口。

**Acceptance criteria:**
- [ ] 图片轮播组件（image-carousel），支持左右滑动，显示页码指示器
- [ ] 信息卡片：标题、类型、状态、分类、位置、发生时间、描述、特征
- [ ] 统计栏：浏览数、收藏数、认领数
- [ ] 发布者信息卡片（头像、昵称）
- [ ] 收藏按钮（已收藏/未收藏切换）
- [ ] 底部操作栏：认领申请按钮（仅非本人且状态为 pending 时显示）
- [ ] 页面加载时调用详情 API

**Verification:**
- [ ] 手动验证：图片轮播、收藏切换、认领按钮显示/隐藏逻辑

**Dependencies:** Task 6, Task 7

**Files likely touched:**
- `campus-finder-app/src/pages/lost-found/detail.vue`
- `campus-finder-app/src/components/image-carousel.vue`

**Estimated scope:** Medium (3-5 files)

---

### Checkpoint: 列表 + 详情
- [ ] 列表页搜索、筛选、分页正常
- [ ] 详情页信息展示完整
- [ ] 收藏功能正常
- [ ] `npm run lint && npm run test` 通过

---

### Phase 4: 发布与编辑

---

#### Task 10: 图片选择器组件 + 上传 API

**Description:** 实现图片选择器组件（拍照/相册），支持多图选择、预览、删除，以及图片上传 API 封装。

**Acceptance criteria:**
- [ ] `image-picker.vue`：展示已选图片网格，点击"+"弹出选择（拍照/相册）
- [ ] 支持最多 9 张图片
- [ ] 选择后自动压缩（`uni.compressImage`，目标 < 1MB）
- [ ] 可预览大图（`uni.previewImage`）
- [ ] 可删除已选图片
- [ ] `api/upload.js`：封装 multipart/form-data 上传，返回图片 URL
- [ ] 上传中显示进度

**Verification:**
- [ ] 手动验证：选择图片 → 压缩 → 上传 → 获取 URL
- [ ] 边界测试：选满 9 张后禁用添加、删除后可重新添加

**Dependencies:** Task 2

**Files likely touched:**
- `campus-finder-app/src/components/image-picker.vue`
- `campus-finder-app/src/api/upload.js`

**Estimated scope:** Small (1-2 files)

---

#### Task 11: 地图选址组件

**Description:** 实现地图选址组件，使用 UniApp 原生 `map` 组件 + 高德 REST API（与 Flutter 端相同的 API），支持搜索选址和返回经纬度。

**Acceptance criteria:**
- [ ] `map-picker.vue`：搜索框 + 地图展示 + 搜索结果列表
- [ ] 搜索调用高德 inputtips API（与 Flutter 端 `amap_service.dart` 相同）
- [ ] 选择结果后返回 `{ latitude, longitude, address }`
- [ ] 支持 App 端（`#ifdef APP-PLUS` 条件编译如果需要）
- [ ] 组件可被 publish/edit 页面引用

**Verification:**
- [ ] 手动验证：搜索"食堂" → 选择 → 返回经纬度和地址

**Dependencies:** Task 1

**Files likely touched:**
- `campus-finder-app/src/components/map-picker.vue`

**Estimated scope:** Small (1-2 files)

---

#### Task 12: 发布页 + 编辑页

**Description:** 实现发布和编辑物品的表单页面，包含类型选择、分类、标题、描述、特征、图片上传、地图选址、日期选择、校区选择。

**Acceptance criteria:**
- [ ] 发布页：所有字段可填写，表单校验，提交后跳转列表页
- [ ] 编辑页：预填充已有数据，提交后返回详情页
- [ ] 表单字段：itemType（失物/招领）、categoryId、title、description、features、images、location、latitude、longitude、happenedTime、campus
- [ ] 使用 uni-ui 的 `uni-forms`、`uni-data-select`、`uni-datetime-picker` 组件
- [ ] 图片使用 image-picker 组件，地址使用 map-picker 组件
- [ ] 提交前前端校验（必填项、标题长度等）

**Verification:**
- [ ] 手动验证：填写完整表单 → 提交 → 列表页出现新物品
- [ ] 手动验证：编辑已有物品 → 预填充正确 → 修改后提交

**Dependencies:** Task 7, Task 10, Task 11

**Files likely touched:**
- `campus-finder-app/src/pages/lost-found/publish.vue`
- `campus-finder-app/src/pages/lost-found/edit.vue`

**Estimated scope:** Medium (3-5 files)

---

### Phase 5: 我的模块

---

#### Task 13: 我的发布页

**Description:** 实现"我的发布"页面，展示当前用户发布的物品列表，支持状态筛选和操作（关闭/重开/删除）。

**Acceptance criteria:**
- [ ] 顶部 Tab 切换：全部/待认领/已认领/已关闭
- [ ] 列表使用 item-card 组件
- [ ] 每个 item 可操作：关闭（弹窗输入原因）、重开、删除（确认弹窗）
- [ ] 操作后列表自动刷新
- [ ] 无数据时显示 empty-state

**Verification:**
- [ ] 手动验证：发布物品 → 我的发布可见 → 关闭/重开/删除操作正常

**Dependencies:** Task 6, Task 7, Task 12

**Files likely touched:**
- `campus-finder-app/src/pages/my/publishes.vue`

**Estimated scope:** Small (1-2 files)

---

#### Task 14: 我的认领页

**Description:** 实现"我的认领"页面，展示当前用户的认领申请列表，支持状态筛选和取消操作。

**Acceptance criteria:**
- [ ] 顶部 Tab 切换：全部/待审核/已通过/已拒绝/已取消
- [ ] 列表展示认领信息（物品标题、申请时间、状态、审核备注）
- [ ] 待审核状态的申请可取消（确认弹窗）
- [ ] 点击跳转物品详情页
- [ ] 无数据时显示 empty-state

**Verification:**
- [ ] 手动验证：提交认领 → 我的认领可见 → 取消操作正常

**Dependencies:** Task 6, Task 9

**Files likely touched:**
- `campus-finder-app/src/pages/my/claims.vue`

**Estimated scope:** Small (1-2 files)

---

#### Task 15: 认领申请弹窗

**Description:** 在详情页实现认领申请的底部弹窗表单，包含认领类型、描述、特征、联系方式、证明图片。

**Acceptance criteria:**
- [ ] 底部弹窗（`uni-popup`）展示认领表单
- [ ] 字段：claimType（认领/线索）、description、features、contact（必填）、proofImages
- [ ] 表单校验（联系方式必填）
- [ ] 提交后关闭弹窗，详情页刷新认领数
- [ ] `api/claim.js` 封装认领相关接口

**Verification:**
- [ ] 手动验证：详情页 → 点击认领 → 填写表单 → 提交成功

**Dependencies:** Task 9, Task 10

**Files likely touched:**
- `campus-finder-app/src/pages/lost-found/detail.vue`（修改已有文件）
- `campus-finder-app/src/api/claim.js`

**Estimated scope:** Small (1-2 files)

---

### Checkpoint: 核心功能完整
- [ ] 发布 → 列表 → 详情 → 认领 完整流程通畅
- [ ] 我的发布/我的认领 操作正常
- [ ] `npm run lint && npm run test` 通过

---

### Phase 6: 个人资料与收尾

---

#### Task 16: 首页 + 个人中心页

**Description:** 实现首页（快捷入口 + 最新物品）和个人中心页（头像、菜单导航）。

**Acceptance criteria:**
- [ ] 首页：4 个快捷入口卡片（发布失物、发布招领、我的发布、个人中心）+ 最新物品列表（取前 10 条）
- [ ] 个人中心页（Tab 3）：用户头像、昵称、菜单项（我的发布、我的认领、编辑资料、退出登录）
- [ ] 点击快捷入口跳转对应页面
- [ ] 退出登录确认弹窗 → 调用 logout → 跳转登录页

**Verification:**
- [ ] 手动验证：首页入口跳转、个人中心菜单跳转、退出登录流程

**Dependencies:** Task 4, Task 6, Task 7

**Files likely touched:**
- `campus-finder-app/src/pages/index/index.vue`
- `campus-finder-app/src/pages/my/index.vue`

**Estimated scope:** Small (1-2 files)

---

#### Task 17: 编辑资料页

**Description:** 实现个人资料编辑页面，支持修改昵称、头像、邮箱、性别、手机号。

**Acceptance criteria:**
- [ ] 页面加载时从 API 获取当前资料并填充
- [ ] 头像支持点击更换（调用 image-picker + upload）
- [ ] 表单字段：nickname、avatar、email、gender（选择器）、phone
- [ ] 提交后返回个人中心，更新显示
- [ ] `api/user.js` 封装用户 API

**Verification:**
- [ ] 手动验证：修改昵称/头像 → 提交 → 个人中心显示更新

**Dependencies:** Task 4, Task 10

**Files likely touched:**
- `campus-finder-app/src/pages/profile/edit.vue`
- `campus-finder-app/src/api/user.js`
- `campus-finder-app/src/stores/profile.js`

**Estimated scope:** Small (1-2 files)

---

#### Task 18: 全局样式与交互打磨

**Description:** 统一全局样式变量（主题色、间距、字号），优化加载状态、空状态、错误状态的展示，确保整体视觉达到中等水准。

**Acceptance criteria:**
- [ ] `uni.scss` 定义全局变量（主色、辅色、成功/警告/错误色、间距、字号）
- [ ] 所有页面使用统一的颜色和间距变量
- [ ] 加载状态统一使用 `uni-load-more` 或自定义 loading
- [ ] 空状态统一使用 empty-state 组件
- [ ] 页面间过渡自然，无明显视觉跳变

**Verification:**
- [ ] 手动验证：全流程走一遍，确认视觉一致性

**Dependencies:** 所有页面 Task 完成后

**Files likely touched:**
- `campus-finder-app/src/uni.scss`
- 各页面 `.vue` 文件的 `<style>` 部分

**Estimated scope:** Medium (多文件微调)

---

### Phase 7: 测试与验证

---

#### Task 19: 补充 API 层和 Store 测试

**Description:** 为所有 API 模块和 Pinia store 补充单元测试，确保核心逻辑覆盖。

**Acceptance criteria:**
- [ ] `tests/api/` 覆盖 auth、lost-found、claim、user、upload 的请求封装
- [ ] `tests/stores/` 覆盖 auth、lost-found、profile 的状态流转
- [ ] 测试用例覆盖：成功路径、错误路径、边界条件
- [ ] `npm run test` 全绿

**Verification:**
- [ ] `npm run test` 通过，无 skip/todo

**Dependencies:** 所有功能 Task

**Files likely touched:**
- `campus-finder-app/tests/api/*.test.js`
- `campus-finder-app/tests/stores/*.test.js`

**Estimated scope:** Medium (3-5 files)

---

#### Task 20: 端到端手动验证

**Description:** 在 Android 模拟器/真机上走完所有核心流程，记录并修复发现的问题。

**Acceptance criteria:**
- [ ] 注册 → 登录 → 首页 → 发布物品 → 列表查看 → 详情 → 收藏 → 认领 → 我的发布 → 我的认领 → 编辑资料 → 退出登录 全流程通畅
- [ ] 边界场景：无网络提示、空数据展示、表单校验错误提示
- [ ] 无 JS 报错（控制台无红色错误）

**Verification:**
- [ ] 全流程录屏或截图确认

**Dependencies:** 所有功能 Task

**Files likely touched:** Bug fix 时涉及的文件

**Estimated scope:** 不确定（取决于发现的问题）

---

## Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| uni-ui App 端视觉不达标 | Medium | Task 18 专门做样式打磨，必要时手写关键组件 |
| 高德地图组件在 App 端行为不一致 | Medium | Task 11 先做 POC，不行就退回 REST API 文本搜索（与 Flutter 端一致） |
| uni.request 封装复杂度超预期 | Low | 参考前端管理端 axios 拦截器逻辑，模式相同 |
| 图片压缩/上传在某些机型异常 | Low | 使用 uni-app 官方 API，兼容性有保障 |

## Parallelization Opportunities

以下 Task 可并行开发（无依赖关系）：
- **Task 2 + Task 3**：API 封装和工具函数互相独立
- **Task 6 + Task 7**：通用组件和 store 互相独立
- **Task 10 + Task 11**：图片选择器和地图选址互相独立
- **Task 13 + Task 14 + Task 15**：我的发布、我的认领、认领弹窗互相独立
