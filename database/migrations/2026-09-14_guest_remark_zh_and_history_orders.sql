-- 2026-09-14 住客备注中文化 + 补充历史已退房订单
-- 适用对象：已经跑过 hotel_management.sql 的存量库（新库直接执行主脚本即可，无需本文件）
-- 注意：本脚本只执行一次；重复执行会因 reservation_no 唯一约束报重复键错误。

USE hotel_management;

-- 1. 住客备注改成中文
UPDATE guest SET remark = '习惯晚到，请保留房间'   WHERE phone = '13800000001';
UPDATE guest SET remark = '企业协议客户，按月结算' WHERE phone = '13800000002';
UPDATE guest SET remark = '需要机场接送服务'       WHERE phone = '13800000003';

-- 2. 房型信息中文化（房型列表 / 住客端可订房型会直接展示这些字段）
UPDATE room_type
SET name = '都市大床房', bed_type = '1.8 米大床',
    description = '适合商旅出行与城市短住。', amenities = '早餐, 无线网络, 智能电视'
WHERE name = 'Urban Queen';

UPDATE room_type
SET name = '花园双床房', bed_type = '2 张 1.2 米单人床',
    description = '安静楼层，窗户朝向庭院。', amenities = '早餐, 无线网络, 茶具'
WHERE name = 'Garden Twin';

UPDATE room_type
SET name = '行政套房', bed_type = '1.8 米大床 + 沙发',
    description = '客厅式布局，适合家庭或贵宾入住。', amenities = '早餐, 迷你吧, 浴缸'
WHERE name = 'Executive Suite';

-- 3. 已有订单的特殊需求改成中文
UPDATE reservation SET special_request = '偏好靠窗房间' WHERE reservation_no = 'RES20260422080001';
UPDATE reservation SET special_request = '需要额外毛巾' WHERE reservation_no = 'RES20260421093015';
UPDATE reservation SET special_request = '需要婴儿床'   WHERE reservation_no = 'RES20260420114530';

-- 4. 历史已退房订单
--    住客画像的「完成入住 / 累计消费 / 平均消费」只统计 status = 'CHECKED_OUT' 的订单，
--    原有种子数据里全是 BOOKED / CHECKED_IN，所以这三个指标一直是 0。
INSERT INTO reservation (
    reservation_no, guest_id, room_id, check_in_date, check_out_date, guest_count,
    room_fee, breakfast_fee, extra_bed_fee, deposit_amount, coupon_amount, total_amount,
    status, channel, special_request, created_at, actual_check_in_time, actual_check_out_time
) VALUES
-- 林若川（GOLD）
('RES20260312080001',
 (SELECT id FROM guest WHERE phone = '13800000001'),
 (SELECT id FROM room WHERE room_number = '801'),
 DATE_SUB(CURDATE(), INTERVAL 60 DAY), DATE_SUB(CURDATE(), INTERVAL 58 DAY), 2,
 996.00, 68.00, 0.00, 300.00, 0.00, 1364.00, 'CHECKED_OUT', 'DIRECT', '希望安排高楼层安静房间',
 DATE_SUB(NOW(), INTERVAL 62 DAY), DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_SUB(NOW(), INTERVAL 58 DAY)),
('RES20260405093002',
 (SELECT id FROM guest WHERE phone = '13800000001'),
 (SELECT id FROM room WHERE room_number = '901'),
 DATE_SUB(CURDATE(), INTERVAL 25 DAY), DATE_SUB(CURDATE(), INTERVAL 23 DAY), 2,
 1136.00, 88.00, 0.00, 300.00, 50.00, 1474.00, 'CHECKED_OUT', 'OTA', '需要开具增值税发票',
 DATE_SUB(NOW(), INTERVAL 27 DAY), DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 23 DAY)),
-- 周清禾（REGULAR）
('RES20260402101503',
 (SELECT id FROM guest WHERE phone = '13800000002'),
 (SELECT id FROM room WHERE room_number = '801'),
 DATE_SUB(CURDATE(), INTERVAL 30 DAY), DATE_SUB(CURDATE(), INTERVAL 29 DAY), 2,
 498.00, 68.00, 0.00, 300.00, 0.00, 866.00, 'CHECKED_OUT', 'PHONE', '企业协议价，按月度结算',
 DATE_SUB(NOW(), INTERVAL 31 DAY), DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 29 DAY)),
('RES20260415113004',
 (SELECT id FROM guest WHERE phone = '13800000002'),
 (SELECT id FROM room WHERE room_number = '901'),
 DATE_SUB(CURDATE(), INTERVAL 15 DAY), DATE_SUB(CURDATE(), INTERVAL 13 DAY), 2,
 1136.00, 88.00, 0.00, 300.00, 0.00, 1524.00, 'CHECKED_OUT', 'DIRECT', '希望延迟退房至 14:00',
 DATE_SUB(NOW(), INTERVAL 16 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 13 DAY)),
-- 沈嘉屿（PLATINUM）
('RES20260320093005',
 (SELECT id FROM guest WHERE phone = '13800000003'),
 (SELECT id FROM room WHERE room_number = '1001'),
 DATE_SUB(CURDATE(), INTERVAL 45 DAY), DATE_SUB(CURDATE(), INTERVAL 42 DAY), 3,
 2904.00, 128.00, 160.00, 500.00, 100.00, 3592.00, 'CHECKED_OUT', 'DIRECT', '需要婴儿床与接送机服务',
 DATE_SUB(NOW(), INTERVAL 46 DAY), DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_SUB(NOW(), INTERVAL 42 DAY)),
('RES20260410144506',
 (SELECT id FROM guest WHERE phone = '13800000003'),
 (SELECT id FROM room WHERE room_number = '1001'),
 DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 18 DAY), 3,
 1936.00, 128.00, 0.00, 500.00, 0.00, 2564.00, 'CHECKED_OUT', 'OTA', '家庭同行，需加床',
 DATE_SUB(NOW(), INTERVAL 21 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY));

-- 5. 对应的退房结算流水，让「财务流水 / 流水概览」统计一致
INSERT INTO financial_transaction (
    reservation_id, reservation_no, transaction_type, amount, direction, remark, created_at
)
SELECT id, reservation_no, 'CHECKOUT_SETTLEMENT', total_amount, 'CHARGE', '历史订单退房结算', actual_check_out_time
FROM reservation
WHERE reservation_no IN (
    'RES20260312080001', 'RES20260405093002',
    'RES20260402101503', 'RES20260415113004',
    'RES20260320093005', 'RES20260410144506'
);
