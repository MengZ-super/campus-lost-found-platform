-- 修复密码：123456 的正确 BCrypt hash
-- $2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW
UPDATE sys_user SET password='$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW' WHERE username IN ('admin','test001');
SELECT username, LEFT(password,20) as pwd_prefix, phone, status FROM sys_user;
