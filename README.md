# 校园失物招领平台

一个完整的校园失物招领解决方案，包含 **管理后台（Web）**、**用户前端（Web）** 和 **移动端（Android）**，三端共享同一后端 API。

## 项目结构

```
campus-lost-found-platform/
├── campus-finder-backend/        # Spring Boot 3.3 后端 (端口 8080)
├── campus-finder-frontend/       # Vue 3 + Vite 用户前端 (端口 3000)
├── campus-finder-flutter/        # Flutter 移动端 (Android)
└── specs/                        # 需求文档和计划
```

## 功能概览

| 模块 | Web 用户端 | Web 管理后台 | Flutter 移动端 |
|------|-----------|-------------|---------------|
| 注册/登录/Token 刷新 | ✅ | ✅ | ✅ |
| 失物招领列表（搜索/筛选/分页） | ✅ | ✅ | ✅ |
| 物品详情（图片轮播/地图定位） | ✅ | ✅ | ✅ |
| 发布/编辑/删除物品 | ✅ | ✅ | ✅ |
| 地图选点（高德地图） | — | — | ✅ |
| 收藏物品 | ✅ | — | ✅ |
| 认领申请/审核 | ✅ | — | ✅ |
| 我的发布/我的认领 | ✅ | — | ✅ |
| 个人资料/修改密码 | ✅ | ✅ | ✅ |
| 用户/物品/认领/分类管理 | — | ✅ | — |
| 仪表盘数据统计 | — | ✅ | — |
| 图片上传（MinIO） | ✅ | ✅ | ✅ |
| 推送通知（JPush） | — | — | ✅ |

## 技术栈

### 后端
- **框架**: Spring Boot 3.3.6
- **数据库**: MySQL 8.4 + MyBatis-Plus
- **缓存**: Redis 8.2
- **对象存储**: MinIO
- **认证**: Spring Security + JWT (access + refresh token)
- **API 文档**: SpringDoc OpenAPI (Swagger)

### Web 前端
- **框架**: Vue 3 + Vite
- **UI 库**: Element Plus
- **状态管理**: Pinia
- **路由**: Vue Router 4
- **HTTP**: Axios (JWT 拦截器 + 401 自动刷新)

### Flutter 移动端
- **SDK**: Flutter 3.x / Dart 3.8
- **状态管理**: flutter_bloc (BLoC 模式)
- **数据模型**: freezed 3.x + json_serializable
- **HTTP**: Dio (JWT 拦截器 + 401 刷新队列)
- **路由**: go_router 17.x
- **安全存储**: flutter_secure_storage
- **地图**: amap_flutter_map (高德地图)
- **推送**: jpush_flutter (极光推送)
- **UI**: Material 3

## 快速开始

### 前置条件

- JDK 17+
- Maven 3.6+
- Node.js 18+
- Flutter 3.x + Dart 3.8
- WSL (Ubuntu-22.04) + Docker (用于运行 MySQL/Redis/MinIO)

### 1. 启动依赖服务

```bash
# 保持 WSL 活跃
wsl -d Ubuntu-22.04 sleep 3600 &

# 检查 Docker 容器状态
wsl -d Ubuntu-22.04 docker ps
```

| 服务 | 端口 | 默认密码 |
|------|------|----------|
| MySQL | 3306 | `mysql_jeZ4zX` |
| Redis | 6379 | `redis_myijP2` |
| MinIO | 9000/9001 | `minio_bhFH5e` / `minio_Fmnjpw` |

### 2. 启动后端

```bash
cd campus-finder-backend
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dfile.encoding=UTF-8"
```

后端运行在 http://localhost:8080，Swagger 文档在 http://localhost:8080/swagger-ui.html

### 3. 启动 Web 前端

```bash
cd campus-finder-frontend
npx vite --host 0.0.0.0
```

前端运行在 http://localhost:3000，`/api` 请求代理到 `:8080`

### 4. 启动 Flutter 移动端

```bash
cd campus-finder-flutter

# 设置 pub 镜像（国内）
export PUB_HOSTED_URL=https://pub.flutter-io.cn

# 生成数据模型代码
dart run build_runner build

# 静态分析
flutter analyze

# 运行（需连接 Android 设备或模拟器）
flutter run
```

### 5. 测试账号

| 用户名 | 密码 | 角色 |
|--------|------|------|
| admin | 123456 | 系统管理员 |
| test001 | 123456 | 普通用户 |

## API 文档

后端启动后访问 http://localhost:8080/swagger-ui.html 查看完整 API 文档。

主要模块：
- `POST /api/auth/*` — 认证（登录/注册/刷新Token）
- `GET/POST /api/user/*` — 用户信息
- `GET/POST /api/lost/*` — 失物招领 CRUD
- `GET/POST /api/lost/claim/*` — 认领管理
- `GET/POST /api/admin/*` — 管理后台

## 数据库

数据库名: `campus_finder`，字符集: `utf8mb4`

初始化脚本位于 `campus-finder-backend/sql/` 目录。

## 常见问题

详见 [CLAUDE.md](CLAUDE.md) 中的常见问题章节，包括：

- 数据库连接超时处理
- 端口占用解决
- 中文数据乱码处理
- Flutter freezed 3.x 语法要求
- Git worktree 注意事项

## 许可

MIT
