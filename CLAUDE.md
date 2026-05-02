# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

与用户说中文时

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
├── CLAUDE.md
├── fix_script.py
├── generate_assets.py
└── verify_sizes.py
```

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
