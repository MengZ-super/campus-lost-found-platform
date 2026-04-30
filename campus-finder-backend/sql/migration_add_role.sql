-- =============================================
-- 添加用户角色字段
-- 执行方式: 在 MySQL 中执行此脚本
-- =============================================

USE `campus_finder`;

ALTER TABLE `sys_user`
    ADD COLUMN IF NOT EXISTS `role` VARCHAR(20) NOT NULL DEFAULT 'user'
    COMMENT '角色：user-普通用户，admin-管理员'
    AFTER `gender`;

-- 将 admin 用户设为管理员
UPDATE `sys_user` SET `role` = 'admin' WHERE `username` = 'admin';
