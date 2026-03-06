-- 厨师上门服务平台数据库设计
-- 数据库名称：cookerc come

-- 创建数据库
CREATE DATABASE IF NOT EXISTS cookerc come DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE cookerc come;

-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `username` VARCHAR(50) NOT NULL COMMENT '用户名',
  `password` VARCHAR(255) NOT NULL COMMENT '密码（加密）',
  `phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',
  `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
  `real_name` VARCHAR(50) DEFAULT NULL COMMENT '真实姓名',
  `id_card` VARCHAR(20) DEFAULT NULL COMMENT '身份证号',
  `user_type` TINYINT NOT NULL DEFAULT 1 COMMENT '用户类型：1-普通用户，2-厨师',
  `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像 URL',
  `gender` TINYINT DEFAULT 0 COMMENT '性别：0-女，1-男',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-正常',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除标志：0-未删除，1-已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_phone` (`phone`),
  KEY `idx_user_type` (`user_type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 厨师信息表
DROP TABLE IF EXISTS `chef`;
CREATE TABLE `chef` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `user_id` BIGINT NOT NULL COMMENT '用户 ID',
  `chef_no` VARCHAR(50) NOT NULL COMMENT '厨师编号',
  `work_years` INT DEFAULT 0 COMMENT '工作年限',
  `specialty` VARCHAR(500) DEFAULT NULL COMMENT '擅长菜系（逗号分隔）',
  `level` TINYINT NOT NULL DEFAULT 1 COMMENT '厨师等级：1-初级，2-中级，3-高级，4-名厨',
  `service_count` INT DEFAULT 0 COMMENT '服务次数',
  `rating` DECIMAL(3,2) DEFAULT 5.00 COMMENT '评分',
  `base_price` DECIMAL(10,2) DEFAULT 0.00 COMMENT '起步价',
  `service_radius` INT DEFAULT 10 COMMENT '服务半径（公里）',
  `longitude` DECIMAL(10,7) DEFAULT NULL COMMENT '经度',
  `latitude` DECIMAL(10,7) DEFAULT NULL COMMENT '纬度',
  `address` VARCHAR(255) DEFAULT NULL COMMENT '详细地址',
  `introduction` TEXT COMMENT '简介',
  `certificates` VARCHAR(1000) DEFAULT NULL COMMENT '资质证书图片（逗号分隔）',
  `audit_status` TINYINT NOT NULL DEFAULT 0 COMMENT '审核状态：0-待审核，1-通过，2-拒绝',
  `online_status` TINYINT NOT NULL DEFAULT 0 COMMENT '上架状态：0-下架，1-上架',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除标志：0-未删除，1-已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  UNIQUE KEY `uk_chef_no` (`chef_no`),
  KEY `idx_level` (`level`),
  KEY `idx_audit_status` (`audit_status`),
  KEY `idx_online_status` (`online_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='厨师信息表';

-- 订单表
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
  `user_id` BIGINT NOT NULL COMMENT '用户 ID',
  `chef_id` BIGINT NOT NULL COMMENT '厨师 ID',
  `address_id` BIGINT DEFAULT NULL COMMENT '服务地址 ID',
  `appointment_time` DATETIME NOT NULL COMMENT '预约时间',
  `duration` INT DEFAULT 2 COMMENT '预计服务时长（小时）',
  `guest_count` INT DEFAULT 4 COMMENT '用餐人数',
  `dish_requirement` VARCHAR(500) DEFAULT NULL COMMENT '菜品要求',
  `taste_requirement` VARCHAR(200) DEFAULT NULL COMMENT '口味要求',
  `ingredient_mode` TINYINT NOT NULL DEFAULT 1 COMMENT '食材方式：1-厨师代购，2-用户自备',
  `ingredient_fee` DECIMAL(10,2) DEFAULT 0.00 COMMENT '食材费用',
  `service_fee` DECIMAL(10,2) DEFAULT 0.00 COMMENT '服务费',
  `total_fee` DECIMAL(10,2) DEFAULT 0.00 COMMENT '总费用',
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '订单状态：0-待支付，1-待接单，2-已接单，3-服务中，4-已完成，5-已取消，6-已退款',
  `payment_method` TINYINT DEFAULT NULL COMMENT '支付方式：1-微信，2-支付宝',
  `payment_time` DATETIME DEFAULT NULL COMMENT '支付时间',
  `transaction_id` VARCHAR(100) DEFAULT NULL COMMENT '交易流水号',
  `cancel_reason` VARCHAR(500) DEFAULT NULL COMMENT '取消原因',
  `remark` VARCHAR(500) DEFAULT NULL COMMENT '备注',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除标志：0-未删除，1-已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_chef_id` (`chef_id`),
  KEY `idx_status` (`status`),
  KEY `idx_appointment_time` (`appointment_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- 菜品表
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `chef_id` BIGINT NOT NULL COMMENT '厨师 ID',
  `name` VARCHAR(100) NOT NULL COMMENT '菜品名称',
  `category` TINYINT DEFAULT 1 COMMENT '菜品分类：1-川菜，2-粤菜，3-浙菜，4-苏菜，5-湘菜，6-徽菜，7-闽菜，8-鲁菜',
  `image` VARCHAR(255) DEFAULT NULL COMMENT '菜品图片 URL',
  `price` DECIMAL(10,2) DEFAULT 0.00 COMMENT '价格',
  `cook_time` INT DEFAULT 30 COMMENT '制作时长（分钟）',
  `spicy_level` TINYINT DEFAULT 0 COMMENT '辣度：0-不辣，1-微辣，2-中辣，3-特辣',
  `taste_tags` VARCHAR(200) DEFAULT NULL COMMENT '口味标签（逗号分隔）',
  `ingredients` VARCHAR(500) DEFAULT NULL COMMENT '食材清单',
  `steps` TEXT COMMENT '制作步骤',
  `order_count` INT DEFAULT 0 COMMENT '点单次数',
  `good_review_count` INT DEFAULT 0 COMMENT '好评数',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态：0-下架，1-上架',
  `sort` INT DEFAULT 0 COMMENT '排序',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除标志：0-未删除，1-已删除',
  PRIMARY KEY (`id`),
  KEY `idx_chef_id` (`chef_id`),
  KEY `idx_category` (`category`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜品表';

-- 评价表
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `order_id` BIGINT NOT NULL COMMENT '订单 ID',
  `user_id` BIGINT NOT NULL COMMENT '用户 ID',
  `chef_id` BIGINT NOT NULL COMMENT '厨师 ID',
  `rating` TINYINT NOT NULL DEFAULT 5 COMMENT '评分（1-5 星）',
  `content` TEXT COMMENT '评价内容',
  `images` VARCHAR(1000) DEFAULT NULL COMMENT '图片列表（逗号分隔）',
  `taste_score` TINYINT DEFAULT 5 COMMENT '口味评分',
  `service_score` TINYINT DEFAULT 5 COMMENT '服务评分',
  `value_score` TINYINT DEFAULT 5 COMMENT '性价比评分',
  `reply` TEXT COMMENT '回复内容',
  `reply_time` DATETIME DEFAULT NULL COMMENT '回复时间',
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态：0-未回复，1-已回复',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除标志：0-未删除，1-已删除',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_chef_id` (`chef_id`),
  KEY `idx_rating` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评价表';

-- 用户地址表
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `user_id` BIGINT NOT NULL COMMENT '用户 ID',
  `contact_name` VARCHAR(50) NOT NULL COMMENT '联系人姓名',
  `contact_phone` VARCHAR(20) NOT NULL COMMENT '联系电话',
  `province` VARCHAR(50) DEFAULT NULL COMMENT '省份',
  `city` VARCHAR(50) DEFAULT NULL COMMENT '城市',
  `district` VARCHAR(50) DEFAULT NULL COMMENT '区县',
  `detail_address` VARCHAR(255) DEFAULT NULL COMMENT '详细地址',
  `full_address` VARCHAR(500) DEFAULT NULL COMMENT '完整地址',
  `longitude` DECIMAL(10,7) DEFAULT NULL COMMENT '经度',
  `latitude` DECIMAL(10,7) DEFAULT NULL COMMENT '纬度',
  `is_default` TINYINT NOT NULL DEFAULT 0 COMMENT '是否默认：0-否，1-是',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除标志：0-未删除，1-已删除',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户地址表';

-- 初始化数据

-- 插入测试用户
INSERT INTO `user` (`username`, `password`, `phone`, `user_type`, `status`) VALUES
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iDJqp9Sx.VqKlVpLxCwZBvFqjXoC', '13800138000', 1, 1),
('chef1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iDJqp9Sx.VqKlVpLxCwZBvFqjXoC', '13800138001', 2, 1),
('user1', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iDJqp9Sx.VqKlVpLxCwZBvFqjXoC', '13800138002', 1, 1);

-- 插入测试厨师
INSERT INTO `chef` (`user_id`, `chef_no`, `work_years`, `specialty`, `level`, `service_count`, `rating`, `base_price`, `service_radius`, `audit_status`, `online_status`) VALUES
(2, 'CH000001', 5, '川菜，湘菜', 3, 100, 4.9, 150, 10, 1, 1),
(2, 'CH000002', 3, '粤菜，闽菜', 2, 50, 4.8, 120, 8, 1, 1);

-- 插入测试菜品
INSERT INTO `dish` (`chef_id`, `name`, `category`, `price`, `cook_time`, `spicy_level`, `status`) VALUES
(1, '宫保鸡丁', 1, 38.00, 20, 2, 1),
(1, '麻婆豆腐', 1, 28.00, 15, 3, 1),
(1, '回锅肉', 1, 48.00, 25, 2, 1),
(2, '白切鸡', 2, 58.00, 30, 0, 1),
(2, '清蒸石斑鱼', 2, 88.00, 25, 0, 1);
