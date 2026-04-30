# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

---

# 项目环境信息

## 项目结构

```
campus-lost-found-platform/
├── campus-finder-backend/                      # Spring Boot 3.3.6 后端
│   ├── pom.xml
│   ├── sql/
│   │   ├── init.sql                            # 建库建表 + 默认数据
│   │   ├── check_admin.sql
│   │   ├── fix_password.sql
│   │   └── update_pwd.sql
│   └── src/main/java/com/campus/finder/
│       ├── FinderApplication.java              # 启动类
│       ├── config/
│       │   ├── SecurityConfig.java             # Spring Security 配置
│       │   ├── JwtAuthenticationFilter.java    # JWT 认证过滤器
│       │   ├── CorsConfig.java
│       │   ├── RedisConfig.java
│       │   ├── MinioConfig.java
│       │   ├── MyBatisPlusConfig.java
│       │   └── OpenApiConfig.java
│       ├── common/
│       │   ├── exception/
│       │   │   ├── BusinessException.java
│       │   │   └── GlobalExceptionHandler.java # 全局异常处理
│       │   ├── result/
│       │   │   ├── Result.java                 # 统一响应体
│       │   │   └── ResultCode.java             # 错误码枚举
│       │   └── util/
│       │       ├── JwtUtil.java
│       │       └── PasswordUtil.java
│       ├── controller/
│       │   └── FileController.java             # 文件上传
│       ├── service/
│       │   └── FileStorageService.java
│       └── module/
│           ├── auth/                           # 认证模块
│           │   ├── controller/AuthController.java  # /api/auth/*
│           │   ├── service/AuthService.java
│           │   └── dto/ (LoginRequest, RegisterRequest, AuthResponse...)
│           ├── user/                           # 用户模块
│           │   ├── controller/UserController.java  # /api/user/*
│           │   ├── service/UserService.java
│           │   ├── entity/User.java            # sys_user 表
│           │   ├── mapper/UserMapper.java
│           │   └── dto/ (UserProfileDTO, UpdateProfileRequest...)
│           └── lost/                           # 失物招领模块
│               ├── controller/ (CategoryController, LostFoundController, ClaimController)
│               ├── service/ (CategoryService, LostFoundService, ClaimService)
│               ├── entity/ (Category, LostFound, Claim, Favorite)
│               ├── mapper/ (4个Mapper)
│               └── dto/ (10个DTO)
│
├── campus-finder-frontend/                     # Vue 3 + Vite 前端
│   ├── package.json                            # element-plus + pinia + vue-router + axios
│   ├── vite.config.js                          # 端口3000, /api → :8080 代理
│   ├── index.html
│   └── src/
│       ├── App.vue
│       ├── main.js
│       ├── api/index.js                        # authApi, userApi, lostFoundApi, claimApi...
│       ├── utils/request.js                    # Axios 实例 + 拦截器
│       ├── stores/auth.js                      # Pinia 认证状态
│       ├── router/index.js                     # 路由 + beforeEach 守卫
│       ├── layouts/MainLayout.vue
│       ├── views/
│       │   ├── HomeView.vue
│       │   ├── auth/ (LoginView.vue, RegisterView.vue)
│       │   ├── lost/ (列表/详情/发布/编辑/我的发布/我的认领)
│       │   └── user/ (ProfileView.vue)
│       ├── components/ (EmptyState.vue)
│       ├── assets/ (icons/ + images/)
│       └── styles/base.css
│
├── CLAUDE.md                                   # 本文件
└── fix_script.py / generate_assets.py / verify_sizes.py
```

## 依赖服务（WSL Docker 容器）

项目依赖 MySQL、Redis、MinIO，通过 **1Panel** 在 WSL (Ubuntu-22.04) 中管理 Docker 容器：

| 容器名 | 服务 | 端口 | 密码 |
|--------|------|------|------|
| 1Panel-mysql-8fOV | MySQL 8.4 | 3306 | `mysql_jeZ4zX` |
| 1Panel-redis-mSCW | Redis 8.2 | 6379 | `redis_myijP2` |
| 1Panel-minio-lNJA | MinIO | 9000/9001 | `minioadmin` / `minio123456` |

## 启动步骤

1. **启动 WSL 并保持活跃**（WSL 无活跃进程时会自动关闭，导致容器被杀死）：
   ```bash
   wsl -d Ubuntu-22.04 sleep 3600 &
   ```

2. **启动后端**（端口 8080）：
   ```bash
   cd campus-finder-backend && mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dfile.encoding=UTF-8"
   ```

3. **启动前端**（端口 3000）：
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

**排查步骤**:
1. 检查 WSL 状态: `wsl -l -v`（应为 Running）
2. 检查容器状态: `wsl -d Ubuntu-22.04 docker ps`
3. 检查 WSL IP: `wsl -d Ubuntu-22.04 ip addr show eth0 | grep "inet "`
4. 测试端口连通: PowerShell 中 `Test-NetConnection <wsl_ip> -Port 3306`

**解决**: 用后台进程保持 WSL 活跃；如果 Windows → WSL `127.0.0.1` 转发失效，需将 `application-dev.yml` 中的 `127.0.0.1`/`localhost` 改为 WSL 实际 IP（WSL IP 重启后会变化）。

### 2. 端口 8080 被占用（`Port 8080 was already in use`）

上一个后端进程未正常退出。用 PowerShell 杀掉占用端口的 Java 进程：
```powershell
Get-Process -Name java | Stop-Process -Force
```

### 3. WSL 中 `docker mysql` 命令报 socket 错误

WSL 内使用 `docker exec` 连接 MySQL，不要直接在 WSL 中执行 `mysql` 客户端（走的是 Unix socket，容器内外路径不同）。

正确方式: `wsl -d Ubuntu-22.04 docker exec 1Panel-mysql-8fOV mysql -uroot -pmysql_jeZ4zX -e "..."`

### 4. 插入中文数据出现乱码（Mojibake）

**根因**: 从 Windows bash 直接通过 `docker exec mysql -e "INSERT ..."` 插入中文时，bash 的字符编码层（非 UTF-8）会导致 SQL 字符串在到达容器前就被损坏。

**解决**: 将 SQL 写入文件（Write 工具保证 UTF-8 编码），然后用 `cat` 管道传入容器执行：

```bash
cat path/to/script.sql | wsl -d Ubuntu-22.04 docker exec -i 1Panel-mysql-8fOV mysql -uroot -pmysql_jeZ4zX --default-character-set=utf8mb4 campus_finder
```

`--default-character-set=utf8mb4` 和 `-i`（stdin 管道）两个参数缺一不可。
