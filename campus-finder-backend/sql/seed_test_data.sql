-- 插入测试物品数据（UTF-8）
DELETE FROM biz_claim;
DELETE FROM biz_lost_found;
ALTER TABLE biz_lost_found AUTO_INCREMENT = 1;
ALTER TABLE biz_claim AUTO_INCREMENT = 1;

INSERT INTO biz_lost_found (user_id, category_id, item_type, title, description, images, features, location, happened_time, campus, status, view_count, favorite_count, claim_count, create_time) VALUES
(2, 1, 'lost', '丢失白色iPhone 15 Pro', '今天下午在图书馆三楼自习室丢失一部白色iPhone 15 Pro，手机壳是透明带熊猫图案的，有捡到的同学请联系我', '["https://picsum.photos/seed/iphone1/400/300", "https://picsum.photos/seed/iphone2/400/300"]', '白色，透明熊猫手机壳，屏幕有细微划痕', '图书馆三楼自习室A区', '2026-04-29 14:30:00', '南校区', 'pending', 128, 5, 0, '2026-04-29 15:00:00'),
(2, 2, 'found', '捡到校园卡一张', '在食堂门口捡到一张校园卡，卡号后四位8832，失主速联系', '["https://picsum.photos/seed/card1/400/300"]', '计算机学院 张同学', '第一食堂正门口', '2026-04-30 08:00:00', '南校区', 'pending', 56, 2, 0, '2026-04-30 08:30:00'),
(3, 3, 'lost', '丢失蓝色双肩包', '昨天在操场跑步时放在看台座位上，回来发现不见了，内有高数课本和笔记', '["https://picsum.photos/seed/bag1/400/300", "https://picsum.photos/seed/bag2/400/300", "https://picsum.photos/seed/bag3/400/300"]', '蓝色jansport双肩包，有挂件小熊', '北操场看台', '2026-04-28 17:00:00', '北校区', 'pending', 89, 3, 0, '2026-04-28 18:00:00'),
(1, 4, 'found', '捡到灰色围巾一条', '今天在第一教学楼203教室捡到一条灰色羊毛围巾，放在讲台上了', '["https://picsum.photos/seed/scarf1/400/300"]', '灰色，羊毛材质，无标签', '第一教学楼203教室', '2026-04-30 10:00:00', '南校区', 'claimed', 210, 8, 0, '2026-04-27 10:30:00'),
(2, 5, 'lost', '丢失黑色雨伞', '上周五在图书馆门口伞架上丢失一把黑色长柄雨伞，伞柄有刻字LZH', '[]', '黑色长柄，伞柄刻有LZH', '图书馆门口伞架', '2026-04-25 09:00:00', '南校区', 'closed', 45, 1, 0, '2026-04-25 10:00:00'),
(3, 6, 'found', '捡到一副羽毛球拍', '在体育馆羽毛球场捡到一副尤尼克斯羽毛球拍', '["https://picsum.photos/seed/racket1/400/300"]', '尤尼克斯，黑色拍袋', '体育馆羽毛球馆', '2026-04-29 16:00:00', '北校区', 'pending', 67, 4, 0, '2026-04-29 17:00:00'),
(1, 7, 'lost', '丢失钥匙串', '丢失一串钥匙，有宿舍钥匙和U盘（金士顿32G），非常重要', '[]', '银色钥匙圈，约5把钥匙，挂有红色U盘', '第二食堂二楼', '2026-04-30 07:30:00', '南校区', 'pending', 34, 2, 0, '2026-04-30 08:00:00'),
(2, 1, 'found', '捡到AirPods耳机盒', '在图书馆二楼捡到一个AirPods Pro充电盒，放在服务台了', '["https://picsum.photos/seed/airpods1/400/300"]', 'AirPods Pro，深蓝色保护套', '图书馆二楼', '2026-04-26 11:00:00', '南校区', 'claimed', 320, 12, 0, '2026-04-26 11:30:00'),
(3, 3, 'lost', '丢失考研资料一套', '在考研自习室丢失一套数学复习资料，包括张宇18讲和真题集', '[]', '资料封面有写名字"李明"', '考研自习室308', '2026-04-30 06:00:00', '南校区', 'pending', 12, 0, 0, '2026-04-30 07:00:00'),
(1, 5, 'lost', '丢失保温杯', '丢失一个膳魔师保温杯，深蓝色500ml，在操场附近丢失', '["https://picsum.photos/seed/cup1/400/300"]', '膳魔师，深蓝色，500ml，底部有轻微掉漆', '南操场跑道旁', '2026-04-28 16:00:00', '南校区', 'closed', 78, 3, 0, '2026-04-28 16:30:00'),
(2, 2, 'found', '捡到身份证一张', '在学校南门口捡到一张身份证，已交到门卫处', '[]', '姓名李某某，请失主携带学生证到南门门卫处领取', '学校南门', '2026-04-29 13:00:00', '南校区', 'pending', 156, 6, 0, '2026-04-29 13:30:00'),
(3, 4, 'found', '捡到黑色外套', '在快递站门口捡到一件黑色夹克外套，M码', '["https://picsum.photos/seed/jacket1/400/300"]', '黑色夹克，M码，左口袋有超市小票', '菜鸟驿站门口', '2026-04-30 09:00:00', '北校区', 'pending', 23, 1, 0, '2026-04-30 09:30:00');

-- 认领数据
INSERT INTO biz_claim (lost_found_id, user_id, claim_type, description, features, contact, proof_images, status, remark, reviewed_by, reviewed_time, create_time) VALUES
(1, 1, 'found', '这是我的手机，手机壳是透明熊猫图案，手机串号我可以提供', '白色iPhone 15 Pro，透明熊猫手机壳，屏幕左上角有细微划痕', '13800138000', '["https://picsum.photos/seed/claim1/400/300"]', 'pending', NULL, NULL, NULL, '2026-04-29 16:00:00'),
(1, 3, 'found', '这个手机好像是我朋友丢的，我帮他认领一下', '白色iPhone 15 Pro，具体细节我要再确认', '13900139000', '[]', 'pending', NULL, NULL, NULL, '2026-04-30 09:00:00'),
(3, 1, 'found', '我的包！蓝色jansport，有个小熊挂件，里面有高数课本', '蓝色双肩包，挂件是棕色小熊，课本封面有写名字', '13800138000', '["https://picsum.photos/seed/claim3/400/300"]', 'pending', NULL, NULL, NULL, '2026-04-29 10:00:00'),
(4, 3, 'found', '灰色围巾是我的，那天上课忘在教室了，标签被我剪掉了所以没有', '灰色羊毛围巾，摸起来很柔软', '13900139000', '[]', 'approved', '确认无误，特征匹配', 1, '2026-04-28 14:00:00', '2026-04-28 12:00:00'),
(4, 2, 'found', '这个围巾可能是我的，但我不太确定', '灰色围巾', '13900139001', '[]', 'rejected', '特征描述不够详细，无法确认', 1, '2026-04-28 14:10:00', '2026-04-28 13:00:00'),
(6, 1, 'found', '我昨天在体育馆打球忘了拿，是我的拍子没错', '尤尼克斯，黑色拍袋，拍柄有缠白色手胶', '13800138000', '[]', 'pending', NULL, NULL, NULL, '2026-04-29 18:00:00'),
(6, 2, 'found', '这个拍子是我同学的，我可以让他来认领', '尤尼克斯羽毛球拍，黑色', '13900139001', '["https://picsum.photos/seed/claim6/400/300"]', 'pending', NULL, NULL, NULL, '2026-04-30 10:00:00'),
(7, 2, 'found', '我的钥匙串！红色U盘是金士顿32G的，宿舍钥匙形状我记得很清楚', '银色钥匙圈，大约5把钥匙，挂着一个红色金士顿U盘', '13900139001', '[]', 'pending', NULL, NULL, NULL, '2026-04-30 09:00:00'),
(8, 3, 'found', '我的AirPods Pro，保护套是深蓝色的，有些磨损', '深蓝色硅胶保护套，底部有一处磨损', '13900139000', '["https://picsum.photos/seed/claim8/400/300"]', 'approved', '特征完全匹配', 1, '2026-04-27 09:00:00', '2026-04-26 14:00:00'),
(8, 1, 'found', '这个耳机好像是我的，但我没有特别明显的标记', 'AirPods Pro，蓝色壳', '13800138000', '[]', 'rejected', '提供的特征信息不足，无法验证', 1, '2026-04-27 09:10:00', '2026-04-26 15:00:00'),
(12, 2, 'found', '我的夹克！那天取快递太热脱下来忘拿了', '黑色夹克M码，左口袋有昨天超市的小票', '13900139001', '[]', 'pending', NULL, NULL, NULL, '2026-04-30 10:30:00');

-- 更新认领计数
UPDATE biz_lost_found SET claim_count = (SELECT COUNT(*) FROM biz_claim WHERE biz_claim.lost_found_id = biz_lost_found.id);

-- 更新已认领物品
UPDATE biz_lost_found SET claimed_by = 3, claimed_time = '2026-04-28 14:00:00' WHERE id = 4;
UPDATE biz_lost_found SET claimed_by = 3, claimed_time = '2026-04-27 09:00:00' WHERE id = 8;

-- 更新关闭物品
UPDATE biz_lost_found SET closed_time = '2026-04-28 10:00:00', close_reason = '已自行找回' WHERE id = 5;
UPDATE biz_lost_found SET closed_time = '2026-04-30 08:00:00', close_reason = '已重新购买' WHERE id = 10;

-- 更新收藏计数
UPDATE biz_lost_found SET favorite_count = 5 WHERE id = 1;
UPDATE biz_lost_found SET favorite_count = 3 WHERE id = 3;
UPDATE biz_lost_found SET favorite_count = 8 WHERE id = 4;
UPDATE biz_lost_found SET favorite_count = 12 WHERE id = 8;
UPDATE biz_lost_found SET favorite_count = 4 WHERE id = 6;
UPDATE biz_lost_found SET favorite_count = 6 WHERE id = 11;
