# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

与用户沟通说中文

## 项目结构

```
campus-lost-found-platform/
├── campus-finder-backend/                  # Spring Boot 3.3.6, 端口 8080
│   ├── sql/                                # 数据库脚本 (init/migration/seed)
│   └── src/main/java/com/campus/finder/
│       ├── config/                         # Security, JWT, CORS, Redis, MinIO, MyBatisPlus
│       ├── common/                         # 异常处理, 统一响应, JWT/密码工具
│       └── module/
│           ├── auth/                       # 认证: /api/auth/* (登录/注册/刷新Token)
│           ├── user/                       # 用户: /api/user/* (个人信息/修改密码)
│           ├── lost/                       # 失物招领: 分类/物品/认领/收藏 CRUD
│           └── admin/                      # 管理后台: /api/admin/* (仪表盘/用户/物品/认领/分类管理)
├── campus-finder-frontend/                 # Vue 3 + Vite + Element Plus, 端口 3000
│   └── src/
│       ├── api/ (index.js, admin.js)       # 后端 API 封装
│       ├── router/index.js                 # 路由 + beforeEach 权限守卫 (admin 路由 requiresAdmin)
│       ├── stores/auth.js                  # Pinia 认证状态
│       ├── views/ (auth/, lost/, user/, admin/, HomeView.vue)
│       └── layouts/MainLayout.vue
├── campus-finder-app/                      # UniApp + Vue 3 + uni-ui + Pinia, App 端
│   ├── src/
│   │   ├── api/                            # uni.request 封装 (request.js + 业务 API)
│   │   ├── stores/                         # Pinia 状态管理 (auth / lost-found / profile)
│   │   ├── utils/                          # 工具函数 (storage / date / validator)
│   │   ├── components/                     # 通用组件 (item-card / status-badge / image-carousel 等)
│   │   ├── pages/                          # 页面 (auth/ lost-found/ my/ profile/)
│   │   ├── App.vue
│   │   ├── main.js
│   │   └── pages.json                      # 路由 + TabBar 配置
│   └── tests/                              # Vitest 单元测试
├── CLAUDE.md
├── docs/
│   ├── SPEC.md                             # UniApp 开发规范
│   └── PLAN.md                             # 20 个 Task 的实施计划
├── fix_script.py
├── generate_assets.py
└── verify_sizes.py
```

## 代码规范

### Vue 3 管理前端

- **组件风格**：Composition API + `<script setup>`，不用 Options API
- **视图命名**：PascalCase `XxxView.vue`，按模块放 `src/views/{module}/`
- **路由**：懒加载 `() => import(...)`，`meta: { requiresAuth, title }`，admin 路由加 `requiresAdmin`
- **状态管理**：Pinia Composition API 写法 `defineStore('name', () => { ... })`，命名导出 `useXxxStore`
- **API 封装**：对象字面量导出 `export const xxxApi = { ... }`，统一用 `@/utils/request`，页面不直接调 axios
- **CSS**：scoped 样式，Element Plus 组件为主
- **响应格式**：`{ code, message, data, timestamp }`

### Spring Boot 后端

- **Controller**：`@RestController` + `@RequestMapping("/api/{module}")`，`@RequiredArgsConstructor` 注入，`@Slf4j` 日志
- **Service**：继承 `ServiceImpl<Mapper, Entity> implements IService<Entity>`，不用接口+实现分离，`@Transactional` 管事务
- **异常处理**：`throw new BusinessException(ResultCode.XXX)` 或 `throw new BusinessException(ResultCode.XXX, "自定义消息")`
- **响应封装**：统一 `Result<T>`，`Result.success(data)` / `Result.success("消息", data)` / `Result.error(ResultCode.XXX)`
- **DTO**：请求用 `XxxRequest`（`@Valid` 校验），响应用 `XxxDTO`（`fromEntity()` 静态工厂转换）
- **查询**：MyBatis-Plus `LambdaQueryWrapper`，分页用 `Page<T>`
- **文档**：Swagger `@Operation(summary, description)` + `@Tag(name, description)`
- **权限**：`SecurityContextHolder.getContext().getAuthentication()` 获取当前用户，Controller 内 `getCurrentUserId()` 私有方法
- **Lombok**：`@Data`（实体/DTO）、`@RequiredArgsConstructor`（Controller/Service）、`@Slf4j`
- **包结构**：`module/{功能}/` 下分 `controller/`、`service/`、`entity/`、`dto/`、`mapper/`

## 依赖服务（WSL Docker 容器）

通过 **1Panel** 在 WSL (Ubuntu-22.04) 管理 Docker 容器：

| 容器 | 服务 | 端口 | 密码 |
|------|------|------|------|
| 1Panel-mysql-8fOV | MySQL 8.4 | 3306 | `mysql_jeZ4zX` |
| 1Panel-redis-mSCW | Redis 8.2 | 6379 | `redis_myijP2` |
| 1Panel-minio-lNJA | MinIO | 9000/9001 | `minio_bhFH5e` / `minio_Fmnjpw` |

数据库名: `campus_finder`，字符集: `utf8mb4`

## 启动步骤

1. **启动 WSL 并保持活跃**（WSL 无活跃进程时自动关闭，容器被杀）：
   ```bash
   wsl -d Ubuntu-22.04 sleep 3600 &
   ```

2. **启动后端**（端口 8080）：
   ```bash
   cd campus-finder-backend && mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dfile.encoding=UTF-8"
   ```

3. **启动前端**（端口 3000，`/api` 代理到 `:8080`）：
   ```bash
   cd campus-finder-frontend && npx vite --host 0.0.0.0
   ```

## 默认测试账号

| 用户名 | 密码 | 角色 |
|--------|------|------|
| admin | 123456 | 系统管理员 |
| test001 | 123456 | 测试用户 |

## 常见问题和解决方案

### 1. 登录失败 / 数据库连接超时（`Communications link failure`, `Connection timed out`）

**根因**: WSL 未运行或 WSL 自动关闭导致 Docker 容器不活跃。

**排查**:
1. `wsl -l -v` — 应为 Running
2. `wsl -d Ubuntu-22.04 docker ps` — 检查容器状态
3. `wsl -d Ubuntu-22.04 ip addr show eth0 | grep "inet "` — 获取 WSL IP
4. PowerShell: `Test-NetConnection <wsl_ip> -Port 3306` — 测试端口

**解决**: 后台进程保持 WSL 活跃；若 Windows → WSL `127.0.0.1` 转发失效，需将 `application-dev.yml` 中的 host 改为 WSL 实际 IP（WSL IP 重启后变化）。

### 2. 端口 8080 被占用

```powershell
Get-Process -Name java | Stop-Process -Force
```

### 3. WSL 中连接 MySQL 用 `docker exec`，不要直接用 `mysql` 客户端

WSL 内 `mysql` 走 Unix socket，容器内外路径不同。正确方式:
```bash
wsl -d Ubuntu-22.04 docker exec 1Panel-mysql-8fOV mysql -uroot -pmysql_jeZ4zX -e "..."
```

### 4. 插入中文数据出现乱码（Mojibake）

从 Windows bash 直接 `docker exec mysql -e "INSERT ..."` 插入中文时，bash 非 UTF-8 编码会损坏 SQL 字符串。

**解决**: 将 SQL 写入文件（Write 工具保证 UTF-8），管道传入容器:
```bash
cat path/to/script.sql | wsl -d Ubuntu-22.04 docker exec -i 1Panel-mysql-8fOV mysql -uroot -pmysql_jeZ4zX --default-character-set=utf8mb4 campus_finder
```

`--default-character-set=utf8mb4` 和 `-i`（stdin 管道）两个参数缺一不可。

## UniApp 移动端开发（App 端）

### 环境变量

UniApp CLI 已在 PATH 中，直接使用 `uni` 命令：
```bash
# 进入项目目录
cd campus-finder-app

# 运行到 Android 真机/模拟器
npm run dev:app-android

# 运行到 iOS 真机/模拟器（macOS）
npm run dev:app-ios

# 运行到微信小程序（后续扩展）
npm run dev:mp-weixin
```

### 代码质量

```bash
# ESLint 检查
npm run lint

# 单元测试（Vitest）
npm run test
```

### 关键规范

- **单位**：用 `rpx` 不用 `px`，适配多端
- **状态管理**：Pinia Composition API 写法
- **API 封装**：通过 `api/request.js` 统一封装，页面不直接调 `uni.request`
- **组件**：统一用 uni-ui，按需引入
- **响应格式**：`{ code, message, data, timestamp }`（与后端一致）

### 页面路由

在 `pages.json` 中声明式配置，3 个 Tab 底部导航 + 二级页面：
- Tab 1: `pages/index/index` — 首页
- Tab 2: `pages/lost-found/index` — 失物招领列表
- Tab 3: `pages/my/index` — 个人中心
- 其他: `pages/auth/login`、`pages/lost-found/detail`、`pages/lost-found/publish` 等

### TabBar 图标路径注意

微信小程序中 TabBar 图标路径**必须以 `/` 开头**，否则图标无法显示：
```json
"iconPath": "/static/tab/home.png",
"selectedIconPath": "/static/tab/home-active.png"
```

## Git 工作流程

### 分支命名

- 功能分支：`ft/task-18-global-styles`（Task 编号 + 简短描述，kebab-case）
- 修复分支：`fix/xxx-description`
- 分支名与已有分支名冲突时，改用 `ft/` 前缀（不用 `feature/`）

### 提交规范

格式：`<type>: <简短描述>`

类型：
- `feat:` — 新功能
- `fix:` — 修复 bug
- `refactor:` — 重构
- `test:` — 测试相关
- `chore:` — 工具/构建/杂项

示例：
```
feat: add global styles and spacing variables (Task 18)
fix: correct image picker compression ratio
test: add store unit tests for auth module
chore: apply lint auto-fixes across all pages
```

### 提交流程

1. 在 `master` 分支上做 `git pull` 确保最新
2. 创建新分支 `ft/task-XX-description`
3. 开发 + 提交（每完成一个小逻辑就提交）
4. 完成功能后 `git checkout master && git pull`
5. 切回功能分支 rebase：`git rebase master`
6. 推送：`git push -u origin ft/task-XX-description`
7. 创建 PR 或直接合并到 master（若 PR 流程不强制）

### 合并策略

- **永远不用 `git merge master`**（防止污染历史）
- 优先 `git rebase master` 保持线性历史
- 已合并到 master 的功能分支应删除
- Windows 下 `git worktree remove` 可能因文件锁失败，`--force` 可清理 git 引用但目录需手动删除

### 注意事项

- 分支名 `feature/xxx` 与已有分支名 `feature` 冲突时，改用 `ft/` 前缀
- Windows 下 `git worktree remove` 可能因文件锁失败，`--force` 可清理 git 引用但目录需手动删除
