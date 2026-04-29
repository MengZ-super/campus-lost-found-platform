-- =============================================
-- 校园失物招领平台 - 数据库初始化脚本
-- 数据库名: campus_finder
-- =============================================

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS `campus_finder`
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE `campus_finder`;

-- =============================================
-- 用户表 (sys_user)
-- =============================================
DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `username` varchar(50) NOT NULL COMMENT '用户名（登录账号）',
    `password` varchar(255) NOT NULL COMMENT '密码（BCrypt加密）',
    `phone` varchar(20) NOT NULL COMMENT '手机号（唯一）',
    `student_id` varchar(20) DEFAULT NULL COMMENT '学号（可选）',
    `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
    `avatar` varchar(500) DEFAULT NULL COMMENT '头像URL',
    `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
    `gender` tinyint DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
    `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-正常',
    `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
    `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录IP',
    `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_phone` (`phone`),
    KEY `idx_status` (`status`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- =============================================
-- 物品分类表 (biz_category)
-- =============================================
DROP TABLE IF EXISTS `biz_category`;

CREATE TABLE `biz_category` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    `name` varchar(50) NOT NULL COMMENT '分类名称',
    `icon` varchar(200) DEFAULT NULL COMMENT '分类图标',
    `description` varchar(500) DEFAULT NULL COMMENT '分类描述',
    `sort` int NOT NULL DEFAULT 0 COMMENT '排序号',
    `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
    `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_status` (`status`),
    KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='物品分类表';

-- 初始化分类数据
INSERT INTO `biz_category` (`name`, `icon`, `description`, `sort`) VALUES
('电子产品', '💻', '手机、电脑、平板、耳机等电子设备', 1),
('证件卡片', '📇', '校园卡、身份证、银行卡、学生证等', 2),
('书籍资料', '📚', '课本、笔记、资料、文具等', 3),
('衣物配饰', '👕', '衣服、鞋子、包包、首饰等', 4),
('生活用品', '🧴', '水杯、雨伞、钥匙、眼镜等', 5),
('运动器材', '⚽', '球类、球拍、运动装备等', 6),
('其他物品', '📦', '其他未分类的物品', 99);

-- =============================================
-- 失物招领表 (biz_lost_found)
-- =============================================
DROP TABLE IF EXISTS `biz_lost_found`;

CREATE TABLE `biz_lost_found` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `user_id` bigint NOT NULL COMMENT '发布者ID',
    `category_id` bigint NOT NULL COMMENT '分类ID',
    `item_type` varchar(20) NOT NULL COMMENT '物品类型：lost-丢失物品，found-捡到物品',
    `title` varchar(100) NOT NULL COMMENT '标题',
    `description` text NOT NULL COMMENT '物品描述',
    `images` json DEFAULT NULL COMMENT '图片地址（JSON数组）',
    `features` varchar(500) DEFAULT NULL COMMENT '物品特征',
    `location` varchar(200) NOT NULL COMMENT '发现/丢失地点',
    `happened_time` datetime NOT NULL COMMENT '发现/丢失时间',
    `campus` varchar(50) DEFAULT NULL COMMENT '校区',
    `status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT '状态：pending-待认领，claimed-已认领，closed-已结束，expired-已过期',
    `claimed_by` bigint DEFAULT NULL COMMENT '认领者ID',
    `claimed_time` datetime DEFAULT NULL COMMENT '认领时间',
    `closed_time` datetime DEFAULT NULL COMMENT '关闭时间',
    `close_reason` varchar(500) DEFAULT NULL COMMENT '关闭原因',
    `view_count` int NOT NULL DEFAULT 0 COMMENT '浏览次数',
    `favorite_count` int NOT NULL DEFAULT 0 COMMENT '收藏次数',
    `claim_count` int NOT NULL DEFAULT 0 COMMENT '认领申请次数',
    `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_category_id` (`category_id`),
    KEY `idx_item_type` (`item_type`),
    KEY `idx_status` (`status`),
    KEY `idx_campus` (`campus`),
    KEY `idx_happened_time` (`happened_time`),
    KEY `idx_create_time` (`create_time`),
    FULLTEXT KEY `ft_title_desc` (`title`, `description`, `location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='失物招领表';

-- =============================================
-- 认领申请表 (biz_claim)
-- =============================================
DROP TABLE IF EXISTS `biz_claim`;

CREATE TABLE `biz_claim` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '申请ID',
    `lost_found_id` bigint NOT NULL COMMENT '失物招领记录ID',
    `user_id` bigint NOT NULL COMMENT '申请人ID',
    `claim_type` varchar(20) NOT NULL COMMENT '认领类型：found-认领捡到的物品，lost-提供丢失物品线索',
    `description` varchar(1000) NOT NULL COMMENT '认领说明',
    `features` varchar(500) DEFAULT NULL COMMENT '物品特征描述',
    `contact` varchar(100) NOT NULL COMMENT '联系方式',
    `proof_images` json DEFAULT NULL COMMENT '证明材料（图片）',
    `expect_time` datetime DEFAULT NULL COMMENT '期望认领时间',
    `status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT '状态：pending-待审核，approved-已通过，rejected-已拒绝，cancelled-已取消',
    `remark` varchar(500) DEFAULT NULL COMMENT '审核备注（拒绝原因）',
    `reviewed_by` bigint DEFAULT NULL COMMENT '审核人ID',
    `reviewed_time` datetime DEFAULT NULL COMMENT '审核时间',
    `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_lost_found_id` (`lost_found_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_status` (`status`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='认领申请表';

-- =============================================
-- 收藏表 (biz_favorite)
-- =============================================
DROP TABLE IF EXISTS `biz_favorite`;

CREATE TABLE `biz_favorite` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
    `user_id` bigint NOT NULL COMMENT '用户ID',
    `lost_found_id` bigint NOT NULL COMMENT '失物招领记录ID',
    `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_lost_found` (`user_id`, `lost_found_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_lost_found_id` (`lost_found_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收藏表';

-- =============================================
-- 初始化测试数据（可选）
-- =============================================
-- 密码为: 123456 (BCrypt加密后)
INSERT INTO `sys_user` (`username`, `password`, `phone`, `nickname`, `status`)
VALUES
    ('admin', '$2a$12$5PC3gt4xZSHKAlgW9nE0W.XJ2iXp6LxcKvIvq1SIb4M8gvkA8DdJG', '13800138000', '系统管理员', 1),
    ('test001', '$2a$12$5PC3gt4xZSHKAlgW9nE0W.XJ2iXp6LxcKvIvq1SIb4M8gvkA8DdJG', '13900139000', '测试用户', 1);
