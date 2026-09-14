/*
 Navicat Premium Dump SQL

 Source Server         : MC风月无边
 Source Server Type    : MySQL
 Source Server Version : 260700 (26.7.0)
 Source Host           : localhost:3306
 Source Schema         : hotel_management

 Target Server Type    : MySQL
 Target Server Version : 260700 (26.7.0)
 File Encoding         : 65001

 Date: 14/09/2026 12:46:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `display_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, 'admin', '$2a$10$eS0Rstli0HC4vTuC0PLSJegYry1d8yjhtbdPMKZ9CQhWxbEIhrZPK', '系统管理员', 'ADMIN', 'ACTIVE');
INSERT INTO `admin_user` VALUES (2, 'frontdesk', '$2a$10$yg5hdwvcNd4e8Zn187YLV.KtmpACbBFTIzl9qbnbHf5IutoA9Absy', '前台专员', 'FRONT_DESK', 'ACTIVE');

-- ----------------------------
-- Table structure for customer_user
-- ----------------------------
DROP TABLE IF EXISTS `customer_user`;
CREATE TABLE `customer_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `display_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `member_level` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_user
-- ----------------------------
INSERT INTO `customer_user` VALUES (1, '12345678901', '12345678901', '$2a$10$SA3b3YpLzaAxUwhf.7W2X.hzJxw2nkcwONS3o20HToAS9VI8YkjFW', 'MC风月无边', 'REGULAR', 'ACTIVE');

-- ----------------------------
-- Table structure for financial_transaction
-- ----------------------------
DROP TABLE IF EXISTS `financial_transaction`;
CREATE TABLE `financial_transaction`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint NOT NULL,
  `reservation_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `transaction_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `amount` decimal(10, 2) NOT NULL,
  `direction` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_financial_transaction_reservation`(`reservation_id` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_financial_transaction_type`(`transaction_type` ASC, `direction` ASC) USING BTREE,
  CONSTRAINT `fk_financial_transaction_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of financial_transaction
-- ----------------------------
INSERT INTO `financial_transaction` VALUES (1, 4, 'RES20260312080001', 'CHECKOUT_SETTLEMENT', 1364.00, 'CHARGE', '历史订单退房结算', '2026-07-18 02:20:58');
INSERT INTO `financial_transaction` VALUES (2, 5, 'RES20260405093002', 'CHECKOUT_SETTLEMENT', 1474.00, 'CHARGE', '历史订单退房结算', '2026-08-22 02:20:58');
INSERT INTO `financial_transaction` VALUES (3, 6, 'RES20260402101503', 'CHECKOUT_SETTLEMENT', 866.00, 'CHARGE', '历史订单退房结算', '2026-08-16 02:20:58');
INSERT INTO `financial_transaction` VALUES (4, 7, 'RES20260415113004', 'CHECKOUT_SETTLEMENT', 1524.00, 'CHARGE', '历史订单退房结算', '2026-09-01 02:20:58');
INSERT INTO `financial_transaction` VALUES (5, 8, 'RES20260320093005', 'CHECKOUT_SETTLEMENT', 3592.00, 'CHARGE', '历史订单退房结算', '2026-08-03 02:20:58');
INSERT INTO `financial_transaction` VALUES (6, 9, 'RES20260410144506', 'CHECKOUT_SETTLEMENT', 2564.00, 'CHARGE', '历史订单退房结算', '2026-08-27 02:20:58');
INSERT INTO `financial_transaction` VALUES (8, 1, 'RES20260422080001', 'ROOM_FEE_ADJUSTMENT', 498.00, 'CHARGE', '续住 - 房费调整', '2026-09-14 02:32:15');
INSERT INTO `financial_transaction` VALUES (9, 1, 'RES20260422080001', 'ROOM_FEE_ADJUSTMENT', 498.00, 'CHARGE', '续住 - 房费调整', '2026-09-14 02:32:27');

-- ----------------------------
-- Table structure for guest
-- ----------------------------
DROP TABLE IF EXISTS `guest`;
CREATE TABLE `guest`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `member_level` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guest
-- ----------------------------
INSERT INTO `guest` VALUES (1, '林若川', '13800000001', '330102199110101234', 'GOLD', '习惯晚到，请保留房间');
INSERT INTO `guest` VALUES (2, '周清禾', '13800000002', '330102199305052456', 'REGULAR', '企业协议客户，按月结算');
INSERT INTO `guest` VALUES (3, '沈嘉屿', '13800000003', '330102199512128888', 'PLATINUM', '需要机场接送服务');

-- ----------------------------
-- Table structure for notification_message
-- ----------------------------
DROP TABLE IF EXISTS `notification_message`;
CREATE TABLE `notification_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `related_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `related_id` bigint NOT NULL,
  `target_role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'UNREAD',
  `scheduled_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_notification_target`(`target_role` ASC, `status` ASC, `scheduled_at` ASC) USING BTREE,
  INDEX `idx_notification_related`(`related_type` ASC, `related_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notification_message
-- ----------------------------
INSERT INTO `notification_message` VALUES (1, 'UPCOMING_CHECKIN', '即将入住提醒', '订单 RES20260422080001 · 林若川 将于 2026-09-14 到店，房间 802 请提前确认。', 'RESERVATION', 1, 'STAFF', 'UNREAD', '2026-09-14 09:00:00', '2026-09-14 00:43:38', NULL);
INSERT INTO `notification_message` VALUES (2, 'UPCOMING_CHECKOUT', '即将退房提醒', '订单 RES20260421093015 · 周清禾 将于 2026-09-15 离店，请准备退房结算。', 'RESERVATION', 2, 'STAFF', 'UNREAD', '2026-09-15 09:00:00', '2026-09-14 00:43:38', NULL);

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint NULL DEFAULT NULL,
  `room_id` bigint NULL DEFAULT NULL,
  `operator_username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `operator_role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `before_snapshot` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `after_snapshot` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_operation_log_room`(`room_id` ASC) USING BTREE,
  INDEX `idx_operation_log_reservation`(`reservation_id` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_operation_log_operator`(`operator_username` ASC, `created_at` ASC) USING BTREE,
  CONSTRAINT `fk_operation_log_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_operation_log_room` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES (1, 1, 2, 'admin', 'ADMIN', 'EXTEND_STAY', '续住至 2026-09-17', 'reservationNo=RES20260422080001,status=BOOKED,roomId=2,checkIn=2026-09-14,checkOut=2026-09-16,total=1314.00,operator=admin/ADMIN', 'reservationNo=RES20260422080001,status=BOOKED,roomId=2,checkIn=2026-09-14,checkOut=2026-09-17,total=1812.00,operator=admin/ADMIN', '2026-09-14 02:32:15');
INSERT INTO `operation_log` VALUES (2, 1, 2, 'admin', 'ADMIN', 'EXTEND_STAY', '续住至 2026-09-18', 'reservationNo=RES20260422080001,status=BOOKED,roomId=2,checkIn=2026-09-14,checkOut=2026-09-17,total=1812.00,operator=admin/ADMIN', 'reservationNo=RES20260422080001,status=BOOKED,roomId=2,checkIn=2026-09-14,checkOut=2026-09-18,total=2310.00,operator=admin/ADMIN', '2026-09-14 02:32:27');

-- ----------------------------
-- Table structure for reservation
-- ----------------------------
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE `reservation`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reservation_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `guest_id` bigint NOT NULL,
  `room_id` bigint NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `guest_count` int NOT NULL,
  `room_fee` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `breakfast_fee` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `extra_bed_fee` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `deposit_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `coupon_amount` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(10, 2) NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `channel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `special_request` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actual_check_in_time` datetime NULL DEFAULT NULL,
  `actual_check_out_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `reservation_no`(`reservation_no` ASC) USING BTREE,
  INDEX `fk_reservation_guest`(`guest_id` ASC) USING BTREE,
  INDEX `idx_reservation_room_dates`(`room_id` ASC, `check_in_date` ASC, `check_out_date` ASC) USING BTREE,
  INDEX `idx_reservation_status_dates`(`status` ASC, `check_in_date` ASC, `check_out_date` ASC) USING BTREE,
  CONSTRAINT `fk_reservation_guest` FOREIGN KEY (`guest_id`) REFERENCES `guest` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_reservation_room` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservation
-- ----------------------------
INSERT INTO `reservation` VALUES (1, 'RES20260422080001', 1, 2, '2026-09-14', '2026-09-18', 2, 1992.00, 68.00, 0.00, 300.00, 50.00, 2310.00, 'BOOKED', 'DIRECT', '偏好靠窗房间', '2026-09-14 00:31:44', NULL, NULL);
INSERT INTO `reservation` VALUES (2, 'RES20260421093015', 2, 4, '2026-09-13', '2026-09-15', 2, 1136.00, 88.00, 0.00, 300.00, 0.00, 1524.00, 'CHECKED_IN', 'OTA', '需要额外毛巾', '2026-09-14 00:31:44', NULL, NULL);
INSERT INTO `reservation` VALUES (3, 'RES20260420114530', 3, 5, '2026-09-17', '2026-09-19', 3, 1936.00, 128.00, 160.00, 500.00, 100.00, 2624.00, 'BOOKED', 'DIRECT', '需要婴儿床', '2026-09-14 00:31:44', NULL, NULL);
INSERT INTO `reservation` VALUES (4, 'RES20260312080001', 1, 1, '2026-07-16', '2026-07-18', 2, 996.00, 68.00, 0.00, 300.00, 0.00, 1364.00, 'CHECKED_OUT', 'DIRECT', '希望安排高楼层安静房间', '2026-07-14 02:20:58', '2026-07-16 02:20:58', '2026-07-18 02:20:58');
INSERT INTO `reservation` VALUES (5, 'RES20260405093002', 1, 3, '2026-08-20', '2026-08-22', 2, 1136.00, 88.00, 0.00, 300.00, 50.00, 1474.00, 'CHECKED_OUT', 'OTA', '需要开具增值税发票', '2026-08-18 02:20:58', '2026-08-20 02:20:58', '2026-08-22 02:20:58');
INSERT INTO `reservation` VALUES (6, 'RES20260402101503', 2, 1, '2026-08-15', '2026-08-16', 2, 498.00, 68.00, 0.00, 300.00, 0.00, 866.00, 'CHECKED_OUT', 'PHONE', '企业协议价，按月度结算', '2026-08-14 02:20:58', '2026-08-15 02:20:58', '2026-08-16 02:20:58');
INSERT INTO `reservation` VALUES (7, 'RES20260415113004', 2, 3, '2026-08-30', '2026-09-01', 2, 1136.00, 88.00, 0.00, 300.00, 0.00, 1524.00, 'CHECKED_OUT', 'DIRECT', '希望延迟退房至 14:00', '2026-08-29 02:20:58', '2026-08-30 02:20:58', '2026-09-01 02:20:58');
INSERT INTO `reservation` VALUES (8, 'RES20260320093005', 3, 5, '2026-07-31', '2026-08-03', 3, 2904.00, 128.00, 160.00, 500.00, 100.00, 3592.00, 'CHECKED_OUT', 'DIRECT', '需要婴儿床与接送机服务', '2026-07-30 02:20:58', '2026-07-31 02:20:58', '2026-08-03 02:20:58');
INSERT INTO `reservation` VALUES (9, 'RES20260410144506', 3, 5, '2026-08-25', '2026-08-27', 3, 1936.00, 128.00, 0.00, 500.00, 0.00, 2564.00, 'CHECKED_OUT', 'OTA', '家庭同行，需加床', '2026-08-24 02:20:58', '2026-08-25 02:20:58', '2026-08-27 02:20:58');

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `room_type_id` bigint NOT NULL,
  `floor` int NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `clean_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `room_number`(`room_number` ASC) USING BTREE,
  INDEX `fk_room_room_type`(`room_type_id` ASC) USING BTREE,
  CONSTRAINT `fk_room_room_type` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, '801', 1, 8, 'AVAILABLE', 'READY');
INSERT INTO `room` VALUES (2, '802', 1, 8, 'AVAILABLE', 'READY');
INSERT INTO `room` VALUES (3, '901', 2, 9, 'AVAILABLE', 'READY');
INSERT INTO `room` VALUES (4, '902', 2, 9, 'OCCUPIED', 'CLEANING');
INSERT INTO `room` VALUES (5, '1001', 3, 10, 'AVAILABLE', 'READY');
INSERT INTO `room` VALUES (6, '1002', 3, 10, 'MAINTENANCE', 'BLOCKED');

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `base_price` decimal(10, 2) NOT NULL,
  `max_guests` int NOT NULL,
  `bed_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `area` int NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `amenities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES (1, '都市大床房', 498.00, 2, '1.8 米大床', 32, '适合商旅出行与城市短住。', '早餐, 无线网络, 智能电视');
INSERT INTO `room_type` VALUES (2, '花园双床房', 568.00, 2, '2 张 1.2 米单人床', 36, '安静楼层，窗户朝向庭院。', '早餐, 无线网络, 茶具');
INSERT INTO `room_type` VALUES (3, '行政套房', 968.00, 4, '1.8 米大床 + 沙发', 62, '客厅式布局，适合家庭或贵宾入住。', '早餐, 迷你吧, 浴缸');

SET FOREIGN_KEY_CHECKS = 1;
