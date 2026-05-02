# 实施计划：校园失物招领 Flutter 移动端

## 总体策略

分 6 个阶段，由底向上构建。每个阶段有明确的验证标准，阶段内任务按依赖排序。阶段间串行，阶段内可部分并行。

**关键原则**：
- 后端先改（坐标字段），前端才能跟进地图功能
- 基础层（API Client / Models / Auth）必须最先做，所有上层功能依赖
- 每个页面完成即验证，不积累集成问题

---

## 阶段总览

```
Phase A: 基础设施     (后端坐标字段 + Flutter 项目骨架 + API Client + Models)
    ↓
Phase B: 认证系统     (Auth BLoC + 登录/注册/启动页 + 路由守卫)
    ↓
Phase C: 核心功能     (首页 + 列表 + 详情 + 发布 + 编辑 + 图片上传 + 地图选点)
    ↓
Phase D: 认领 + 我的  (认领申请/审核 + 我的发布 + 我的申请)
    ↓
Phase E: 个人中心     (资料编辑 + 修改密码)
    ↓
Phase F: 推送 + 收尾  (JPush 集成 + App 图标 + 最终测试)
```

---

## Phase A: 基础设施

**目标**：后端支持坐标字段，Flutter 项目能编译，HTTP 请求链路打通。

### Task A1: 后端新增坐标字段

- **内容**：
  - `biz_lost_found` 表新增 `latitude DOUBLE` 和 `longitude DOUBLE` 字段（ALTER TABLE SQL）
  - `LostFound` 实体新增对应属性
  - `CreateLostFoundRequest` 新增 `latitude`/`longitude`（选填，Double）
  - `UpdateLostFoundRequest` 新增 `latitude`/`longitude`（选填，Double）
  - `LostFoundDTO` 新增 `latitude`/`longitude`
- **验证**：Maven 编译通过，启动后端，`GET /api/lost/{id}` 返回数据包含 `latitude`/`longitude` 字段
- **文件**：`sql/migration/`, `LostFound.java`, `CreateLostFoundRequest.java`, `UpdateLostFoundRequest.java`, `LostFoundDTO.java`

### Task A2: Flutter 项目初始化

- **内容**：`flutter create` 创建项目，配置 `pubspec.yaml` 依赖，建目录结构
- **依赖**：`flutter_bloc`, `dio`, `go_router`, `flutter_secure_storage`, `image_picker`, `freezed`, `json_serializable`, `amap_flutter_map`, `jpush_flutter`
- **验证**：`flutter analyze` 通过，`flutter build apk --debug` 成功
- **文件**：`pubspec.yaml`, `lib/main.dart`, `lib/app.dart`, 整个目录结构

### Task A3: Models + JSON 序列化

- **内容**：定义所有数据模型（Dart class），freezed 不可变 + json_serializable 序列化
  - `common.dart` — `Result<T>`, `PageData<T>`
  - `user.dart` — `User`, `UserProfile`, `AuthResponse`, `LoginRequest`, `RegisterRequest`
  - `lost_found.dart` — `LostFoundItem`, `CreateLostFoundRequest`, `UpdateLostFoundRequest`
  - `claim.dart` — `Claim`, `CreateClaimRequest`, `ReviewClaimRequest`
  - `category.dart` — `Category`
- **验证**：`flutter pub run build_runner build` 成功，模型文件生成 `.g.dart` / `.freezed.dart`
- **文件**：`lib/models/*.dart`

### Task A4: API Client (Dio + Interceptor)

- **内容**：
  - `api_client.dart`：Dio 实例，配置 baseURL、超时
  - Request Interceptor：从 SecureStorage 读 accessToken → 注入 `Authorization: Bearer`
  - Response Interceptor：拦截 401 → 队列机制自动 refresh → 重放请求（参考 Web 端 axios interceptor）
  - 统一错误处理：`Result.code` 非 200 → 抛业务异常
- **验证**：手动测试（配合后续 Task），401 刷新逻辑可单独单元测试
- **文件**：`lib/services/api_client.dart`, `lib/config/api_config.dart`

### Task A5: Secure Storage 封装

- **内容**：封装 `flutter_secure_storage` 的读写操作，提供 `saveToken`/`getAccessToken`/`getRefreshToken`/`clearAll`
- **验证**：单元测试
- **文件**：`lib/services/token_storage.dart`

---

## Phase B: 认证系统

**目标**：用户可以注册、登录、自动登录，路由有权限守卫。

### Task B1: Auth Service

- **内容**：`auth_service.dart` — 封装所有 `/api/auth/*` 调用（login, register, logout, refresh, me）
- **验证**：单元测试（mock Dio）
- **文件**：`lib/services/auth_service.dart`

### Task B2: Auth BLoC

- **内容**：
  - `AuthState`：initial / loading / authenticated(User) / unauthenticated(error?)
  - `AuthEvent`：AppStarted, LoginRequested, RegisterRequested, LogoutRequested
  - `AuthBloc`：处理登录→写 Token→emit authenticated；AppStarted→读 Token→调 /me→验证
- **验证**：`bloc_test` 单元测试覆盖各状态转换
- **文件**：`lib/blocs/auth/`

### Task B3: SplashPage + LoginPage + RegisterPage

- **内容**：
  - SplashPage：App Logo + 应用名，触发 `AppStarted` 事件，根据结果跳转
  - LoginPage：用户名 + 密码 → 触发 `LoginRequested` → 成功后跳首页
  - RegisterPage：完整注册表单（用户名/手机号/学号/昵称/密码/确认密码）→ 触发 `RegisterRequested`
- **验证**：Widget 测试 + 手动真机测试（注册→登录→首页全流程）
- **文件**：`lib/pages/splash/`, `lib/pages/auth/`

### Task B4: go_router 路由配置 + 守卫

- **内容**：
  - 定义所有路由（12 个页面）
  - `AuthGuard`：未登录 → 重定向到登录页，带 `redirect` 参数
  - BottomNavigationBar 的三条路由（首页/失物招领/我的）用 `StatefulShellRoute` 保持 Tab 状态
- **验证**：手动测试：未登录访问首页 → 跳登录页；登录后访问登录页 → 跳首页
- **文件**：`lib/app.dart`, `lib/config/router.dart`

---

## Phase C: 核心功能

**目标**：用户可以浏览列表、查看详情、发布物品、编辑物品。

### Task C1: Category Service + Upload Service

- **内容**：
  - `category_service.dart`：`getList()` → 分类列表
  - `upload_service.dart`：`upload(File)` → multipart 上传 → 返回 URL
- **验证**：单元测试
- **文件**：`lib/services/category_service.dart`, `lib/services/upload_service.dart`

### Task C2: LostFound Service

- **内容**：封装所有 `/api/lost/*` 调用（list, search, detail, publish, update, delete, close, reopen, favorite, unfavorite, favorites）
- **验证**：单元测试
- **文件**：`lib/services/lost_found_service.dart`

### Task C3: Common Widgets

- **内容**：
  - `item_card.dart`：物品卡片（缩略图 + 状态标签 + 标题截断 + 位置/日期 + 统计）
  - `status_badge.dart`：状态彩色标签
  - `image_carousel.dart`：图片轮播（PageView + 指示器）
  - `empty_state.dart`：空状态插图 + 文案
  - `error_widget.dart`：错误重试
  - `paginated_list.dart`：上拉加载更多（ScrollController 监听滚动到底部）
  - `image_picker_sheet.dart`：底部弹窗（相册/相机选择 → image_picker → 压缩 → 上传 → 返回 URL）
- **验证**：Widget 测试（item_card 不同状态渲染、image_carousel 滑动）
- **文件**：`lib/widgets/`

### Task C4: HomePage

- **内容**：欢迎语 + 4 功能卡片 + 2 快捷入口 + BottomNavigationBar
- **验证**：Widget 测试 + 手动测试（四个卡片跳转正确）
- **文件**：`lib/pages/home/`

### Task C5: LostFoundListPage

- **内容**：
  - 搜索框（防抖 300ms）
  - 类型 Tab（全部/寻物/招领）
  - 分类筛选下拉
  - 状态筛选 Chip
  - 2 列瀑布流/网格卡片
  - 上拉加载更多（pageNum++）
  - FAB 发布按钮
- **BLoC**：`LostFoundListBloc` — LoadList, SearchChanged, FilterChanged, LoadMore
- **验证**：手动真机测试（搜索/筛选/分页/点击跳转详情）
- **文件**：`lib/pages/lost_found/list_page.dart`, `lib/blocs/lost_found/`

### Task C6: LostFoundDetailPage

- **内容**：
  - 图片轮播
  - 元信息区（分类/类型/位置/时间/校区）
  - 描述 + 特征
  - 发布者信息 + 统计（浏览量/收藏数/认领数）
  - 操作区：收藏（toggle）、编辑/关闭（owner）、申请认领（非 owner）
  - 收藏状态实时更新
- **BLoC**：`LostFoundDetailBloc` — LoadDetail, ToggleFavorite
- **验证**：手动测试（各种状态组合：owner/非owner、pending/claimed/closed）
- **文件**：`lib/pages/lost_found/detail_page.dart`, `lib/blocs/lost_found/`

### Task C7: Image Picker + Upload Flow

- **内容**：
  - `image_picker_sheet.dart`：拍照 / 相册选择 → 限制 5MB/JPEG/PNG → 显示上传进度 → 返回 URL 列表
  - 网格展示已选图片（可删除/重排）
- **验证**：手动测试（选图→上传→预览→删除）
- **文件**：`lib/widgets/image_picker_sheet.dart`

### Task C8: PublishLostFoundPage

- **内容**：
  - 完整表单（类型/分类/标题/描述/图片/特征/地点/时间/校区）
  - 图片上传集成（Task C7 组件）
  - **地图选点集成**（Task C9 组件）
  - 表单校验（所有必填项 + 长度限制）
  - 提交 → POST /api/lost/publish → 跳详情页
- **验证**：手动真机测试（完整发布流程含图片上传和地图选点）
- **文件**：`lib/pages/lost_found/publish_page.dart`

### Task C9: EditLostFoundPage

- **内容**：表单同发布页、类型禁用、已有数据预填充
- **验证**：手动测试（编辑→保存→回详情页验证）
- **文件**：`lib/pages/lost_found/edit_page.dart`

### Task C10: Map Picker 组件

- **内容**：
  - `map_picker.dart`：全屏高德地图页面
  - 顶部搜索栏（地址搜索 → 移动到搜索结果坐标）
  - 地图中央十字准星 + 底部当前地址文字
  - 确认按钮 → 回传 `{latitude, longitude, address}` 给发布/编辑页
- **依赖**：`amap_flutter_map` + 高德 Key 配置
- **验证**：手动真机测试（搜索地址 → 选点 → 确认回填）
- **文件**：`lib/widgets/map_picker.dart`

---

## Phase D: 认领 + 我的

**目标**：认领完整闭环（申请→审核），用户可以管理自己发布和认领。

### Task D1: Claim Service

- **内容**：封装所有 `/api/lost/claim/*` 调用（apply, cancel, detail, myList, review）
- **验证**：单元测试
- **文件**：`lib/services/claim_service.dart`

### Task D2: Claim 功能（详情页内嵌）

- **内容**：
  - 详情页新增"申请认领/提供线索"按钮 → 底部弹窗表单（描述 + 特征 + 联系方式 + 凭证图片 5 张）
  - 本人发布 → 显示认领列表（申请者信息 + 通过/拒绝按钮）
  - 拒绝弹窗（可选原因）
- **BLoC**：合并到 `LostFoundDetailBloc` 或独立 `ClaimBloc`
- **验证**：手动测试（申请 → owner 审核通过 → 物品状态变 claimed）
- **文件**：`lib/pages/lost_found/detail_page.dart`（扩展）, `lib/blocs/claim/`

### Task D3: MyPublishesPage

- **内容**：
  - 状态筛选 Tab（全部/待认领/已认领/已结束）
  - 卡片列表（复用 item_card）+ 操作按钮（关闭/重开/删除）
  - 关闭弹窗（输入原因）
- **验证**：手动测试（筛选/关闭/删除）
- **文件**：`lib/pages/my/my_publishes_page.dart`

### Task D4: MyClaimsPage

- **内容**：
  - 状态筛选 Tab（全部/待审核/已通过/已拒绝/已取消）
  - 列表（物品缩略图 + 标题 + 状态标签 + 申请描述 + 时间）
  - 已拒绝 → 显示拒绝原因
  - 待审核 → 取消按钮
- **验证**：手动测试（筛选/取消）
- **文件**：`lib/pages/my/my_claims_page.dart`

---

## Phase E: 个人中心

**目标**：用户可以查看/编辑资料、修改密码。

### Task E1: User Service + Profile BLoC

- **内容**：`user_service.dart`（getProfile, updateProfile, changePassword），ProfileBloc
- **验证**：单元测试
- **文件**：`lib/services/user_service.dart`, `lib/blocs/profile/`

### Task E2: ProfilePage

- **内容**：头像 + 昵称 + 信息列表 + 编辑入口 + 修改密码入口 + 退出登录
- **验证**：手动测试（编辑资料→保存→刷新验证）
- **文件**：`lib/pages/profile/profile_page.dart`

### Task E3: ChangePasswordPage

- **内容**：旧密码 + 新密码 + 确认新密码 → 提交
- **验证**：手动测试（修改→退出→用新密码登录）
- **文件**：`lib/pages/profile/change_password_page.dart`

---

## Phase F: 推送 + 收尾

**目标**：推送通知可送达，App 可以打包发布。

### Task F1: JPush 集成

- **内容**：
  - `push_service.dart`：初始化 JPush、注册设备、处理通知点击（根据 extras 跳转对应页面）
  - `main.dart` 初始化 JPush
  - 后端推送触发接口（待后端出方案后补充）
- **验证**：手动测试（推送→通知栏→点击→跳转正确页面）
- **文件**：`lib/services/push_service.dart`

### Task F2: App 图标 + 启动屏

- **内容**：复用 Web 端 Logo 生成 Android 自适应图标（`flutter_launcher_icons`），设置启动页背景色
- **验证**：APK 安装后桌面图标正常显示
- **文件**：`android/app/src/main/res/mipmap-*`

### Task F3: 真机全流程测试

- **内容**：按 Success Criteria 逐条验证，Bug 修复
- **验证**：所有 Success Criteria 通过
- **文件**：可能需要修复的各类文件

---

## 风险与缓解

| 风险 | 影响 | 缓解 |
|---|---|---|
| 高德地图 `amap_flutter_map` 与 Flutter 3.x 不兼容 | 地图功能受阻 | 备选：降级插件版本或改用 WebView + 高德 JS API |
| 极光推送 `jpush_flutter` 配置复杂 | 推送延期 | Phase F 独立，不影响核心功能，可延后发布 |
| 后端坐标字段新增后前端未对齐 | 地图选点数据丢失 | Phase A 第一时间完成后端改动，前后端联调 |
| BLoC 样板代码过多 | 开发速度慢 | 使用代码片段/snippet 加速 Event/State 创建 |
| Dio 401 刷新队列逻辑复杂 | Token 刷新 Bug | 参考 Web 端已验证的 interceptor 模式，核心逻辑一致 |

## 可并行化

- **Phase A 内**：A1（后端）和 A2-A5（前端）可并行（不同人/不同时间段）
- **Phase C 内**：C1-C3（Service + Widget）可并行
- **Phase C 内**：C8（发布页）和 C9（编辑页）依赖 C7 完成，但可同时开发
- **Phase D 内**：D3（我的发布）和 D4（我的申请）可并行
- **Phase E 内**：E2 和 E3 可并行
