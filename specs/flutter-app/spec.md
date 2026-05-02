# Spec: 校园失物招领 Flutter 移动端

## Objective

为校园失物招领平台开发 Flutter 移动端 App，覆盖 Web 端全部普通用户功能，复用现有 Spring Boot 后端 API。首期仅发布 Android，iOS 代码保留后续启用。

**目标用户**：在校学生，通过手机快速发布/查找失物、提交认领申请、管理个人信息。

**成功标准**：用户可以在手机上完成从注册登录 → 浏览失物招领 → 发布物品 → 认领物品 → 管理个人物品的完整闭环。

## Tech Stack

| 层 | 技术 | 版本 |
|---|---|---|
| SDK | Flutter / Dart | 3.x stable |
| 状态管理 | flutter_bloc | ^8.x |
| HTTP 客户端 | dio | ^5.x |
| 路由 | go_router | ^14.x |
| 安全存储 | flutter_secure_storage | ^9.x |
| 图片选择 | image_picker | ^1.x |
| 地图 | amap_flutter_map (高德地图) | ^3.x |
| 推送 | jpush_flutter (极光推送) | ^4.x |
| UI | Material 3 (material: ^3.x) | — |
| 平台 | Android 优先（iOS 保留不测试） | — |
| 后端 | 复用现有 campus-finder-backend (Spring Boot) | — |

> **地图**：高德地图 Flutter 插件，用于发布/编辑时在地图上选点、详情页显示位置标记。  
> **推送**：极光推送（JPush），国内网络环境可用。通知场景：认领申请被审核通过/拒绝、有人申请认领我的物品、物品状态变更。

## Commands

```bash
# 初始化
cd campus-finder-flutter && flutter pub get

# 开发运行（选择 Android 设备）
flutter run -d android

# 构建 APK
flutter build apk --release

# 构建 AAB（上架 Google Play）
flutter build appbundle --release

# 静态分析
flutter analyze

# 测试
flutter test

# 代码生成（freezed / json_serializable）
flutter pub run build_runner build --delete-conflicting-outputs
```

## Project Structure

```
campus-finder-flutter/              # 独立项目，仓库根目录下
├── lib/
│   ├── main.dart                   # 入口：初始化 Storage、Dio、运行 App
│   ├── app.dart                    # MaterialApp.router，全局 Theme + Router 定义
│   │
│   ├── config/
│   │   ├── api_config.dart         # Base URL、超时、上传大小限制
│   │   └── theme.dart              # Material 3 亮色主题定义
│   │
│   ├── models/                     # 数据模型（Dart class + JSON 序列化）
│   │   ├── user.dart               # User, UserProfile, AuthResponse
│   │   ├── lost_found.dart         # LostFoundItem, LostFoundListParams
│   │   ├── claim.dart              # Claim, ClaimRequest
│   │   ├── category.dart           # Category
│   │   └── common.dart             # Result<T>, PageData<T>, Pagination
│   │
│   ├── services/                   # API 服务层（纯 HTTP，无业务逻辑）
│   │   ├── api_client.dart         # Dio 实例：interceptor 挂 Token、401 自动刷新、统一错误处理
│   │   ├── auth_service.dart       # /api/auth/*
│   │   ├── user_service.dart       # /api/user/*
│   │   ├── lost_found_service.dart # /api/lost/*
│   │   ├── claim_service.dart      # /api/lost/claim/*
│   │   ├── category_service.dart   # /api/lost/category/*
│   │   ├── upload_service.dart     # /api/upload (multipart)
│   │   └── push_service.dart       # 极光推送：注册设备、处理通知点击跳转
│   │
│   ├── blocs/                      # BLoC 状态管理（每个功能模块一个 bloc 文件夹）
│   │   ├── auth/
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   └── auth_state.dart
│   │   ├── lost_found/
│   │   │   ├── lost_found_bloc.dart
│   │   │   ├── lost_found_event.dart
│   │   │   └── lost_found_state.dart
│   │   ├── claim/
│   │   ├── category/
│   │   ├── upload/
│   │   └── profile/
│   │
│   ├── pages/                      # 页面（每个页面一个文件夹）
│   │   ├── splash/                 # 启动页：静默登录检查，跳转首页或登录页
│   │   ├── auth/
│   │   │   ├── login_page.dart
│   │   │   └── register_page.dart
│   │   ├── home/
│   │   │   └── home_page.dart
│   │   ├── lost_found/
│   │   │   ├── list_page.dart      # 失物招领列表（搜索 + 筛选 + 分页）
│   │   │   ├── detail_page.dart    # 物品详情（图片轮播 + 信息 + 认领操作）
│   │   │   ├── publish_page.dart   # 发布物品
│   │   │   └── edit_page.dart      # 编辑物品
│   │   ├── my/
│   │   │   ├── my_publishes_page.dart  # 我的发布
│   │   │   └── my_claims_page.dart     # 我的认领申请
│   │   └── profile/
│   │       ├── profile_page.dart       # 个人资料
│   │       └── change_password_page.dart
│   │
│   ├── widgets/                    # 可复用组件
│   │   ├── image_carousel.dart     # 图片轮播
│   │   ├── item_card.dart          # 失物招领卡片
│   │   ├── status_badge.dart       # 状态标签（pending/claimed/closed）
│   │   ├── empty_state.dart        # 空状态占位
│   │   ├── error_widget.dart       # 错误重试占位
│   │   ├── image_picker_sheet.dart # 图片选择底部弹窗
│   │   ├── map_picker.dart         # 高德地图选点组件（支持搜索 + 点击选点）
│   │   └── paginated_list.dart     # 上拉加载更多封装
│   │
│   └── utils/
│       ├── date_format.dart        # 日期格式化工具（yyyy-MM-dd HH:mm:ss）
│       ├── validators.dart         # 表单校验（手机号、密码强度等）
│       └── constants.dart          # App 级常量（状态映射、类型映射等）
│
├── test/                           # 单元测试 + Widget 测试
│   ├── blocs/
│   ├── services/
│   └── widgets/
│
├── android/                        # Android 原生配置
│                                   #   包名: com.campus.finder
│                                   #   高德 Key: AndroidManifest.xml <meta-data>
│                                   #   极光 Key: build.gradle + AndroidManifest.xml
├── ios/                            # iOS 配置（保留，不测试）
└── pubspec.yaml                    # 依赖声明
```

## Code Style

遵循 [Effective Dart](https://dart.dev/effective-dart) 规范。BLoC 遵循 flutter_bloc 官方约定：Event 用过去时动词或名词、State 用 `copyWith` 模式。

```dart
// 模型：freezed 不可变 + json_serializable
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated({String? error}) = _Unauthenticated;
  const factory AuthState.loading() = _Loading;
}

// BLoC：简洁的事件处理
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final FlutterSecureStorage _storage;

  AuthBloc(this._authService, this._storage) : super(const AuthState.initial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AppStarted>(_onAppStarted);  // splash 页触发，静默登录
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final response = await _authService.login(event.username, event.password);
      await _storage.write(key: 'accessToken', value: response.accessToken);
      await _storage.write(key: 'refreshToken', value: response.refreshToken);
      emit(AuthState.authenticated(response.toUser()));
    } catch (e) {
      emit(AuthState.unauthenticated(error: e.toString()));
    }
  }
}
```

**命名约定**：
- 文件：`snake_case.dart`
- 类/枚举：`PascalCase`
- 变量/方法：`camelCase`
- 常量：`camelCase`（Dart 惯例）
- BLoC 事件：过去时动词（`LoginRequested`, `ListRefreshed`, `ItemDeleted`）
- BLoC 状态：语义化（`initial`, `loading`, `loaded`, `error`）

## API Integration

### 请求/响应模型

所有后端响应使用统一封装 `Result<T>`：
```json
{
  "code": 200,          // int, 200 = 成功
  "message": "操作成功", // String
  "data": { ... },      // T, 实际数据
  "timestamp": 1714567890123  // long epoch millis
}
```

Bloc 层解析 `Result<T>` → 提取 `data` 或转换 `code` 为业务异常。

### JWT Token 管理

- **存储**：`flutter_secure_storage`（Android Keystore 加密存储）
- **Access Token**：15 分钟有效期，每个请求通过 Dio Interceptor 自动注入 `Authorization: Bearer <token>`
- **Refresh Token**：7 天有效期，`api_client.dart` 的 Dio Interceptor 拦截 401 → 自动调用 `/api/auth/refresh` → 重放失败请求
- **队列机制**：多个并发请求同时遇到 401 时，只发一次 refresh，其余请求排队等待
- **启动流程**：SplashPage → `AppStarted` 事件 → 从 SecureStorage 读取 accessToken → 调用 `/api/auth/me` 验证 → 有效则进入首页，过期则尝试 refresh，都失败则进入登录页
- **退出**：调用 `/api/auth/logout`，清除本地存储，导航到登录页

### 图片上传流程

```
用户选择图片 → image_picker (相册/相机)
  → 压缩（可选）→ 调用 POST /api/upload (multipart)
  → 服务端返回 MinIO URL
  → 将 URL 加入 form 的 images[] 数组
  → 提交时 images[] 随表单 JSON 一起发送
```

### 分页模式

列表页面使用 `GET /api/lost/list?pageNum=1&pageSize=12`，响应中 `data.current/page/total/records` 为分页信息。移动端使用**上拉加载更多**交互（非传统分页器）。

## Page Specification

以下是每个页面的功能规格：

### 1. SplashPage（启动页）
- App Logo + 应用名居中
- 1-2 秒内完成静默登录检查
- 有效 token → 首页；无/过期 token → 登录页

### 2. LoginPage（登录页）
- 输入：用户名（usernam/手机号）+ 密码
- 校验：非空
- 登录成功后导航到首页（替换路由栈，不可返回）
- 底部链接跳转注册页

### 3. RegisterPage（注册页）
- 输入：用户名、手机号、学号（可选）、昵称（可选）、密码、确认密码
- 校验：用户名 3-50 字符、手机号格式、密码 6-20 含字母+数字、两次密码一致
- 注册成功后自动登录 → 跳转首页

### 4. HomePage（首页）
- 顶部：用户昵称 + 欢迎语
- 4 个功能卡片：发布失物、寻找失物、我的发布、个人中心
- 2 个快捷入口：丢失了物品？→ 发布寻物 / 捡到了东西？→ 发布招领
- 底部导航栏（BottomNavigationBar）：首页 / 失物招领 / 我的

### 5. LostFoundListPage（列表页）
- 顶部搜索框（关键词搜索，防抖）
- 类型切换 Tab：全部 / 寻物(lost) / 招领(found)
- 分类筛选下拉
- 状态筛选 Chip：待认领 / 已认领 / 已结束
- 结果以卡片网格展示（2 列）
- 每张卡片：首图、状态标签（颜色编码）、标题、描述（2 行截断）、位置、日期、发布者昵称、浏览/收藏数
- 上拉加载更多
- 点击卡片 → 详情页
- FAB：发布按钮（根据当前 tab 预设类型）

### 6. LostFoundDetailPage（详情页）
- 图片轮播（自动播放 + 手动滑动）
- 物品元信息：分类、类型、位置、发生时间、校区
- **地图缩略图**：如果物品有坐标信息，显示高德地图静态图标记位置，点击可展开全屏地图
- 完整描述 + 物品特征
- 发布者信息（头像 + 昵称 + 发布时间）
- 浏览数 / 收藏数 / 认领数
- **操作区**（根据物品状态和用户角色动态变化）：
  - 非本人 + pending：收藏按钮 + 申请认领/提供线索按钮
  - 本人 + pending：编辑 + 关闭物品按钮
  - 本人 + claimed/closed：重新开启按钮
  - claimed 显示认领人信息
- **认领申请弹窗**：描述 + 特征 + 联系方式 + 凭证图片（最多 5 张）
- **本人可见的认领列表**：每个认领显示申请人、状态、操作（通过/拒绝）
- 关闭物品弹窗：关闭原因

### 7. PublishLostFoundPage（发布页）
- 选择类型：寻物 / 招领（radio / segmented button）
- 选择分类（下拉 + 图标）
- 标题（2-100 字）
- 描述（10-2000 字）
- 上传图片（最多 9 张，网格展示，可删除）
- 物品特征（选填，500 字）
- **地点选择**（根据类型自动切换标签：丢失地点 / 发现地点）：
  - 文本输入框（必填，200 字）
  - **地图选点**：点击打开高德地图，搜索地址或点击地图选中坐标，回填坐标（latitude, longitude）和地址文本到表单
- 发生时间（日期时间选择器）
- 校区（选填）
- 发布按钮 + 取消按钮

> **地图选点交互**：地点输入框右侧有地图图标按钮 → 点击进入全屏地图页面 → 顶部搜索栏（输入地址搜索）→ 地图中央十字准星 → 移动地图选点 → 底部显示当前地址 → 点击确认返回并回填坐标+地址。

### 8. EditLostFoundPage（编辑页）
- 表单同发布页（含地图选点）
- 类型不可修改（禁用）
- 已有图片和已有坐标预加载
- 保存调用 update API → 成功后跳回详情页

### 9. MyPublishesPage（我的发布）
- 状态筛选 Tab：全部 / 待认领 / 已认领 / 已结束
- 列表同 LostFoundListPage 卡片样式
- 每张卡片额外操作：关闭 / 重新开启 / 删除
- 关闭弹窗 → 输入关闭原因

### 10. MyClaimsPage（我的认领申请）
- 状态筛选 Tab：全部 / 待审核 / 已通过 / 已拒绝 / 已取消
- 列表：物品缩略图 + 标题 + 状态标签 + 申请描述 + 申请时间
- 已拒绝显示拒绝原因
- 待审核的可以取消

### 11. ProfilePage（个人资料）
- 头像 + 昵称 + 用户名展示
- 信息列表：学号、手机、邮箱、注册时间、上次登录
- 编辑资料入口（跳转编辑表单）
- 修改密码入口
- 退出登录按钮

### 12. ChangePasswordPage（修改密码）
- 输入：旧密码 + 新密码 + 确认新密码
- 校验：旧密码必填、新密码 6-20 含字母+数字、两次一致

## Global Navigation

### BottomNavigationBar（首页 / 失物招领 / 我的）

| Tab | 图标 | 目标 |
|---|---|---|
| 首页 | home | HomePage |
| 失物招领 | search | LostFoundListPage |
| 我的 | person | 我的页面（包含：个人资料、我的发布、我的申请、退出） |

### AppBar 左上角返回 + 标题

详情页、发布页等子页面通过 Navigator.push 入栈，带 AppBar 返回键。

## Testing Strategy

| 层级 | 工具 | 目标 | 范围 |
|---|---|---|---|
| 单元测试 | `flutter_test` + `mocktail` | Service、Bloc 逻辑 | 每个 service/bloc 至少覆盖核心路径 |
| Widget 测试 | `flutter_test` + `bloc_test` | 页面交互 | 关键页面（登录、列表、详情） |
| 集成测试 | 暂无（首期手动测试） | — | — |

**测试文件位置**：`test/` 下镜像 `lib/` 结构。

## Boundaries

### Always
- `flutter analyze` 零 error 才能提交
- 遵循 BLoC 模式：Event → Bloc → State → UI，不在 UI 层直接调用 Service
- API 调用统一走 Service 层，不在 Bloc/UI 层直接使用 Dio
- 所有网络请求有 loading/error 状态
- Token 用 `flutter_secure_storage` 存储，不用 SharedPreferences
- 图片上传前校验大小（≤5MB）和格式（JPG/PNG）

### Ask First
- 新增不在规格范围内的依赖（pubspec.yaml 变更）
- 修改后端 API 接口定义（需要前后端协调）
- 修改路由结构（go_router 配置）
- 方案级别的架构改动
- 上架应用商店（Google Play / 国内应用市场）

### Never
- 硬编码 API URL / 密钥 / Token 在代码中
- 在 UI 层直接操作 SecureStorage
- 跳过错误状态处理
- 在 Bloc 中使用 BuildContext

## Success Criteria

- [ ] 12 个页面全部可访问，导航流程完整
- [ ] 注册 → 登录 → 浏览列表 → 查看详情 → 发布物品 → 编辑物品 → 关闭物品：完整闭环
- [ ] 申请认领 → 物品所有者审核通过 → 物品状态变更为已认领：认领闭环
- [ ] 收藏 / 取消收藏：状态即时更新
- [ ] Token 自动刷新：15 分钟过期后无感刷新，用户无感知
- [ ] 图片上传：选择 → 上传 → 预览 → 提交，全流程正常
- [ ] 表单校验：所有输入框校验提示完整、密码强度检查
- [ ] 空状态 / 错误状态 / 加载状态：每个列表页面三种状态齐全
- [ ] 地图选点：发布/编辑时可搜索地址、在地图上点击选点，坐标和地址回填到表单
- [ ] 详情页地图：物品有坐标时显示位置地图
- [ ] 推送通知：认领审核结果可推送到手机通知栏，点击通知跳转到对应页面
- [ ] `flutter analyze` 零 error
- [ ] Android APK 构建成功，在 Android 真机上运行无崩溃

## Decisions Log

| # | 问题 | 决定 | 日期 |
|---|---|---|---|
| 1 | 包名 | `com.campus.finder` | 2026-05-02 |
| 2 | App 名称 | 校园失物招领 | 2026-05-02 |
| 3 | 地图集成 | 高德地图：发布/编辑时地图选点，详情页显示位置 | 2026-05-02 |
| 4 | 推送通知 | 极光推送（JPush）：认领审核结果、新认领申请通知 | 2026-05-02 |
| 5 | App 图标 | 复用 Web 端 Logo | 2026-05-02 |
| 6 | 坐标字段 | 后端 LostFound 表新增 latitude/longitude 字段，Flutter 端负责落地 | 2026-05-02 |
| 7 | 高德 Key | Android 平台 Key `10c419201f02fea0e4c53e015e87d7cf`（待确认是否为 Android 平台 Key） | 2026-05-02 |

## Open Questions

1. **推送通知后端支持？** 极光推送需要后端集成 JPush SDK 或提供设备注册/推送触发接口。当前后端没有推送相关代码，需要新增。→ 待确认方案
2. **高德 Key 类型确认**：用户提供的 Key `10c419201f02fea0e4c53e015e87d7cf`，需确认是否为 Android 平台 Key（非 Web JS API Key）。
