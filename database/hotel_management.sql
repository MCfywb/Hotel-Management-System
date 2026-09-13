CREATE DATABASE IF NOT EXISTS hotel_management
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

USE hotel_management;

DROP TABLE IF EXISTS notification_message;
DROP TABLE IF EXISTS operation_log;
DROP TABLE IF EXISTS financial_transaction;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS customer_user;
DROP TABLE IF EXISTS admin_user;
DROP TABLE IF EXISTS guest;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS room_type;

CREATE TABLE room_type (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    max_guests INT NOT NULL,
    bed_type VARCHAR(64) NOT NULL,
    area INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    amenities VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE room (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(32) NOT NULL UNIQUE,
    room_type_id BIGINT NOT NULL,
    floor INT NOT NULL,
    status VARCHAR(32) NOT NULL,
    clean_status VARCHAR(32) NOT NULL,
    CONSTRAINT fk_room_room_type FOREIGN KEY (room_type_id) REFERENCES room_type(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE guest (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(64) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    id_card VARCHAR(32) NOT NULL,
    member_level VARCHAR(32) NOT NULL,
    remark VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE admin_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    display_name VARCHAR(64) NOT NULL,
    role VARCHAR(32) NOT NULL,
    status VARCHAR(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE customer_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(64) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    display_name VARCHAR(64) NOT NULL,
    member_level VARCHAR(32) NOT NULL,
    status VARCHAR(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE reservation (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    reservation_no VARCHAR(40) NOT NULL UNIQUE,
    guest_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    guest_count INT NOT NULL,
    room_fee DECIMAL(10, 2) NOT NULL DEFAULT 0,
    breakfast_fee DECIMAL(10, 2) NOT NULL DEFAULT 0,
    extra_bed_fee DECIMAL(10, 2) NOT NULL DEFAULT 0,
    deposit_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    coupon_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(32) NOT NULL,
    channel VARCHAR(32) NOT NULL,
    special_request VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actual_check_in_time DATETIME NULL,
    actual_check_out_time DATETIME NULL,
    CONSTRAINT fk_reservation_guest FOREIGN KEY (guest_id) REFERENCES guest(id),
    CONSTRAINT fk_reservation_room FOREIGN KEY (room_id) REFERENCES room(id),
    INDEX idx_reservation_room_dates (room_id, check_in_date, check_out_date),
    INDEX idx_reservation_status_dates (status, check_in_date, check_out_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE financial_transaction (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    reservation_id BIGINT NOT NULL,
    reservation_no VARCHAR(40) NOT NULL,
    transaction_type VARCHAR(64) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    direction VARCHAR(32) NOT NULL,
    remark VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_financial_transaction_reservation FOREIGN KEY (reservation_id) REFERENCES reservation(id),
    INDEX idx_financial_transaction_reservation (reservation_id, created_at),
    INDEX idx_financial_transaction_type (transaction_type, direction)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE operation_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    reservation_id BIGINT NULL,
    room_id BIGINT NULL,
    operator_username VARCHAR(64) NOT NULL,
    operator_role VARCHAR(32) NOT NULL,
    action_type VARCHAR(64) NOT NULL,
    description VARCHAR(255) NOT NULL,
    before_snapshot VARCHAR(500),
    after_snapshot VARCHAR(500),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_operation_log_reservation FOREIGN KEY (reservation_id) REFERENCES reservation(id),
    CONSTRAINT fk_operation_log_room FOREIGN KEY (room_id) REFERENCES room(id),
    INDEX idx_operation_log_reservation (reservation_id, created_at),
    INDEX idx_operation_log_operator (operator_username, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notification_message (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(64) NOT NULL,
    title VARCHAR(128) NOT NULL,
    content VARCHAR(255) NOT NULL,
    related_type VARCHAR(32) NOT NULL,
    related_id BIGINT NOT NULL,
    target_role VARCHAR(32) NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'UNREAD',
    scheduled_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    read_at DATETIME NULL,
    INDEX idx_notification_target (target_role, status, scheduled_at),
    INDEX idx_notification_related (related_type, related_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO room_type (name, base_price, max_guests, bed_type, area, description, amenities) VALUES
('都市大床房', 498.00, 2, '1.8 米大床', 32, '适合商旅出行与城市短住。', '早餐, 无线网络, 智能电视'),
('花园双床房', 568.00, 2, '2 张 1.2 米单人床', 36, '安静楼层，窗户朝向庭院。', '早餐, 无线网络, 茶具'),
('行政套房', 968.00, 4, '1.8 米大床 + 沙发', 62, '客厅式布局，适合家庭或贵宾入住。', '早餐, 迷你吧, 浴缸');

INSERT INTO room (room_number, room_type_id, floor, status, clean_status) VALUES
('801', 1, 8, 'AVAILABLE', 'READY'),
('802', 1, 8, 'AVAILABLE', 'READY'),
('901', 2, 9, 'AVAILABLE', 'READY'),
('902', 2, 9, 'OCCUPIED', 'CLEANING'),
('1001', 3, 10, 'AVAILABLE', 'READY'),
('1002', 3, 10, 'MAINTENANCE', 'BLOCKED');

INSERT INTO guest (full_name, phone, id_card, member_level, remark) VALUES
('林若川', '13800000001', '330102199110101234', 'GOLD', '习惯晚到，请保留房间'),
('周清禾', '13800000002', '330102199305052456', 'REGULAR', '企业协议客户，按月结算'),
('沈嘉屿', '13800000003', '330102199512128888', 'PLATINUM', '需要机场接送服务');

INSERT INTO customer_user (username, phone, password, display_name, member_level, status) VALUES
('13900000001', '13900000001', '$2a$10$VvN31onlQ0j5W1D2Laj0zuzQO2S4M0nB6fTP3D6JrIoYNewc0hXtS', '住客示例', 'REGULAR', 'ACTIVE');

INSERT INTO reservation (
    reservation_no, guest_id, room_id, check_in_date, check_out_date, guest_count,
    room_fee, breakfast_fee, extra_bed_fee, deposit_amount, coupon_amount, total_amount,
    status, channel, special_request, created_at
) VALUES
('RES20260422080001', 1, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 2 DAY), 2, 996.00, 68.00, 0.00, 300.00, 50.00, 1314.00, 'BOOKED', 'DIRECT', '偏好靠窗房间', NOW()),
('RES20260421093015', 2, 4, DATE_SUB(CURDATE(), INTERVAL 1 DAY), DATE_ADD(CURDATE(), INTERVAL 1 DAY), 2, 1136.00, 88.00, 0.00, 300.00, 0.00, 1524.00, 'CHECKED_IN', 'OTA', '需要额外毛巾', NOW()),
('RES20260420114530', 3, 5, DATE_ADD(CURDATE(), INTERVAL 3 DAY), DATE_ADD(CURDATE(), INTERVAL 5 DAY), 3, 1936.00, 128.00, 160.00, 500.00, 100.00, 2624.00, 'BOOKED', 'DIRECT', '需要婴儿床', NOW());

-- 历史已退房订单：让住客画像的「完成入住 / 累计消费 / 平均消费」有真实数据
INSERT INTO reservation (
    reservation_no, guest_id, room_id, check_in_date, check_out_date, guest_count,
    room_fee, breakfast_fee, extra_bed_fee, deposit_amount, coupon_amount, total_amount,
    status, channel, special_request, created_at, actual_check_in_time, actual_check_out_time
) VALUES
('RES20260312080001', 1, 1, DATE_SUB(CURDATE(), INTERVAL 60 DAY), DATE_SUB(CURDATE(), INTERVAL 58 DAY), 2,
 996.00, 68.00, 0.00, 300.00, 0.00, 1364.00, 'CHECKED_OUT', 'DIRECT', '希望安排高楼层安静房间',
 DATE_SUB(NOW(), INTERVAL 62 DAY), DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_SUB(NOW(), INTERVAL 58 DAY)),
('RES20260405093002', 1, 3, DATE_SUB(CURDATE(), INTERVAL 25 DAY), DATE_SUB(CURDATE(), INTERVAL 23 DAY), 2,
 1136.00, 88.00, 0.00, 300.00, 50.00, 1474.00, 'CHECKED_OUT', 'OTA', '需要开具增值税发票',
 DATE_SUB(NOW(), INTERVAL 27 DAY), DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 23 DAY)),
('RES20260402101503', 2, 1, DATE_SUB(CURDATE(), INTERVAL 30 DAY), DATE_SUB(CURDATE(), INTERVAL 29 DAY), 2,
 498.00, 68.00, 0.00, 300.00, 0.00, 866.00, 'CHECKED_OUT', 'PHONE', '企业协议价，按月度结算',
 DATE_SUB(NOW(), INTERVAL 31 DAY), DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 29 DAY)),
('RES20260415113004', 2, 3, DATE_SUB(CURDATE(), INTERVAL 15 DAY), DATE_SUB(CURDATE(), INTERVAL 13 DAY), 2,
 1136.00, 88.00, 0.00, 300.00, 0.00, 1524.00, 'CHECKED_OUT', 'DIRECT', '希望延迟退房至 14:00',
 DATE_SUB(NOW(), INTERVAL 16 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 13 DAY)),
('RES20260320093005', 3, 5, DATE_SUB(CURDATE(), INTERVAL 45 DAY), DATE_SUB(CURDATE(), INTERVAL 42 DAY), 3,
 2904.00, 128.00, 160.00, 500.00, 100.00, 3592.00, 'CHECKED_OUT', 'DIRECT', '需要婴儿床与接送机服务',
 DATE_SUB(NOW(), INTERVAL 46 DAY), DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_SUB(NOW(), INTERVAL 42 DAY)),
('RES20260410144506', 3, 5, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 18 DAY), 3,
 1936.00, 128.00, 0.00, 500.00, 0.00, 2564.00, 'CHECKED_OUT', 'OTA', '家庭同行，需加床',
 DATE_SUB(NOW(), INTERVAL 21 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY));

-- 退房结算流水：与上面的历史订单对应，保证「财务流水 / 流水概览」统计一致
INSERT INTO financial_transaction (
    reservation_id, reservation_no, transaction_type, amount, direction, remark, created_at
)
SELECT r.id, r.reservation_no, 'CHECKOUT_SETTLEMENT', r.total_amount, 'CHARGE', '历史订单退房结算', r.actual_check_out_time
FROM reservation r
WHERE r.status = 'CHECKED_OUT';
