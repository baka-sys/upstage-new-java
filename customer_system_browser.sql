/*
 Navicat Premium Dump SQL

 Source Server         : 本地服务器
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : 127.0.0.1:3306
 Source Schema         : customer_system_browser

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 02/08/2026 10:44:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cs_account
-- ----------------------------
DROP TABLE IF EXISTS `cs_account`;
CREATE TABLE `cs_account`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `img` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号头像',
  `account_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账户名称',
  `account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号密码',
  `phone_number` bigint(11) NULL DEFAULT NULL COMMENT '手机号码',
  `account_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录唯一key',
  `points` double(16, 2) NULL DEFAULT 0.00 COMMENT '积分',
  `status` int(1) NULL DEFAULT 0 COMMENT '账号状态：0:启用状态，1：禁用状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `login_time` datetime NULL DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员总表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_account
-- ----------------------------
INSERT INTO `cs_account` VALUES (1, 'http://taobao626080.cn/641_1742896678769.png', '测试账号1111', 'admin', '$2a$10$PHidlBuDFKq74IQJ53dKTeLswPykIiqrpRgVx4.qMLPsYjfaNSpM.', 18802353737, 'abc123456789', 1800.00, 0, '2025-03-28 15:29:53', '2025-06-17 15:54:41', NULL);
INSERT INTO `cs_account` VALUES (2, NULL, '123123', 'ceshi2222', '$2a$10$NP9RYA3RKhi4yVffk/6fQ.ZP0oXJms2jQBAx8cJQBvk9oEUA4rAby', 123123, '49db41cc8b404849933c465e6c333fed', 300.00, 0, '2025-03-28 10:31:06', '2025-03-28 16:19:59', NULL);

-- ----------------------------
-- Table structure for cs_account_points_record
-- ----------------------------
DROP TABLE IF EXISTS `cs_account_points_record`;
CREATE TABLE `cs_account_points_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NULL DEFAULT NULL COMMENT '管理账号id',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型:1、充值，2、消费',
  `points` double(16, 2) NULL DEFAULT NULL COMMENT '积分',
  `before_operation` double(16, 2) NULL DEFAULT NULL COMMENT '操作前积分',
  `after_operation` double(16, 2) NULL DEFAULT NULL COMMENT '操作后积分',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分消费记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_account_points_record
-- ----------------------------

-- ----------------------------
-- Table structure for cs_admin
-- ----------------------------
DROP TABLE IF EXISTS `cs_admin`;
CREATE TABLE `cs_admin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '总后台账号表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_admin
-- ----------------------------
INSERT INTO `cs_admin` VALUES (1, 'dabao', '$2a$10$dddzq0fqe7aVsPAEm5P9/e0VjwPgIyrVq/imNZ7XVYq8Ok4LnzU3y', '2025-03-28 14:29:57', '2025-03-28 14:29:59');

-- ----------------------------
-- Table structure for cs_asked_questions
-- ----------------------------
DROP TABLE IF EXISTS `cs_asked_questions`;
CREATE TABLE `cs_asked_questions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '常见问题标题',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '账号id',
  `account_type` int(1) NULL DEFAULT NULL COMMENT '账号类型：1：客服，2、管理账号',
  `status` int(1) NULL DEFAULT 0 COMMENT '0:启用，1禁用',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '智能问答' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_asked_questions
-- ----------------------------

-- ----------------------------
-- Table structure for cs_asked_questions_son
-- ----------------------------
DROP TABLE IF EXISTS `cs_asked_questions_son`;
CREATE TABLE `cs_asked_questions_son`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_type` int(1) NULL DEFAULT 0 COMMENT '账号类型:0 客服账号，1、企业账号',
  `main_id` bigint(20) NULL DEFAULT NULL,
  `question_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `answer_type` int(1) NULL DEFAULT 0,
  `answer_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `sort` int(11) NULL DEFAULT 0,
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_asked_questions_son
-- ----------------------------

-- ----------------------------
-- Table structure for cs_auto_reply
-- ----------------------------
DROP TABLE IF EXISTS `cs_auto_reply`;
CREATE TABLE `cs_auto_reply`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_type` int(1) NULL DEFAULT NULL COMMENT '0 客服，1企业',
  `user_id` bigint(20) NULL DEFAULT NULL,
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `type` int(1) NULL DEFAULT NULL COMMENT '回复类型:1：文字，2：图片,3、定位，4：智能问答、5、音频，6、视频',
  `mode_type` int(1) NULL DEFAULT 1 COMMENT '1，半匹配，2，全匹配',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `status` int(1) NULL DEFAULT 0 COMMENT '状态:0：开启,1：关闭',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自动回复' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_auto_reply
-- ----------------------------
INSERT INTO `cs_auto_reply` VALUES (1, 0, 1, '1', 1, 1, '<p>1</p>', 0, 1000, '2026-06-12 15:24:45', NULL);
INSERT INTO `cs_auto_reply` VALUES (2, 0, 1, '2', 1, 1, '<p>2</p>', 0, 1001, '2026-06-12 15:24:49', NULL);
INSERT INTO `cs_auto_reply` VALUES (3, 0, 1, '3', 1, 1, '<p>3</p>', 0, 1002, '2026-06-12 15:24:53', NULL);
INSERT INTO `cs_auto_reply` VALUES (4, 0, 1, '4', 1, 1, '<p>4</p>', 0, 1003, '2026-06-12 15:24:58', NULL);
INSERT INTO `cs_auto_reply` VALUES (5, 0, 1, '5', 1, 1, '<p>5</p>', 0, 1004, '2026-06-12 15:25:03', NULL);
INSERT INTO `cs_auto_reply` VALUES (6, 0, 1, '6', 1, 1, '<p>6</p>', 0, 1005, '2026-06-12 15:25:09', NULL);
INSERT INTO `cs_auto_reply` VALUES (7, 0, 1, '7', 1, 1, '<p>7</p>', 0, 1006, '2026-06-12 15:25:15', NULL);
INSERT INTO `cs_auto_reply` VALUES (8, 0, 1, '8', 1, 1, '<p>8</p>', 0, 1007, '2026-06-12 15:25:20', NULL);
INSERT INTO `cs_auto_reply` VALUES (9, 0, 1, '9', 1, 1, '<p>9</p>', 0, 1008, '2026-06-12 15:25:25', NULL);
INSERT INTO `cs_auto_reply` VALUES (10, 0, 1, '10', 1, 1, '<p>10</p>', 0, 1009, '2026-06-12 15:25:31', NULL);
INSERT INTO `cs_auto_reply` VALUES (11, 0, 1, '11', 1, 1, '<p>11</p>', 0, 1010, '2026-06-12 15:25:37', NULL);
INSERT INTO `cs_auto_reply` VALUES (12, 0, 73, '1,2', 17, 2, '自动回复测试标题测试一下', 0, 1000, '2026-07-02 01:04:02', '2026-07-03 22:56:46');
INSERT INTO `cs_auto_reply` VALUES (13, 0, 73, '123', 1, 1, '<p>半匹配模式</p>', 0, 1001, '2026-07-02 01:06:21', '2026-07-02 01:06:35');
INSERT INTO `cs_auto_reply` VALUES (14, 0, 74, '1,2', 1, 2, '<p>全匹配模式</p>', 0, 1000, '2026-07-02 01:17:32', NULL);
INSERT INTO `cs_auto_reply` VALUES (15, 0, 74, '123', 1, 1, '<p>半匹配模式</p>', 0, 1001, '2026-07-02 01:17:32', NULL);
INSERT INTO `cs_auto_reply` VALUES (16, 0, 179, '1', 17, 2, '自动回复表单卡填写', 0, 1000, '2026-07-04 17:34:17', NULL);
INSERT INTO `cs_auto_reply` VALUES (17, 0, 179, '提交成功', 1, 2, '<p>你提交的表单已经成功了</p>', 0, 1001, '2026-07-04 18:51:25', NULL);

-- ----------------------------
-- Table structure for cs_avatar
-- ----------------------------
DROP TABLE IF EXISTS `cs_avatar`;
CREATE TABLE `cs_avatar`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 194 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '头像库' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_avatar
-- ----------------------------
INSERT INTO `cs_avatar` VALUES (1, '/avatar/avatar_1747757818826.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (2, '/avatar/avatar_1747757818834.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (3, '/avatar/avatar_1747757818842.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (4, '/avatar/avatar_1747757818851.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (5, '/avatar/avatar_1747757818860.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (6, '/avatar/avatar_1747757818862.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (7, '/avatar/avatar_1747757818921.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (8, '/avatar/avatar_1747757818922.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (9, '/avatar/avatar_1747757818923.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (10, '/avatar/avatar_1747757818923.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (11, '/avatar/avatar_1747757818923.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (12, '/avatar/avatar_1747757818923.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (13, '/avatar/avatar_1747757818939.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (14, '/avatar/avatar_1747757818939.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (15, '/avatar/avatar_1747757818939.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (16, '/avatar/avatar_1747757818939.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (17, '/avatar/avatar_1747757819105.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (18, '/avatar/avatar_1747757819108.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (19, '/avatar/avatar_1747757819116.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (20, '/avatar/avatar_1747757819151.jpg', '2025-05-21 00:16:59', NULL);
INSERT INTO `cs_avatar` VALUES (21, '/avatar/avatar_1747757835668.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (22, '/avatar/avatar_1747757835675.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (23, '/avatar/avatar_1747757835682.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (24, '/avatar/avatar_1747757835689.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (25, '/avatar/avatar_1747757835692.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (26, '/avatar/avatar_1747757835694.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (27, '/avatar/avatar_1747757835703.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (28, '/avatar/avatar_1747757835804.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (29, '/avatar/avatar_1747757835812.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (30, '/avatar/avatar_1747757835818.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (31, '/avatar/avatar_1747757835871.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (32, '/avatar/avatar_1747757835885.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (33, '/avatar/avatar_1747757835922.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (34, '/avatar/avatar_1747757835928.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (35, '/avatar/avatar_1747757835936.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (36, '/avatar/avatar_1747757835980.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (37, '/avatar/avatar_1747757835984.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (38, '/avatar/avatar_1747757835991.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (39, '/avatar/avatar_1747757835993.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (40, '/avatar/avatar_1747757835999.jpg', '2025-05-21 00:17:16', NULL);
INSERT INTO `cs_avatar` VALUES (41, '/avatar/avatar_1747757854491.jpg', '2025-05-21 00:17:34', NULL);
INSERT INTO `cs_avatar` VALUES (42, '/avatar/avatar_1747757854494.jpg', '2025-05-21 00:17:34', NULL);
INSERT INTO `cs_avatar` VALUES (43, '/avatar/avatar_1747757854499.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (44, '/avatar/avatar_1747757854505.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (45, '/avatar/avatar_1747757854508.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (46, '/avatar/avatar_1747757854574.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (47, '/avatar/avatar_1747757854615.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (48, '/avatar/avatar_1747757854621.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (49, '/avatar/avatar_1747757854624.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (50, '/avatar/avatar_1747757854627.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (51, '/avatar/avatar_1747757854631.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (52, '/avatar/avatar_1747757854734.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (53, '/avatar/avatar_1747757854738.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (54, '/avatar/avatar_1747757854792.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (55, '/avatar/avatar_1747757854793.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (56, '/avatar/avatar_1747757854800.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (57, '/avatar/avatar_1747757854803.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (58, '/avatar/avatar_1747757854811.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (59, '/avatar/avatar_1747757854896.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (60, '/avatar/avatar_1747757854903.jpg', '2025-05-21 00:17:35', NULL);
INSERT INTO `cs_avatar` VALUES (61, '/avatar/avatar_1747757874794.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (62, '/avatar/avatar_1747757874798.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (63, '/avatar/avatar_1747757874805.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (64, '/avatar/avatar_1747757874812.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (65, '/avatar/avatar_1747757874815.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (66, '/avatar/avatar_1747757874818.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (67, '/avatar/avatar_1747757874841.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (68, '/avatar/avatar_1747757874841.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (69, '/avatar/avatar_1747757874841.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (70, '/avatar/avatar_1747757874841.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (71, '/avatar/avatar_1747757875051.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (72, '/avatar/avatar_1747757875057.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (73, '/avatar/avatar_1747757875103.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (74, '/avatar/avatar_1747757875107.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (75, '/avatar/avatar_1747757875116.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (76, '/avatar/avatar_1747757875119.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (77, '/avatar/avatar_1747757875206.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (78, '/avatar/avatar_1747757875215.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (79, '/avatar/avatar_1747757875262.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (80, '/avatar/avatar_1747757875271.jpg', '2025-05-21 00:17:55', NULL);
INSERT INTO `cs_avatar` VALUES (81, '/avatar/avatar_1747757890860.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (82, '/avatar/avatar_1747757890866.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (83, '/avatar/avatar_1747757890941.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (84, '/avatar/avatar_1747757890949.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (85, '/avatar/avatar_1747757891016.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (86, '/avatar/avatar_1747757891052.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (87, '/avatar/avatar_1747757891101.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (88, '/avatar/avatar_1747757891106.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (89, '/avatar/avatar_1747757891111.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (90, '/avatar/avatar_1747757891117.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (91, '/avatar/avatar_1747757891221.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (92, '/avatar/avatar_1747757891229.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (93, '/avatar/avatar_1747757891291.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (94, '/avatar/avatar_1747757891300.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (95, '/avatar/avatar_1747757891303.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (96, '/avatar/avatar_1747757891380.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (97, '/avatar/avatar_1747757891435.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (98, '/avatar/avatar_1747757891437.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (99, '/avatar/avatar_1747757891443.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (100, '/avatar/avatar_1747757891446.jpg', '2025-05-21 00:18:11', NULL);
INSERT INTO `cs_avatar` VALUES (101, '/avatar/avatar_1747757903224.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (102, '/avatar/avatar_1747757903229.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (103, '/avatar/avatar_1747757903297.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (104, '/avatar/avatar_1747757903304.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (105, '/avatar/avatar_1747757903372.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (106, '/avatar/avatar_1747757903425.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (107, '/avatar/avatar_1747757903427.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (108, '/avatar/avatar_1747757903431.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (109, '/avatar/avatar_1747757903462.jpg', '2025-05-21 00:18:23', NULL);
INSERT INTO `cs_avatar` VALUES (110, '/avatar/avatar_1747757903557.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (111, '/avatar/avatar_1747757903559.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (112, '/avatar/avatar_1747757903566.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (113, '/avatar/avatar_1747757903569.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (114, '/avatar/avatar_1747757903576.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (115, '/avatar/avatar_1747757903741.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (116, '/avatar/avatar_1747757903746.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (117, '/avatar/avatar_1747757903803.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (118, '/avatar/avatar_1747757903837.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (119, '/avatar/avatar_1747757903842.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (120, '/avatar/avatar_1747757903844.jpg', '2025-05-21 00:18:24', NULL);
INSERT INTO `cs_avatar` VALUES (121, '/avatar/avatar_1747757918075.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (122, '/avatar/avatar_1747757918082.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (123, '/avatar/avatar_1747757918165.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (124, '/avatar/avatar_1747757918172.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (125, '/avatar/avatar_1747757918275.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (126, '/avatar/avatar_1747757918280.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (127, '/avatar/avatar_1747757918284.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (128, '/avatar/avatar_1747757918397.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (129, '/avatar/avatar_1747757918400.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (130, '/avatar/avatar_1747757918409.jpg', '2025-05-21 00:18:38', NULL);
INSERT INTO `cs_avatar` VALUES (131, '/avatar/avatar_1747757918516.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (132, '/avatar/avatar_1747757918521.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (133, '/avatar/avatar_1747757918586.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (134, '/avatar/avatar_1747757918591.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (135, '/avatar/avatar_1747757918594.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (136, '/avatar/avatar_1747757918796.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (137, '/avatar/avatar_1747757918839.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (138, '/avatar/avatar_1747757918844.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (139, '/avatar/avatar_1747757918847.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (140, '/avatar/avatar_1747757918943.jpg', '2025-05-21 00:18:39', NULL);
INSERT INTO `cs_avatar` VALUES (141, '/avatar/avatar_1747757929802.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (142, '/avatar/avatar_1747757929808.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (143, '/avatar/avatar_1747757929816.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (144, '/avatar/avatar_1747757929822.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (145, '/avatar/avatar_1747757929993.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (146, '/avatar/avatar_1747757929999.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (147, '/avatar/avatar_1747757930010.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (148, '/avatar/avatar_1747757930132.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (149, '/avatar/avatar_1747757930137.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (150, '/avatar/avatar_1747757930145.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (151, '/avatar/avatar_1747757930149.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (152, '/avatar/avatar_1747757930296.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (153, '/avatar/avatar_1747757930342.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (154, '/avatar/avatar_1747757930350.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (155, '/avatar/avatar_1747757930430.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (156, '/avatar/avatar_1747757930491.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (157, '/avatar/avatar_1747757930499.jpg', '2025-05-21 00:18:50', NULL);
INSERT INTO `cs_avatar` VALUES (158, '/avatar/avatar_1747757930788.jpg', '2025-05-21 00:18:51', NULL);
INSERT INTO `cs_avatar` VALUES (159, '/avatar/avatar_1747757930796.jpg', '2025-05-21 00:18:51', NULL);
INSERT INTO `cs_avatar` VALUES (160, '/avatar/avatar_1747757930798.jpg', '2025-05-21 00:18:51', NULL);
INSERT INTO `cs_avatar` VALUES (161, '/avatar/avatar_1747757943869.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (162, '/avatar/avatar_1747757943877.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (163, '/avatar/avatar_1747757943989.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (164, '/avatar/avatar_1747757943996.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (165, '/avatar/avatar_1747757944005.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (166, '/avatar/avatar_1747757944156.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (167, '/avatar/avatar_1747757944162.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (168, '/avatar/avatar_1747757944203.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (169, '/avatar/avatar_1747757944308.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (170, '/avatar/avatar_1747757944312.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (171, '/avatar/avatar_1747757944398.jpg', '2025-05-21 00:19:04', NULL);
INSERT INTO `cs_avatar` VALUES (172, '/avatar/avatar_1747757944610.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (173, '/avatar/avatar_1747757944618.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (174, '/avatar/avatar_1747757944620.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (175, '/avatar/avatar_1747757944745.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (176, '/avatar/avatar_1747757944939.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (177, '/avatar/avatar_1747757944946.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (178, '/avatar/avatar_1747757944951.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (179, '/avatar/avatar_1747757945088.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (180, '/avatar/avatar_1747757945095.jpg', '2025-05-21 00:19:05', NULL);
INSERT INTO `cs_avatar` VALUES (181, '/avatar/avatar_1747757955727.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (182, '/avatar/avatar_1747757955731.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (183, '/avatar/avatar_1747757955732.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (184, '/avatar/avatar_1747757955741.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (185, '/avatar/avatar_1747757955922.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (186, '/avatar/avatar_1747757955981.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (187, '/avatar/avatar_1747757955986.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (188, '/avatar/avatar_1747757956082.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (189, '/avatar/avatar_1747757956090.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (190, '/avatar/avatar_1747757956093.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (191, '/avatar/avatar_1747757956105.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (192, '/avatar/avatar_1747757956302.jpg', '2025-05-21 00:19:16', NULL);
INSERT INTO `cs_avatar` VALUES (193, '/avatar/avatar_1747757956307.jpg', '2025-05-21 00:19:16', NULL);

-- ----------------------------
-- Table structure for cs_chat_session
-- ----------------------------
DROP TABLE IF EXISTS `cs_chat_session`;
CREATE TABLE `cs_chat_session`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_id` bigint(20) NULL DEFAULT NULL COMMENT '主id',
  `to_id` bigint(20) NULL DEFAULT NULL COMMENT '到id',
  `setting_top` int(1) NULL DEFAULT NULL COMMENT '置顶：0不置顶,1置顶',
  `type` int(1) NULL DEFAULT NULL COMMENT '会话类型: 0：单聊，1群聊',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fromid,toid`(`from_id` ASC, `to_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会话表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_chat_session
-- ----------------------------
INSERT INTO `cs_chat_session` VALUES (1, 61, 143, 0, 0, '2026-06-20 21:12:45', 1781961165315);
INSERT INTO `cs_chat_session` VALUES (2, 61, 144, 0, 0, '2026-06-24 15:38:33', 1782286713460);
INSERT INTO `cs_chat_session` VALUES (3, 71, 126, 0, 0, '2026-06-30 02:18:21', 1782757100852);
INSERT INTO `cs_chat_session` VALUES (4, 71, 84, 0, 0, '2026-06-30 02:18:21', 1782757101143);
INSERT INTO `cs_chat_session` VALUES (5, 72, 108, 0, 0, '2026-06-30 02:18:21', 1782757101185);
INSERT INTO `cs_chat_session` VALUES (6, 71, 122, 0, 0, '2026-06-30 02:18:21', 1782757101201);
INSERT INTO `cs_chat_session` VALUES (7, 71, 95, 0, 0, '2026-06-30 02:18:21', 1782757101272);
INSERT INTO `cs_chat_session` VALUES (8, 1, 24, 0, 0, '2026-06-30 02:18:21', 1782757101308);
INSERT INTO `cs_chat_session` VALUES (9, 62, 91, 0, 0, '2026-06-30 02:18:21', 1782757101398);
INSERT INTO `cs_chat_session` VALUES (10, 71, 85, 0, 0, '2026-06-30 02:18:21', 1782757101433);
INSERT INTO `cs_chat_session` VALUES (11, 71, 93, 0, 0, '2026-06-30 02:18:21', 1782757101462);
INSERT INTO `cs_chat_session` VALUES (12, 71, 119, 0, 0, '2026-06-30 02:18:21', 1782757101481);
INSERT INTO `cs_chat_session` VALUES (14, 71, 101, 0, 0, '2026-06-30 02:18:22', 1782757101610);
INSERT INTO `cs_chat_session` VALUES (15, 71, 94, 0, 0, '2026-06-30 02:18:22', 1782757101630);
INSERT INTO `cs_chat_session` VALUES (16, 71, 124, 0, 0, '2026-06-30 02:18:22', 1782757101661);
INSERT INTO `cs_chat_session` VALUES (17, 1, 25, 0, 0, '2026-06-30 02:18:22', 1782757101675);
INSERT INTO `cs_chat_session` VALUES (18, 71, 135, 0, 0, '2026-06-30 02:18:22', 1782757101697);
INSERT INTO `cs_chat_session` VALUES (19, 71, 77, 0, 0, '2026-06-30 02:18:22', 1782757101711);
INSERT INTO `cs_chat_session` VALUES (20, 71, 78, 0, 0, '2026-06-30 02:18:22', 1782757101727);
INSERT INTO `cs_chat_session` VALUES (21, 71, 81, 0, 0, '2026-06-30 02:18:22', 1782757101742);
INSERT INTO `cs_chat_session` VALUES (22, 71, 83, 0, 0, '2026-06-30 02:18:22', 1782757101767);
INSERT INTO `cs_chat_session` VALUES (23, 72, 137, 0, 0, '2026-06-30 02:18:22', 1782757101777);
INSERT INTO `cs_chat_session` VALUES (24, 1, 60, 0, 0, '2026-06-30 02:18:22', 1782757101798);
INSERT INTO `cs_chat_session` VALUES (25, 1, 62, 0, 0, '2026-06-30 02:18:22', 1782757101816);
INSERT INTO `cs_chat_session` VALUES (26, 71, 80, 0, 0, '2026-06-30 02:18:22', 1782757101829);
INSERT INTO `cs_chat_session` VALUES (27, 71, 79, 0, 0, '2026-06-30 02:18:22', 1782757101842);
INSERT INTO `cs_chat_session` VALUES (28, 71, 88, 0, 0, '2026-06-30 02:18:22', 1782757101859);
INSERT INTO `cs_chat_session` VALUES (29, 62, 89, 0, 0, '2026-06-30 02:18:22', 1782757101870);
INSERT INTO `cs_chat_session` VALUES (30, 71, 99, 0, 0, '2026-06-30 02:18:22', 1782757101880);
INSERT INTO `cs_chat_session` VALUES (31, 71, 102, 0, 0, '2026-06-30 02:18:22', 1782757101892);
INSERT INTO `cs_chat_session` VALUES (32, 73, 116, 0, 0, '2026-06-30 02:18:22', 1782757101906);
INSERT INTO `cs_chat_session` VALUES (33, 71, 118, 0, 0, '2026-06-30 02:18:22', 1782757101915);
INSERT INTO `cs_chat_session` VALUES (34, 71, 131, 0, 0, '2026-06-30 02:18:22', 1782757101925);
INSERT INTO `cs_chat_session` VALUES (35, 71, 134, 0, 0, '2026-06-30 02:18:22', 1782757101934);
INSERT INTO `cs_chat_session` VALUES (36, 71, 138, 0, 0, '2026-06-30 02:18:22', 1782757101941);
INSERT INTO `cs_chat_session` VALUES (37, 1, 21, 0, 0, '2026-06-30 02:18:22', 1782757101950);
INSERT INTO `cs_chat_session` VALUES (38, 1, 22, 0, 0, '2026-06-30 02:18:22', 1782757101957);
INSERT INTO `cs_chat_session` VALUES (39, 71, 76, 0, 0, '2026-06-30 02:18:22', 1782757101965);
INSERT INTO `cs_chat_session` VALUES (40, 71, 82, 0, 0, '2026-06-30 02:18:22', 1782757101975);
INSERT INTO `cs_chat_session` VALUES (41, 71, 92, 0, 0, '2026-06-30 02:18:22', 1782757101984);
INSERT INTO `cs_chat_session` VALUES (42, 62, 100, 0, 0, '2026-06-30 02:18:22', 1782757101993);
INSERT INTO `cs_chat_session` VALUES (43, 71, 104, 0, 0, '2026-06-30 02:18:22', 1782757102002);
INSERT INTO `cs_chat_session` VALUES (44, 62, 105, 0, 0, '2026-06-30 02:18:22', 1782757102013);
INSERT INTO `cs_chat_session` VALUES (45, 71, 106, 0, 0, '2026-06-30 02:18:22', 1782757102025);
INSERT INTO `cs_chat_session` VALUES (46, 73, 110, 0, 0, '2026-06-30 02:18:22', 1782757102034);
INSERT INTO `cs_chat_session` VALUES (47, 73, 112, 0, 0, '2026-06-30 02:18:22', 1782757102042);
INSERT INTO `cs_chat_session` VALUES (48, 73, 114, 0, 0, '2026-06-30 02:18:22', 1782757102053);
INSERT INTO `cs_chat_session` VALUES (49, 71, 117, 0, 0, '2026-06-30 02:18:22', 1782757102061);
INSERT INTO `cs_chat_session` VALUES (50, 71, 127, 0, 0, '2026-06-30 02:18:22', 1782757102070);
INSERT INTO `cs_chat_session` VALUES (51, 71, 129, 0, 0, '2026-06-30 02:18:22', 1782757102078);
INSERT INTO `cs_chat_session` VALUES (52, 71, 130, 0, 0, '2026-06-30 02:18:22', 1782757102086);
INSERT INTO `cs_chat_session` VALUES (53, 71, 132, 0, 0, '2026-06-30 02:18:22', 1782757102093);
INSERT INTO `cs_chat_session` VALUES (54, 72, 133, 0, 0, '2026-06-30 02:18:22', 1782757102100);
INSERT INTO `cs_chat_session` VALUES (55, 61, 139, 0, 0, '2026-06-30 02:18:22', 1782757102107);
INSERT INTO `cs_chat_session` VALUES (56, 61, 140, 0, 0, '2026-06-30 02:18:22', 1782757102113);
INSERT INTO `cs_chat_session` VALUES (57, 61, 142, 0, 0, '2026-06-30 02:18:22', 1782757102120);
INSERT INTO `cs_chat_session` VALUES (58, 1, 23, 0, 0, '2026-06-30 02:18:22', 1782757102127);
INSERT INTO `cs_chat_session` VALUES (59, 71, 86, 0, 0, '2026-06-30 02:18:22', 1782757102133);
INSERT INTO `cs_chat_session` VALUES (60, 71, 87, 0, 0, '2026-06-30 02:18:22', 1782757102139);
INSERT INTO `cs_chat_session` VALUES (61, 62, 90, 0, 0, '2026-06-30 02:18:22', 1782757102144);
INSERT INTO `cs_chat_session` VALUES (62, 62, 96, 0, 0, '2026-06-30 02:18:22', 1782757102150);
INSERT INTO `cs_chat_session` VALUES (63, 71, 97, 0, 0, '2026-06-30 02:18:22', 1782757102155);
INSERT INTO `cs_chat_session` VALUES (64, 71, 98, 0, 0, '2026-06-30 02:18:22', 1782757102160);
INSERT INTO `cs_chat_session` VALUES (65, 72, 103, 0, 0, '2026-06-30 02:18:22', 1782757102166);
INSERT INTO `cs_chat_session` VALUES (66, 71, 107, 0, 0, '2026-06-30 02:18:22', 1782757102171);
INSERT INTO `cs_chat_session` VALUES (67, 73, 109, 0, 0, '2026-06-30 02:18:22', 1782757102177);
INSERT INTO `cs_chat_session` VALUES (68, 73, 111, 0, 0, '2026-06-30 02:18:22', 1782757102184);
INSERT INTO `cs_chat_session` VALUES (69, 73, 113, 0, 0, '2026-06-30 02:18:22', 1782757102191);
INSERT INTO `cs_chat_session` VALUES (70, 74, 115, 0, 0, '2026-06-30 02:18:22', 1782757102197);
INSERT INTO `cs_chat_session` VALUES (71, 71, 120, 0, 0, '2026-06-30 02:18:22', 1782757102204);
INSERT INTO `cs_chat_session` VALUES (72, 71, 121, 0, 0, '2026-06-30 02:18:22', 1782757102212);
INSERT INTO `cs_chat_session` VALUES (73, 71, 123, 0, 0, '2026-06-30 02:18:22', 1782757102220);
INSERT INTO `cs_chat_session` VALUES (74, 71, 125, 0, 0, '2026-06-30 02:18:22', 1782757102227);
INSERT INTO `cs_chat_session` VALUES (75, 71, 128, 0, 0, '2026-06-30 02:18:22', 1782757102233);
INSERT INTO `cs_chat_session` VALUES (76, 71, 136, 0, 0, '2026-06-30 02:18:22', 1782757102238);
INSERT INTO `cs_chat_session` VALUES (77, 61, 141, 0, 0, '2026-06-30 02:18:22', 1782757102243);
INSERT INTO `cs_chat_session` VALUES (78, 61, 145, 0, 0, '2026-06-30 02:22:43', 1782757362720);
INSERT INTO `cs_chat_session` VALUES (79, 61, 146, 0, 0, '2026-06-30 02:36:42', 1782758202447);
INSERT INTO `cs_chat_session` VALUES (80, 61, 148, 0, 0, '2026-07-01 00:18:56', 1782836336039);
INSERT INTO `cs_chat_session` VALUES (81, 61, 147, 0, 0, '2026-07-01 00:18:56', 1782836336275);
INSERT INTO `cs_chat_session` VALUES (82, 61, 149, 0, 0, '2026-07-01 00:19:26', 1782836366413);
INSERT INTO `cs_chat_session` VALUES (83, 61, 150, 0, 0, '2026-07-01 02:42:11', 1782844930555);
INSERT INTO `cs_chat_session` VALUES (84, 61, 151, 0, 0, '2026-07-01 02:43:43', 1782845023134);
INSERT INTO `cs_chat_session` VALUES (85, 61, 152, 0, 0, '2026-07-01 02:45:14', 1782845114235);
INSERT INTO `cs_chat_session` VALUES (86, 73, 153, 0, 0, '2026-07-01 02:48:37', 1782845317145);
INSERT INTO `cs_chat_session` VALUES (87, 73, 154, 0, 0, '2026-07-01 02:49:04', 1782845343608);
INSERT INTO `cs_chat_session` VALUES (88, 74, 155, 0, 0, '2026-07-01 02:49:27', 1782845367260);
INSERT INTO `cs_chat_session` VALUES (89, 73, 156, 0, 0, '2026-07-01 02:50:09', 1782845409075);
INSERT INTO `cs_chat_session` VALUES (90, 73, 157, 0, 0, '2026-07-01 02:51:59', 1782845519144);
INSERT INTO `cs_chat_session` VALUES (91, 73, 158, 0, 0, '2026-07-01 03:14:32', 1782846871594);
INSERT INTO `cs_chat_session` VALUES (92, 73, 159, 0, 0, '2026-07-01 03:15:07', 1782846907272);
INSERT INTO `cs_chat_session` VALUES (93, 73, 160, 0, 0, '2026-07-01 03:15:19', 1782846918969);
INSERT INTO `cs_chat_session` VALUES (94, 73, 161, 0, 0, '2026-07-01 03:15:38', 1782846937690);
INSERT INTO `cs_chat_session` VALUES (95, 73, 162, 0, 0, '2026-07-01 03:47:01', 1782848820516);
INSERT INTO `cs_chat_session` VALUES (96, 73, 163, 0, 0, '2026-07-01 03:47:25', 1782848845386);
INSERT INTO `cs_chat_session` VALUES (97, 73, 164, 0, 0, '2026-07-01 03:47:50', 1782848869710);
INSERT INTO `cs_chat_session` VALUES (98, 73, 165, 0, 0, '2026-07-01 03:48:02', 1782848881995);
INSERT INTO `cs_chat_session` VALUES (99, 73, 166, 0, 0, '2026-07-01 11:40:52', 1782877252178);
INSERT INTO `cs_chat_session` VALUES (100, 73, 167, 0, 0, '2026-07-01 11:42:49', 1782877369162);
INSERT INTO `cs_chat_session` VALUES (101, 73, 168, 0, 0, '2026-07-01 11:44:12', 1782877451635);
INSERT INTO `cs_chat_session` VALUES (102, 62, 169, 0, 0, '2026-07-02 01:07:30', 1782925650328);
INSERT INTO `cs_chat_session` VALUES (103, 73, 170, 0, 0, '2026-07-02 01:08:48', 1782925728473);
INSERT INTO `cs_chat_session` VALUES (104, 73, 171, 0, 0, '2026-07-02 01:11:03', 1782925862702);
INSERT INTO `cs_chat_session` VALUES (105, 73, 172, 0, 0, '2026-07-03 13:12:20', 1783055539520);
INSERT INTO `cs_chat_session` VALUES (106, 73, 173, 0, 0, '2026-07-03 13:13:03', 1783055582543);
INSERT INTO `cs_chat_session` VALUES (107, 73, 174, 0, 0, '2026-07-03 22:53:01', 1783090380936);
INSERT INTO `cs_chat_session` VALUES (108, 73, 175, 0, 0, '2026-07-03 22:54:48', 1783090487536);
INSERT INTO `cs_chat_session` VALUES (109, 73, 176, 0, 0, '2026-07-03 22:56:50', 1783090610117);
INSERT INTO `cs_chat_session` VALUES (110, 73, 177, 0, 0, '2026-07-03 23:07:41', 1783091260967);
INSERT INTO `cs_chat_session` VALUES (111, 73, 178, 0, 0, '2026-07-03 23:15:40', 1783091740076);
INSERT INTO `cs_chat_session` VALUES (112, 179, 180, 0, 0, '2026-07-04 17:36:11', 1783157771372);

-- ----------------------------
-- Table structure for cs_chat_session_son
-- ----------------------------
DROP TABLE IF EXISTS `cs_chat_session_son`;
CREATE TABLE `cs_chat_session_son`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` bigint(20) NULL DEFAULT NULL COMMENT '主表id',
  `send_time` bigint(20) NULL DEFAULT NULL COMMENT '发送时间',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发送内容',
  `type` int(1) NULL DEFAULT NULL COMMENT '发送格式',
  `unread` int(11) NULL DEFAULT 0 COMMENT '未读数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会话扩展表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_chat_session_son
-- ----------------------------
INSERT INTO `cs_chat_session_son` VALUES (1, 1, 1781961165343, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (2, 2, 1782845072435, '/image_1782286727011.jpg', 2, 0);
INSERT INTO `cs_chat_session_son` VALUES (3, 3, 1782757100855, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (4, 4, 1782757101144, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (5, 5, 1782757101187, NULL, NULL, 0);
INSERT INTO `cs_chat_session_son` VALUES (6, 6, 1782757101206, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (7, 7, 1782757101274, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (8, 8, 1782757101830, '111111', 1, 2);
INSERT INTO `cs_chat_session_son` VALUES (9, 9, 1782757101401, '<p>444444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (10, 10, 1782757101441, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (11, 11, 1782757101464, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (12, 12, 1782757101482, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (14, 14, 1782757101611, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (15, 15, 1782757101633, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (16, 16, 1782757101663, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (17, 17, 1782757101866, '123123123123', 1, 1);
INSERT INTO `cs_chat_session_son` VALUES (18, 18, 1782757101699, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (19, 19, 1782757101713, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (20, 20, 1782757101728, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (21, 21, 1782757101744, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (22, 22, 1782757101769, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (23, 23, 1782757101778, NULL, NULL, 0);
INSERT INTO `cs_chat_session_son` VALUES (24, 24, 1782757101799, '<p>22222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (25, 25, 1782757101817, '<p>22222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (26, 26, 1782757101831, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (27, 27, 1782757101843, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (28, 28, 1782757101860, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (29, 29, 1782757101871, '<p>444444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (30, 30, 1782757101881, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (31, 31, 1782757101894, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (32, 32, 1782757101907, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (33, 33, 1782757101916, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (34, 34, 1782757101926, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (35, 35, 1782757101934, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (36, 36, 1782757101942, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (37, 37, 1782757101951, '<p>22222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (38, 38, 1782757101958, '<p>22222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (39, 39, 1782757101968, NULL, NULL, 0);
INSERT INTO `cs_chat_session_son` VALUES (40, 40, 1782757101977, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (41, 41, 1782757101985, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (42, 42, 1782757101994, '<p>444444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (43, 43, 1782757102004, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (44, 44, 1782757102014, '<p>444444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (45, 45, 1782757102026, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (46, 46, 1782757102035, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (47, 47, 1782757102046, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (48, 48, 1782757102054, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (49, 49, 1782757102062, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (50, 50, 1782757102071, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (51, 51, 1782757102079, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (52, 52, 1782757102087, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (53, 53, 1782757102094, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (54, 54, 1782757102101, NULL, NULL, 0);
INSERT INTO `cs_chat_session_son` VALUES (55, 55, 1782757102108, '123123123123', 7, 0);
INSERT INTO `cs_chat_session_son` VALUES (56, 56, 1782845071967, '表单卡测试', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (57, 57, 1782845072423, '3123123', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (58, 58, 1782757102127, '<p>22222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (59, 59, 1782757102134, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (60, 60, 1782757102140, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (61, 61, 1782757102145, '<p>444444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (62, 62, 1782757102150, '<p>444444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (63, 63, 1782757102156, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (64, 64, 1782757102161, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (65, 65, 1782757102167, NULL, NULL, 0);
INSERT INTO `cs_chat_session_son` VALUES (66, 66, 1782757102172, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (67, 67, 1782757102178, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (68, 68, 1782757102185, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (69, 69, 1782757102192, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (70, 70, 1782757102198, '<p>4444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (71, 71, 1782757102205, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (72, 72, 1782757102213, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (73, 73, 1782757102221, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (74, 74, 1782757102228, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (75, 75, 1782757102233, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (76, 76, 1782757102238, '<p>22222222222222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (77, 77, 1782845072369, '表单卡测试', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (78, 78, 1782757362720, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (79, 79, 1782758202449, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (80, 80, 1782836336040, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (81, 81, 1782836336276, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (82, 82, 1782836366414, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (83, 83, 1782844930556, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (84, 84, 1782845023135, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (85, 85, 1782845114236, '123123123123', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (86, 86, 1782845317146, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (87, 87, 1782845343608, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (88, 88, 1782845367261, '<p>4444444444444</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (89, 89, 1782845409075, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (90, 90, 1782845519147, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (91, 91, 1782846871595, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (92, 92, 1782846907275, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (93, 93, 1782846918970, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (94, 94, 1782846937692, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (95, 95, 1782848820518, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (96, 96, 1782848845388, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (97, 97, 1782848869712, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (98, 98, 1782848881996, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (99, 99, 1782877252180, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (100, 100, 1782877369165, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (101, 101, 1783054732092, '测试标题', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (102, 102, 1783054732208, '3213123', 1, 1);
INSERT INTO `cs_chat_session_son` VALUES (103, 103, 1783054732688, '<p>全匹配模式</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (104, 104, 1783054732688, '<p>半匹配模式</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (105, 105, 1783055545774, '测试标题', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (106, 106, 1783055587809, '测试标题', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (107, 107, 1783090380938, '<p>222222222</p>', 1, 0);
INSERT INTO `cs_chat_session_son` VALUES (108, 108, 1783090499685, '测试标题', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (109, 109, 1783090617542, '自动回复测试标题测试一下', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (110, 110, 1783091266871, '自动回复测试标题测试一下', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (111, 111, 1783091745156, '自动回复测试标题测试一下', 17, 0);
INSERT INTO `cs_chat_session_son` VALUES (112, 112, 1783162622396, '<p>你提交的表单已经成功了</p>', 1, 0);

-- ----------------------------
-- Table structure for cs_customer
-- ----------------------------
DROP TABLE IF EXISTS `cs_customer`;
CREATE TABLE `cs_customer`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '  ',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `img` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `user_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `status` int(1) NULL DEFAULT 0 COMMENT '账号状态，0：启用，1： 禁用',
  `account_id` bigint(20) NULL DEFAULT NULL COMMENT '企业账号id',
  `carmine` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '卡密',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `login_time` datetime NULL DEFAULT NULL COMMENT '登录时间',
  `active_time` datetime NULL DEFAULT NULL COMMENT '激活时间',
  `days` double(16, 2) NULL DEFAULT NULL COMMENT '卡密购买天数,可以是小数',
  `expiration_date` datetime NULL DEFAULT NULL COMMENT '到期时间',
  `active_state` int(1) NULL DEFAULT 0 COMMENT '激活状态：0，未激活，1、已激活、2、已续费，3、已过期',
  `test_card` int(1) NULL DEFAULT 0 COMMENT '测试卡：0不是，1是',
  `max_number` int(4) NULL DEFAULT NULL COMMENT '最大进人数量',
  `is_search` int(4) NULL DEFAULT 1 COMMENT '1:普通卡，2：劫持卡',
  `channel_remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_customer
-- ----------------------------
INSERT INTO `cs_customer` VALUES (1, '在线客服', NULL, NULL, 'c53d92695c3948000', NULL, 0, NULL, 'CDD-10002a966cc72af00bc8', '2026-07-14 17:24:35', NULL, NULL, NULL, 1.00, NULL, 0, 0, 1000, 1, NULL);
INSERT INTO `cs_customer` VALUES (2, '在线客服', NULL, NULL, '2dc9fb6c6baddb020', NULL, 0, NULL, 'CC-1000b3c8f92926dc9481', '2026-07-14 17:42:49', NULL, NULL, NULL, 1.00, NULL, 0, 0, 1000, 1, NULL);
INSERT INTO `cs_customer` VALUES (3, '在线客服', NULL, NULL, 'bc2da14c62fed4230', NULL, 0, NULL, 'CM-10001fbef7734e9a78e8', '2026-07-14 17:44:17', NULL, NULL, NULL, 1.00, NULL, 0, 0, 1000, 1, NULL);
INSERT INTO `cs_customer` VALUES (4, '在线客服', NULL, NULL, '12a075efa0a99c4a0', NULL, 0, NULL, 'CC-10005ee9b035abaf15ef', '2026-07-14 17:46:22', NULL, NULL, NULL, 1.00, NULL, 0, 0, 1000, 1, NULL);
INSERT INTO `cs_customer` VALUES (5, '在线客服', NULL, NULL, 'cd922f31996069e00', NULL, 0, NULL, 'CC-10006f54bfbb0cfaf96b', '2026-07-14 17:47:24', NULL, NULL, NULL, 1.00, NULL, 0, 0, 1000, 1, NULL);
INSERT INTO `cs_customer` VALUES (6, '在线客服', NULL, NULL, 'fb8619498012a56c0', NULL, 0, NULL, 'CC-10007ba106f8519e708a', '2026-07-14 17:49:51', NULL, NULL, NULL, 1.00, NULL, 0, 0, 1000, 1, NULL);
INSERT INTO `cs_customer` VALUES (7, '在线客服', NULL, NULL, '4f08e28598f77a570', NULL, 0, NULL, 'CC-100010c3dfe739fbf026', '2026-07-14 17:52:32', NULL, NULL, NULL, 1.00, NULL, 0, 0, 1000, 1, NULL);

-- ----------------------------
-- Table structure for cs_customer_count
-- ----------------------------
DROP TABLE IF EXISTS `cs_customer_count`;
CREATE TABLE `cs_customer_count`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NULL DEFAULT NULL COMMENT '客服id',
  `number` int(11) NULL DEFAULT NULL COMMENT '编码',
  `create_time` date NULL DEFAULT NULL COMMENT '创建时间',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '乐观锁版本号',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_date`(`customer_id` ASC, `create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_customer_count
-- ----------------------------
INSERT INTO `cs_customer_count` VALUES (1, 1, 366, NULL, 365, '2026-06-12 15:56:13');
INSERT INTO `cs_customer_count` VALUES (2, 371, 3, NULL, 2, '2026-05-07 10:02:58');
INSERT INTO `cs_customer_count` VALUES (3, 13, 1, NULL, 0, '2026-05-23 15:59:15');
INSERT INTO `cs_customer_count` VALUES (4, 2, 3, NULL, 2, '2026-05-24 15:56:11');
INSERT INTO `cs_customer_count` VALUES (5, 3, 9, NULL, 8, '2026-05-24 16:02:36');
INSERT INTO `cs_customer_count` VALUES (6, 33, 5, NULL, 4, '2026-05-24 16:01:43');
INSERT INTO `cs_customer_count` VALUES (7, 71, 45, NULL, 44, '2026-06-16 18:27:39');
INSERT INTO `cs_customer_count` VALUES (8, 62, 7, NULL, 6, '2026-07-02 01:07:30');
INSERT INTO `cs_customer_count` VALUES (9, 72, 4, NULL, 3, '2026-06-16 18:27:22');
INSERT INTO `cs_customer_count` VALUES (10, 73, 31, NULL, 30, '2026-07-03 23:15:39');
INSERT INTO `cs_customer_count` VALUES (11, 74, 2, NULL, 1, '2026-07-01 02:49:27');
INSERT INTO `cs_customer_count` VALUES (12, 61, 14, NULL, 13, '2026-07-01 02:45:14');
INSERT INTO `cs_customer_count` VALUES (13, 179, 1, NULL, 0, '2026-07-04 17:36:11');

-- ----------------------------
-- Table structure for cs_customer_nonce
-- ----------------------------
DROP TABLE IF EXISTS `cs_customer_nonce`;
CREATE TABLE `cs_customer_nonce`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(11) NULL DEFAULT NULL COMMENT '客服id',
  `random_str` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '随机字符串',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1372 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '随机参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_customer_nonce
-- ----------------------------
INSERT INTO `cs_customer_nonce` VALUES (1, 1, 'a9c8756858dd408e', '2026-04-29 20:11:28');
INSERT INTO `cs_customer_nonce` VALUES (2, 1, '6bc1c161c2aa4e02', '2026-04-29 20:11:44');
INSERT INTO `cs_customer_nonce` VALUES (3, 1, 'ef997e1e466b4f25', '2026-04-29 20:12:03');
INSERT INTO `cs_customer_nonce` VALUES (4, 1, '94822d22af5f4a8b', '2026-04-29 20:12:05');
INSERT INTO `cs_customer_nonce` VALUES (5, 1, '1f789551cce744d3', '2026-04-29 20:12:08');
INSERT INTO `cs_customer_nonce` VALUES (6, 1, '51e5fbd51df84ae2', '2026-04-29 20:12:09');
INSERT INTO `cs_customer_nonce` VALUES (7, 1, '4bd7d5f59d5f4fcb', '2026-04-29 20:12:30');
INSERT INTO `cs_customer_nonce` VALUES (8, 1, '34f9c61db8444323', '2026-04-29 20:12:35');
INSERT INTO `cs_customer_nonce` VALUES (9, 1, '0daf3c77936b4379', '2026-04-29 20:12:38');
INSERT INTO `cs_customer_nonce` VALUES (10, 1, '8df446db82584fbd', '2026-04-29 20:12:41');
INSERT INTO `cs_customer_nonce` VALUES (11, 1, 'd73dadef45e64cf1', '2026-04-29 20:12:43');
INSERT INTO `cs_customer_nonce` VALUES (12, 1, 'c498f8bab6564876', '2026-04-29 20:12:45');
INSERT INTO `cs_customer_nonce` VALUES (13, 1, 'c350b5f55f5c400d', '2026-04-29 20:12:55');
INSERT INTO `cs_customer_nonce` VALUES (14, 1, '975fb04eb0e44685', '2026-04-29 20:12:57');
INSERT INTO `cs_customer_nonce` VALUES (15, 1, '53f9b68d6d5a4781', '2026-04-29 20:13:00');
INSERT INTO `cs_customer_nonce` VALUES (16, 1, 'ae4fd6329c7f4168', '2026-04-29 20:13:06');
INSERT INTO `cs_customer_nonce` VALUES (17, 1, '79f4b212487e4194', '2026-04-29 20:13:08');
INSERT INTO `cs_customer_nonce` VALUES (18, 1, 'aae70a0b88c04330', '2026-04-29 20:13:11');
INSERT INTO `cs_customer_nonce` VALUES (19, 1, '00b444d139fc4cc8', '2026-04-29 20:13:13');
INSERT INTO `cs_customer_nonce` VALUES (20, 1, 'eb868008ff614990', '2026-04-29 20:14:29');
INSERT INTO `cs_customer_nonce` VALUES (21, 1, 'dbe4c85e36c84b6d', '2026-04-29 20:14:32');
INSERT INTO `cs_customer_nonce` VALUES (22, 1, '71ff450020fe49d4', '2026-04-29 20:14:36');
INSERT INTO `cs_customer_nonce` VALUES (23, 1, 'fafb4f14ba0c4d24', '2026-04-29 20:14:41');
INSERT INTO `cs_customer_nonce` VALUES (24, 1, '68abdf0f5d2141e7', '2026-04-29 20:14:45');
INSERT INTO `cs_customer_nonce` VALUES (25, 1, 'db2bb5c9cae44aa8', '2026-04-29 20:14:48');
INSERT INTO `cs_customer_nonce` VALUES (26, 1, '1633e2826f2a4bc6', '2026-04-29 20:14:51');
INSERT INTO `cs_customer_nonce` VALUES (27, 1, '63a3b96dd66a43eb', '2026-04-29 20:15:07');
INSERT INTO `cs_customer_nonce` VALUES (28, 1, 'd179308977a845d7', '2026-04-29 20:15:11');
INSERT INTO `cs_customer_nonce` VALUES (29, 1, 'bd7aa9518e034364', '2026-04-29 20:15:14');
INSERT INTO `cs_customer_nonce` VALUES (30, 1, '5734fd218ecb47d2', '2026-04-29 20:15:34');
INSERT INTO `cs_customer_nonce` VALUES (31, 1, 'f95978e22b674f5d', '2026-04-29 20:16:06');
INSERT INTO `cs_customer_nonce` VALUES (32, 1, 'ee1fa49b2a8d4608', '2026-04-29 20:28:43');
INSERT INTO `cs_customer_nonce` VALUES (33, 1, 'bf35a163fb54498e', '2026-04-29 20:28:59');
INSERT INTO `cs_customer_nonce` VALUES (34, 1, 'c9262040f2754cdf', '2026-04-29 20:30:57');
INSERT INTO `cs_customer_nonce` VALUES (35, 1, '801704085427436a', '2026-04-29 21:34:37');
INSERT INTO `cs_customer_nonce` VALUES (36, 1, '2c24b66e314c4077', '2026-04-29 21:35:13');
INSERT INTO `cs_customer_nonce` VALUES (37, 1, 'ae2f525b27fa4194', '2026-04-29 21:35:16');
INSERT INTO `cs_customer_nonce` VALUES (38, 1, 'fd8976d3d6d248af', '2026-04-29 21:35:37');
INSERT INTO `cs_customer_nonce` VALUES (39, 1, '615fc0a130544112', '2026-04-29 22:16:06');
INSERT INTO `cs_customer_nonce` VALUES (40, 1, '8d6d71ea595e4016', '2026-04-29 22:16:10');
INSERT INTO `cs_customer_nonce` VALUES (41, 1, 'da184b4acb144b9b', '2026-04-29 22:16:12');
INSERT INTO `cs_customer_nonce` VALUES (42, 1, '93c12b52685344e9', '2026-04-29 22:16:28');
INSERT INTO `cs_customer_nonce` VALUES (43, 1, '016954d8814a44f0', '2026-04-29 22:16:33');
INSERT INTO `cs_customer_nonce` VALUES (44, 1, 'e14f93a965044ec7', '2026-04-29 22:17:03');
INSERT INTO `cs_customer_nonce` VALUES (45, 1, '6160218abe9c48c0', '2026-04-29 22:17:05');
INSERT INTO `cs_customer_nonce` VALUES (46, 371, 'a187b076f8164d67', '2026-04-29 22:20:33');
INSERT INTO `cs_customer_nonce` VALUES (47, 1, 'e4035ae45dc7447e', '2026-04-29 22:22:17');
INSERT INTO `cs_customer_nonce` VALUES (48, 1, '1d82485c805c4814', '2026-04-29 22:53:28');
INSERT INTO `cs_customer_nonce` VALUES (49, 1, 'b96c9ddf4f854f54', '2026-04-29 22:53:33');
INSERT INTO `cs_customer_nonce` VALUES (50, 1, 'e2e3d7ad90114f6b', '2026-04-29 22:56:32');
INSERT INTO `cs_customer_nonce` VALUES (51, 1, 'f2938362c7264e99', '2026-04-29 22:56:36');
INSERT INTO `cs_customer_nonce` VALUES (52, 1, '4796bdabfd7e4277', '2026-05-01 12:41:03');
INSERT INTO `cs_customer_nonce` VALUES (53, 1, 'f2190d2077d64449', '2026-05-01 12:54:19');
INSERT INTO `cs_customer_nonce` VALUES (54, 1, '1fb5db7d355d4445', '2026-05-01 12:54:21');
INSERT INTO `cs_customer_nonce` VALUES (55, 1, '79903280dba148e0', '2026-05-01 12:54:29');
INSERT INTO `cs_customer_nonce` VALUES (56, 1, 'a07e313ea146447b', '2026-05-01 12:54:32');
INSERT INTO `cs_customer_nonce` VALUES (57, 1, 'ad8783605ede45d4', '2026-05-01 12:54:35');
INSERT INTO `cs_customer_nonce` VALUES (58, 1, 'c07a2ef7a30f4637', '2026-05-01 12:54:36');
INSERT INTO `cs_customer_nonce` VALUES (59, 1, '07755e183895428f', '2026-05-01 12:54:38');
INSERT INTO `cs_customer_nonce` VALUES (60, 1, '834c2aef067047f2', '2026-05-01 12:54:41');
INSERT INTO `cs_customer_nonce` VALUES (61, 1, '488e80e44d02470d', '2026-05-01 12:54:42');
INSERT INTO `cs_customer_nonce` VALUES (62, 1, 'faf513ee2e5e4107', '2026-05-01 12:54:43');
INSERT INTO `cs_customer_nonce` VALUES (63, 1, 'cea373bc58c14e9a', '2026-05-01 12:56:28');
INSERT INTO `cs_customer_nonce` VALUES (64, 1, '708959a2d07a4555', '2026-05-01 12:59:28');
INSERT INTO `cs_customer_nonce` VALUES (65, 1, '9094684568d14e25', '2026-05-01 12:59:33');
INSERT INTO `cs_customer_nonce` VALUES (66, 1, '866096ad9a524c65', '2026-05-01 12:59:37');
INSERT INTO `cs_customer_nonce` VALUES (67, 1, '7bad7e105c214f2c', '2026-05-01 12:59:39');
INSERT INTO `cs_customer_nonce` VALUES (68, 1, '271676c7f5814aa4', '2026-05-01 12:59:40');
INSERT INTO `cs_customer_nonce` VALUES (69, 1, 'e66a3788f13a4e04', '2026-05-01 12:59:42');
INSERT INTO `cs_customer_nonce` VALUES (70, 1, '8f2afe4e48174855', '2026-05-01 12:59:43');
INSERT INTO `cs_customer_nonce` VALUES (71, 1, 'bf9978b09c694eb0', '2026-05-01 12:59:46');
INSERT INTO `cs_customer_nonce` VALUES (72, 1, '99452c57a141445c', '2026-05-01 12:59:56');
INSERT INTO `cs_customer_nonce` VALUES (73, 1, '85ffa6a1594d4ea5', '2026-05-01 13:00:09');
INSERT INTO `cs_customer_nonce` VALUES (74, 1, 'd6a49553447544e3', '2026-05-01 13:00:11');
INSERT INTO `cs_customer_nonce` VALUES (75, 1, '2f123fac45574fd0', '2026-05-01 13:00:14');
INSERT INTO `cs_customer_nonce` VALUES (76, 1, 'a558278c00a14aeb', '2026-05-01 13:00:54');
INSERT INTO `cs_customer_nonce` VALUES (77, 1, 'b88c85181fa348e5', '2026-05-01 13:00:57');
INSERT INTO `cs_customer_nonce` VALUES (78, 1, 'bec4970ab8384fa5', '2026-05-01 13:01:40');
INSERT INTO `cs_customer_nonce` VALUES (79, 1, 'c079319a600f4efb', '2026-05-01 13:01:43');
INSERT INTO `cs_customer_nonce` VALUES (80, 1, 'a5853d807d9241ef', '2026-05-01 13:01:51');
INSERT INTO `cs_customer_nonce` VALUES (81, 1, 'cc97b5499a6d4d49', '2026-05-01 13:01:55');
INSERT INTO `cs_customer_nonce` VALUES (82, 1, '1619c3a149d54f7c', '2026-05-01 13:02:27');
INSERT INTO `cs_customer_nonce` VALUES (83, 1, 'a1697c1ed1e44ae6', '2026-05-01 13:02:28');
INSERT INTO `cs_customer_nonce` VALUES (84, 1, 'db7d0d5990d94268', '2026-05-01 13:02:33');
INSERT INTO `cs_customer_nonce` VALUES (85, 1, '16e895c92ed14662', '2026-05-01 13:02:36');
INSERT INTO `cs_customer_nonce` VALUES (86, 1, '10cc0b55f1bc4ab2', '2026-05-01 13:03:05');
INSERT INTO `cs_customer_nonce` VALUES (87, 1, '65fa37b2ca4f4d9b', '2026-05-01 13:03:08');
INSERT INTO `cs_customer_nonce` VALUES (88, 1, '24f379d8923d4f0c', '2026-05-01 13:03:10');
INSERT INTO `cs_customer_nonce` VALUES (89, 1, '7ed6e2c8e14a4228', '2026-05-01 13:03:12');
INSERT INTO `cs_customer_nonce` VALUES (90, 1, '0f0a36e63bc3424f', '2026-05-01 13:03:14');
INSERT INTO `cs_customer_nonce` VALUES (91, 1, '69fb5196bb8f485d', '2026-05-01 13:03:15');
INSERT INTO `cs_customer_nonce` VALUES (92, 1, 'f11bfe0142044fad', '2026-05-01 13:03:22');
INSERT INTO `cs_customer_nonce` VALUES (93, 1, '67e9eea2628a4f2f', '2026-05-01 13:03:25');
INSERT INTO `cs_customer_nonce` VALUES (94, 1, 'cc483f499c0b4f97', '2026-05-01 13:05:15');
INSERT INTO `cs_customer_nonce` VALUES (95, 1, '34858d78e3fe4a19', '2026-05-01 13:05:19');
INSERT INTO `cs_customer_nonce` VALUES (96, 1, '3b059a317c604c87', '2026-05-01 13:05:26');
INSERT INTO `cs_customer_nonce` VALUES (97, 1, '260123f154864500', '2026-05-01 13:05:28');
INSERT INTO `cs_customer_nonce` VALUES (98, 1, 'a2d99808abd142e1', '2026-05-01 13:05:29');
INSERT INTO `cs_customer_nonce` VALUES (99, 1, 'df8ab1c2d0d54fcc', '2026-05-01 13:05:31');
INSERT INTO `cs_customer_nonce` VALUES (100, 1, '43819249a290490f', '2026-05-01 13:05:32');
INSERT INTO `cs_customer_nonce` VALUES (101, 1, 'dfc13a420fce42b2', '2026-05-01 13:07:38');
INSERT INTO `cs_customer_nonce` VALUES (102, 1, 'f4915690cdc84338', '2026-05-01 13:07:40');
INSERT INTO `cs_customer_nonce` VALUES (103, 1, '5a311922401c44ce', '2026-05-01 13:07:47');
INSERT INTO `cs_customer_nonce` VALUES (104, 1, 'c037ae86d720491e', '2026-05-01 13:07:51');
INSERT INTO `cs_customer_nonce` VALUES (105, 1, '819537cef6ba4335', '2026-05-01 13:07:53');
INSERT INTO `cs_customer_nonce` VALUES (106, 1, 'b522c5c7844c4e86', '2026-05-01 13:07:54');
INSERT INTO `cs_customer_nonce` VALUES (107, 1, 'c6c4d6affd9f49f5', '2026-05-01 13:08:56');
INSERT INTO `cs_customer_nonce` VALUES (108, 1, '2cd6f3297d4c4903', '2026-05-01 13:10:43');
INSERT INTO `cs_customer_nonce` VALUES (109, 1, 'da7c3cad456c4f71', '2026-05-01 13:10:45');
INSERT INTO `cs_customer_nonce` VALUES (110, 1, '821138c8019f4117', '2026-05-01 13:10:48');
INSERT INTO `cs_customer_nonce` VALUES (111, 1, 'fd73ff5ab0454f95', '2026-05-01 13:10:53');
INSERT INTO `cs_customer_nonce` VALUES (112, 1, '8f4bcd95c61d4587', '2026-05-01 13:10:55');
INSERT INTO `cs_customer_nonce` VALUES (113, 1, 'f7ab9dd465674ff3', '2026-05-01 13:10:57');
INSERT INTO `cs_customer_nonce` VALUES (114, 1, '94ef532c05cb4bb6', '2026-05-01 13:10:59');
INSERT INTO `cs_customer_nonce` VALUES (115, 1, '8550a4f3acc441de', '2026-05-01 13:11:00');
INSERT INTO `cs_customer_nonce` VALUES (116, 1, '50688db12f864933', '2026-05-01 13:11:02');
INSERT INTO `cs_customer_nonce` VALUES (117, 1, 'e213e9d8b8a64435', '2026-05-01 13:11:04');
INSERT INTO `cs_customer_nonce` VALUES (118, 1, 'c341cfb254714869', '2026-05-01 13:11:07');
INSERT INTO `cs_customer_nonce` VALUES (119, 1, '48033daa5ad54ec3', '2026-05-01 13:11:09');
INSERT INTO `cs_customer_nonce` VALUES (120, 1, '0ff23e2ae28140b8', '2026-05-01 13:13:35');
INSERT INTO `cs_customer_nonce` VALUES (121, 1, '07694cc735614dbe', '2026-05-01 13:13:48');
INSERT INTO `cs_customer_nonce` VALUES (122, 1, '17923bf9c4ee41bd', '2026-05-01 13:13:51');
INSERT INTO `cs_customer_nonce` VALUES (123, 1, '191a7294d7fc4655', '2026-05-01 13:14:00');
INSERT INTO `cs_customer_nonce` VALUES (124, 1, 'e21f626b9d7540fc', '2026-05-01 13:14:03');
INSERT INTO `cs_customer_nonce` VALUES (125, 1, 'a3f915bf033e4bd2', '2026-05-01 13:14:04');
INSERT INTO `cs_customer_nonce` VALUES (126, 1, 'aacc1c6465fc4af7', '2026-05-01 13:14:05');
INSERT INTO `cs_customer_nonce` VALUES (127, 1, '253711328a92491f', '2026-05-01 13:14:10');
INSERT INTO `cs_customer_nonce` VALUES (128, 1, 'e88d9e213e2b43ba', '2026-05-01 13:14:12');
INSERT INTO `cs_customer_nonce` VALUES (129, 1, 'd914d7aed4134c08', '2026-05-01 13:14:32');
INSERT INTO `cs_customer_nonce` VALUES (130, 1, 'e59acbe4cdd64ac6', '2026-05-01 13:14:40');
INSERT INTO `cs_customer_nonce` VALUES (131, 1, 'bb4b120f4f5e409a', '2026-05-01 13:14:43');
INSERT INTO `cs_customer_nonce` VALUES (132, 1, 'afe419fa70f44c2d', '2026-05-01 13:14:44');
INSERT INTO `cs_customer_nonce` VALUES (133, 1, '22f56709b1bd4be2', '2026-05-01 13:14:46');
INSERT INTO `cs_customer_nonce` VALUES (134, 1, 'aef7b774b8e24285', '2026-05-01 13:14:47');
INSERT INTO `cs_customer_nonce` VALUES (135, 1, '181d1bde33674723', '2026-05-01 13:14:48');
INSERT INTO `cs_customer_nonce` VALUES (136, 1, '77f48394f7fd4d69', '2026-05-01 13:16:08');
INSERT INTO `cs_customer_nonce` VALUES (137, 1, 'a861c17ccfc4495a', '2026-05-01 13:19:06');
INSERT INTO `cs_customer_nonce` VALUES (138, 1, 'ffbdf223176142ed', '2026-05-01 13:19:41');
INSERT INTO `cs_customer_nonce` VALUES (139, 1, '45c38eba2b624120', '2026-05-01 13:19:52');
INSERT INTO `cs_customer_nonce` VALUES (140, 1, '50631bdac1b241bb', '2026-05-01 13:19:54');
INSERT INTO `cs_customer_nonce` VALUES (141, 1, 'd959b94417214c47', '2026-05-01 13:19:56');
INSERT INTO `cs_customer_nonce` VALUES (142, 1, 'a0fba613f7c3422a', '2026-05-01 13:19:57');
INSERT INTO `cs_customer_nonce` VALUES (143, 1, '64cc29c8f1b64a5c', '2026-05-01 13:21:40');
INSERT INTO `cs_customer_nonce` VALUES (144, 1, '54d3c433dfd340b5', '2026-05-01 13:21:55');
INSERT INTO `cs_customer_nonce` VALUES (145, 1, '643fc4a3317e4084', '2026-05-01 13:21:58');
INSERT INTO `cs_customer_nonce` VALUES (146, 1, '5f6baeea1620488a', '2026-05-01 13:21:59');
INSERT INTO `cs_customer_nonce` VALUES (147, 1, 'cb398981dff745cd', '2026-05-01 13:22:00');
INSERT INTO `cs_customer_nonce` VALUES (148, 1, '90888a5e7c2348a0', '2026-05-01 13:22:02');
INSERT INTO `cs_customer_nonce` VALUES (149, 1, '2ed047c4a74b4d3d', '2026-05-01 13:22:33');
INSERT INTO `cs_customer_nonce` VALUES (150, 1, '5b101534e8ce46c5', '2026-05-01 13:22:45');
INSERT INTO `cs_customer_nonce` VALUES (151, 1, '0762484eadfb4a37', '2026-05-01 13:22:54');
INSERT INTO `cs_customer_nonce` VALUES (152, 1, '7715d8b1697d49e1', '2026-05-01 13:22:55');
INSERT INTO `cs_customer_nonce` VALUES (153, 1, '1506a292d5c444af', '2026-05-01 13:22:56');
INSERT INTO `cs_customer_nonce` VALUES (154, 1, '7e10714f4e7445d7', '2026-05-01 13:23:02');
INSERT INTO `cs_customer_nonce` VALUES (155, 1, '2194625d712b441a', '2026-05-01 13:23:09');
INSERT INTO `cs_customer_nonce` VALUES (156, 1, '06c852393d1047d3', '2026-05-01 13:23:35');
INSERT INTO `cs_customer_nonce` VALUES (157, 1, '73e2a646a0b54db6', '2026-05-01 13:23:38');
INSERT INTO `cs_customer_nonce` VALUES (158, 1, '1383da4f66d6457c', '2026-05-01 13:23:39');
INSERT INTO `cs_customer_nonce` VALUES (159, 1, '69fa0a89cbb445ae', '2026-05-01 13:23:40');
INSERT INTO `cs_customer_nonce` VALUES (160, 1, 'b76925e0ad894753', '2026-05-01 13:23:41');
INSERT INTO `cs_customer_nonce` VALUES (161, 1, 'ae1053d9ff0c4255', '2026-05-01 13:23:42');
INSERT INTO `cs_customer_nonce` VALUES (162, 1, '0e7e5a5dfbcd4e4f', '2026-05-01 13:23:46');
INSERT INTO `cs_customer_nonce` VALUES (163, 1, '23c2ff7da5b84cc1', '2026-05-01 13:23:52');
INSERT INTO `cs_customer_nonce` VALUES (164, 1, 'ea62ea4690434ad4', '2026-05-01 13:23:53');
INSERT INTO `cs_customer_nonce` VALUES (165, 1, 'b3a4d9201ca44a72', '2026-05-01 13:23:54');
INSERT INTO `cs_customer_nonce` VALUES (166, 1, '9c5ad3c0ec9b4d41', '2026-05-01 13:23:55');
INSERT INTO `cs_customer_nonce` VALUES (167, 1, '1ead391660954e21', '2026-05-01 13:23:56');
INSERT INTO `cs_customer_nonce` VALUES (168, 1, '66cdca5821744feb', '2026-05-01 13:23:57');
INSERT INTO `cs_customer_nonce` VALUES (169, 1, '7b89fde9e3dc42c2', '2026-05-01 13:24:00');
INSERT INTO `cs_customer_nonce` VALUES (170, 1, 'b99d84eed28d42cf', '2026-05-01 13:24:01');
INSERT INTO `cs_customer_nonce` VALUES (171, 1, '29a6e13a31f4474b', '2026-05-01 13:24:02');
INSERT INTO `cs_customer_nonce` VALUES (172, 1, '8216956348664670', '2026-05-01 13:24:03');
INSERT INTO `cs_customer_nonce` VALUES (173, 1, '510cf7d2f2644c75', '2026-05-01 13:24:04');
INSERT INTO `cs_customer_nonce` VALUES (174, 1, '9cceed705b1e4d91', '2026-05-01 13:24:05');
INSERT INTO `cs_customer_nonce` VALUES (175, 1, 'd36384383e594f49', '2026-05-01 13:24:08');
INSERT INTO `cs_customer_nonce` VALUES (176, 1, '799036826eb84365', '2026-05-01 13:24:09');
INSERT INTO `cs_customer_nonce` VALUES (177, 1, 'c15d9c8270424c3c', '2026-05-01 13:24:10');
INSERT INTO `cs_customer_nonce` VALUES (178, 1, 'bfb8a39475ed4b27', '2026-05-01 13:24:11');
INSERT INTO `cs_customer_nonce` VALUES (179, 1, '2520e5dd134d4d3d', '2026-05-01 13:24:12');
INSERT INTO `cs_customer_nonce` VALUES (180, 1, '3868a541e90d4da4', '2026-05-01 13:24:14');
INSERT INTO `cs_customer_nonce` VALUES (181, 1, 'e9486d6454f74cfe', '2026-05-01 13:24:15');
INSERT INTO `cs_customer_nonce` VALUES (182, 1, 'e15689818cf341f1', '2026-05-01 13:24:16');
INSERT INTO `cs_customer_nonce` VALUES (183, 1, 'da36adc1666c4968', '2026-05-01 13:24:17');
INSERT INTO `cs_customer_nonce` VALUES (184, 1, '65cccd74d37e45e1', '2026-05-01 13:24:18');
INSERT INTO `cs_customer_nonce` VALUES (185, 1, 'eea44ca50c1246a9', '2026-05-01 13:24:20');
INSERT INTO `cs_customer_nonce` VALUES (186, 1, '69653974a8f54758', '2026-05-01 13:25:31');
INSERT INTO `cs_customer_nonce` VALUES (187, 1, 'd355bc13e34a4c85', '2026-05-01 13:25:33');
INSERT INTO `cs_customer_nonce` VALUES (188, 1, 'e92f1dc3f0ed4244', '2026-05-01 13:25:34');
INSERT INTO `cs_customer_nonce` VALUES (189, 1, '5b1c25d0fc3f45a2', '2026-05-01 13:25:37');
INSERT INTO `cs_customer_nonce` VALUES (190, 1, '565bffa2ba734fed', '2026-05-01 13:25:38');
INSERT INTO `cs_customer_nonce` VALUES (191, 1, '34a276c11ead4d37', '2026-05-01 13:25:39');
INSERT INTO `cs_customer_nonce` VALUES (192, 1, '6338007ecae44e06', '2026-05-01 13:25:41');
INSERT INTO `cs_customer_nonce` VALUES (193, 1, 'd0af4210733c459b', '2026-05-01 13:25:53');
INSERT INTO `cs_customer_nonce` VALUES (194, 1, '8ce9effc26234c70', '2026-05-01 13:25:54');
INSERT INTO `cs_customer_nonce` VALUES (195, 1, '7787fa5866a14903', '2026-05-01 13:25:56');
INSERT INTO `cs_customer_nonce` VALUES (196, 1, '0f1e8d7e57c94b4e', '2026-05-01 13:25:58');
INSERT INTO `cs_customer_nonce` VALUES (197, 1, '3b88d9381f3745ce', '2026-05-01 13:25:59');
INSERT INTO `cs_customer_nonce` VALUES (198, 1, 'a79411ce31cc4a77', '2026-05-01 13:26:00');
INSERT INTO `cs_customer_nonce` VALUES (199, 1, '119e8b33ebc14197', '2026-05-01 13:26:28');
INSERT INTO `cs_customer_nonce` VALUES (200, 1, 'a34f95a8b09546c0', '2026-05-01 13:27:55');
INSERT INTO `cs_customer_nonce` VALUES (201, 1, '43182651b77d4194', '2026-05-01 13:29:39');
INSERT INTO `cs_customer_nonce` VALUES (202, 1, '75ce999f24b14cf7', '2026-05-01 13:29:41');
INSERT INTO `cs_customer_nonce` VALUES (203, 1, 'bed38fca2f734299', '2026-05-01 13:29:43');
INSERT INTO `cs_customer_nonce` VALUES (204, 1, '04754c0fe3f448e6', '2026-05-01 13:29:44');
INSERT INTO `cs_customer_nonce` VALUES (205, 1, 'a4a20f1cc2c74fa3', '2026-05-01 13:29:45');
INSERT INTO `cs_customer_nonce` VALUES (206, 1, 'b455821d6b9b4a33', '2026-05-01 13:30:04');
INSERT INTO `cs_customer_nonce` VALUES (207, 1, '67b46b3b20e9412a', '2026-05-01 13:31:31');
INSERT INTO `cs_customer_nonce` VALUES (208, 1, 'f966b2e67a8242f8', '2026-05-01 13:31:33');
INSERT INTO `cs_customer_nonce` VALUES (209, 1, '420165116bc54726', '2026-05-01 13:31:34');
INSERT INTO `cs_customer_nonce` VALUES (210, 1, 'f37b4e2630f54221', '2026-05-01 13:31:35');
INSERT INTO `cs_customer_nonce` VALUES (211, 1, '826c5b9e2f084cbd', '2026-05-02 20:18:01');
INSERT INTO `cs_customer_nonce` VALUES (212, 1, '8a4ffcda2a234b91', '2026-05-02 20:18:05');
INSERT INTO `cs_customer_nonce` VALUES (213, 1, 'cdd897082597405e', '2026-05-02 20:18:07');
INSERT INTO `cs_customer_nonce` VALUES (214, 1, '24ec8f39f77c4682', '2026-05-02 20:18:09');
INSERT INTO `cs_customer_nonce` VALUES (215, 1, 'abf7bb9e366c43b1', '2026-05-02 20:18:11');
INSERT INTO `cs_customer_nonce` VALUES (216, 1, '4130984a099c4846', '2026-05-02 20:18:12');
INSERT INTO `cs_customer_nonce` VALUES (217, 1, '579bc0b237c34f97', '2026-05-02 20:18:14');
INSERT INTO `cs_customer_nonce` VALUES (218, 1, 'd73876b59c0849b2', '2026-05-02 20:18:17');
INSERT INTO `cs_customer_nonce` VALUES (219, 1, '0be65d0630ad4221', '2026-05-02 20:18:18');
INSERT INTO `cs_customer_nonce` VALUES (220, 1, '0b5b12d3841f4e87', '2026-05-02 20:18:21');
INSERT INTO `cs_customer_nonce` VALUES (221, 1, '406b71a2298645f8', '2026-05-02 20:18:22');
INSERT INTO `cs_customer_nonce` VALUES (222, 1, '2e049cf1d05a4d6c', '2026-05-02 20:18:23');
INSERT INTO `cs_customer_nonce` VALUES (223, 1, '8d6028fc32f54f12', '2026-05-02 20:18:24');
INSERT INTO `cs_customer_nonce` VALUES (224, 1, '2d6ce29821aa4951', '2026-05-02 20:19:11');
INSERT INTO `cs_customer_nonce` VALUES (225, 1, 'e3de6835343a4c5f', '2026-05-02 20:19:18');
INSERT INTO `cs_customer_nonce` VALUES (226, 1, 'b37bba5b08a74032', '2026-05-02 20:19:25');
INSERT INTO `cs_customer_nonce` VALUES (227, 1, '1ebeb25d63ed4dc6', '2026-05-02 20:20:06');
INSERT INTO `cs_customer_nonce` VALUES (228, 1, '9e4d017291bb4e05', '2026-05-02 20:20:08');
INSERT INTO `cs_customer_nonce` VALUES (229, 1, 'e751cb857d964ac3', '2026-05-02 20:20:09');
INSERT INTO `cs_customer_nonce` VALUES (230, 1, '822af2fc405e4333', '2026-05-02 20:20:10');
INSERT INTO `cs_customer_nonce` VALUES (231, 1, '9f6e8f842ccc406a', '2026-05-02 20:20:12');
INSERT INTO `cs_customer_nonce` VALUES (232, 1, 'b285e7176a3944b2', '2026-05-02 20:20:46');
INSERT INTO `cs_customer_nonce` VALUES (233, 1, '6ee679b64e7548e1', '2026-05-02 20:21:16');
INSERT INTO `cs_customer_nonce` VALUES (234, 1, '99ad0467f5e74d8e', '2026-05-02 20:22:20');
INSERT INTO `cs_customer_nonce` VALUES (235, 1, '79b46527239e407a', '2026-05-02 20:23:38');
INSERT INTO `cs_customer_nonce` VALUES (236, 1, '375bf389d0334001', '2026-05-02 20:24:28');
INSERT INTO `cs_customer_nonce` VALUES (237, 1, '1efced49dd104817', '2026-05-02 20:25:27');
INSERT INTO `cs_customer_nonce` VALUES (238, 1, '224d86c42f064a62', '2026-05-02 20:27:12');
INSERT INTO `cs_customer_nonce` VALUES (239, 1, '1de5df2a603c4d67', '2026-05-02 20:27:51');
INSERT INTO `cs_customer_nonce` VALUES (240, 1, 'a93c47a4659a4e4a', '2026-05-02 20:27:55');
INSERT INTO `cs_customer_nonce` VALUES (241, 1, '84b50426214d4ae8', '2026-05-02 20:28:11');
INSERT INTO `cs_customer_nonce` VALUES (242, 1, '7c53bfa4efa049c1', '2026-05-02 20:28:17');
INSERT INTO `cs_customer_nonce` VALUES (243, 1, 'e8c9536cd0ab42bf', '2026-05-02 20:28:20');
INSERT INTO `cs_customer_nonce` VALUES (244, 1, '122e26030c994891', '2026-05-02 20:28:21');
INSERT INTO `cs_customer_nonce` VALUES (245, 1, '3bbeec15ab3d458c', '2026-05-02 20:28:23');
INSERT INTO `cs_customer_nonce` VALUES (246, 1, '3206ca4b35904368', '2026-05-02 20:28:28');
INSERT INTO `cs_customer_nonce` VALUES (247, 1, '6c076bbdb7a34ad1', '2026-05-02 20:28:29');
INSERT INTO `cs_customer_nonce` VALUES (248, 1, 'add0a5ae8acd4655', '2026-05-02 20:28:30');
INSERT INTO `cs_customer_nonce` VALUES (249, 1, '378cf801027b48fc', '2026-05-02 20:28:31');
INSERT INTO `cs_customer_nonce` VALUES (250, 1, 'ded3e7098d8a4b9d', '2026-05-02 20:28:32');
INSERT INTO `cs_customer_nonce` VALUES (251, 1, 'f57a4957d0514854', '2026-05-02 20:28:46');
INSERT INTO `cs_customer_nonce` VALUES (252, 1, '9a8d6f3c6e8b4a24', '2026-05-02 20:28:54');
INSERT INTO `cs_customer_nonce` VALUES (253, 1, 'fc14d19dca904d3a', '2026-05-02 20:28:59');
INSERT INTO `cs_customer_nonce` VALUES (254, 1, '0410e152b9ee48e0', '2026-05-02 20:29:15');
INSERT INTO `cs_customer_nonce` VALUES (255, 1, '22241d459fb1448e', '2026-05-02 20:29:24');
INSERT INTO `cs_customer_nonce` VALUES (256, 1, '786004b4061d4b37', '2026-05-02 20:29:41');
INSERT INTO `cs_customer_nonce` VALUES (257, 1, '866cff0a9d034bfd', '2026-05-02 20:30:51');
INSERT INTO `cs_customer_nonce` VALUES (258, 1, '839112b4be714308', '2026-05-02 20:31:00');
INSERT INTO `cs_customer_nonce` VALUES (259, 1, '216ba3220db442b4', '2026-05-02 20:31:03');
INSERT INTO `cs_customer_nonce` VALUES (260, 1, '6bcd60ef81c2499a', '2026-05-02 20:31:06');
INSERT INTO `cs_customer_nonce` VALUES (261, 1, '911ff7e3db2d46ce', '2026-05-02 20:31:09');
INSERT INTO `cs_customer_nonce` VALUES (262, 1, 'fd65d460b81a4460', '2026-05-02 20:31:12');
INSERT INTO `cs_customer_nonce` VALUES (263, 1, '745fafeb2bb3464f', '2026-05-02 20:31:15');
INSERT INTO `cs_customer_nonce` VALUES (264, 1, 'ffdba78031a94fe0', '2026-05-02 20:31:17');
INSERT INTO `cs_customer_nonce` VALUES (265, 1, 'f20025ecc1284509', '2026-05-02 20:31:18');
INSERT INTO `cs_customer_nonce` VALUES (266, 1, '0cd7418367ea422a', '2026-05-02 20:31:24');
INSERT INTO `cs_customer_nonce` VALUES (267, 1, 'a40e41e5c3e9444c', '2026-05-02 20:32:45');
INSERT INTO `cs_customer_nonce` VALUES (268, 1, 'cf1e1e5762c04fc0', '2026-05-02 20:32:47');
INSERT INTO `cs_customer_nonce` VALUES (269, 1, '61bca3a966544c37', '2026-05-02 20:32:48');
INSERT INTO `cs_customer_nonce` VALUES (270, 1, '28a82a06164f4bbd', '2026-05-02 20:32:49');
INSERT INTO `cs_customer_nonce` VALUES (271, 1, '3aaf1be0f6464027', '2026-05-02 20:32:51');
INSERT INTO `cs_customer_nonce` VALUES (272, 1, '20fa50c3433544a9', '2026-05-02 20:32:52');
INSERT INTO `cs_customer_nonce` VALUES (273, 1, 'abffe46cf8f542ba', '2026-05-02 20:32:53');
INSERT INTO `cs_customer_nonce` VALUES (274, 1, '5f91681e4687439d', '2026-05-02 20:32:54');
INSERT INTO `cs_customer_nonce` VALUES (275, 1, 'f73de2fc8b884555', '2026-05-02 20:32:56');
INSERT INTO `cs_customer_nonce` VALUES (276, 1, '125c78bcf3954781', '2026-05-02 20:32:57');
INSERT INTO `cs_customer_nonce` VALUES (277, 1, 'a6c45afee4634846', '2026-05-02 20:32:59');
INSERT INTO `cs_customer_nonce` VALUES (278, 1, '956eedf1bdc14d93', '2026-05-02 20:33:00');
INSERT INTO `cs_customer_nonce` VALUES (279, 1, '5fa223dfca254339', '2026-05-02 20:33:01');
INSERT INTO `cs_customer_nonce` VALUES (280, 1, 'fc5039894a3645a1', '2026-05-02 20:33:02');
INSERT INTO `cs_customer_nonce` VALUES (281, 1, '8d56153050d44acb', '2026-05-02 20:33:02');
INSERT INTO `cs_customer_nonce` VALUES (282, 1, '3a6d6fdd514b4731', '2026-05-02 20:33:04');
INSERT INTO `cs_customer_nonce` VALUES (283, 1, '6fbf87043bb54a44', '2026-05-02 20:33:06');
INSERT INTO `cs_customer_nonce` VALUES (284, 1, 'b40ae19d662643eb', '2026-05-02 20:33:07');
INSERT INTO `cs_customer_nonce` VALUES (285, 1, 'a630ab9515334a70', '2026-05-02 20:33:08');
INSERT INTO `cs_customer_nonce` VALUES (286, 1, '5a8a8a81f1b84122', '2026-05-02 20:33:10');
INSERT INTO `cs_customer_nonce` VALUES (287, 1, '4a0c9836ca964aa1', '2026-05-02 20:33:12');
INSERT INTO `cs_customer_nonce` VALUES (288, 1, 'af27c25c53c245c1', '2026-05-02 20:33:14');
INSERT INTO `cs_customer_nonce` VALUES (289, 1, '088c135f76a44f82', '2026-05-02 20:34:30');
INSERT INTO `cs_customer_nonce` VALUES (290, 1, '785a379c4a8d4961', '2026-05-02 20:34:32');
INSERT INTO `cs_customer_nonce` VALUES (291, 1, 'c421e185941f4663', '2026-05-02 20:34:33');
INSERT INTO `cs_customer_nonce` VALUES (292, 1, '791205770893447e', '2026-05-02 20:34:34');
INSERT INTO `cs_customer_nonce` VALUES (293, 1, 'a97013a7dbf14e3e', '2026-05-02 20:34:37');
INSERT INTO `cs_customer_nonce` VALUES (294, 1, '2267c1c5f1544ae2', '2026-05-02 20:34:39');
INSERT INTO `cs_customer_nonce` VALUES (295, 1, 'a90acd5cbb9e4bcc', '2026-05-02 20:34:40');
INSERT INTO `cs_customer_nonce` VALUES (296, 1, '88f94e753d6e4329', '2026-05-02 20:34:42');
INSERT INTO `cs_customer_nonce` VALUES (297, 1, '56092652e5d7479c', '2026-05-02 20:34:43');
INSERT INTO `cs_customer_nonce` VALUES (298, 1, '3a772ffcc8ba463c', '2026-05-02 20:34:44');
INSERT INTO `cs_customer_nonce` VALUES (299, 1, '426bbbb812594efd', '2026-05-02 20:34:48');
INSERT INTO `cs_customer_nonce` VALUES (300, 1, '2ef1bb9c84ad43a9', '2026-05-02 20:34:51');
INSERT INTO `cs_customer_nonce` VALUES (301, 1, 'ea02d0710c374b38', '2026-05-02 20:34:53');
INSERT INTO `cs_customer_nonce` VALUES (302, 1, '0a68a63aaa5746db', '2026-05-02 20:34:54');
INSERT INTO `cs_customer_nonce` VALUES (303, 1, '7335048a6cdb41ce', '2026-05-02 20:34:55');
INSERT INTO `cs_customer_nonce` VALUES (304, 1, 'f7a370e5b1a54373', '2026-05-02 20:34:56');
INSERT INTO `cs_customer_nonce` VALUES (305, 1, 'd7b4880e67ca4ff3', '2026-05-02 20:34:58');
INSERT INTO `cs_customer_nonce` VALUES (306, 1, '604aafa035fc4421', '2026-05-02 20:34:59');
INSERT INTO `cs_customer_nonce` VALUES (307, 1, 'c4e6f23577b44051', '2026-05-02 20:34:59');
INSERT INTO `cs_customer_nonce` VALUES (308, 1, '433f0fd9832243c1', '2026-05-02 20:35:46');
INSERT INTO `cs_customer_nonce` VALUES (309, 1, 'e3f1b8d50f074b30', '2026-05-02 20:37:12');
INSERT INTO `cs_customer_nonce` VALUES (310, 1, 'db872f61c91f4201', '2026-05-02 20:37:28');
INSERT INTO `cs_customer_nonce` VALUES (311, 1, '69f7d7a2c6bd44d1', '2026-05-02 20:37:35');
INSERT INTO `cs_customer_nonce` VALUES (312, 1, '23dc921daf114ed4', '2026-05-02 20:37:41');
INSERT INTO `cs_customer_nonce` VALUES (313, 1, 'e460fe1e2b954e03', '2026-05-02 20:37:45');
INSERT INTO `cs_customer_nonce` VALUES (314, 1, '9591c600258d4423', '2026-05-02 20:37:49');
INSERT INTO `cs_customer_nonce` VALUES (315, 1, 'a924321c102a4ad0', '2026-05-02 20:38:01');
INSERT INTO `cs_customer_nonce` VALUES (316, 1, '6d0138639e1c4b3a', '2026-05-02 20:38:06');
INSERT INTO `cs_customer_nonce` VALUES (317, 1, '84d042b01c184515', '2026-05-02 20:38:09');
INSERT INTO `cs_customer_nonce` VALUES (318, 1, '23abd42093df454f', '2026-05-02 20:38:12');
INSERT INTO `cs_customer_nonce` VALUES (319, 1, 'e62b0997861848c3', '2026-05-02 20:38:15');
INSERT INTO `cs_customer_nonce` VALUES (320, 1, 'a8761047bd5d4dbd', '2026-05-02 20:38:39');
INSERT INTO `cs_customer_nonce` VALUES (321, 1, 'b5dd168ce31f4589', '2026-05-02 20:38:41');
INSERT INTO `cs_customer_nonce` VALUES (322, 1, 'acef4ba584f1404f', '2026-05-02 20:38:47');
INSERT INTO `cs_customer_nonce` VALUES (323, 1, '160e74fdeb104473', '2026-05-02 20:38:51');
INSERT INTO `cs_customer_nonce` VALUES (324, 1, 'b96c353635c34485', '2026-05-02 20:38:53');
INSERT INTO `cs_customer_nonce` VALUES (325, 1, '85cb3315fe284112', '2026-05-02 20:38:57');
INSERT INTO `cs_customer_nonce` VALUES (326, 1, '6338874dca084efc', '2026-05-02 20:39:00');
INSERT INTO `cs_customer_nonce` VALUES (327, 1, 'fec1ce59f0bd4892', '2026-05-02 20:39:05');
INSERT INTO `cs_customer_nonce` VALUES (328, 1, '6514e6c575e94f35', '2026-05-02 20:39:33');
INSERT INTO `cs_customer_nonce` VALUES (329, 1, '33701b937da84332', '2026-05-02 20:39:37');
INSERT INTO `cs_customer_nonce` VALUES (330, 1, '1b826db93d3f43ca', '2026-05-02 20:39:40');
INSERT INTO `cs_customer_nonce` VALUES (331, 1, 'c2726cd3662642d9', '2026-05-02 20:39:44');
INSERT INTO `cs_customer_nonce` VALUES (332, 1, '6ba110d05b374ac2', '2026-05-02 20:39:46');
INSERT INTO `cs_customer_nonce` VALUES (333, 1, '79f2b6c4385e400c', '2026-05-02 20:39:47');
INSERT INTO `cs_customer_nonce` VALUES (334, 1, '4d11292af7ab4cc3', '2026-05-02 20:39:49');
INSERT INTO `cs_customer_nonce` VALUES (335, 1, '265adfb60fee4906', '2026-05-02 20:39:50');
INSERT INTO `cs_customer_nonce` VALUES (336, 1, '666312480dcd46ea', '2026-05-02 20:39:51');
INSERT INTO `cs_customer_nonce` VALUES (337, 1, '6071a2b3a3284b3a', '2026-05-02 20:39:59');
INSERT INTO `cs_customer_nonce` VALUES (338, 1, '18ada527289943ca', '2026-05-02 20:40:27');
INSERT INTO `cs_customer_nonce` VALUES (339, 1, 'e026b44a6de4413e', '2026-05-02 20:40:30');
INSERT INTO `cs_customer_nonce` VALUES (340, 1, 'e6789246c3bc4c02', '2026-05-02 20:40:33');
INSERT INTO `cs_customer_nonce` VALUES (341, 1, 'b0721c0ebcfa4be7', '2026-05-02 20:40:35');
INSERT INTO `cs_customer_nonce` VALUES (342, 1, 'fb829f6f9c1d49f8', '2026-05-02 20:40:38');
INSERT INTO `cs_customer_nonce` VALUES (343, 1, '0c2be5d3889e47ca', '2026-05-02 20:40:49');
INSERT INTO `cs_customer_nonce` VALUES (344, 1, 'ea8d4495cd824820', '2026-05-02 20:40:52');
INSERT INTO `cs_customer_nonce` VALUES (345, 1, 'e5347284afca437c', '2026-05-02 20:40:56');
INSERT INTO `cs_customer_nonce` VALUES (346, 1, '0462f85d35d9451b', '2026-05-02 20:40:58');
INSERT INTO `cs_customer_nonce` VALUES (347, 1, '30edaba3f3174748', '2026-05-02 20:41:00');
INSERT INTO `cs_customer_nonce` VALUES (348, 1, 'e1f30ce800794502', '2026-05-02 20:41:03');
INSERT INTO `cs_customer_nonce` VALUES (349, 1, '8474b171a9ae4080', '2026-05-02 20:41:04');
INSERT INTO `cs_customer_nonce` VALUES (350, 1, '3693254221a14413', '2026-05-02 20:41:48');
INSERT INTO `cs_customer_nonce` VALUES (351, 1, '9ea22067fad44ab9', '2026-05-02 20:41:50');
INSERT INTO `cs_customer_nonce` VALUES (352, 1, '83fc4f513add4b5a', '2026-05-02 20:41:51');
INSERT INTO `cs_customer_nonce` VALUES (353, 1, '1c997ed146964cb8', '2026-05-02 20:41:52');
INSERT INTO `cs_customer_nonce` VALUES (354, 1, '9a73ae327feb4665', '2026-05-02 20:41:57');
INSERT INTO `cs_customer_nonce` VALUES (355, 1, '8c5f7ad5db744ebd', '2026-05-02 20:42:33');
INSERT INTO `cs_customer_nonce` VALUES (356, 1, '52b67ba013da4231', '2026-05-02 20:42:35');
INSERT INTO `cs_customer_nonce` VALUES (357, 1, '0fa5d2593d7949d1', '2026-05-02 20:42:37');
INSERT INTO `cs_customer_nonce` VALUES (358, 1, '9559fab206a84848', '2026-05-02 20:42:38');
INSERT INTO `cs_customer_nonce` VALUES (359, 1, '70a523fbebf24784', '2026-05-02 20:46:07');
INSERT INTO `cs_customer_nonce` VALUES (360, 1, '63c08338fd7b4a49', '2026-05-02 20:46:15');
INSERT INTO `cs_customer_nonce` VALUES (361, 1, '6abe3b83e58a4df4', '2026-05-02 20:46:30');
INSERT INTO `cs_customer_nonce` VALUES (362, 1, '35188bc1e62d410f', '2026-05-02 20:46:33');
INSERT INTO `cs_customer_nonce` VALUES (363, 1, '7a52d6c2710047bd', '2026-05-02 20:46:35');
INSERT INTO `cs_customer_nonce` VALUES (364, 1, '44c4221ea69c4e78', '2026-05-02 20:46:37');
INSERT INTO `cs_customer_nonce` VALUES (365, 1, '5d6eb1dbee844f52', '2026-05-02 20:46:38');
INSERT INTO `cs_customer_nonce` VALUES (366, 1, 'bbacb87004bf489c', '2026-05-02 20:46:55');
INSERT INTO `cs_customer_nonce` VALUES (367, 1, 'f11a4487656e4953', '2026-05-02 20:47:23');
INSERT INTO `cs_customer_nonce` VALUES (368, 1, '746a5f0372c6483f', '2026-05-02 20:47:30');
INSERT INTO `cs_customer_nonce` VALUES (369, 1, '3a29bf266dfb47ce', '2026-05-02 20:47:34');
INSERT INTO `cs_customer_nonce` VALUES (370, 1, '883c66dcde8c43a7', '2026-05-02 20:47:59');
INSERT INTO `cs_customer_nonce` VALUES (371, 1, '30e7f6f6a7e44914', '2026-05-02 20:49:29');
INSERT INTO `cs_customer_nonce` VALUES (372, 1, '97de7da4ad7646a9', '2026-05-02 20:49:33');
INSERT INTO `cs_customer_nonce` VALUES (373, 1, '395fb450d5494266', '2026-05-02 20:49:44');
INSERT INTO `cs_customer_nonce` VALUES (374, 1, 'd551499587c94fd6', '2026-05-02 20:49:47');
INSERT INTO `cs_customer_nonce` VALUES (375, 1, 'f65742d46e4745f7', '2026-05-02 20:49:50');
INSERT INTO `cs_customer_nonce` VALUES (376, 1, 'acdc009179554f1c', '2026-05-02 20:49:52');
INSERT INTO `cs_customer_nonce` VALUES (377, 1, 'bd1992c3449743d6', '2026-05-02 20:49:54');
INSERT INTO `cs_customer_nonce` VALUES (378, 1, '3a4ff8e839f045b4', '2026-05-02 20:49:55');
INSERT INTO `cs_customer_nonce` VALUES (379, 1, '78d2141ec5fc43eb', '2026-05-02 20:49:59');
INSERT INTO `cs_customer_nonce` VALUES (380, 1, '8657ce3527d44b76', '2026-05-02 20:50:01');
INSERT INTO `cs_customer_nonce` VALUES (381, 1, '81e624cda9524310', '2026-05-02 20:50:03');
INSERT INTO `cs_customer_nonce` VALUES (382, 1, 'ab0f5701df6242dc', '2026-05-02 20:50:06');
INSERT INTO `cs_customer_nonce` VALUES (383, 1, '2fad503c33d74190', '2026-05-02 20:50:08');
INSERT INTO `cs_customer_nonce` VALUES (384, 1, '62c66224d2b94a15', '2026-05-02 20:50:10');
INSERT INTO `cs_customer_nonce` VALUES (385, 1, '4fe8ecc3919b4daa', '2026-05-02 20:50:14');
INSERT INTO `cs_customer_nonce` VALUES (386, 1, 'a8afcd08852a4d4a', '2026-05-02 20:50:18');
INSERT INTO `cs_customer_nonce` VALUES (387, 1, '35a79c85217d44b6', '2026-05-02 20:50:22');
INSERT INTO `cs_customer_nonce` VALUES (388, 1, '2b280f581a944bc9', '2026-05-02 20:51:43');
INSERT INTO `cs_customer_nonce` VALUES (389, 1, '20154da78e954723', '2026-05-02 20:51:48');
INSERT INTO `cs_customer_nonce` VALUES (390, 1, '736316d2fc8e4039', '2026-05-02 20:51:52');
INSERT INTO `cs_customer_nonce` VALUES (391, 1, '14971f4c7b854b12', '2026-05-02 20:52:30');
INSERT INTO `cs_customer_nonce` VALUES (392, 1, 'bc4c38c2f3434c5b', '2026-05-02 20:52:33');
INSERT INTO `cs_customer_nonce` VALUES (393, 1, 'cf3015e0b14c4c93', '2026-05-02 20:52:36');
INSERT INTO `cs_customer_nonce` VALUES (394, 1, '16fa44d521e5423b', '2026-05-02 20:52:39');
INSERT INTO `cs_customer_nonce` VALUES (395, 1, '3291e40858954461', '2026-05-02 20:52:43');
INSERT INTO `cs_customer_nonce` VALUES (396, 1, 'daba44a25b634228', '2026-05-02 20:52:45');
INSERT INTO `cs_customer_nonce` VALUES (397, 1, '6986f5a10fec426d', '2026-05-02 20:52:47');
INSERT INTO `cs_customer_nonce` VALUES (398, 1, '8763ace77ad14b3c', '2026-05-02 20:52:50');
INSERT INTO `cs_customer_nonce` VALUES (399, 1, '2dbd1a8b23984678', '2026-05-02 20:52:53');
INSERT INTO `cs_customer_nonce` VALUES (400, 1, 'e3953a1afd714c3d', '2026-05-02 20:52:55');
INSERT INTO `cs_customer_nonce` VALUES (401, 1, '0ba70eb93aa846d8', '2026-05-02 20:52:58');
INSERT INTO `cs_customer_nonce` VALUES (402, 1, '9e8f5d90f8d14f41', '2026-05-02 20:53:01');
INSERT INTO `cs_customer_nonce` VALUES (403, 1, 'cfcde8f108ed4b69', '2026-05-02 20:53:04');
INSERT INTO `cs_customer_nonce` VALUES (404, 1, '1168fe7dd2ef43f3', '2026-05-02 20:53:05');
INSERT INTO `cs_customer_nonce` VALUES (405, 1, '58aee40943554730', '2026-05-02 20:53:06');
INSERT INTO `cs_customer_nonce` VALUES (406, 1, '9903d04f9b1a4172', '2026-05-02 20:54:07');
INSERT INTO `cs_customer_nonce` VALUES (407, 1, '6b4846a2d1324238', '2026-05-02 20:57:06');
INSERT INTO `cs_customer_nonce` VALUES (408, 1, '3c69233d49c541a8', '2026-05-02 20:58:31');
INSERT INTO `cs_customer_nonce` VALUES (409, 1, 'ba30ac1a984d4caa', '2026-05-02 20:59:03');
INSERT INTO `cs_customer_nonce` VALUES (410, 1, '510b63d5f91646ce', '2026-05-02 20:59:25');
INSERT INTO `cs_customer_nonce` VALUES (411, 1, '2f5233e2967d44be', '2026-05-02 20:59:32');
INSERT INTO `cs_customer_nonce` VALUES (412, 1, 'df5c809c52bb4bb0', '2026-05-02 20:59:35');
INSERT INTO `cs_customer_nonce` VALUES (413, 1, '20f5e82361b947d8', '2026-05-02 21:00:32');
INSERT INTO `cs_customer_nonce` VALUES (414, 1, '6347318a2b424bdf', '2026-05-02 21:01:25');
INSERT INTO `cs_customer_nonce` VALUES (415, 1, '524a37b55ad4492b', '2026-05-02 21:05:00');
INSERT INTO `cs_customer_nonce` VALUES (416, 1, '229f12c140b84a15', '2026-05-02 21:05:30');
INSERT INTO `cs_customer_nonce` VALUES (417, 1, '7ac7404cf4b449d7', '2026-05-02 21:07:45');
INSERT INTO `cs_customer_nonce` VALUES (418, 1, 'bde6adda69e04936', '2026-05-02 21:08:46');
INSERT INTO `cs_customer_nonce` VALUES (419, 1, 'eaa9713e3cf94141', '2026-05-02 21:14:26');
INSERT INTO `cs_customer_nonce` VALUES (420, 1, '7e120c5fbe5e439b', '2026-05-02 21:14:34');
INSERT INTO `cs_customer_nonce` VALUES (421, 1, 'c56fd653d13a4021', '2026-05-02 21:14:50');
INSERT INTO `cs_customer_nonce` VALUES (422, 1, '97ba1e8c0a5e437d', '2026-05-02 21:14:57');
INSERT INTO `cs_customer_nonce` VALUES (423, 1, 'fde4a8e303374f70', '2026-05-02 21:15:03');
INSERT INTO `cs_customer_nonce` VALUES (424, 1, '7f2c324a15054e8d', '2026-05-02 21:15:08');
INSERT INTO `cs_customer_nonce` VALUES (425, 1, '511c9cc7b5314eb2', '2026-05-02 21:15:16');
INSERT INTO `cs_customer_nonce` VALUES (426, 1, 'd6f3ab691cb048bb', '2026-05-02 21:15:48');
INSERT INTO `cs_customer_nonce` VALUES (427, 1, '71bdc6122cd24e6b', '2026-05-02 21:15:54');
INSERT INTO `cs_customer_nonce` VALUES (428, 1, 'ee202c1437b04726', '2026-05-02 21:16:10');
INSERT INTO `cs_customer_nonce` VALUES (429, 1, 'be46fd451fbb439c', '2026-05-02 21:16:28');
INSERT INTO `cs_customer_nonce` VALUES (430, 1, 'd1c12710f4894ccb', '2026-05-02 21:16:31');
INSERT INTO `cs_customer_nonce` VALUES (431, 1, 'c0d009558a5249bf', '2026-05-02 21:16:34');
INSERT INTO `cs_customer_nonce` VALUES (432, 1, '8b716cd6a9e345aa', '2026-05-02 21:16:36');
INSERT INTO `cs_customer_nonce` VALUES (433, 1, 'eb6ee4f8a2e943a8', '2026-05-02 21:16:38');
INSERT INTO `cs_customer_nonce` VALUES (434, 1, 'cfff284e847c404b', '2026-05-02 21:16:39');
INSERT INTO `cs_customer_nonce` VALUES (435, 1, '9e0cfa3c30c845c0', '2026-05-02 21:16:41');
INSERT INTO `cs_customer_nonce` VALUES (436, 1, 'b0c0e366f42d40ae', '2026-05-02 21:16:42');
INSERT INTO `cs_customer_nonce` VALUES (437, 1, '02ff7b48a9594a4e', '2026-05-02 21:16:43');
INSERT INTO `cs_customer_nonce` VALUES (438, 1, '861dfba94163419d', '2026-05-02 21:16:44');
INSERT INTO `cs_customer_nonce` VALUES (439, 1, 'b5cd760b23d14247', '2026-05-02 21:16:46');
INSERT INTO `cs_customer_nonce` VALUES (440, 1, '4f4a43b3f6ff4685', '2026-05-02 21:16:46');
INSERT INTO `cs_customer_nonce` VALUES (441, 1, '0598b5a310a84b8f', '2026-05-02 21:16:47');
INSERT INTO `cs_customer_nonce` VALUES (442, 1, '24da6c34b89d4f40', '2026-05-02 21:16:49');
INSERT INTO `cs_customer_nonce` VALUES (443, 1, 'b3a03a47ba204971', '2026-05-02 21:17:41');
INSERT INTO `cs_customer_nonce` VALUES (444, 1, 'c23188ee133a4dd3', '2026-05-02 21:17:43');
INSERT INTO `cs_customer_nonce` VALUES (445, 1, '8e3bf2610f2c4281', '2026-05-02 21:17:45');
INSERT INTO `cs_customer_nonce` VALUES (446, 1, '07c5dcd7292f42f9', '2026-05-02 21:17:47');
INSERT INTO `cs_customer_nonce` VALUES (447, 1, 'dcf72b8955a3452d', '2026-05-02 21:17:49');
INSERT INTO `cs_customer_nonce` VALUES (448, 1, '812ec1df5e6c43fa', '2026-05-02 21:17:50');
INSERT INTO `cs_customer_nonce` VALUES (449, 1, 'f9c315f47e134c5e', '2026-05-02 21:20:47');
INSERT INTO `cs_customer_nonce` VALUES (450, 1, '5a8e59832dcb495a', '2026-05-02 21:22:36');
INSERT INTO `cs_customer_nonce` VALUES (451, 1, '4873107062414c37', '2026-05-02 21:22:37');
INSERT INTO `cs_customer_nonce` VALUES (452, 1, 'fef86d8aa38f4335', '2026-05-02 21:22:48');
INSERT INTO `cs_customer_nonce` VALUES (453, 1, '91ce5cfc09214c46', '2026-05-02 21:22:53');
INSERT INTO `cs_customer_nonce` VALUES (454, 1, '640e140262f3488c', '2026-05-02 21:22:54');
INSERT INTO `cs_customer_nonce` VALUES (455, 1, '488b33acdd794f86', '2026-05-02 21:22:55');
INSERT INTO `cs_customer_nonce` VALUES (456, 1, '21d8c4bb52de4a3c', '2026-05-02 21:22:57');
INSERT INTO `cs_customer_nonce` VALUES (457, 1, 'd7ac8ac8235d468a', '2026-05-02 21:22:59');
INSERT INTO `cs_customer_nonce` VALUES (458, 1, 'bd796397bfe34a95', '2026-05-02 21:23:07');
INSERT INTO `cs_customer_nonce` VALUES (459, 1, '66a217780e254c6f', '2026-05-02 21:23:09');
INSERT INTO `cs_customer_nonce` VALUES (460, 1, 'fdafc3feb17048eb', '2026-05-02 21:23:10');
INSERT INTO `cs_customer_nonce` VALUES (461, 1, '7d30c27ccbd84bc1', '2026-05-02 21:23:11');
INSERT INTO `cs_customer_nonce` VALUES (462, 1, 'f341df0a4c5e4cc5', '2026-05-02 21:23:13');
INSERT INTO `cs_customer_nonce` VALUES (463, 1, '22fd94b662014f7f', '2026-05-02 21:23:20');
INSERT INTO `cs_customer_nonce` VALUES (464, 1, '175fdb3fec8143fa', '2026-05-02 21:23:22');
INSERT INTO `cs_customer_nonce` VALUES (465, 1, 'f04bcbf8fd424756', '2026-05-02 21:23:23');
INSERT INTO `cs_customer_nonce` VALUES (466, 1, '22473f42a71c4a29', '2026-05-02 21:23:24');
INSERT INTO `cs_customer_nonce` VALUES (467, 1, '85ca91e6ca1540e4', '2026-05-02 21:23:26');
INSERT INTO `cs_customer_nonce` VALUES (468, 1, '2a65775e7e874e25', '2026-05-02 21:23:27');
INSERT INTO `cs_customer_nonce` VALUES (469, 1, '0b1eabef9c6a4da7', '2026-05-02 21:24:38');
INSERT INTO `cs_customer_nonce` VALUES (470, 1, '469d23e292f54043', '2026-05-02 21:24:40');
INSERT INTO `cs_customer_nonce` VALUES (471, 1, '1c1bf6170427447c', '2026-05-02 21:24:41');
INSERT INTO `cs_customer_nonce` VALUES (472, 1, '8b3c91bcd48147a4', '2026-05-02 21:24:42');
INSERT INTO `cs_customer_nonce` VALUES (473, 1, '1f1449d7ac9a4798', '2026-05-02 21:24:43');
INSERT INTO `cs_customer_nonce` VALUES (474, 1, '49990cc97ce1460d', '2026-05-02 21:24:45');
INSERT INTO `cs_customer_nonce` VALUES (475, 1, '0f88b9820d1f4610', '2026-05-02 21:24:46');
INSERT INTO `cs_customer_nonce` VALUES (476, 1, 'f3b3889735a84dae', '2026-05-02 21:24:48');
INSERT INTO `cs_customer_nonce` VALUES (477, 1, 'a7f2c308dca04276', '2026-05-02 21:26:36');
INSERT INTO `cs_customer_nonce` VALUES (478, 1, 'ca301267d87a474d', '2026-05-02 21:26:50');
INSERT INTO `cs_customer_nonce` VALUES (479, 1, '1ab6a6b1831041a5', '2026-05-02 21:26:51');
INSERT INTO `cs_customer_nonce` VALUES (480, 1, '06b26342369c4540', '2026-05-02 21:26:52');
INSERT INTO `cs_customer_nonce` VALUES (481, 1, '8c205185be4c4f9a', '2026-05-02 21:26:53');
INSERT INTO `cs_customer_nonce` VALUES (482, 1, '7ecd8d0e19f74bca', '2026-05-02 21:26:54');
INSERT INTO `cs_customer_nonce` VALUES (483, 1, '70e18b31ad8b4b93', '2026-05-02 21:26:55');
INSERT INTO `cs_customer_nonce` VALUES (484, 1, '9eb30879bd294919', '2026-05-02 21:26:57');
INSERT INTO `cs_customer_nonce` VALUES (485, 1, '4ee077b094994a99', '2026-05-02 21:26:57');
INSERT INTO `cs_customer_nonce` VALUES (486, 1, 'ae899af5cb984e69', '2026-05-02 21:26:58');
INSERT INTO `cs_customer_nonce` VALUES (487, 1, '005d191c22fd4c28', '2026-05-02 21:26:59');
INSERT INTO `cs_customer_nonce` VALUES (488, 1, 'b765cdf9f56d4687', '2026-05-02 21:27:00');
INSERT INTO `cs_customer_nonce` VALUES (489, 1, '2826412656644d1d', '2026-05-02 21:27:02');
INSERT INTO `cs_customer_nonce` VALUES (490, 1, '8b06856958b84129', '2026-05-02 21:27:03');
INSERT INTO `cs_customer_nonce` VALUES (491, 1, 'f3a3e58784314120', '2026-05-02 21:27:04');
INSERT INTO `cs_customer_nonce` VALUES (492, 1, '205a5825b3b34084', '2026-05-02 21:27:05');
INSERT INTO `cs_customer_nonce` VALUES (493, 1, '0b57d28486c64ac9', '2026-05-02 21:27:06');
INSERT INTO `cs_customer_nonce` VALUES (494, 1, 'c3b54982778446b8', '2026-05-02 21:27:07');
INSERT INTO `cs_customer_nonce` VALUES (495, 1, '4b8ee9aeb9ff4a17', '2026-05-02 21:27:08');
INSERT INTO `cs_customer_nonce` VALUES (496, 1, '5ad919f1499440b6', '2026-05-02 21:27:09');
INSERT INTO `cs_customer_nonce` VALUES (497, 1, '55c22ea7cabc4f55', '2026-05-02 21:27:10');
INSERT INTO `cs_customer_nonce` VALUES (498, 1, '2d55a93646ca4975', '2026-05-02 21:27:11');
INSERT INTO `cs_customer_nonce` VALUES (499, 1, 'a285c90c54964bbc', '2026-05-02 21:27:12');
INSERT INTO `cs_customer_nonce` VALUES (500, 1, 'fed208c912484254', '2026-05-02 21:28:26');
INSERT INTO `cs_customer_nonce` VALUES (501, 1, '4065a447cf644951', '2026-05-02 21:28:27');
INSERT INTO `cs_customer_nonce` VALUES (502, 1, '63fa0968f9b7472d', '2026-05-02 21:28:28');
INSERT INTO `cs_customer_nonce` VALUES (503, 1, 'bef05e9e167e4f60', '2026-05-02 21:28:29');
INSERT INTO `cs_customer_nonce` VALUES (504, 1, 'd386dfdfd07d40f5', '2026-05-02 21:28:30');
INSERT INTO `cs_customer_nonce` VALUES (505, 1, '36b1a54d555d447f', '2026-05-02 21:28:32');
INSERT INTO `cs_customer_nonce` VALUES (506, 1, 'fc415b5039fc4474', '2026-05-02 21:28:33');
INSERT INTO `cs_customer_nonce` VALUES (507, 1, 'f4ed7d20c54c4cab', '2026-05-02 21:28:34');
INSERT INTO `cs_customer_nonce` VALUES (508, 1, '0cc94bdd234d405b', '2026-05-02 21:28:35');
INSERT INTO `cs_customer_nonce` VALUES (509, 1, '8fd14925f6c843da', '2026-05-02 21:28:36');
INSERT INTO `cs_customer_nonce` VALUES (510, 1, '66c8c942a4b7462e', '2026-05-02 21:28:36');
INSERT INTO `cs_customer_nonce` VALUES (511, 1, '4ffc320b75f6453b', '2026-05-02 21:28:37');
INSERT INTO `cs_customer_nonce` VALUES (512, 1, '300e0cb36fc0448d', '2026-05-02 21:28:38');
INSERT INTO `cs_customer_nonce` VALUES (513, 1, 'e7ec7b48fc9a412a', '2026-05-02 21:28:39');
INSERT INTO `cs_customer_nonce` VALUES (514, 1, 'ecc234ccca3a4f72', '2026-05-02 21:28:40');
INSERT INTO `cs_customer_nonce` VALUES (515, 1, '338a0eecd1d148db', '2026-05-02 21:28:40');
INSERT INTO `cs_customer_nonce` VALUES (516, 1, '598a722634f94924', '2026-05-02 21:28:41');
INSERT INTO `cs_customer_nonce` VALUES (517, 1, 'e06e8cf9588e44fb', '2026-05-02 21:28:42');
INSERT INTO `cs_customer_nonce` VALUES (518, 1, '8796ffef24494f43', '2026-05-02 21:28:43');
INSERT INTO `cs_customer_nonce` VALUES (519, 1, '8f8159c8b9f34137', '2026-05-02 21:28:44');
INSERT INTO `cs_customer_nonce` VALUES (520, 1, '974c1bbd168e49b8', '2026-05-02 21:28:45');
INSERT INTO `cs_customer_nonce` VALUES (521, 1, 'd35c767b10fe4ed0', '2026-05-02 21:28:46');
INSERT INTO `cs_customer_nonce` VALUES (522, 1, '64fb09cd41e14efc', '2026-05-02 21:28:46');
INSERT INTO `cs_customer_nonce` VALUES (523, 1, 'fe7343160dfc4ed3', '2026-05-02 21:28:47');
INSERT INTO `cs_customer_nonce` VALUES (524, 1, 'b5b53024695e493b', '2026-05-02 21:28:48');
INSERT INTO `cs_customer_nonce` VALUES (525, 1, '18cb8dff09a740a9', '2026-05-02 21:28:48');
INSERT INTO `cs_customer_nonce` VALUES (526, 1, '06671a81b8ab4f34', '2026-05-02 21:28:49');
INSERT INTO `cs_customer_nonce` VALUES (527, 1, '6e36d63c7a0446af', '2026-05-02 21:28:50');
INSERT INTO `cs_customer_nonce` VALUES (528, 1, 'db1ac8176b8d433c', '2026-05-02 21:28:50');
INSERT INTO `cs_customer_nonce` VALUES (529, 1, '129ed9eb795d4b2e', '2026-05-02 21:28:51');
INSERT INTO `cs_customer_nonce` VALUES (530, 1, '3a27957c173c4d0c', '2026-05-02 21:28:52');
INSERT INTO `cs_customer_nonce` VALUES (531, 1, '673c0f96095449bf', '2026-05-02 21:28:52');
INSERT INTO `cs_customer_nonce` VALUES (532, 1, 'acb92037794849a4', '2026-05-02 21:28:53');
INSERT INTO `cs_customer_nonce` VALUES (533, 1, '9f67ca6089694a2a', '2026-05-02 21:28:54');
INSERT INTO `cs_customer_nonce` VALUES (534, 1, '34ddab9296594cf1', '2026-05-02 21:28:54');
INSERT INTO `cs_customer_nonce` VALUES (535, 1, 'a8bcc2e9f6c44852', '2026-05-02 21:28:55');
INSERT INTO `cs_customer_nonce` VALUES (536, 1, '7809fa3f7b724f44', '2026-05-02 21:28:56');
INSERT INTO `cs_customer_nonce` VALUES (537, 1, 'a25f4f1371a34238', '2026-05-02 21:28:56');
INSERT INTO `cs_customer_nonce` VALUES (538, 1, 'd57dd37b45bf480e', '2026-05-02 21:28:57');
INSERT INTO `cs_customer_nonce` VALUES (539, 1, 'dbd9f301883746a5', '2026-05-02 21:28:58');
INSERT INTO `cs_customer_nonce` VALUES (540, 1, '8f7c2efeb3094ec0', '2026-05-02 21:28:58');
INSERT INTO `cs_customer_nonce` VALUES (541, 1, '507eb29a31ec4557', '2026-05-02 21:28:59');
INSERT INTO `cs_customer_nonce` VALUES (542, 1, '72f33e76cf9d4655', '2026-05-02 21:29:00');
INSERT INTO `cs_customer_nonce` VALUES (543, 1, '9d7a1158fa2a4664', '2026-05-02 21:29:00');
INSERT INTO `cs_customer_nonce` VALUES (544, 1, '6ba63633082248ae', '2026-05-02 21:29:01');
INSERT INTO `cs_customer_nonce` VALUES (545, 1, 'db0f4028a54f49f2', '2026-05-02 21:29:02');
INSERT INTO `cs_customer_nonce` VALUES (546, 1, '1cc1c9d3ceb94f47', '2026-05-02 21:29:02');
INSERT INTO `cs_customer_nonce` VALUES (547, 1, '3c95aeb657e9403f', '2026-05-02 21:30:35');
INSERT INTO `cs_customer_nonce` VALUES (548, 1, '1ff907b3ca2b43e3', '2026-05-02 21:30:37');
INSERT INTO `cs_customer_nonce` VALUES (549, 1, '46ddb40ea9f041b4', '2026-05-02 21:30:39');
INSERT INTO `cs_customer_nonce` VALUES (550, 1, '5a748a91343143e7', '2026-05-02 21:30:40');
INSERT INTO `cs_customer_nonce` VALUES (551, 1, '8a6d636509e141e3', '2026-05-02 21:30:41');
INSERT INTO `cs_customer_nonce` VALUES (552, 1, '9a5f173001144d21', '2026-05-02 21:30:41');
INSERT INTO `cs_customer_nonce` VALUES (553, 1, '790aa0e8ea1e4646', '2026-05-02 21:30:42');
INSERT INTO `cs_customer_nonce` VALUES (554, 1, '2fc3058133204236', '2026-05-02 21:30:43');
INSERT INTO `cs_customer_nonce` VALUES (555, 1, '53ead03e549c4a32', '2026-05-02 21:30:44');
INSERT INTO `cs_customer_nonce` VALUES (556, 1, '2bb49f59b0bc42d4', '2026-05-02 21:30:45');
INSERT INTO `cs_customer_nonce` VALUES (557, 1, '4d97563eabf24468', '2026-05-02 21:30:46');
INSERT INTO `cs_customer_nonce` VALUES (558, 1, '76d9f365e8e04126', '2026-05-02 21:30:47');
INSERT INTO `cs_customer_nonce` VALUES (559, 1, 'd6f6cd6ffba449d8', '2026-05-02 21:30:47');
INSERT INTO `cs_customer_nonce` VALUES (560, 1, 'c227299ad29146b5', '2026-05-02 21:30:49');
INSERT INTO `cs_customer_nonce` VALUES (561, 1, 'ad142125ff2b4b01', '2026-05-02 21:30:49');
INSERT INTO `cs_customer_nonce` VALUES (562, 1, '9dc4bf7221494aec', '2026-05-02 21:30:50');
INSERT INTO `cs_customer_nonce` VALUES (563, 1, '73720b94a76a41bf', '2026-05-02 21:30:51');
INSERT INTO `cs_customer_nonce` VALUES (564, 1, '69a0a900546748d4', '2026-05-02 21:30:52');
INSERT INTO `cs_customer_nonce` VALUES (565, 1, '5886693de5ca4c02', '2026-05-02 21:30:53');
INSERT INTO `cs_customer_nonce` VALUES (566, 1, '69362d39d0a848d2', '2026-05-02 21:30:54');
INSERT INTO `cs_customer_nonce` VALUES (567, 1, '4a6c5053385040c7', '2026-05-02 21:30:55');
INSERT INTO `cs_customer_nonce` VALUES (568, 1, 'ca8163f0e6064ac9', '2026-05-02 21:30:56');
INSERT INTO `cs_customer_nonce` VALUES (569, 1, 'c8b73834100046a3', '2026-05-02 21:30:56');
INSERT INTO `cs_customer_nonce` VALUES (570, 1, '6403bb03bf3847b7', '2026-05-02 21:30:57');
INSERT INTO `cs_customer_nonce` VALUES (571, 1, 'd282a3bf02174116', '2026-05-02 21:30:58');
INSERT INTO `cs_customer_nonce` VALUES (572, 1, '74630a831b204027', '2026-05-02 21:30:59');
INSERT INTO `cs_customer_nonce` VALUES (573, 1, '2ab3992dbe9f4d9b', '2026-05-02 21:31:00');
INSERT INTO `cs_customer_nonce` VALUES (574, 1, 'a598852fa7b24796', '2026-05-02 21:31:01');
INSERT INTO `cs_customer_nonce` VALUES (575, 1, '5f8e7569bdcd4520', '2026-05-02 21:31:01');
INSERT INTO `cs_customer_nonce` VALUES (576, 1, '220805a8501e4b37', '2026-05-02 21:31:02');
INSERT INTO `cs_customer_nonce` VALUES (577, 1, '6c49e7090303488a', '2026-05-02 21:31:03');
INSERT INTO `cs_customer_nonce` VALUES (578, 1, 'a0bb3dec69624d55', '2026-05-02 21:31:04');
INSERT INTO `cs_customer_nonce` VALUES (579, 1, '9b23b609b5934127', '2026-05-02 21:31:05');
INSERT INTO `cs_customer_nonce` VALUES (580, 1, '44b456102fe249fd', '2026-05-02 21:31:06');
INSERT INTO `cs_customer_nonce` VALUES (581, 1, '89ea389f2b314737', '2026-05-02 21:31:06');
INSERT INTO `cs_customer_nonce` VALUES (582, 1, '164dea7edb72480b', '2026-05-02 21:31:07');
INSERT INTO `cs_customer_nonce` VALUES (583, 1, '5a776a86529e4783', '2026-05-02 21:31:08');
INSERT INTO `cs_customer_nonce` VALUES (584, 1, '49070d525e3f4d35', '2026-05-02 21:31:09');
INSERT INTO `cs_customer_nonce` VALUES (585, 1, '09d1bf8355124ba8', '2026-05-02 21:31:09');
INSERT INTO `cs_customer_nonce` VALUES (586, 1, '11e2f67cbe3344ff', '2026-05-02 21:31:10');
INSERT INTO `cs_customer_nonce` VALUES (587, 1, '51acb58cac284ac0', '2026-05-02 21:31:11');
INSERT INTO `cs_customer_nonce` VALUES (588, 1, 'f6aef18f20a446a5', '2026-05-02 21:32:59');
INSERT INTO `cs_customer_nonce` VALUES (589, 1, '8c46f275f2544529', '2026-05-02 21:33:00');
INSERT INTO `cs_customer_nonce` VALUES (590, 1, '72d1b1ef514d4c62', '2026-05-02 21:33:02');
INSERT INTO `cs_customer_nonce` VALUES (591, 1, 'b1ba39818ebf48b1', '2026-05-02 21:33:04');
INSERT INTO `cs_customer_nonce` VALUES (592, 1, '14903387a11d40d8', '2026-05-02 21:33:05');
INSERT INTO `cs_customer_nonce` VALUES (593, 1, '6f714ef17ed1404d', '2026-05-02 21:33:06');
INSERT INTO `cs_customer_nonce` VALUES (594, 1, 'bfb2b376d1f14552', '2026-05-02 21:33:08');
INSERT INTO `cs_customer_nonce` VALUES (595, 1, 'b791cb80d8434f64', '2026-05-02 21:33:11');
INSERT INTO `cs_customer_nonce` VALUES (596, 1, '23f378985f534f40', '2026-05-02 21:33:12');
INSERT INTO `cs_customer_nonce` VALUES (597, 1, '9da2d74e1eb24bb4', '2026-05-02 21:33:14');
INSERT INTO `cs_customer_nonce` VALUES (598, 1, '49f9de9eb0c04929', '2026-05-02 21:33:15');
INSERT INTO `cs_customer_nonce` VALUES (599, 1, '59d10f13ac964da7', '2026-05-02 21:33:16');
INSERT INTO `cs_customer_nonce` VALUES (600, 1, 'f3ff446d6ecd4425', '2026-05-02 21:33:18');
INSERT INTO `cs_customer_nonce` VALUES (601, 1, '23fbe1548f4948f4', '2026-05-02 21:33:19');
INSERT INTO `cs_customer_nonce` VALUES (602, 1, 'b443bc15a3ba447e', '2026-05-02 21:33:50');
INSERT INTO `cs_customer_nonce` VALUES (603, 1, 'd485dee673634ba1', '2026-05-02 21:33:51');
INSERT INTO `cs_customer_nonce` VALUES (604, 1, '3eb04927f9e84031', '2026-05-02 21:33:52');
INSERT INTO `cs_customer_nonce` VALUES (605, 1, '17afad3f096d4ebc', '2026-05-02 21:33:53');
INSERT INTO `cs_customer_nonce` VALUES (606, 1, 'ff6c0907fe9646a1', '2026-05-02 21:33:55');
INSERT INTO `cs_customer_nonce` VALUES (607, 1, '433f20dda2694659', '2026-05-02 21:33:56');
INSERT INTO `cs_customer_nonce` VALUES (608, 1, '169c4d1d56a94eea', '2026-05-02 21:33:57');
INSERT INTO `cs_customer_nonce` VALUES (609, 1, '4a320dbfd15b4bd7', '2026-05-02 21:33:58');
INSERT INTO `cs_customer_nonce` VALUES (610, 1, '8f77bf4c0ff647f1', '2026-05-02 21:34:05');
INSERT INTO `cs_customer_nonce` VALUES (611, 1, '7227d09178334537', '2026-05-02 21:34:19');
INSERT INTO `cs_customer_nonce` VALUES (612, 1, '50b1f1daade0404c', '2026-05-02 21:34:20');
INSERT INTO `cs_customer_nonce` VALUES (613, 1, '5df423b5244a4546', '2026-05-02 21:34:21');
INSERT INTO `cs_customer_nonce` VALUES (614, 1, 'f84ee8c808624a1d', '2026-05-02 21:34:22');
INSERT INTO `cs_customer_nonce` VALUES (615, 1, 'c82e55aa1002401d', '2026-05-02 21:34:23');
INSERT INTO `cs_customer_nonce` VALUES (616, 1, 'ec3a5b47c5b84df0', '2026-05-02 21:34:24');
INSERT INTO `cs_customer_nonce` VALUES (617, 1, '1de2a9156b744f23', '2026-05-02 21:34:25');
INSERT INTO `cs_customer_nonce` VALUES (618, 1, '4ddd7570b7164554', '2026-05-02 21:34:27');
INSERT INTO `cs_customer_nonce` VALUES (619, 1, '0fe0332ab9694804', '2026-05-02 21:34:28');
INSERT INTO `cs_customer_nonce` VALUES (620, 1, '09aafe1059ab4ca7', '2026-05-02 21:34:28');
INSERT INTO `cs_customer_nonce` VALUES (621, 1, '173f34eb72b7453a', '2026-05-02 21:34:29');
INSERT INTO `cs_customer_nonce` VALUES (622, 1, '6ffcac35612d41f8', '2026-05-02 21:34:30');
INSERT INTO `cs_customer_nonce` VALUES (623, 1, '938a91e802b64808', '2026-05-02 21:34:32');
INSERT INTO `cs_customer_nonce` VALUES (624, 1, '02be3f403ea94795', '2026-05-02 21:34:32');
INSERT INTO `cs_customer_nonce` VALUES (625, 1, 'fcd4b4c6e92841fc', '2026-05-02 21:34:33');
INSERT INTO `cs_customer_nonce` VALUES (626, 1, '422d989f29474ec1', '2026-05-02 21:34:34');
INSERT INTO `cs_customer_nonce` VALUES (627, 1, '5c488a5cdca346ff', '2026-05-02 21:34:35');
INSERT INTO `cs_customer_nonce` VALUES (628, 1, 'f6b87c3731dc4923', '2026-05-02 21:34:37');
INSERT INTO `cs_customer_nonce` VALUES (629, 1, '1ef725f241604a11', '2026-05-02 21:34:38');
INSERT INTO `cs_customer_nonce` VALUES (630, 1, '1c2bab3b263b4857', '2026-05-02 21:34:39');
INSERT INTO `cs_customer_nonce` VALUES (631, 1, '215b09de42fc41b6', '2026-05-02 21:34:40');
INSERT INTO `cs_customer_nonce` VALUES (632, 1, '49b659d0215b4a8c', '2026-05-02 21:34:41');
INSERT INTO `cs_customer_nonce` VALUES (633, 1, '07ccaebc2b8e461f', '2026-05-02 21:34:42');
INSERT INTO `cs_customer_nonce` VALUES (634, 1, 'd24f8d48f15b4f6a', '2026-05-02 21:34:43');
INSERT INTO `cs_customer_nonce` VALUES (635, 1, 'd12cc247237547aa', '2026-05-02 21:34:44');
INSERT INTO `cs_customer_nonce` VALUES (636, 1, 'a1ef032b281b47ed', '2026-05-02 21:34:45');
INSERT INTO `cs_customer_nonce` VALUES (637, 1, 'f242542426d24a4e', '2026-05-02 21:34:47');
INSERT INTO `cs_customer_nonce` VALUES (638, 1, '39b287ebc7a14fbf', '2026-05-02 21:34:48');
INSERT INTO `cs_customer_nonce` VALUES (639, 1, '562b62cca49549e7', '2026-05-02 21:34:48');
INSERT INTO `cs_customer_nonce` VALUES (640, 1, '6e0aca9c612a4183', '2026-05-02 21:34:50');
INSERT INTO `cs_customer_nonce` VALUES (641, 1, 'f5cd303c55d945ab', '2026-05-02 21:34:52');
INSERT INTO `cs_customer_nonce` VALUES (642, 1, 'f6ab827ae22b44f0', '2026-05-02 21:34:53');
INSERT INTO `cs_customer_nonce` VALUES (643, 1, '4521106e4d3b4a09', '2026-05-02 21:34:55');
INSERT INTO `cs_customer_nonce` VALUES (644, 1, '52d84d53711b44be', '2026-05-02 21:34:56');
INSERT INTO `cs_customer_nonce` VALUES (645, 1, 'd59ec58a168a4a11', '2026-05-02 21:34:57');
INSERT INTO `cs_customer_nonce` VALUES (646, 1, 'fcac65955bcc4492', '2026-05-02 21:34:59');
INSERT INTO `cs_customer_nonce` VALUES (647, 1, '96d3d8642fd34cd4', '2026-05-02 21:35:00');
INSERT INTO `cs_customer_nonce` VALUES (648, 1, '0f4a2c90d1dc4e88', '2026-05-02 21:35:02');
INSERT INTO `cs_customer_nonce` VALUES (649, 1, '7747bb6edafa4837', '2026-05-02 21:35:04');
INSERT INTO `cs_customer_nonce` VALUES (650, 1, '825fff12555941c8', '2026-05-02 21:35:05');
INSERT INTO `cs_customer_nonce` VALUES (651, 1, '4c7b7af423934ed7', '2026-05-02 21:35:07');
INSERT INTO `cs_customer_nonce` VALUES (652, 1, '9c089c4661134c49', '2026-05-02 21:35:52');
INSERT INTO `cs_customer_nonce` VALUES (653, 1, '026e5fd403524354', '2026-05-02 21:35:54');
INSERT INTO `cs_customer_nonce` VALUES (654, 1, 'f81c2141ef91492d', '2026-05-02 21:35:55');
INSERT INTO `cs_customer_nonce` VALUES (655, 1, '012fbf3056594e78', '2026-05-02 21:35:57');
INSERT INTO `cs_customer_nonce` VALUES (656, 1, 'da8f64c648384d2c', '2026-05-02 21:35:58');
INSERT INTO `cs_customer_nonce` VALUES (657, 1, '05d4a503a44b4964', '2026-05-02 21:35:59');
INSERT INTO `cs_customer_nonce` VALUES (658, 1, '9d3f68566c364cab', '2026-05-02 21:36:01');
INSERT INTO `cs_customer_nonce` VALUES (659, 1, 'cfaaa6722a124965', '2026-05-02 21:36:02');
INSERT INTO `cs_customer_nonce` VALUES (660, 1, 'e07b7b987afb46e6', '2026-05-02 21:36:04');
INSERT INTO `cs_customer_nonce` VALUES (661, 1, 'b239b479de3a4eae', '2026-05-02 21:36:05');
INSERT INTO `cs_customer_nonce` VALUES (662, 1, '2579df77788b4dff', '2026-05-02 21:36:30');
INSERT INTO `cs_customer_nonce` VALUES (663, 1, '8b6db470ec6943e2', '2026-05-02 21:36:31');
INSERT INTO `cs_customer_nonce` VALUES (664, 1, 'ee6c18d017c3468f', '2026-05-02 21:36:34');
INSERT INTO `cs_customer_nonce` VALUES (665, 1, '62f2b4a70fc3415c', '2026-05-02 21:36:34');
INSERT INTO `cs_customer_nonce` VALUES (666, 1, 'ce8fbe6ea928483e', '2026-05-02 21:36:35');
INSERT INTO `cs_customer_nonce` VALUES (667, 1, '58b1bbb716184d99', '2026-05-02 21:36:36');
INSERT INTO `cs_customer_nonce` VALUES (668, 1, 'b877de83fe69428c', '2026-05-02 21:36:38');
INSERT INTO `cs_customer_nonce` VALUES (669, 1, '2806a791a3204227', '2026-05-02 21:36:39');
INSERT INTO `cs_customer_nonce` VALUES (670, 1, '3e385d481d61403e', '2026-05-02 21:36:40');
INSERT INTO `cs_customer_nonce` VALUES (671, 1, '3ae0049974d54aa5', '2026-05-02 21:36:41');
INSERT INTO `cs_customer_nonce` VALUES (672, 1, 'dc6db30ccd2b477d', '2026-05-02 21:36:41');
INSERT INTO `cs_customer_nonce` VALUES (673, 1, '837ba4986a6a4264', '2026-05-02 21:37:00');
INSERT INTO `cs_customer_nonce` VALUES (674, 1, '661415b4d0be4080', '2026-05-02 21:37:01');
INSERT INTO `cs_customer_nonce` VALUES (675, 1, '1eeb5a42304f43b2', '2026-05-02 21:37:02');
INSERT INTO `cs_customer_nonce` VALUES (676, 1, '32867f046230413d', '2026-05-02 21:37:03');
INSERT INTO `cs_customer_nonce` VALUES (677, 1, 'a4aacb355eed4201', '2026-05-02 21:37:04');
INSERT INTO `cs_customer_nonce` VALUES (678, 1, 'a1e069fab6454817', '2026-05-02 21:37:05');
INSERT INTO `cs_customer_nonce` VALUES (679, 1, '2631fb7ab7e04503', '2026-05-02 21:37:06');
INSERT INTO `cs_customer_nonce` VALUES (680, 1, '0eca79a0a3cb4156', '2026-05-02 21:37:06');
INSERT INTO `cs_customer_nonce` VALUES (681, 1, '191c2411b4f043c3', '2026-05-02 21:37:07');
INSERT INTO `cs_customer_nonce` VALUES (682, 1, 'ddfc8c788d944b1e', '2026-05-02 21:37:08');
INSERT INTO `cs_customer_nonce` VALUES (683, 1, 'ba2cb2a63f084331', '2026-05-02 21:37:09');
INSERT INTO `cs_customer_nonce` VALUES (684, 1, '659c8b5377da445e', '2026-05-02 21:37:10');
INSERT INTO `cs_customer_nonce` VALUES (685, 1, '9f75cccb96504e89', '2026-05-02 21:37:11');
INSERT INTO `cs_customer_nonce` VALUES (686, 1, 'b899505471d54a50', '2026-05-02 21:37:12');
INSERT INTO `cs_customer_nonce` VALUES (687, 1, '74bffaa86c3d407d', '2026-05-02 21:37:13');
INSERT INTO `cs_customer_nonce` VALUES (688, 1, '0130b1c90a6a49e9', '2026-05-02 21:37:14');
INSERT INTO `cs_customer_nonce` VALUES (689, 1, '8a76fcfa13e44897', '2026-05-02 21:37:15');
INSERT INTO `cs_customer_nonce` VALUES (690, 1, '7179fbd12106473a', '2026-05-02 21:37:15');
INSERT INTO `cs_customer_nonce` VALUES (691, 1, 'cb608b503ebb466b', '2026-05-02 21:37:16');
INSERT INTO `cs_customer_nonce` VALUES (692, 1, 'ccafa4dc545a476e', '2026-05-02 21:37:17');
INSERT INTO `cs_customer_nonce` VALUES (693, 1, 'a2906409cd5f4349', '2026-05-02 21:37:19');
INSERT INTO `cs_customer_nonce` VALUES (694, 1, 'a3dd265fd2a44614', '2026-05-02 21:37:19');
INSERT INTO `cs_customer_nonce` VALUES (695, 1, '106a749c1a94409b', '2026-05-02 21:37:20');
INSERT INTO `cs_customer_nonce` VALUES (696, 1, '754acdba263b4a60', '2026-05-02 21:37:21');
INSERT INTO `cs_customer_nonce` VALUES (697, 1, '4f32ae98e6ff40e0', '2026-05-02 21:37:22');
INSERT INTO `cs_customer_nonce` VALUES (698, 1, '703d1a864f644773', '2026-05-02 21:37:23');
INSERT INTO `cs_customer_nonce` VALUES (699, 1, 'f6add32980794a3f', '2026-05-02 21:37:24');
INSERT INTO `cs_customer_nonce` VALUES (700, 1, '048d1d8641774dea', '2026-05-02 21:37:25');
INSERT INTO `cs_customer_nonce` VALUES (701, 1, 'e74bc02475a54e38', '2026-05-02 21:37:26');
INSERT INTO `cs_customer_nonce` VALUES (702, 1, 'c1abc2b9853f41f1', '2026-05-02 21:37:27');
INSERT INTO `cs_customer_nonce` VALUES (703, 1, 'ee9ec4d1eff540ee', '2026-05-02 21:37:28');
INSERT INTO `cs_customer_nonce` VALUES (704, 1, '4e7dbfbf81b144bb', '2026-05-02 21:37:29');
INSERT INTO `cs_customer_nonce` VALUES (705, 1, '16e67c876fb54f91', '2026-05-02 21:37:31');
INSERT INTO `cs_customer_nonce` VALUES (706, 1, 'da0cf52cb3af4a47', '2026-05-02 21:37:31');
INSERT INTO `cs_customer_nonce` VALUES (707, 1, '345c303205de472e', '2026-05-02 21:37:32');
INSERT INTO `cs_customer_nonce` VALUES (708, 1, '2145e0c5aabf4cb0', '2026-05-02 21:37:33');
INSERT INTO `cs_customer_nonce` VALUES (709, 1, 'eec644ae56e74401', '2026-05-02 21:37:34');
INSERT INTO `cs_customer_nonce` VALUES (710, 1, 'c259b79c9ad545f3', '2026-05-02 21:37:35');
INSERT INTO `cs_customer_nonce` VALUES (711, 1, '615123d720d04537', '2026-05-02 21:37:37');
INSERT INTO `cs_customer_nonce` VALUES (712, 1, '4e1575d979844f40', '2026-05-02 21:37:38');
INSERT INTO `cs_customer_nonce` VALUES (713, 1, '2dfb96e829944852', '2026-05-02 21:47:43');
INSERT INTO `cs_customer_nonce` VALUES (714, 1, '908ba869b0914753', '2026-05-02 21:47:45');
INSERT INTO `cs_customer_nonce` VALUES (715, 1, 'c8bb969f5c7d4bd3', '2026-05-02 21:48:05');
INSERT INTO `cs_customer_nonce` VALUES (716, 1, '6a84407a952c4d6d', '2026-05-02 21:48:07');
INSERT INTO `cs_customer_nonce` VALUES (717, 1, '3c0fbcf07f194722', '2026-05-02 21:48:09');
INSERT INTO `cs_customer_nonce` VALUES (718, 1, '52a48c7d24434b63', '2026-05-02 21:48:09');
INSERT INTO `cs_customer_nonce` VALUES (719, 1, '32f41cc67dc94f0f', '2026-05-02 21:48:10');
INSERT INTO `cs_customer_nonce` VALUES (720, 1, '30c6125c883f4cab', '2026-05-02 21:48:11');
INSERT INTO `cs_customer_nonce` VALUES (721, 1, '3df3233870044c62', '2026-05-02 21:48:11');
INSERT INTO `cs_customer_nonce` VALUES (722, 1, '87d3f02a0b244e0b', '2026-05-02 21:48:12');
INSERT INTO `cs_customer_nonce` VALUES (723, 1, '6bad990bd4294944', '2026-05-02 21:48:13');
INSERT INTO `cs_customer_nonce` VALUES (724, 1, 'f88149db0be64a3d', '2026-05-02 21:48:14');
INSERT INTO `cs_customer_nonce` VALUES (725, 1, '7fb98683dac941e8', '2026-05-02 21:48:14');
INSERT INTO `cs_customer_nonce` VALUES (726, 1, '472c90b3c3d14ed5', '2026-05-02 21:48:15');
INSERT INTO `cs_customer_nonce` VALUES (727, 1, '2e1193ab74a745d4', '2026-05-02 21:48:16');
INSERT INTO `cs_customer_nonce` VALUES (728, 1, '087be01e2e624c47', '2026-05-02 21:48:17');
INSERT INTO `cs_customer_nonce` VALUES (729, 1, '82fa5a68835848cc', '2026-05-02 21:48:18');
INSERT INTO `cs_customer_nonce` VALUES (730, 1, '000fc504d7704ee4', '2026-05-02 21:48:18');
INSERT INTO `cs_customer_nonce` VALUES (731, 1, '50efe5198043424c', '2026-05-02 21:48:19');
INSERT INTO `cs_customer_nonce` VALUES (732, 1, 'e05b82785f1d4b3d', '2026-05-02 21:48:20');
INSERT INTO `cs_customer_nonce` VALUES (733, 1, 'bc9863ef49aa4d15', '2026-05-02 21:48:20');
INSERT INTO `cs_customer_nonce` VALUES (734, 1, '7ea3d906e56646ea', '2026-05-02 21:48:21');
INSERT INTO `cs_customer_nonce` VALUES (735, 1, '103b889b327f40e7', '2026-05-02 21:48:22');
INSERT INTO `cs_customer_nonce` VALUES (736, 1, 'c788b213e2804019', '2026-05-02 21:48:23');
INSERT INTO `cs_customer_nonce` VALUES (737, 1, 'a9f720004997432d', '2026-05-02 21:48:23');
INSERT INTO `cs_customer_nonce` VALUES (738, 1, '77c36141caca44fc', '2026-05-02 21:48:24');
INSERT INTO `cs_customer_nonce` VALUES (739, 1, '0cedc68da5e94a03', '2026-05-02 21:48:25');
INSERT INTO `cs_customer_nonce` VALUES (740, 1, 'c45e7b7b82154907', '2026-05-02 21:48:26');
INSERT INTO `cs_customer_nonce` VALUES (741, 1, '0a4b624fd4d3497b', '2026-05-02 21:48:26');
INSERT INTO `cs_customer_nonce` VALUES (742, 1, 'd1e384fcbb214050', '2026-05-02 21:48:27');
INSERT INTO `cs_customer_nonce` VALUES (743, 1, 'fcdfc57ecee54ae2', '2026-05-02 21:48:28');
INSERT INTO `cs_customer_nonce` VALUES (744, 1, 'dd261b198f6b476b', '2026-05-02 21:48:28');
INSERT INTO `cs_customer_nonce` VALUES (745, 1, '97217baaa0ac4796', '2026-05-02 21:48:29');
INSERT INTO `cs_customer_nonce` VALUES (746, 1, '2e27bdac53a64dae', '2026-05-02 21:48:30');
INSERT INTO `cs_customer_nonce` VALUES (747, 1, 'fb9a792a11d44392', '2026-05-02 21:48:30');
INSERT INTO `cs_customer_nonce` VALUES (748, 1, 'ee0dd0267b224748', '2026-05-02 21:48:31');
INSERT INTO `cs_customer_nonce` VALUES (749, 1, '7784587955a74243', '2026-05-02 21:48:32');
INSERT INTO `cs_customer_nonce` VALUES (750, 1, 'fa701fbc9f804537', '2026-05-02 21:48:32');
INSERT INTO `cs_customer_nonce` VALUES (751, 1, '757b08b2910447d8', '2026-05-02 21:48:33');
INSERT INTO `cs_customer_nonce` VALUES (752, 1, 'ce75e93dcb224838', '2026-05-02 21:48:34');
INSERT INTO `cs_customer_nonce` VALUES (753, 1, '95e61e37e23e4407', '2026-05-02 21:48:34');
INSERT INTO `cs_customer_nonce` VALUES (754, 1, 'fb8baea5a75c45f0', '2026-05-02 21:48:35');
INSERT INTO `cs_customer_nonce` VALUES (755, 1, 'd1c3b51e725b4666', '2026-05-02 21:48:35');
INSERT INTO `cs_customer_nonce` VALUES (756, 1, '8fe111f1dc584f39', '2026-05-02 21:48:36');
INSERT INTO `cs_customer_nonce` VALUES (757, 1, 'fed86fb993aa4d5e', '2026-05-02 21:48:36');
INSERT INTO `cs_customer_nonce` VALUES (758, 1, '86f20d9b6c984077', '2026-05-02 21:48:37');
INSERT INTO `cs_customer_nonce` VALUES (759, 1, '785eb89b682d41d3', '2026-05-02 21:48:38');
INSERT INTO `cs_customer_nonce` VALUES (760, 1, '30d7901174f444d2', '2026-05-02 21:48:53');
INSERT INTO `cs_customer_nonce` VALUES (761, 1, '08b6df17f20d4e76', '2026-05-02 21:48:55');
INSERT INTO `cs_customer_nonce` VALUES (762, 1, 'fc0ca74fc46f497a', '2026-05-02 21:48:56');
INSERT INTO `cs_customer_nonce` VALUES (763, 1, '4125ba66c6894cb2', '2026-05-02 21:48:56');
INSERT INTO `cs_customer_nonce` VALUES (764, 1, 'bbf6b5120a2b40f4', '2026-05-02 21:48:57');
INSERT INTO `cs_customer_nonce` VALUES (765, 1, '5cade6e6e64b4574', '2026-05-02 21:48:58');
INSERT INTO `cs_customer_nonce` VALUES (766, 1, 'b7347fbb5a6f4fa4', '2026-05-02 21:48:59');
INSERT INTO `cs_customer_nonce` VALUES (767, 1, 'f3fa46a447a64d05', '2026-05-02 21:49:00');
INSERT INTO `cs_customer_nonce` VALUES (768, 1, 'b19f22f786ab4489', '2026-05-02 21:49:01');
INSERT INTO `cs_customer_nonce` VALUES (769, 1, '42e2d6ba58ca449b', '2026-05-02 21:49:01');
INSERT INTO `cs_customer_nonce` VALUES (770, 1, '9a59cb3aa4404bac', '2026-05-02 21:49:02');
INSERT INTO `cs_customer_nonce` VALUES (771, 1, 'c888995fae7143c9', '2026-05-02 21:49:03');
INSERT INTO `cs_customer_nonce` VALUES (772, 1, 'f3902b30587047a9', '2026-05-02 21:52:32');
INSERT INTO `cs_customer_nonce` VALUES (773, 1, 'c5efa71356d74dff', '2026-05-02 21:52:38');
INSERT INTO `cs_customer_nonce` VALUES (774, 1, 'ff0ce8fd19b943b8', '2026-05-02 21:52:40');
INSERT INTO `cs_customer_nonce` VALUES (775, 1, 'e60340f635164d56', '2026-05-02 21:52:42');
INSERT INTO `cs_customer_nonce` VALUES (776, 1, '01ce0006a8e34473', '2026-05-02 21:52:43');
INSERT INTO `cs_customer_nonce` VALUES (777, 1, '083731bfdb2d4ee1', '2026-05-02 21:52:45');
INSERT INTO `cs_customer_nonce` VALUES (778, 1, 'f8715452738e4194', '2026-05-02 21:52:47');
INSERT INTO `cs_customer_nonce` VALUES (779, 1, 'deb3fc7594964b46', '2026-05-02 21:52:49');
INSERT INTO `cs_customer_nonce` VALUES (780, 1, '0d8aa35e89f848eb', '2026-05-02 21:52:50');
INSERT INTO `cs_customer_nonce` VALUES (781, 1, '722946ea59fe44f8', '2026-05-02 21:52:53');
INSERT INTO `cs_customer_nonce` VALUES (782, 1, '860593f2af1b4690', '2026-05-02 21:52:55');
INSERT INTO `cs_customer_nonce` VALUES (783, 1, '2158a99309864690', '2026-05-02 21:52:56');
INSERT INTO `cs_customer_nonce` VALUES (784, 1, '4dbf9c3a8afc4b0b', '2026-05-02 21:52:58');
INSERT INTO `cs_customer_nonce` VALUES (785, 1, 'd553724e63e44154', '2026-05-02 22:04:12');
INSERT INTO `cs_customer_nonce` VALUES (786, 1, '3caa68c51b5a4d37', '2026-05-02 22:15:38');
INSERT INTO `cs_customer_nonce` VALUES (787, 1, '7c8d47bae6b84645', '2026-05-02 22:15:45');
INSERT INTO `cs_customer_nonce` VALUES (788, 1, '4ef116e9fbf048d8', '2026-05-02 22:15:54');
INSERT INTO `cs_customer_nonce` VALUES (789, 1, '191c9d99b16841a1', '2026-05-02 22:17:38');
INSERT INTO `cs_customer_nonce` VALUES (790, 1, '3435df8fa55a49ea', '2026-05-02 22:18:23');
INSERT INTO `cs_customer_nonce` VALUES (791, 1, 'b4c97414e92d49c7', '2026-05-02 22:18:39');
INSERT INTO `cs_customer_nonce` VALUES (792, 1, '2f1ffb0c3b4d40af', '2026-05-02 22:26:46');
INSERT INTO `cs_customer_nonce` VALUES (793, 1, 'c12b2d07f5b94084', '2026-05-02 22:26:51');
INSERT INTO `cs_customer_nonce` VALUES (794, 1, '5e4ba873a96d4dc5', '2026-05-02 22:29:10');
INSERT INTO `cs_customer_nonce` VALUES (795, 1, '66ec8fa9dfd34fb6', '2026-05-02 22:29:20');
INSERT INTO `cs_customer_nonce` VALUES (796, 1, '6a578de4b60642e0', '2026-05-02 22:29:26');
INSERT INTO `cs_customer_nonce` VALUES (797, 1, 'c61e31ed46c04e3c', '2026-05-02 22:29:40');
INSERT INTO `cs_customer_nonce` VALUES (798, 1, '2be80e58240047e2', '2026-05-02 22:29:48');
INSERT INTO `cs_customer_nonce` VALUES (799, 1, '4b7fea5b1fa0406f', '2026-05-02 22:30:05');
INSERT INTO `cs_customer_nonce` VALUES (800, 1, '2dfa28c1d670456b', '2026-05-02 22:30:17');
INSERT INTO `cs_customer_nonce` VALUES (801, 1, '9255b1dd94944645', '2026-05-02 22:30:27');
INSERT INTO `cs_customer_nonce` VALUES (802, 1, '9d1b40629a0b4eaa', '2026-05-02 22:30:34');
INSERT INTO `cs_customer_nonce` VALUES (803, 1, '8046b60f4dd847cf', '2026-05-02 22:30:48');
INSERT INTO `cs_customer_nonce` VALUES (804, 1, '2142d96aafb04965', '2026-05-02 22:38:27');
INSERT INTO `cs_customer_nonce` VALUES (805, 1, 'eaba0784dc284362', '2026-05-02 22:38:32');
INSERT INTO `cs_customer_nonce` VALUES (806, 1, '1ababd92b49d46ef', '2026-05-02 22:45:33');
INSERT INTO `cs_customer_nonce` VALUES (807, 1, '54db182efa5142ae', '2026-05-02 22:45:38');
INSERT INTO `cs_customer_nonce` VALUES (808, 1, '43395606234b4193', '2026-05-04 02:45:24');
INSERT INTO `cs_customer_nonce` VALUES (809, 1, 'b10946ebbce04a8f', '2026-05-04 02:46:45');
INSERT INTO `cs_customer_nonce` VALUES (810, 1, '1fdc3cba9df84734', '2026-05-04 15:32:31');
INSERT INTO `cs_customer_nonce` VALUES (811, 1, 'ec9752195012435b', '2026-05-04 15:32:36');
INSERT INTO `cs_customer_nonce` VALUES (812, 1, 'daaa1671849c4d2c', '2026-05-04 15:32:38');
INSERT INTO `cs_customer_nonce` VALUES (813, 1, '5f11277fe1b444c7', '2026-05-04 15:32:55');
INSERT INTO `cs_customer_nonce` VALUES (814, 1, '994a2231be8a4df1', '2026-05-04 15:46:47');
INSERT INTO `cs_customer_nonce` VALUES (815, 1, '66886ca6932543fe', '2026-05-04 16:28:12');
INSERT INTO `cs_customer_nonce` VALUES (816, 1, '8db16d12d9464529', '2026-05-06 09:50:41');
INSERT INTO `cs_customer_nonce` VALUES (817, 1, '563c2d87a5094a1d', '2026-05-06 10:02:11');
INSERT INTO `cs_customer_nonce` VALUES (818, 1, '5aadeaf0c4da446f', '2026-05-06 10:05:10');
INSERT INTO `cs_customer_nonce` VALUES (819, 1, 'ccc6c772426c4b5b', '2026-05-07 10:01:44');
INSERT INTO `cs_customer_nonce` VALUES (820, 1, '44d8b58b7bbb4923', '2026-05-07 10:34:03');
INSERT INTO `cs_customer_nonce` VALUES (821, 1, '2576db3cb31c41dd', '2026-05-08 18:30:53');
INSERT INTO `cs_customer_nonce` VALUES (822, 1, '203bc385cdbc46e7', '2026-05-09 10:02:34');
INSERT INTO `cs_customer_nonce` VALUES (823, 1, 'ef08dd921be24e72', '2026-05-11 09:21:33');
INSERT INTO `cs_customer_nonce` VALUES (824, 1, '7c38144c49e149d6', '2026-05-11 09:21:36');
INSERT INTO `cs_customer_nonce` VALUES (825, 1, 'd48ac903d239477f', '2026-05-11 09:21:37');
INSERT INTO `cs_customer_nonce` VALUES (826, 1, 'c5e2e5c970f145d8', '2026-05-11 09:21:38');
INSERT INTO `cs_customer_nonce` VALUES (827, 1, 'a8ef568697d64ff2', '2026-05-11 09:21:39');
INSERT INTO `cs_customer_nonce` VALUES (828, 1, '43860081c9f440c3', '2026-05-11 09:22:55');
INSERT INTO `cs_customer_nonce` VALUES (829, 1, '6d80adac83c24e42', '2026-05-11 09:23:00');
INSERT INTO `cs_customer_nonce` VALUES (830, 1, '625820d0efe84be9', '2026-05-11 09:23:01');
INSERT INTO `cs_customer_nonce` VALUES (831, 1, '1daa3960a7614cb4', '2026-05-11 09:23:02');
INSERT INTO `cs_customer_nonce` VALUES (832, 1, '0025cfc76a954dc9', '2026-05-11 09:28:58');
INSERT INTO `cs_customer_nonce` VALUES (833, 1, 'e7c5a1eb54ad4097', '2026-05-11 09:29:11');
INSERT INTO `cs_customer_nonce` VALUES (834, 1, '419fead553564a6b', '2026-05-11 09:29:14');
INSERT INTO `cs_customer_nonce` VALUES (835, 1, 'f30265443a0b41bf', '2026-05-11 09:29:14');
INSERT INTO `cs_customer_nonce` VALUES (836, 1, 'c6a25efdd2f74ed0', '2026-05-11 09:29:15');
INSERT INTO `cs_customer_nonce` VALUES (837, 1, 'db2b4fb28b6243e5', '2026-05-11 09:29:16');
INSERT INTO `cs_customer_nonce` VALUES (838, 1, '18713c766c6843a0', '2026-05-11 09:29:32');
INSERT INTO `cs_customer_nonce` VALUES (839, 1, '12341258424d43f7', '2026-05-11 09:29:32');
INSERT INTO `cs_customer_nonce` VALUES (840, 1, '694cc054ed524011', '2026-05-11 09:29:33');
INSERT INTO `cs_customer_nonce` VALUES (841, 1, '2c38d2e048fc4441', '2026-05-11 09:29:34');
INSERT INTO `cs_customer_nonce` VALUES (842, 1, '586e0cfff27c425e', '2026-05-11 09:29:34');
INSERT INTO `cs_customer_nonce` VALUES (843, 1, '165de5feefe34744', '2026-05-11 09:29:36');
INSERT INTO `cs_customer_nonce` VALUES (844, 1, '248f0305a22d496b', '2026-05-11 09:29:40');
INSERT INTO `cs_customer_nonce` VALUES (845, 1, 'e4cd760a60d24c4d', '2026-05-11 09:29:41');
INSERT INTO `cs_customer_nonce` VALUES (846, 1, '48611d3f4bf14a6d', '2026-05-11 09:29:41');
INSERT INTO `cs_customer_nonce` VALUES (847, 1, '156bfe47e81c4760', '2026-05-11 09:29:42');
INSERT INTO `cs_customer_nonce` VALUES (848, 1, '5f3ade45933b4bc1', '2026-05-11 09:29:43');
INSERT INTO `cs_customer_nonce` VALUES (849, 1, '0d6301a0326e4063', '2026-05-11 09:29:50');
INSERT INTO `cs_customer_nonce` VALUES (850, 1, '68a35e658e2d4ff7', '2026-05-11 10:18:29');
INSERT INTO `cs_customer_nonce` VALUES (851, 1, '88cc6fefc8204f78', '2026-05-11 10:21:26');
INSERT INTO `cs_customer_nonce` VALUES (852, 1, '8e9bf8419ffe45ec', '2026-05-11 10:22:25');
INSERT INTO `cs_customer_nonce` VALUES (853, 1, '4b4f7ed2d4024a70', '2026-05-11 10:25:44');
INSERT INTO `cs_customer_nonce` VALUES (854, 1, '705e67d56acc4eca', '2026-05-11 10:27:48');
INSERT INTO `cs_customer_nonce` VALUES (855, 1, '5cad9b66a31d4e92', '2026-05-11 10:27:51');
INSERT INTO `cs_customer_nonce` VALUES (856, 1, 'c4f0817c967f45ff', '2026-05-11 10:27:52');
INSERT INTO `cs_customer_nonce` VALUES (857, 1, '7a2d074cc7074771', '2026-05-11 10:27:53');
INSERT INTO `cs_customer_nonce` VALUES (858, 1, '814a0fdcc8754d1e', '2026-05-11 10:27:54');
INSERT INTO `cs_customer_nonce` VALUES (859, 1, 'e9c85a4ce22e448d', '2026-05-11 10:27:54');
INSERT INTO `cs_customer_nonce` VALUES (860, 1, '64dcd3ea98ba4c93', '2026-05-11 10:27:55');
INSERT INTO `cs_customer_nonce` VALUES (861, 1, '7d3dadf8c0eb43f7', '2026-05-11 10:27:56');
INSERT INTO `cs_customer_nonce` VALUES (862, 1, 'e5b0a489561241bd', '2026-05-11 10:28:21');
INSERT INTO `cs_customer_nonce` VALUES (863, 1, '1f478316972a4bf5', '2026-05-11 10:28:22');
INSERT INTO `cs_customer_nonce` VALUES (864, 1, '3e345be18df041c0', '2026-05-11 10:28:24');
INSERT INTO `cs_customer_nonce` VALUES (865, 1, 'ffe19e501f0b4f0e', '2026-05-11 10:28:52');
INSERT INTO `cs_customer_nonce` VALUES (866, 1, 'c74d5e70c77f48b0', '2026-05-11 10:29:35');
INSERT INTO `cs_customer_nonce` VALUES (867, 1, '89e43f071f3d42e3', '2026-05-11 10:32:19');
INSERT INTO `cs_customer_nonce` VALUES (868, 1, '543f44c05d2b45d5', '2026-05-11 10:32:20');
INSERT INTO `cs_customer_nonce` VALUES (869, 1, 'ecc2ef91730445f4', '2026-05-11 10:32:20');
INSERT INTO `cs_customer_nonce` VALUES (870, 1, 'af8626a544934a14', '2026-05-11 10:32:21');
INSERT INTO `cs_customer_nonce` VALUES (871, 1, '81af790d0d0d443e', '2026-05-11 10:32:22');
INSERT INTO `cs_customer_nonce` VALUES (872, 1, '1525db0d35c64f1d', '2026-05-11 10:32:22');
INSERT INTO `cs_customer_nonce` VALUES (873, 1, '4124c059bd7447b7', '2026-05-11 10:32:23');
INSERT INTO `cs_customer_nonce` VALUES (874, 1, '7e8d6ca8b5e64de7', '2026-05-11 10:32:23');
INSERT INTO `cs_customer_nonce` VALUES (875, 1, '0dd9ee6f80c848e8', '2026-05-11 10:32:23');
INSERT INTO `cs_customer_nonce` VALUES (876, 1, '06ffba3131c94feb', '2026-05-11 10:32:23');
INSERT INTO `cs_customer_nonce` VALUES (877, 1, '4cab22d943834d7f', '2026-05-11 10:32:24');
INSERT INTO `cs_customer_nonce` VALUES (878, 1, 'd0dfbc275d2f4d42', '2026-05-11 10:32:24');
INSERT INTO `cs_customer_nonce` VALUES (879, 1, 'b38757c80b01410d', '2026-05-11 10:32:25');
INSERT INTO `cs_customer_nonce` VALUES (880, 1, 'f9c6183155224a73', '2026-05-11 10:32:25');
INSERT INTO `cs_customer_nonce` VALUES (881, 1, '43c078d300bd426b', '2026-05-11 10:33:10');
INSERT INTO `cs_customer_nonce` VALUES (882, 1, 'c3030e21694a4b27', '2026-05-11 10:50:51');
INSERT INTO `cs_customer_nonce` VALUES (883, 1, '54d687b50c11419d', '2026-05-12 15:58:15');
INSERT INTO `cs_customer_nonce` VALUES (884, 1, 'd3383452a03e4d86', '2026-05-12 15:58:23');
INSERT INTO `cs_customer_nonce` VALUES (885, 1, '90e4dcc78404498d', '2026-05-12 16:36:05');
INSERT INTO `cs_customer_nonce` VALUES (886, 1, 'bf4502ba5df24787', '2026-05-12 16:36:20');
INSERT INTO `cs_customer_nonce` VALUES (887, 1, 'ef53d13f736d4147', '2026-05-12 16:40:14');
INSERT INTO `cs_customer_nonce` VALUES (888, 1, '49256ed3f7074662', '2026-05-12 16:40:51');
INSERT INTO `cs_customer_nonce` VALUES (889, 1, 'eac320f89ae84f73', '2026-05-12 16:40:59');
INSERT INTO `cs_customer_nonce` VALUES (890, 1, '47c472457efe407e', '2026-05-12 16:41:15');
INSERT INTO `cs_customer_nonce` VALUES (891, 1, '40445db523aa4929', '2026-05-12 16:46:23');
INSERT INTO `cs_customer_nonce` VALUES (892, 1, 'ce5791f144e34f4d', '2026-05-12 16:52:25');
INSERT INTO `cs_customer_nonce` VALUES (893, 1, '3f9ec96529364245', '2026-05-12 16:53:08');
INSERT INTO `cs_customer_nonce` VALUES (894, 1, 'de7e02cb65704460', '2026-05-12 17:43:35');
INSERT INTO `cs_customer_nonce` VALUES (895, 1, 'bfbf4de8568145a0', '2026-05-12 17:43:51');
INSERT INTO `cs_customer_nonce` VALUES (896, 1, '76a550e4b69b4429', '2026-05-14 20:24:57');
INSERT INTO `cs_customer_nonce` VALUES (897, 1, '370d37b4f17a4639', '2026-05-14 20:25:41');
INSERT INTO `cs_customer_nonce` VALUES (898, 1, 'ecb3df16de3340e6', '2026-05-14 20:26:07');
INSERT INTO `cs_customer_nonce` VALUES (899, 1, '8fb6c679a5f04a4d', '2026-05-14 20:28:16');
INSERT INTO `cs_customer_nonce` VALUES (900, 1, '0da1b7ab618c4042', '2026-05-14 20:28:19');
INSERT INTO `cs_customer_nonce` VALUES (901, 1, 'ad84800fd2c245fd', '2026-05-14 20:28:32');
INSERT INTO `cs_customer_nonce` VALUES (902, 1, '4f2523bce3d141d2', '2026-05-14 20:28:46');
INSERT INTO `cs_customer_nonce` VALUES (903, 1, 'd7d7a01540dd4510', '2026-05-14 20:29:42');
INSERT INTO `cs_customer_nonce` VALUES (904, 1, '8cdeb725de074eca', '2026-05-14 20:29:50');
INSERT INTO `cs_customer_nonce` VALUES (905, 1, 'f9f6e8ee5b1c494b', '2026-05-14 20:29:58');
INSERT INTO `cs_customer_nonce` VALUES (906, 1, '4dc63a1bb90146a9', '2026-05-14 20:30:05');
INSERT INTO `cs_customer_nonce` VALUES (907, 1, '5b6a614f478c4db8', '2026-05-14 20:30:26');
INSERT INTO `cs_customer_nonce` VALUES (908, 1, 'd3852ecbfc344eb6', '2026-05-14 20:30:38');
INSERT INTO `cs_customer_nonce` VALUES (909, 1, '1deae97d402547be', '2026-05-14 20:31:01');
INSERT INTO `cs_customer_nonce` VALUES (910, 1, '4a180ae38cc04c84', '2026-05-14 20:31:05');
INSERT INTO `cs_customer_nonce` VALUES (911, 1, '9d30cc2804fc4134', '2026-05-14 20:31:08');
INSERT INTO `cs_customer_nonce` VALUES (912, 1, 'c996561a72f049de', '2026-05-14 20:31:09');
INSERT INTO `cs_customer_nonce` VALUES (913, 1, '1cc05aa88d804698', '2026-05-14 20:31:12');
INSERT INTO `cs_customer_nonce` VALUES (914, 1, 'b4fbe3f485e24a84', '2026-05-14 20:31:14');
INSERT INTO `cs_customer_nonce` VALUES (915, 1, 'e3a250f6cbed4736', '2026-05-14 20:31:39');
INSERT INTO `cs_customer_nonce` VALUES (916, 1, '75b82ff67e77497b', '2026-05-14 20:32:25');
INSERT INTO `cs_customer_nonce` VALUES (917, 1, '5f3cf16ea2814c88', '2026-05-14 20:36:12');
INSERT INTO `cs_customer_nonce` VALUES (918, 1, '2a8e2a7e4f064294', '2026-05-14 20:36:56');
INSERT INTO `cs_customer_nonce` VALUES (919, 1, 'c9236489a49745aa', '2026-05-14 20:52:47');
INSERT INTO `cs_customer_nonce` VALUES (920, 1, 'c5c7a5f722fc45d3', '2026-05-14 20:54:40');
INSERT INTO `cs_customer_nonce` VALUES (921, 1, '5196c5fce8094c46', '2026-05-14 20:54:42');
INSERT INTO `cs_customer_nonce` VALUES (922, 1, '2bddab4a0c704bd9', '2026-05-14 20:54:54');
INSERT INTO `cs_customer_nonce` VALUES (923, 1, '788d029a75344491', '2026-05-14 20:55:44');
INSERT INTO `cs_customer_nonce` VALUES (924, 1, '7df5b53378144275', '2026-05-14 20:55:49');
INSERT INTO `cs_customer_nonce` VALUES (925, 1, '3ea5f03f028c4779', '2026-05-14 20:55:53');
INSERT INTO `cs_customer_nonce` VALUES (926, 1, 'a8fa6860b1c24a6b', '2026-05-14 20:55:55');
INSERT INTO `cs_customer_nonce` VALUES (927, 1, '88b1ffe954654d0e', '2026-05-14 20:56:41');
INSERT INTO `cs_customer_nonce` VALUES (928, 1, 'abb06bf99c884a4a', '2026-05-14 20:56:44');
INSERT INTO `cs_customer_nonce` VALUES (929, 1, '2761276a2e394661', '2026-05-14 20:57:33');
INSERT INTO `cs_customer_nonce` VALUES (930, 1, '4eefc00fb5f649a3', '2026-05-14 20:57:36');
INSERT INTO `cs_customer_nonce` VALUES (931, 1, '8c1ba05db7364863', '2026-05-14 20:59:06');
INSERT INTO `cs_customer_nonce` VALUES (932, 1, 'b4b89e8fe6d24030', '2026-05-14 20:59:08');
INSERT INTO `cs_customer_nonce` VALUES (933, 1, '8960085dbcfa43e1', '2026-05-14 20:59:20');
INSERT INTO `cs_customer_nonce` VALUES (934, 1, 'ee170325728e405e', '2026-05-14 20:59:22');
INSERT INTO `cs_customer_nonce` VALUES (935, 1, '7544694ddcfb4a48', '2026-05-14 20:59:48');
INSERT INTO `cs_customer_nonce` VALUES (936, 1, 'c4838623748a42a2', '2026-05-14 20:59:51');
INSERT INTO `cs_customer_nonce` VALUES (937, 1, '96f876b1f8704352', '2026-05-14 20:59:54');
INSERT INTO `cs_customer_nonce` VALUES (938, 1, '73d868af6ad54009', '2026-05-14 21:01:10');
INSERT INTO `cs_customer_nonce` VALUES (939, 1, '33c2188f7d304844', '2026-05-14 21:01:11');
INSERT INTO `cs_customer_nonce` VALUES (940, 1, '0a2fbf7ffc784e42', '2026-05-14 21:01:34');
INSERT INTO `cs_customer_nonce` VALUES (941, 1, 'efc8a925d88a47b6', '2026-05-14 21:01:35');
INSERT INTO `cs_customer_nonce` VALUES (942, 1, '2723e56ef2b2490f', '2026-05-14 21:01:58');
INSERT INTO `cs_customer_nonce` VALUES (943, 1, '20d654b8b33b4596', '2026-05-14 21:02:00');
INSERT INTO `cs_customer_nonce` VALUES (944, 1, '339e8749c98945a8', '2026-05-14 21:02:14');
INSERT INTO `cs_customer_nonce` VALUES (945, 1, '33a50d4eb8204261', '2026-05-14 21:02:21');
INSERT INTO `cs_customer_nonce` VALUES (946, 1, '16086018b7df41dc', '2026-05-14 21:02:23');
INSERT INTO `cs_customer_nonce` VALUES (947, 1, 'eec1b4e3d9644508', '2026-05-14 21:02:37');
INSERT INTO `cs_customer_nonce` VALUES (948, 1, 'c661ad4b0e374daa', '2026-05-14 21:02:42');
INSERT INTO `cs_customer_nonce` VALUES (949, 1, '3cd5973d797b447f', '2026-05-14 21:02:49');
INSERT INTO `cs_customer_nonce` VALUES (950, 1, 'aa366e52427a49fc', '2026-05-14 21:11:18');
INSERT INTO `cs_customer_nonce` VALUES (951, 1, 'f8419be7cf9b4ac6', '2026-05-14 21:38:08');
INSERT INTO `cs_customer_nonce` VALUES (952, 1, '33c6abab033b4a40', '2026-05-14 21:38:45');
INSERT INTO `cs_customer_nonce` VALUES (953, 1, 'a5315731ad07401b', '2026-05-14 21:39:40');
INSERT INTO `cs_customer_nonce` VALUES (954, 1, 'b41a1f1c695d4e6b', '2026-05-14 21:40:16');
INSERT INTO `cs_customer_nonce` VALUES (955, 1, '19b586e36704440a', '2026-05-14 21:40:40');
INSERT INTO `cs_customer_nonce` VALUES (956, 1, '180d4c1bef36440c', '2026-05-14 21:43:01');
INSERT INTO `cs_customer_nonce` VALUES (957, 1, '014e4c54372a4ec0', '2026-05-14 23:13:07');
INSERT INTO `cs_customer_nonce` VALUES (958, 1, '63af81faadf54015', '2026-05-15 13:09:35');
INSERT INTO `cs_customer_nonce` VALUES (959, 1, '70e1f07f148849bf', '2026-05-15 13:09:41');
INSERT INTO `cs_customer_nonce` VALUES (960, 1, 'c3251f6eef464afe', '2026-05-15 13:09:46');
INSERT INTO `cs_customer_nonce` VALUES (961, 1, 'b2919a606cd34809', '2026-05-15 13:09:52');
INSERT INTO `cs_customer_nonce` VALUES (962, 1, 'e1640f850a894a44', '2026-05-15 13:10:36');
INSERT INTO `cs_customer_nonce` VALUES (963, 1, '27f7b1b45bee40a0', '2026-05-15 14:14:54');
INSERT INTO `cs_customer_nonce` VALUES (964, 1, '4de34833654f444d', '2026-05-15 14:29:06');
INSERT INTO `cs_customer_nonce` VALUES (965, 1, '4db486959e6e4afd', '2026-05-15 14:29:10');
INSERT INTO `cs_customer_nonce` VALUES (966, 1, '582565a732724a76', '2026-05-15 14:29:12');
INSERT INTO `cs_customer_nonce` VALUES (967, 1, '6c5be9a768144ae4', '2026-05-15 14:29:15');
INSERT INTO `cs_customer_nonce` VALUES (968, 1, 'a80c65d73b804a8b', '2026-05-15 14:29:21');
INSERT INTO `cs_customer_nonce` VALUES (969, 1, '84cb1a94ed76488b', '2026-05-15 14:30:25');
INSERT INTO `cs_customer_nonce` VALUES (970, 1, '1af516e08ac6419d', '2026-05-15 14:30:28');
INSERT INTO `cs_customer_nonce` VALUES (971, 1, 'dfc611ad39c845bb', '2026-05-15 14:30:31');
INSERT INTO `cs_customer_nonce` VALUES (972, 1, '4791ff54134d4964', '2026-05-15 14:31:10');
INSERT INTO `cs_customer_nonce` VALUES (973, 1, '0e0a907cecf04596', '2026-05-15 14:31:32');
INSERT INTO `cs_customer_nonce` VALUES (974, 1, '90a7f13eff5143f1', '2026-05-15 14:31:43');
INSERT INTO `cs_customer_nonce` VALUES (975, 1, '804a58c66a5a4ec7', '2026-05-15 14:31:47');
INSERT INTO `cs_customer_nonce` VALUES (976, 1, '8538c847abfd41ca', '2026-05-15 14:31:54');
INSERT INTO `cs_customer_nonce` VALUES (977, 1, '4cbf5d00a5a24b79', '2026-05-15 14:32:35');
INSERT INTO `cs_customer_nonce` VALUES (978, 1, '52a8245982d14d6a', '2026-05-15 14:32:58');
INSERT INTO `cs_customer_nonce` VALUES (979, 1, '1850176296d24a67', '2026-05-15 14:53:50');
INSERT INTO `cs_customer_nonce` VALUES (980, 1, 'cd5f6e22e8d24900', '2026-05-15 15:08:13');
INSERT INTO `cs_customer_nonce` VALUES (981, 1, '168c73d334f74d7f', '2026-05-15 15:08:16');
INSERT INTO `cs_customer_nonce` VALUES (982, 1, 'd5bfc55a86f24843', '2026-05-15 15:08:18');
INSERT INTO `cs_customer_nonce` VALUES (983, 1, '458cfaf8202b4352', '2026-05-15 15:15:25');
INSERT INTO `cs_customer_nonce` VALUES (984, 1, '36d75e694edc4eb4', '2026-05-15 15:15:35');
INSERT INTO `cs_customer_nonce` VALUES (985, 1, '5e75b28307d14b4b', '2026-05-15 15:18:08');
INSERT INTO `cs_customer_nonce` VALUES (986, 1, '53bfcd814c864800', '2026-05-15 15:30:53');
INSERT INTO `cs_customer_nonce` VALUES (987, 1, '1f20f7fc40254f41', '2026-05-15 15:33:25');
INSERT INTO `cs_customer_nonce` VALUES (988, 1, 'c0ac9b2db0e44ed9', '2026-05-15 15:35:12');
INSERT INTO `cs_customer_nonce` VALUES (989, 1, '1ffd2b9c2fef4252', '2026-05-15 15:35:22');
INSERT INTO `cs_customer_nonce` VALUES (990, 1, '2c0dc8d7687449af', '2026-05-15 16:31:12');
INSERT INTO `cs_customer_nonce` VALUES (991, 11, '56a53148e7e44a88', '2026-05-23 14:53:37');
INSERT INTO `cs_customer_nonce` VALUES (992, 12, '91c7324adc254a28', '2026-05-23 14:53:53');
INSERT INTO `cs_customer_nonce` VALUES (993, 1, '0777b99114484ad0', '2026-05-23 15:01:25');
INSERT INTO `cs_customer_nonce` VALUES (994, 1, 'dafa378d1b8941cc', '2026-05-23 15:04:02');
INSERT INTO `cs_customer_nonce` VALUES (995, 3, '978642368ae84c4f', '2026-05-23 15:04:38');
INSERT INTO `cs_customer_nonce` VALUES (996, 5, '6b89bb6fe0224b60', '2026-05-23 15:07:57');
INSERT INTO `cs_customer_nonce` VALUES (997, 8, 'c284012023174b74', '2026-05-23 15:19:36');
INSERT INTO `cs_customer_nonce` VALUES (998, 8, '7827ac51ba9e4214', '2026-05-23 15:19:59');
INSERT INTO `cs_customer_nonce` VALUES (999, 8, '2e4a9021cdd84dd0', '2026-05-23 15:20:01');
INSERT INTO `cs_customer_nonce` VALUES (1000, 9, 'c60c4be4b881494f', '2026-05-23 15:25:46');
INSERT INTO `cs_customer_nonce` VALUES (1001, 10, '7d914d903b484305', '2026-05-23 15:26:17');
INSERT INTO `cs_customer_nonce` VALUES (1002, 14, '1f7928ef80874ada', '2026-05-23 15:30:44');
INSERT INTO `cs_customer_nonce` VALUES (1003, 14, '488065dc18024bf0', '2026-05-23 15:34:07');
INSERT INTO `cs_customer_nonce` VALUES (1004, 14, '571d082f7d4d412d', '2026-05-23 15:34:08');
INSERT INTO `cs_customer_nonce` VALUES (1005, 15, '09415434d2bb44e6', '2026-05-23 15:34:20');
INSERT INTO `cs_customer_nonce` VALUES (1006, 11, '899eadbda0344b6e', '2026-05-23 15:38:39');
INSERT INTO `cs_customer_nonce` VALUES (1007, 13, '644e733ad25a4261', '2026-05-23 15:44:56');
INSERT INTO `cs_customer_nonce` VALUES (1008, 14, 'cd13df4943d54d27', '2026-05-23 15:45:20');
INSERT INTO `cs_customer_nonce` VALUES (1009, 1, 'ab20291bb01d4599', '2026-05-23 15:45:37');
INSERT INTO `cs_customer_nonce` VALUES (1010, 1, 'd661af2b760a4924', '2026-05-23 15:47:54');
INSERT INTO `cs_customer_nonce` VALUES (1011, 1, '2e2520c65be54322', '2026-05-23 15:47:59');
INSERT INTO `cs_customer_nonce` VALUES (1012, 1, '319a39b05f624c64', '2026-05-23 15:48:04');
INSERT INTO `cs_customer_nonce` VALUES (1013, 1, 'e6549bea11e54723', '2026-05-23 15:49:45');
INSERT INTO `cs_customer_nonce` VALUES (1014, 1, '4d8ab97d7337462d', '2026-05-23 16:02:48');
INSERT INTO `cs_customer_nonce` VALUES (1015, 1, 'ec3a7fc7fb03453b', '2026-05-23 16:03:25');
INSERT INTO `cs_customer_nonce` VALUES (1016, 1, 'd8d8ce83009b4441', '2026-05-23 16:04:34');
INSERT INTO `cs_customer_nonce` VALUES (1017, 1, '8889a076844d4cd1', '2026-05-23 16:04:44');
INSERT INTO `cs_customer_nonce` VALUES (1018, 1, '552ce008171e45af', '2026-05-23 16:04:58');
INSERT INTO `cs_customer_nonce` VALUES (1019, 1, '874e762158d247e3', '2026-05-23 16:05:03');
INSERT INTO `cs_customer_nonce` VALUES (1020, 1, 'da8b085e7a964dea', '2026-05-23 16:07:21');
INSERT INTO `cs_customer_nonce` VALUES (1021, 1, 'e40d01097edc4467', '2026-05-23 16:07:38');
INSERT INTO `cs_customer_nonce` VALUES (1022, 1, 'ede3097e83a94674', '2026-05-23 16:08:28');
INSERT INTO `cs_customer_nonce` VALUES (1023, 1, 'c18ea0db17e94cc2', '2026-05-23 16:08:57');
INSERT INTO `cs_customer_nonce` VALUES (1024, 1, '46d70d0eacd840f7', '2026-05-23 16:09:00');
INSERT INTO `cs_customer_nonce` VALUES (1025, 1, '1d305b4732854751', '2026-05-23 16:09:30');
INSERT INTO `cs_customer_nonce` VALUES (1026, 1, '36b013e2932c4d15', '2026-05-23 16:10:40');
INSERT INTO `cs_customer_nonce` VALUES (1027, 1, '3322677fd35a411f', '2026-05-23 16:12:22');
INSERT INTO `cs_customer_nonce` VALUES (1028, 1, '1f2eb803f1a94bf7', '2026-05-23 16:12:44');
INSERT INTO `cs_customer_nonce` VALUES (1029, 1, '03a444bbc449418f', '2026-05-23 16:12:48');
INSERT INTO `cs_customer_nonce` VALUES (1030, 1, '9ba7bdcb50e4493f', '2026-05-23 16:13:04');
INSERT INTO `cs_customer_nonce` VALUES (1031, 1, 'e82dff55ee0f4909', '2026-05-23 16:13:28');
INSERT INTO `cs_customer_nonce` VALUES (1032, 1, '7d49cbcbd5f54377', '2026-05-23 16:13:30');
INSERT INTO `cs_customer_nonce` VALUES (1033, 1, 'a59eda345d784444', '2026-05-23 16:14:17');
INSERT INTO `cs_customer_nonce` VALUES (1034, 20, '5d73468888e44a1f', '2026-05-23 16:22:23');
INSERT INTO `cs_customer_nonce` VALUES (1035, 20, 'd69875752cfb4b6e', '2026-05-23 16:22:26');
INSERT INTO `cs_customer_nonce` VALUES (1036, 20, 'a6cf6fca3f42493f', '2026-05-23 16:22:38');
INSERT INTO `cs_customer_nonce` VALUES (1037, 20, '3774819d94434fe6', '2026-05-23 16:22:44');
INSERT INTO `cs_customer_nonce` VALUES (1038, 19, 'f4fe96bc581a4fd0', '2026-05-23 16:32:10');
INSERT INTO `cs_customer_nonce` VALUES (1039, 19, '9888bc34f4e14264', '2026-05-23 16:41:44');
INSERT INTO `cs_customer_nonce` VALUES (1040, 19, 'a6e5ecc505a0466d', '2026-05-24 15:16:49');
INSERT INTO `cs_customer_nonce` VALUES (1041, 19, 'c8050918c46c4556', '2026-05-24 15:17:50');
INSERT INTO `cs_customer_nonce` VALUES (1042, 19, '4b09cd453caf42e4', '2026-05-24 15:20:01');
INSERT INTO `cs_customer_nonce` VALUES (1043, 19, 'f08ebdd485654820', '2026-05-24 15:21:12');
INSERT INTO `cs_customer_nonce` VALUES (1044, 19, '72bf286096864472', '2026-05-24 15:23:20');
INSERT INTO `cs_customer_nonce` VALUES (1045, 19, '8768b2f3a57d435f', '2026-05-24 15:23:33');
INSERT INTO `cs_customer_nonce` VALUES (1046, 19, '4474c26ee9844c2f', '2026-05-24 15:23:38');
INSERT INTO `cs_customer_nonce` VALUES (1047, 19, '413bd6e1adf64bce', '2026-05-24 15:23:42');
INSERT INTO `cs_customer_nonce` VALUES (1048, 3, '459d2344ccd944b8', '2026-05-24 15:31:21');
INSERT INTO `cs_customer_nonce` VALUES (1049, 1, '723f553d750f4b00', '2026-05-24 15:31:40');
INSERT INTO `cs_customer_nonce` VALUES (1050, 1, '34a049a0c0664700', '2026-05-24 15:42:28');
INSERT INTO `cs_customer_nonce` VALUES (1051, 1, 'ba741ff321104997', '2026-05-24 15:46:37');
INSERT INTO `cs_customer_nonce` VALUES (1052, 31, 'bf661bf218d44231', '2026-05-24 15:57:33');
INSERT INTO `cs_customer_nonce` VALUES (1053, 31, 'defdf287b5a84d10', '2026-05-24 15:58:00');
INSERT INTO `cs_customer_nonce` VALUES (1054, 32, '68cfa473b1c24a82', '2026-05-24 15:58:25');
INSERT INTO `cs_customer_nonce` VALUES (1055, 33, '1c84ab5948794bcd', '2026-05-24 16:00:13');
INSERT INTO `cs_customer_nonce` VALUES (1058, 1, 'd7e6eec79edb4517', '2026-05-25 17:03:00');
INSERT INTO `cs_customer_nonce` VALUES (1059, 1, 'fdc66a809257407d', '2026-05-25 17:03:03');
INSERT INTO `cs_customer_nonce` VALUES (1060, 1, 'e1081733664a4b3a', '2026-05-25 17:03:21');
INSERT INTO `cs_customer_nonce` VALUES (1061, 1, '4fa7de9d9e204d72', '2026-05-25 17:04:35');
INSERT INTO `cs_customer_nonce` VALUES (1062, 1, 'f52e181b44984919', '2026-05-25 18:10:28');
INSERT INTO `cs_customer_nonce` VALUES (1063, 1, '252e861c3a174e24', '2026-05-26 21:00:43');
INSERT INTO `cs_customer_nonce` VALUES (1064, 1, '3c8b0c5bd1b74d00', '2026-05-26 21:25:58');
INSERT INTO `cs_customer_nonce` VALUES (1065, 1, 'fb879a60433a4ba2', '2026-05-26 21:27:48');
INSERT INTO `cs_customer_nonce` VALUES (1066, 1, 'f3e2095bfacb4496', '2026-05-26 21:28:03');
INSERT INTO `cs_customer_nonce` VALUES (1067, 1, 'c553a77c5d9b4576', '2026-05-26 21:28:05');
INSERT INTO `cs_customer_nonce` VALUES (1068, 1, '1fbd83bc23d34d82', '2026-05-26 21:28:23');
INSERT INTO `cs_customer_nonce` VALUES (1069, 1, '644450e2ece345b3', '2026-05-26 21:28:30');
INSERT INTO `cs_customer_nonce` VALUES (1070, 1, '9220a66a8e034de9', '2026-05-26 21:38:43');
INSERT INTO `cs_customer_nonce` VALUES (1071, 1, '9402a0d4de1c4c50', '2026-05-26 21:43:31');
INSERT INTO `cs_customer_nonce` VALUES (1072, 1, '814ba4545c124202', '2026-05-26 21:48:52');
INSERT INTO `cs_customer_nonce` VALUES (1073, 1, '94c03b7d96cc40a1', '2026-05-29 10:26:31');
INSERT INTO `cs_customer_nonce` VALUES (1074, 1, 'cc7679acfa404945', '2026-05-29 10:29:22');
INSERT INTO `cs_customer_nonce` VALUES (1075, 1, '78dbd04788274cca', '2026-05-29 10:31:20');
INSERT INTO `cs_customer_nonce` VALUES (1076, 1, 'b91383d4137942ec', '2026-05-29 11:07:50');
INSERT INTO `cs_customer_nonce` VALUES (1077, 1, 'ad81a8adfe974d80', '2026-05-29 11:34:29');
INSERT INTO `cs_customer_nonce` VALUES (1078, 1, 'fd9e64f5f0ce44e2', '2026-05-29 17:03:22');
INSERT INTO `cs_customer_nonce` VALUES (1079, 1, '5fe3d4c6720f47e9', '2026-05-29 17:03:23');
INSERT INTO `cs_customer_nonce` VALUES (1080, 1, '5f903d6ed3544696', '2026-05-29 17:26:24');
INSERT INTO `cs_customer_nonce` VALUES (1081, 1, 'f37b2f84896c43ee', '2026-05-29 17:26:28');
INSERT INTO `cs_customer_nonce` VALUES (1082, 1, '8f0f64a92e9a4a1f', '2026-05-29 17:34:17');
INSERT INTO `cs_customer_nonce` VALUES (1083, 1, '2dc73b99aec34fd1', '2026-05-29 20:14:57');
INSERT INTO `cs_customer_nonce` VALUES (1084, 1, '9c13b855bcf64cf2', '2026-05-29 20:15:09');
INSERT INTO `cs_customer_nonce` VALUES (1085, 1, '0c996345651947b0', '2026-05-29 20:32:32');
INSERT INTO `cs_customer_nonce` VALUES (1086, 1, '515f5582e4a0430f', '2026-05-29 20:32:55');
INSERT INTO `cs_customer_nonce` VALUES (1087, 1, '0d11914d17fa4b31', '2026-05-29 20:34:16');
INSERT INTO `cs_customer_nonce` VALUES (1088, 1, '76d6106037df4684', '2026-05-29 20:40:15');
INSERT INTO `cs_customer_nonce` VALUES (1089, 1, 'a3eb364565b844b3', '2026-05-29 20:40:47');
INSERT INTO `cs_customer_nonce` VALUES (1090, 1, '5601db1ed85b4c73', '2026-05-29 20:42:02');
INSERT INTO `cs_customer_nonce` VALUES (1091, 1, 'cf6866ccfcc24793', '2026-05-29 20:47:17');
INSERT INTO `cs_customer_nonce` VALUES (1092, 1, 'f75ef81073db44f7', '2026-05-29 20:49:46');
INSERT INTO `cs_customer_nonce` VALUES (1093, 1, 'd7c1222512664e79', '2026-05-29 20:51:20');
INSERT INTO `cs_customer_nonce` VALUES (1094, 1, '7ea50812908d4aef', '2026-05-29 20:53:43');
INSERT INTO `cs_customer_nonce` VALUES (1095, 1, '0be69d0bd98a4286', '2026-05-29 20:57:14');
INSERT INTO `cs_customer_nonce` VALUES (1096, 1, '30f0c9d759184e94', '2026-05-29 20:57:16');
INSERT INTO `cs_customer_nonce` VALUES (1097, 1, '74a60870b072470c', '2026-05-29 20:58:39');
INSERT INTO `cs_customer_nonce` VALUES (1098, 1, 'c665170f5bc9409f', '2026-05-29 20:58:47');
INSERT INTO `cs_customer_nonce` VALUES (1099, 1, '2fb04981ef9c4162', '2026-05-29 20:58:51');
INSERT INTO `cs_customer_nonce` VALUES (1100, 1, '1e9b691e7e294cee', '2026-05-29 20:59:56');
INSERT INTO `cs_customer_nonce` VALUES (1101, 1, '84838f5d84194e21', '2026-05-29 21:00:28');
INSERT INTO `cs_customer_nonce` VALUES (1102, 1, '037df6a746454ced', '2026-05-29 21:00:38');
INSERT INTO `cs_customer_nonce` VALUES (1103, 1, '79ceecf75d584159', '2026-05-29 21:00:58');
INSERT INTO `cs_customer_nonce` VALUES (1104, 1, '586cab387c214bf0', '2026-05-29 21:51:17');
INSERT INTO `cs_customer_nonce` VALUES (1105, 1, '8eaf52dcaffc4713', '2026-06-03 16:04:15');
INSERT INTO `cs_customer_nonce` VALUES (1106, 1, 'e83cdce9861142d2', '2026-06-03 16:04:37');
INSERT INTO `cs_customer_nonce` VALUES (1107, 1, 'c5e31cf3894f414b', '2026-06-03 16:04:39');
INSERT INTO `cs_customer_nonce` VALUES (1108, 1, 'fb12e46f65514562', '2026-06-03 19:05:57');
INSERT INTO `cs_customer_nonce` VALUES (1109, 1, 'ac3ddfa58b4a4704', '2026-06-03 19:09:51');
INSERT INTO `cs_customer_nonce` VALUES (1110, 1, 'cd7aefe607c54fb5', '2026-06-03 19:10:00');
INSERT INTO `cs_customer_nonce` VALUES (1111, 1, '8af37bd894bb4563', '2026-06-03 19:10:58');
INSERT INTO `cs_customer_nonce` VALUES (1112, 1, 'd54b0b5391dd4673', '2026-06-03 19:13:27');
INSERT INTO `cs_customer_nonce` VALUES (1113, 1, '2a6731e422404fec', '2026-06-03 19:13:45');
INSERT INTO `cs_customer_nonce` VALUES (1114, 1, 'be915bd372df4a3c', '2026-06-03 19:13:51');
INSERT INTO `cs_customer_nonce` VALUES (1115, 1, '520d09ffc9774005', '2026-06-03 19:15:27');
INSERT INTO `cs_customer_nonce` VALUES (1116, 1, '889d94afee094103', '2026-06-03 19:15:33');
INSERT INTO `cs_customer_nonce` VALUES (1117, 1, '15410dd04c6c4bb5', '2026-06-04 03:28:10');
INSERT INTO `cs_customer_nonce` VALUES (1118, 1, 'fc731c9b1fbb4c26', '2026-06-04 09:12:36');
INSERT INTO `cs_customer_nonce` VALUES (1119, 1, 'e06c972a92bc4dad', '2026-06-04 09:35:36');
INSERT INTO `cs_customer_nonce` VALUES (1120, 1, 'b351f6dfe7ec4bdc', '2026-06-04 09:37:12');
INSERT INTO `cs_customer_nonce` VALUES (1121, 1, 'd24885d7be2a4f4e', '2026-06-04 09:37:32');
INSERT INTO `cs_customer_nonce` VALUES (1122, 1, '5e1d052527f049c7', '2026-06-04 10:15:16');
INSERT INTO `cs_customer_nonce` VALUES (1123, 1, '3e959bd0625f4fd8', '2026-06-04 10:54:57');
INSERT INTO `cs_customer_nonce` VALUES (1124, 1, 'dc878f12c12a4159', '2026-06-04 10:59:55');
INSERT INTO `cs_customer_nonce` VALUES (1125, 1, '642dff98ed6d4a07', '2026-06-04 11:00:31');
INSERT INTO `cs_customer_nonce` VALUES (1126, 1, '53730551d2a8411c', '2026-06-04 11:10:59');
INSERT INTO `cs_customer_nonce` VALUES (1127, 1, 'dbe06cd5e4524b7d', '2026-06-04 11:11:28');
INSERT INTO `cs_customer_nonce` VALUES (1128, 1, '12e2fefac5c744b1', '2026-06-04 12:38:43');
INSERT INTO `cs_customer_nonce` VALUES (1129, 1, '39ba3610d9934c34', '2026-06-04 13:13:41');
INSERT INTO `cs_customer_nonce` VALUES (1130, 1, '69ceecf517454620', '2026-06-04 13:20:23');
INSERT INTO `cs_customer_nonce` VALUES (1131, 1, '7d2c8a466dc74583', '2026-06-04 13:34:53');
INSERT INTO `cs_customer_nonce` VALUES (1132, 1, '6e23ed9005f945ea', '2026-06-04 20:46:37');
INSERT INTO `cs_customer_nonce` VALUES (1133, 11, '6b652a01b5474457', '2026-06-04 20:55:27');
INSERT INTO `cs_customer_nonce` VALUES (1134, 12, '96b95d06634544c9', '2026-06-04 21:03:02');
INSERT INTO `cs_customer_nonce` VALUES (1135, 1, '29d7af5a07f943e8', '2026-06-07 10:04:48');
INSERT INTO `cs_customer_nonce` VALUES (1136, 1, 'bb2f2ede90d940a9', '2026-06-07 10:04:51');
INSERT INTO `cs_customer_nonce` VALUES (1137, 1, '6c3b1afddd4e48a5', '2026-06-07 10:08:15');
INSERT INTO `cs_customer_nonce` VALUES (1138, 1, 'e58ed0105f964ee2', '2026-06-07 10:10:15');
INSERT INTO `cs_customer_nonce` VALUES (1139, 1, '52c55f8c69c3443d', '2026-06-07 10:10:45');
INSERT INTO `cs_customer_nonce` VALUES (1140, 1, '77514eba551840a3', '2026-06-07 10:12:17');
INSERT INTO `cs_customer_nonce` VALUES (1141, 1, '2e975cc600af4da5', '2026-06-07 10:12:30');
INSERT INTO `cs_customer_nonce` VALUES (1142, 1, 'c7467f76e21448fa', '2026-06-07 10:12:34');
INSERT INTO `cs_customer_nonce` VALUES (1143, 1, 'a543c48f96b94982', '2026-06-07 13:54:19');
INSERT INTO `cs_customer_nonce` VALUES (1144, 1, 'fde80526a85b4caf', '2026-06-07 15:19:02');
INSERT INTO `cs_customer_nonce` VALUES (1145, 1, '33b8ffe0aede4f74', '2026-06-10 02:07:11');
INSERT INTO `cs_customer_nonce` VALUES (1146, 1, '92cdab33369e4c1f', '2026-06-10 02:07:15');
INSERT INTO `cs_customer_nonce` VALUES (1147, 1, 'af2abbc83aca4f4e', '2026-06-10 02:08:44');
INSERT INTO `cs_customer_nonce` VALUES (1148, 1, '17cfe3a516654064', '2026-06-10 02:20:32');
INSERT INTO `cs_customer_nonce` VALUES (1149, 1, '6f2f68c6b0744a23', '2026-06-10 02:21:15');
INSERT INTO `cs_customer_nonce` VALUES (1150, 1, 'f3ed7447e7db404c', '2026-06-12 15:04:32');
INSERT INTO `cs_customer_nonce` VALUES (1151, 1, '29c3a99b7d364498', '2026-06-12 15:04:41');
INSERT INTO `cs_customer_nonce` VALUES (1152, 1, 'd7e9c25446e14033', '2026-06-12 15:04:55');
INSERT INTO `cs_customer_nonce` VALUES (1153, 1, 'b276982907144f13', '2026-06-12 15:04:57');
INSERT INTO `cs_customer_nonce` VALUES (1154, 1, '6d9bd3e487b941c3', '2026-06-12 15:14:02');
INSERT INTO `cs_customer_nonce` VALUES (1155, 1, '75d43979a01341fd', '2026-06-12 15:14:04');
INSERT INTO `cs_customer_nonce` VALUES (1156, 1, 'aa41a03b45be471f', '2026-06-12 15:16:16');
INSERT INTO `cs_customer_nonce` VALUES (1157, 1, 'dc89b33edaa6406f', '2026-06-12 15:16:42');
INSERT INTO `cs_customer_nonce` VALUES (1158, 2, '76136e293a7e4b2c', '2026-06-12 15:16:51');
INSERT INTO `cs_customer_nonce` VALUES (1159, 2, '2486b58bb95c44c3', '2026-06-12 15:17:41');
INSERT INTO `cs_customer_nonce` VALUES (1160, 1, 'd2ce11400a9547f3', '2026-06-12 15:18:13');
INSERT INTO `cs_customer_nonce` VALUES (1161, 1, '26a70855bfea4286', '2026-06-12 15:19:14');
INSERT INTO `cs_customer_nonce` VALUES (1162, 1, 'd7826fd18fea4357', '2026-06-12 15:19:16');
INSERT INTO `cs_customer_nonce` VALUES (1163, 2, '2981d9b7853f4bdd', '2026-06-12 15:19:33');
INSERT INTO `cs_customer_nonce` VALUES (1164, 1, '303ac8d08d3942fe', '2026-06-12 15:20:12');
INSERT INTO `cs_customer_nonce` VALUES (1165, 1, 'bd191a6d3a614672', '2026-06-12 15:21:57');
INSERT INTO `cs_customer_nonce` VALUES (1166, 1, 'db11502450cd4f92', '2026-06-12 15:22:23');
INSERT INTO `cs_customer_nonce` VALUES (1167, 1, '59824e7e6e3e4403', '2026-06-12 15:41:06');
INSERT INTO `cs_customer_nonce` VALUES (1168, 1, 'bdb7d2c483e445c1', '2026-06-12 15:42:47');
INSERT INTO `cs_customer_nonce` VALUES (1169, 1, '4429a802f5884dbc', '2026-06-12 15:43:06');
INSERT INTO `cs_customer_nonce` VALUES (1170, 1, '99ea7176e1cb4528', '2026-06-12 15:43:18');
INSERT INTO `cs_customer_nonce` VALUES (1171, 1, '8a4d66f9a7a34fd9', '2026-06-12 15:43:30');
INSERT INTO `cs_customer_nonce` VALUES (1172, 2, '586bdec5b5434da3', '2026-06-12 15:43:50');
INSERT INTO `cs_customer_nonce` VALUES (1173, 1, 'd925cc038d06441a', '2026-06-12 15:44:33');
INSERT INTO `cs_customer_nonce` VALUES (1174, 1, '054d1fea7cbc4c01', '2026-06-12 15:44:51');
INSERT INTO `cs_customer_nonce` VALUES (1175, 1, '44d74f2a71fe4b4d', '2026-06-12 15:47:09');
INSERT INTO `cs_customer_nonce` VALUES (1176, 1, 'a0b4430e4a8b4ddd', '2026-06-12 15:47:24');
INSERT INTO `cs_customer_nonce` VALUES (1177, 1, '51b82a61c067490e', '2026-06-12 15:52:29');
INSERT INTO `cs_customer_nonce` VALUES (1178, 1, 'a320e4ba27874ca4', '2026-06-12 15:52:44');
INSERT INTO `cs_customer_nonce` VALUES (1179, 1, 'dce4e75b8c674922', '2026-06-12 15:53:01');
INSERT INTO `cs_customer_nonce` VALUES (1180, 1, '3a74e93ed91541d3', '2026-06-12 15:55:56');
INSERT INTO `cs_customer_nonce` VALUES (1181, 1, '7b746be0e8f34590', '2026-06-12 15:56:50');
INSERT INTO `cs_customer_nonce` VALUES (1182, 1, '062ff8fbcd8f4b70', '2026-06-12 15:56:57');
INSERT INTO `cs_customer_nonce` VALUES (1183, 1, '50e0a24a1d9d437d', '2026-06-12 15:57:30');
INSERT INTO `cs_customer_nonce` VALUES (1184, 1, 'df84306240174af9', '2026-06-12 15:57:39');
INSERT INTO `cs_customer_nonce` VALUES (1185, 1, '9a11ce322ba84e7e', '2026-06-12 15:59:01');
INSERT INTO `cs_customer_nonce` VALUES (1186, 1, '80adca14580b491d', '2026-06-12 16:01:37');
INSERT INTO `cs_customer_nonce` VALUES (1187, 1, '8ce6fb4f3a384844', '2026-06-12 16:13:44');
INSERT INTO `cs_customer_nonce` VALUES (1188, 1, '43380f6eca224cb8', '2026-06-12 16:14:38');
INSERT INTO `cs_customer_nonce` VALUES (1189, 1, 'a395357b49c84594', '2026-06-12 16:15:22');
INSERT INTO `cs_customer_nonce` VALUES (1190, 2, 'beab2be7632f477f', '2026-06-12 16:15:59');
INSERT INTO `cs_customer_nonce` VALUES (1191, 2, '68ff1a3e0707464c', '2026-06-12 16:16:21');
INSERT INTO `cs_customer_nonce` VALUES (1192, 2, 'faf77bb476e54def', '2026-06-12 16:17:21');
INSERT INTO `cs_customer_nonce` VALUES (1193, 2, '99efd2abc367498c', '2026-06-12 16:17:29');
INSERT INTO `cs_customer_nonce` VALUES (1194, 2, '8b0569adf20f4033', '2026-06-12 16:18:38');
INSERT INTO `cs_customer_nonce` VALUES (1195, 2, 'a8e8417564e74194', '2026-06-12 16:18:41');
INSERT INTO `cs_customer_nonce` VALUES (1196, 2, '6a4144d31a2140ba', '2026-06-12 16:18:43');
INSERT INTO `cs_customer_nonce` VALUES (1197, 2, '1e62cc01e2c54ca9', '2026-06-12 16:19:14');
INSERT INTO `cs_customer_nonce` VALUES (1198, 2, 'a42fc637adc84ce8', '2026-06-12 16:19:25');
INSERT INTO `cs_customer_nonce` VALUES (1199, 1, '99515ce5b6b8419b', '2026-06-12 17:53:01');
INSERT INTO `cs_customer_nonce` VALUES (1200, 1, '7c1d9950b91c46fc', '2026-06-12 17:53:04');
INSERT INTO `cs_customer_nonce` VALUES (1201, 1, '1242050ea0964293', '2026-06-12 18:31:34');
INSERT INTO `cs_customer_nonce` VALUES (1202, 1, 'e74e3c03d415496d', '2026-06-12 18:34:24');
INSERT INTO `cs_customer_nonce` VALUES (1203, 1, 'a161be30c1b343d2', '2026-06-12 18:53:06');
INSERT INTO `cs_customer_nonce` VALUES (1204, 62, '375e88c7b2b54f6a', '2026-06-13 15:04:36');
INSERT INTO `cs_customer_nonce` VALUES (1205, 63, '937c79278b294ac4', '2026-06-13 15:05:03');
INSERT INTO `cs_customer_nonce` VALUES (1206, 71, 'e0b0ebb5db544760', '2026-06-13 15:06:25');
INSERT INTO `cs_customer_nonce` VALUES (1207, 62, 'd6c00bb474454511', '2026-06-13 15:16:26');
INSERT INTO `cs_customer_nonce` VALUES (1208, 71, '5bc0c74939b74654', '2026-06-13 15:16:35');
INSERT INTO `cs_customer_nonce` VALUES (1209, 62, 'c921d88337f14767', '2026-06-13 15:21:30');
INSERT INTO `cs_customer_nonce` VALUES (1210, 62, 'b27cf6fc380e406a', '2026-06-13 15:21:48');
INSERT INTO `cs_customer_nonce` VALUES (1211, 71, '2b7ec1f6a5da45a6', '2026-06-13 15:26:11');
INSERT INTO `cs_customer_nonce` VALUES (1212, 73, 'f4260598064e4baf', '2026-06-13 15:35:43');
INSERT INTO `cs_customer_nonce` VALUES (1213, 74, '69c4b567b6bb4555', '2026-06-13 15:35:49');
INSERT INTO `cs_customer_nonce` VALUES (1214, 73, '730e24450bf14ac2', '2026-06-13 15:36:59');
INSERT INTO `cs_customer_nonce` VALUES (1215, 61, '81501c9e0f55495d', '2026-06-14 14:09:06');
INSERT INTO `cs_customer_nonce` VALUES (1216, 61, '24f99c91a1a14291', '2026-06-14 14:09:11');
INSERT INTO `cs_customer_nonce` VALUES (1217, 61, '585bab803a7c424d', '2026-06-14 14:31:07');
INSERT INTO `cs_customer_nonce` VALUES (1218, 61, '718c6d5449314f0f', '2026-06-14 14:31:11');
INSERT INTO `cs_customer_nonce` VALUES (1219, 61, 'e62206e8b420404c', '2026-06-14 14:31:13');
INSERT INTO `cs_customer_nonce` VALUES (1220, 61, '0ff52c8a1c2b406f', '2026-06-14 14:31:17');
INSERT INTO `cs_customer_nonce` VALUES (1221, 61, 'b8f554b6246c456e', '2026-06-14 14:31:28');
INSERT INTO `cs_customer_nonce` VALUES (1222, 61, '2be8b18d8dd949ee', '2026-06-14 14:37:23');
INSERT INTO `cs_customer_nonce` VALUES (1223, 61, 'dc04dd10b05341bc', '2026-06-14 14:37:26');
INSERT INTO `cs_customer_nonce` VALUES (1224, 61, 'c2a95c70073e4cf8', '2026-06-14 15:09:57');
INSERT INTO `cs_customer_nonce` VALUES (1225, 71, '08145be5f74a4a39', '2026-06-16 18:02:35');
INSERT INTO `cs_customer_nonce` VALUES (1226, 61, '64900863adfc4d3b', '2026-06-18 16:33:48');
INSERT INTO `cs_customer_nonce` VALUES (1227, 61, '1c9f2bb28b0b4b0d', '2026-06-18 16:33:58');
INSERT INTO `cs_customer_nonce` VALUES (1229, 61, 'a395214a72a34441', '2026-06-18 16:41:01');
INSERT INTO `cs_customer_nonce` VALUES (1230, 61, '8734f1ccc3094ee9', '2026-06-18 16:44:25');
INSERT INTO `cs_customer_nonce` VALUES (1231, 61, '45b5cc56418847aa', '2026-06-18 16:45:17');
INSERT INTO `cs_customer_nonce` VALUES (1232, 61, 'd867649e1d604428', '2026-06-18 16:47:50');
INSERT INTO `cs_customer_nonce` VALUES (1233, 61, '530557c2bdb3405b', '2026-06-18 16:59:40');
INSERT INTO `cs_customer_nonce` VALUES (1234, 61, '760e3478de1d4458', '2026-06-20 10:20:58');
INSERT INTO `cs_customer_nonce` VALUES (1235, 61, '3aa42a7940fa4c1e', '2026-06-20 10:22:19');
INSERT INTO `cs_customer_nonce` VALUES (1236, 61, '0af22cf9308d4bd7', '2026-06-20 10:24:55');
INSERT INTO `cs_customer_nonce` VALUES (1237, 61, '194a685d74224328', '2026-06-20 16:21:24');
INSERT INTO `cs_customer_nonce` VALUES (1238, 61, 'c3f5ca5b83584bd5', '2026-06-20 16:21:37');
INSERT INTO `cs_customer_nonce` VALUES (1239, 61, '11370fedb9854a31', '2026-06-20 16:35:13');
INSERT INTO `cs_customer_nonce` VALUES (1240, 61, 'c784d73d10be4360', '2026-06-20 16:47:26');
INSERT INTO `cs_customer_nonce` VALUES (1241, 61, 'e71062a0d5e14d34', '2026-06-20 16:51:30');
INSERT INTO `cs_customer_nonce` VALUES (1242, 61, 'ef9e7ee720c748f1', '2026-06-20 16:51:35');
INSERT INTO `cs_customer_nonce` VALUES (1243, 61, '97057e0c18b6400e', '2026-06-20 16:53:58');
INSERT INTO `cs_customer_nonce` VALUES (1244, 61, '5c357e327d1f4804', '2026-06-20 16:54:40');
INSERT INTO `cs_customer_nonce` VALUES (1245, 61, '0201863f59e54cc0', '2026-06-20 16:55:18');
INSERT INTO `cs_customer_nonce` VALUES (1246, 61, 'f71454a0b33f4890', '2026-06-20 16:56:11');
INSERT INTO `cs_customer_nonce` VALUES (1247, 61, 'c714604eec3f4838', '2026-06-20 16:56:15');
INSERT INTO `cs_customer_nonce` VALUES (1248, 61, '9507615be2d046d1', '2026-06-20 16:58:19');
INSERT INTO `cs_customer_nonce` VALUES (1249, 61, 'ef57c32c5a7946e4', '2026-06-20 16:58:22');
INSERT INTO `cs_customer_nonce` VALUES (1250, 61, '6802eeb2add64204', '2026-06-20 17:01:57');
INSERT INTO `cs_customer_nonce` VALUES (1251, 61, '86091aaf5c8f4281', '2026-06-20 17:02:45');
INSERT INTO `cs_customer_nonce` VALUES (1252, 61, '904668563f1849d5', '2026-06-20 17:03:03');
INSERT INTO `cs_customer_nonce` VALUES (1253, 61, 'c21bc6421a5a41b6', '2026-06-20 17:03:39');
INSERT INTO `cs_customer_nonce` VALUES (1254, 61, 'f473f4f064c845aa', '2026-06-20 17:03:40');
INSERT INTO `cs_customer_nonce` VALUES (1255, 61, 'aea95e0094364ada', '2026-06-20 17:04:05');
INSERT INTO `cs_customer_nonce` VALUES (1256, 61, '383c844322b54f81', '2026-06-20 17:04:22');
INSERT INTO `cs_customer_nonce` VALUES (1257, 61, 'e477c89d10b34937', '2026-06-20 17:04:29');
INSERT INTO `cs_customer_nonce` VALUES (1258, 61, 'a9d6c9ec64914b35', '2026-06-20 17:04:32');
INSERT INTO `cs_customer_nonce` VALUES (1259, 61, 'fb078440392f4071', '2026-06-20 17:04:53');
INSERT INTO `cs_customer_nonce` VALUES (1260, 61, '58d59c0891ac4193', '2026-06-20 17:04:55');
INSERT INTO `cs_customer_nonce` VALUES (1261, 61, '472f13674d3c4217', '2026-06-20 17:04:58');
INSERT INTO `cs_customer_nonce` VALUES (1262, 61, '45f1d1c4f771478d', '2026-06-20 17:05:39');
INSERT INTO `cs_customer_nonce` VALUES (1263, 61, 'ed8f440426134e83', '2026-06-20 17:05:41');
INSERT INTO `cs_customer_nonce` VALUES (1264, 61, '21ce62968ea049c8', '2026-06-20 17:08:34');
INSERT INTO `cs_customer_nonce` VALUES (1265, 61, '128ba2148b604441', '2026-06-20 17:10:27');
INSERT INTO `cs_customer_nonce` VALUES (1266, 61, '1eb423557cbd415c', '2026-06-20 17:10:56');
INSERT INTO `cs_customer_nonce` VALUES (1267, 61, '28da2d103a88412c', '2026-06-20 17:11:12');
INSERT INTO `cs_customer_nonce` VALUES (1268, 61, 'f590ee0714c04e6e', '2026-06-20 17:11:46');
INSERT INTO `cs_customer_nonce` VALUES (1269, 61, '4f9c4d62e59d4dae', '2026-06-20 17:11:49');
INSERT INTO `cs_customer_nonce` VALUES (1270, 61, 'cc9508051f644d80', '2026-06-20 17:12:11');
INSERT INTO `cs_customer_nonce` VALUES (1271, 61, '38d7774f16cd4630', '2026-06-20 17:12:51');
INSERT INTO `cs_customer_nonce` VALUES (1272, 61, '7d054c8df9ab4d23', '2026-06-20 17:12:52');
INSERT INTO `cs_customer_nonce` VALUES (1273, 61, '71745bfb9857462e', '2026-06-20 17:15:34');
INSERT INTO `cs_customer_nonce` VALUES (1274, 61, '01fa489a211b468c', '2026-06-20 17:17:42');
INSERT INTO `cs_customer_nonce` VALUES (1275, 61, '7d42d0a909a248cd', '2026-06-20 17:18:35');
INSERT INTO `cs_customer_nonce` VALUES (1276, 61, '65048e67feb04090', '2026-06-20 17:18:40');
INSERT INTO `cs_customer_nonce` VALUES (1277, 61, '2a01a0511f8f491b', '2026-06-20 17:19:54');
INSERT INTO `cs_customer_nonce` VALUES (1278, 61, '3c8e0c2b76d74b33', '2026-06-20 17:20:53');
INSERT INTO `cs_customer_nonce` VALUES (1279, 61, 'be03ce683841434f', '2026-06-20 17:20:57');
INSERT INTO `cs_customer_nonce` VALUES (1280, 61, '495047ee4da940eb', '2026-06-20 17:21:00');
INSERT INTO `cs_customer_nonce` VALUES (1281, 61, 'd1322c32e3e5421b', '2026-06-20 17:21:14');
INSERT INTO `cs_customer_nonce` VALUES (1282, 61, '576c1e0bd10d4b97', '2026-06-20 17:21:17');
INSERT INTO `cs_customer_nonce` VALUES (1283, 61, '299c95361f7f4ecb', '2026-06-20 17:21:36');
INSERT INTO `cs_customer_nonce` VALUES (1284, 61, '8647dd861327478f', '2026-06-20 17:21:50');
INSERT INTO `cs_customer_nonce` VALUES (1285, 61, 'd3dd48c50e334f8b', '2026-06-20 17:22:06');
INSERT INTO `cs_customer_nonce` VALUES (1286, 61, '7e084f52457b4a5c', '2026-06-20 17:24:08');
INSERT INTO `cs_customer_nonce` VALUES (1287, 61, '978b9713a42d4e5b', '2026-06-20 17:24:18');
INSERT INTO `cs_customer_nonce` VALUES (1288, 61, '1b92ec4e396a4390', '2026-06-20 17:25:21');
INSERT INTO `cs_customer_nonce` VALUES (1289, 61, '1ff5f0c8fcdd4824', '2026-06-20 17:25:23');
INSERT INTO `cs_customer_nonce` VALUES (1290, 61, '79ad922a40664a21', '2026-06-20 17:25:45');
INSERT INTO `cs_customer_nonce` VALUES (1291, 61, '1aec5b9ace174a90', '2026-06-20 17:29:42');
INSERT INTO `cs_customer_nonce` VALUES (1292, 61, 'f41bc39cea0a4e75', '2026-06-20 17:30:09');
INSERT INTO `cs_customer_nonce` VALUES (1293, 61, 'aba458b28a864c8d', '2026-06-20 17:30:20');
INSERT INTO `cs_customer_nonce` VALUES (1294, 61, 'ca7a92f465544bf6', '2026-06-20 17:30:24');
INSERT INTO `cs_customer_nonce` VALUES (1295, 61, '482d1d1ec0114daa', '2026-06-20 17:30:34');
INSERT INTO `cs_customer_nonce` VALUES (1296, 61, 'af6b637a00a34d56', '2026-06-20 17:31:38');
INSERT INTO `cs_customer_nonce` VALUES (1297, 61, 'e22b4af58d154a33', '2026-06-20 17:31:41');
INSERT INTO `cs_customer_nonce` VALUES (1298, 61, '7447ab7ba2ce4bf8', '2026-06-20 17:31:48');
INSERT INTO `cs_customer_nonce` VALUES (1299, 61, 'e181892cbb7948a9', '2026-06-20 17:36:03');
INSERT INTO `cs_customer_nonce` VALUES (1300, 61, '1a8677d419334a8e', '2026-06-20 17:36:54');
INSERT INTO `cs_customer_nonce` VALUES (1301, 61, 'ea2301d008004e71', '2026-06-20 17:37:30');
INSERT INTO `cs_customer_nonce` VALUES (1302, 61, '7b6b74a8f2054362', '2026-06-20 17:57:15');
INSERT INTO `cs_customer_nonce` VALUES (1303, 61, '6e4e6f0d4d844bab', '2026-06-20 18:00:20');
INSERT INTO `cs_customer_nonce` VALUES (1304, 61, '7e9936e972ff42fd', '2026-06-20 18:38:26');
INSERT INTO `cs_customer_nonce` VALUES (1305, 61, '123ec3949f864244', '2026-06-20 18:40:33');
INSERT INTO `cs_customer_nonce` VALUES (1306, 61, 'c1c29845d6be4c8b', '2026-06-20 19:38:06');
INSERT INTO `cs_customer_nonce` VALUES (1307, 61, '5081218082c6436b', '2026-06-20 20:21:33');
INSERT INTO `cs_customer_nonce` VALUES (1308, 61, 'fd4cbbc7a13945e3', '2026-06-20 20:21:34');
INSERT INTO `cs_customer_nonce` VALUES (1309, 61, '5b244e0e81764ab8', '2026-06-20 21:00:10');
INSERT INTO `cs_customer_nonce` VALUES (1310, 61, '81abd62dad4e420e', '2026-06-20 21:11:57');
INSERT INTO `cs_customer_nonce` VALUES (1311, 61, 'cb9bab93845a49be', '2026-06-20 21:12:10');
INSERT INTO `cs_customer_nonce` VALUES (1312, 61, 'dad9a49fd1074dd8', '2026-06-20 21:12:28');
INSERT INTO `cs_customer_nonce` VALUES (1313, 61, 'e352d2958fc449ca', '2026-06-20 21:13:14');
INSERT INTO `cs_customer_nonce` VALUES (1314, 61, 'f5a814951abd4d60', '2026-06-24 15:36:42');
INSERT INTO `cs_customer_nonce` VALUES (1315, 61, '4cf621cf796a4349', '2026-06-24 15:36:45');
INSERT INTO `cs_customer_nonce` VALUES (1316, 61, 'c9f5b056fe79428b', '2026-06-25 13:47:55');
INSERT INTO `cs_customer_nonce` VALUES (1317, 61, '5d3e47adf53f4ec4', '2026-06-30 02:21:19');
INSERT INTO `cs_customer_nonce` VALUES (1318, 61, '14735226067f4194', '2026-06-30 20:55:54');
INSERT INTO `cs_customer_nonce` VALUES (1319, 61, 'fcdad04676b5432f', '2026-06-30 20:56:13');
INSERT INTO `cs_customer_nonce` VALUES (1320, 61, '6265a674bb7e4fb7', '2026-06-30 20:56:49');
INSERT INTO `cs_customer_nonce` VALUES (1321, 61, '2c1c1cfe1f17456b', '2026-06-30 20:57:47');
INSERT INTO `cs_customer_nonce` VALUES (1322, 61, '472be27d828f4016', '2026-06-30 20:57:53');
INSERT INTO `cs_customer_nonce` VALUES (1323, 61, '815beb2ae2784e44', '2026-06-30 20:57:58');
INSERT INTO `cs_customer_nonce` VALUES (1324, 61, '37997ab42a1e4fbb', '2026-06-30 20:58:10');
INSERT INTO `cs_customer_nonce` VALUES (1325, 61, '85552dfa9d444758', '2026-06-30 20:59:00');
INSERT INTO `cs_customer_nonce` VALUES (1326, 61, '7ae825d128dd41f8', '2026-06-30 20:59:53');
INSERT INTO `cs_customer_nonce` VALUES (1327, 61, 'bc8fc0c687fa4394', '2026-06-30 21:00:12');
INSERT INTO `cs_customer_nonce` VALUES (1328, 61, '0fa0b02d18ed4038', '2026-06-30 21:11:09');
INSERT INTO `cs_customer_nonce` VALUES (1329, 61, '1b7621370b1f406b', '2026-06-30 21:13:27');
INSERT INTO `cs_customer_nonce` VALUES (1330, 61, 'e11a92f14cb34082', '2026-06-30 22:07:58');
INSERT INTO `cs_customer_nonce` VALUES (1331, 61, '4b6f4a9f93c74361', '2026-06-30 22:11:57');
INSERT INTO `cs_customer_nonce` VALUES (1332, 61, '2cabbf39d1f74fdd', '2026-06-30 22:12:01');
INSERT INTO `cs_customer_nonce` VALUES (1333, 61, '7ef5ee92596d465c', '2026-06-30 22:12:04');
INSERT INTO `cs_customer_nonce` VALUES (1334, 61, 'e2b03612139945e8', '2026-06-30 22:12:06');
INSERT INTO `cs_customer_nonce` VALUES (1335, 61, 'a5bca2cc125044dc', '2026-06-30 22:12:40');
INSERT INTO `cs_customer_nonce` VALUES (1336, 61, '30ca71e80d5a4699', '2026-06-30 22:14:22');
INSERT INTO `cs_customer_nonce` VALUES (1337, 61, 'aa537c075f4447ab', '2026-06-30 22:14:25');
INSERT INTO `cs_customer_nonce` VALUES (1338, 61, 'f62048f968034cf3', '2026-06-30 22:14:42');
INSERT INTO `cs_customer_nonce` VALUES (1339, 61, 'f3facd500a69407f', '2026-06-30 22:14:44');
INSERT INTO `cs_customer_nonce` VALUES (1340, 61, '76a39da1b17c40e9', '2026-06-30 22:14:46');
INSERT INTO `cs_customer_nonce` VALUES (1341, 61, '5c3228244496408c', '2026-07-01 00:17:47');
INSERT INTO `cs_customer_nonce` VALUES (1342, 61, '45b1b95b42124d78', '2026-07-01 01:35:02');
INSERT INTO `cs_customer_nonce` VALUES (1343, 61, 'b0246a4dd3cd4b91', '2026-07-01 01:59:10');
INSERT INTO `cs_customer_nonce` VALUES (1344, 61, 'fe84946c66a94867', '2026-07-01 02:41:39');
INSERT INTO `cs_customer_nonce` VALUES (1345, 61, '3f5f5176c2204561', '2026-07-01 02:43:46');
INSERT INTO `cs_customer_nonce` VALUES (1346, 73, 'c3e6519094d54879', '2026-07-01 02:47:06');
INSERT INTO `cs_customer_nonce` VALUES (1347, 73, '633d4ac9067944c1', '2026-07-01 02:47:11');
INSERT INTO `cs_customer_nonce` VALUES (1348, 73, '40092f42d69e4c20', '2026-07-01 03:14:10');
INSERT INTO `cs_customer_nonce` VALUES (1349, 73, '75994a7bd55445e7', '2026-07-01 03:14:15');
INSERT INTO `cs_customer_nonce` VALUES (1350, 73, '20f95ba94e3b4208', '2026-07-01 03:46:31');
INSERT INTO `cs_customer_nonce` VALUES (1351, 61, '604fb5c7edd04b24', '2026-07-01 03:49:08');
INSERT INTO `cs_customer_nonce` VALUES (1352, 61, '30e7fbd303354f7e', '2026-07-01 05:04:35');
INSERT INTO `cs_customer_nonce` VALUES (1353, 73, '7b68a2b5198b4734', '2026-07-01 11:36:20');
INSERT INTO `cs_customer_nonce` VALUES (1354, 73, '72cc63cd421a4b06', '2026-07-02 00:56:25');
INSERT INTO `cs_customer_nonce` VALUES (1355, 73, 'e35c3e1dd4ff4122', '2026-07-02 00:59:14');
INSERT INTO `cs_customer_nonce` VALUES (1356, 73, '1b7fa3b8096742c7', '2026-07-02 01:07:02');
INSERT INTO `cs_customer_nonce` VALUES (1357, 73, 'b4fa607c0406487f', '2026-07-02 01:08:35');
INSERT INTO `cs_customer_nonce` VALUES (1358, 73, 'a51f5cf9f07c47da', '2026-07-02 01:10:50');
INSERT INTO `cs_customer_nonce` VALUES (1359, 74, 'f33c2e0674de4891', '2026-07-02 01:17:07');
INSERT INTO `cs_customer_nonce` VALUES (1360, 73, 'de80a11086c84cf3', '2026-07-03 13:11:39');
INSERT INTO `cs_customer_nonce` VALUES (1361, 73, '9a12fd53249d4ff6', '2026-07-03 13:11:43');
INSERT INTO `cs_customer_nonce` VALUES (1362, 73, '2b5c671bb36a468a', '2026-07-03 13:12:36');
INSERT INTO `cs_customer_nonce` VALUES (1363, 73, 'e6cc7f9b3c7a4cf7', '2026-07-03 22:50:26');
INSERT INTO `cs_customer_nonce` VALUES (1364, 73, '49e9c2caa5b14d71', '2026-07-03 22:50:41');
INSERT INTO `cs_customer_nonce` VALUES (1365, 73, 'e77c65fdcf4d4a19', '2026-07-03 23:06:07');
INSERT INTO `cs_customer_nonce` VALUES (1366, 179, 'a519fa4aabfc4236', '2026-07-04 17:32:52');
INSERT INTO `cs_customer_nonce` VALUES (1367, 179, 'db8497c0616643c3', '2026-07-04 17:33:45');
INSERT INTO `cs_customer_nonce` VALUES (1368, 179, '7f4f7ec0e18f459b', '2026-07-04 17:35:06');
INSERT INTO `cs_customer_nonce` VALUES (1369, 179, 'ab7578905cf04f77', '2026-07-04 17:35:57');
INSERT INTO `cs_customer_nonce` VALUES (1370, 179, '5fb843e5f30e46e4', '2026-07-04 18:14:52');
INSERT INTO `cs_customer_nonce` VALUES (1371, 179, '5a0e4f72a31b445d', '2026-07-04 18:50:03');

-- ----------------------------
-- Table structure for cs_customer_setup
-- ----------------------------
DROP TABLE IF EXISTS `cs_customer_setup`;
CREATE TABLE `cs_customer_setup`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `audio_switch` int(1) NULL DEFAULT 0 COMMENT '声音开关:0开启，1关闭',
  `side_switch` int(1) NULL DEFAULT 1 COMMENT '侧边栏：0开启，1关闭',
  `jump_switch` int(1) NULL DEFAULT 0 COMMENT '跳转开关0开启，1关闭',
  `data_switch` int(1) NULL DEFAULT 1 COMMENT '聊天资料开关：0,开启，1,关闭',
  `chat_record_sort` int(1) NULL DEFAULT 0 COMMENT '聊天记录显示顺序：0、从下往上，1从上往下',
  `qrcode_switch` int(1) NULL DEFAULT 2 COMMENT '二维码类型：0，全网码，1：浏览器码，2:微信码,3:qq码，4：抖音码，5，微博码',
  `code_switch` int(1) NULL DEFAULT 0 COMMENT '进人开关0开启，1关闭',
  `verify_code_switch` int(1) NULL DEFAULT 1 COMMENT '验证码开关:0,开启，1关闭',
  `verify_code_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证码背景图片',
  `verify_code_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证码标题',
  `verify_questions_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '问答验证内容',
  `verify_questions_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问答验证背景图片',
  `count_switch` int(1) NULL DEFAULT 0 COMMENT '计算方式：0、关闭，1、ip过滤',
  `ip_number` int(1) NULL DEFAULT 20 COMMENT 'ip计数过滤数量',
  `domestic_switch` int(1) NULL DEFAULT 1 COMMENT '国外过滤：0 开启，1关闭',
  `seconds_switch` int(1) NULL DEFAULT 1 COMMENT '秒进秒出：0 开启，1关闭',
  `stop_switch` int(1) NULL DEFAULT 1 COMMENT '停留时间开关:0 开启，1关闭',
  `stop_time_number` int(1) NULL DEFAULT 0 COMMENT '停留时间',
  `wechat_switch` int(1) NULL DEFAULT 1 COMMENT '非微信过滤：0开启，1关闭',
  `phone_model_switch` int(1) NULL DEFAULT 1 COMMENT '模拟器过滤：0开启，1关闭',
  `is_proxy_switch` int(1) NULL DEFAULT 1 COMMENT '代理过滤：0开启，1关闭',
  `form_settings` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单字段设置,多选id',
  `version` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '版本',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客服设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_customer_setup
-- ----------------------------
INSERT INTO `cs_customer_setup` VALUES (21, 26, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:26:15');
INSERT INTO `cs_customer_setup` VALUES (22, 27, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:26:15');
INSERT INTO `cs_customer_setup` VALUES (23, 28, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:26:15');
INSERT INTO `cs_customer_setup` VALUES (24, 29, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:26:15');
INSERT INTO `cs_customer_setup` VALUES (25, 30, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:26:15');
INSERT INTO `cs_customer_setup` VALUES (26, 31, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:28:39');
INSERT INTO `cs_customer_setup` VALUES (27, 32, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:28:39');
INSERT INTO `cs_customer_setup` VALUES (28, 33, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:28:39');
INSERT INTO `cs_customer_setup` VALUES (29, 34, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:28:39');
INSERT INTO `cs_customer_setup` VALUES (30, 35, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:28:39');
INSERT INTO `cs_customer_setup` VALUES (31, 36, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:29:11');
INSERT INTO `cs_customer_setup` VALUES (32, 37, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:29:11');
INSERT INTO `cs_customer_setup` VALUES (33, 38, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:29:11');
INSERT INTO `cs_customer_setup` VALUES (34, 39, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:29:11');
INSERT INTO `cs_customer_setup` VALUES (35, 40, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:29:11');
INSERT INTO `cs_customer_setup` VALUES (36, 41, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (37, 42, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (38, 43, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (39, 44, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (40, 45, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (41, 46, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (42, 47, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (43, 48, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (44, 49, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (45, 50, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:31:53');
INSERT INTO `cs_customer_setup` VALUES (46, 51, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (47, 52, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (48, 53, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (49, 54, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (50, 55, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (51, 56, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (52, 57, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (53, 58, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (54, 59, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (55, 60, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:33:19');
INSERT INTO `cs_customer_setup` VALUES (56, 61, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 1, 20, 1, 1, 1, 0, 1, 1, 1, '1,3,2,4', '582a2b69c08747f78ecfc222e8b00a47', '2026-06-30 02:21:28', '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (57, 62, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (58, 63, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (59, 64, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (60, 65, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (61, 66, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (62, 67, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (63, 68, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (64, 69, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (65, 70, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 13:34:20');
INSERT INTO `cs_customer_setup` VALUES (66, 71, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 15:06:13');
INSERT INTO `cs_customer_setup` VALUES (67, 72, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 15:06:13');
INSERT INTO `cs_customer_setup` VALUES (68, 73, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 1, 20, 1, 1, 1, 0, 1, 1, 1, '1,2,3,4', '3dbbc3979d4149d5a8efc969b5541dc5', '2026-07-03 13:12:45', '2026-06-13 15:06:13');
INSERT INTO `cs_customer_setup` VALUES (69, 74, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, '2026-07-02 01:17:32', '2026-06-13 15:06:13');
INSERT INTO `cs_customer_setup` VALUES (70, 75, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-06-13 15:06:13');
INSERT INTO `cs_customer_setup` VALUES (71, 179, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 1, 20, 1, 1, 1, 0, 1, 1, 1, '1,2,3,4', 'c1026a3392794a64887301055573ed8c', '2026-07-04 17:33:53', '2026-07-04 17:32:24');
INSERT INTO `cs_customer_setup` VALUES (72, 1, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-07-14 17:24:35');
INSERT INTO `cs_customer_setup` VALUES (73, 2, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-07-14 17:42:49');
INSERT INTO `cs_customer_setup` VALUES (74, 3, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-07-14 17:44:17');
INSERT INTO `cs_customer_setup` VALUES (75, 4, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-07-14 17:46:22');
INSERT INTO `cs_customer_setup` VALUES (76, 5, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-07-14 17:47:24');
INSERT INTO `cs_customer_setup` VALUES (77, 6, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-07-14 17:49:51');
INSERT INTO `cs_customer_setup` VALUES (78, 7, 0, 1, 0, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, 0, 20, 1, 1, 1, 0, 1, 1, 1, NULL, NULL, NULL, '2026-07-14 17:52:32');

-- ----------------------------
-- Table structure for cs_domain
-- ----------------------------
DROP TABLE IF EXISTS `cs_domain`;
CREATE TABLE `cs_domain`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '客服',
  `type` int(1) NULL DEFAULT 0 COMMENT '活码类型：0公共活码，1、专属活码',
  `live_code_id` bigint(20) NULL DEFAULT NULL,
  `live_code_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活码链接',
  `number` int(1) NULL DEFAULT NULL COMMENT '切码次数',
  `status` int(1) NULL DEFAULT 0 COMMENT '0:开启,1:关闭',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `nonce` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_domain
-- ----------------------------
INSERT INTO `cs_domain` VALUES (1, 62, 0, 11, 'https://www.gonggong1.com?375e88c=7b2b54f6a&eaceshir=ukou1231232', NULL, 0, '2026-06-13 15:04:36', '2026-06-13 15:04:36', 1781334276235);
INSERT INTO `cs_domain` VALUES (2, 63, 0, 11, 'https://www.gonggong1.com?=937c79278b294ac4&avjcesh=irukou1231233', NULL, 0, '2026-06-13 15:05:03', '2026-06-13 15:05:03', 1781334303134);
INSERT INTO `cs_domain` VALUES (3, 71, 0, 11, 'https://www.gonggong1.com?e0=b0ebb5db544760&fbyeceshi=rukou1231234', NULL, 0, '2026-06-13 15:06:25', '2026-06-13 15:06:25', 1781334385029);
INSERT INTO `cs_domain` VALUES (4, 73, 0, 33, 'https://3a3f46a1.www.baidu6.com/cekp/ilrt/633d4ac9067944c1?f48506', NULL, 0, '2026-06-13 15:35:43', '2026-07-01 02:47:11', 1782845230590);
INSERT INTO `cs_domain` VALUES (5, 74, 0, 11, 'https://www.gonggong1.com?69c4b567b6b=b4555&=cceshirukou1231231', NULL, 0, '2026-06-13 15:35:49', '2026-06-13 15:35:49', 1781336149149);
INSERT INTO `cs_domain` VALUES (6, 61, 0, 33, 'https://e29580b.www.baidu6.com/hefbqf/ivtbis/76a39da1b17c40e9?a9f344', NULL, 0, '2026-06-14 14:09:06', '2026-06-30 22:14:46', 1782828886327);
INSERT INTO `cs_domain` VALUES (7, 179, 0, 32, 'https://baidus.com?a519fa4aabfc42=36&tdrjceshirukou123=1234&xxfsdfc=d2', NULL, 0, '2026-07-04 17:32:52', '2026-07-04 17:32:52', 1783157571883);

-- ----------------------------
-- Table structure for cs_entry_ratio
-- ----------------------------
DROP TABLE IF EXISTS `cs_entry_ratio`;
CREATE TABLE `cs_entry_ratio`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `main_user_id` bigint(11) NULL DEFAULT NULL COMMENT '主卡',
  `main_carmine` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主卡密',
  `sub_user_id` bigint(11) NULL DEFAULT NULL COMMENT '副卡',
  `sub_carmine` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '副卡密',
  `main_radio_number` int(4) NULL DEFAULT 0 COMMENT '主卡比例数量',
  `sub_radio_number` int(4) NULL DEFAULT 0 COMMENT '副卡比例数量',
  `main_number` int(5) NULL DEFAULT 0 COMMENT '主卡进人数量',
  `sub_number` int(5) NULL DEFAULT 0 COMMENT '副卡进入数量',
  `switch_code` int(1) NULL DEFAULT 0 COMMENT '开关：0开，1关',
  `main_number_total` int(4) NULL DEFAULT 0 COMMENT '头寸进人数量',
  `system_total_number` int(4) NULL DEFAULT 0 COMMENT '头寸',
  `sub_user_id_two` bigint(20) NULL DEFAULT NULL COMMENT '副卡2id',
  `sub_carmine_two` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '副卡2卡密',
  `main_radio_number_two` int(4) NULL DEFAULT 0 COMMENT '主卡2比例数量',
  `sub_radio_number_two` int(4) NULL DEFAULT 0 COMMENT '副卡2比例数量',
  `main_number_two` int(4) NULL DEFAULT 0 COMMENT '主卡2进人数量',
  `sub_number_two` int(4) NULL DEFAULT 0 COMMENT '副卡2进人数量',
  `switch_code_two` int(1) NULL DEFAULT 0 COMMENT '副卡2开关：0开，1关',
  `main_number_total_two` int(4) NULL DEFAULT 0 COMMENT '副卡2头寸进人数量',
  `system_total_number_two` int(4) NULL DEFAULT 0 COMMENT '副卡2头寸',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '劫持比例表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_entry_ratio
-- ----------------------------
INSERT INTO `cs_entry_ratio` VALUES (17, 61, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 62, 'CS-1000f07c0ebb77bc9209', 11, 3, 0, 0, 0, 14, 60, NULL, '2026-07-01 02:45:14');
INSERT INTO `cs_entry_ratio` VALUES (18, 63, 'CS-1000b0e31d91107f15f2', NULL, NULL, 0, 0, 0, 0, 0, 0, 60, 62, 'CS-1000f07c0ebb77bc9209', 11, 3, 0, 0, 0, 0, 60, NULL, NULL);
INSERT INTO `cs_entry_ratio` VALUES (19, 71, 'JC-1000ad33ca6dd4e07444', 72, 'JC-1000956e3230e909db23', 3, 1, 1, 0, 0, 5, 5, 62, 'CS-1000f07c0ebb77bc9209', 17, 20, 3, 0, 0, 10, 30, '2026-06-13 15:25:45', '2026-06-30 02:52:08');
INSERT INTO `cs_entry_ratio` VALUES (21, 73, 'JC-1000d7d412960561beca', NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 62, 'CS-1000f07c0ebb77bc9209', 3, 1, 0, 0, 1, 10, 10, NULL, '2026-07-03 23:15:40');

-- ----------------------------
-- Table structure for cs_entry_ratio_carmine
-- ----------------------------
DROP TABLE IF EXISTS `cs_entry_ratio_carmine`;
CREATE TABLE `cs_entry_ratio_carmine`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `carmine` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '劫持卡密',
  `main_id` bigint(20) NULL DEFAULT NULL COMMENT '主表cs_settint id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '劫持卡密id',
  `number` int(11) NULL DEFAULT 0 COMMENT '绑定数量',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '劫持设置默认卡密' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_entry_ratio_carmine
-- ----------------------------
INSERT INTO `cs_entry_ratio_carmine` VALUES (22, 'CS-1000f07c0ebb77bc9209', 1, 62, 4, '2026-06-30 02:18:22');

-- ----------------------------
-- Table structure for cs_entry_ratio_setting
-- ----------------------------
DROP TABLE IF EXISTS `cs_entry_ratio_setting`;
CREATE TABLE `cs_entry_ratio_setting`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `main_number_two` int(11) NULL DEFAULT NULL COMMENT '普通卡主卡比例',
  `sub_number_two` int(11) NULL DEFAULT NULL COMMENT '普通卡副卡2比例',
  `hijack_main_number_two` int(11) NULL DEFAULT NULL COMMENT '劫持卡主卡比例',
  `hijack_sub_number_two` int(11) NULL DEFAULT NULL COMMENT '劫持卡副卡2比例',
  `total_number` int(11) NULL DEFAULT 0 COMMENT '普通卡头寸数量',
  `hack_total_number` int(11) NULL DEFAULT NULL COMMENT '劫持卡默认头寸（副卡1不设置的情况）',
  `exclude_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排除卡密',
  `delay_time` int(11) NULL DEFAULT NULL COMMENT '队列延迟时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '劫持默认设置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_entry_ratio_setting
-- ----------------------------
INSERT INTO `cs_entry_ratio_setting` VALUES (1, 11, 3, 12, 1, 60, 30, 'CS-1000f07c0ebb77bc9209', 60, '2026-06-13 13:59:54');

-- ----------------------------
-- Table structure for cs_exclusive_code
-- ----------------------------
DROP TABLE IF EXISTS `cs_exclusive_code`;
CREATE TABLE `cs_exclusive_code`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `live_code_id` bigint(20) NULL DEFAULT NULL COMMENT '专属域名id',
  `exclusive_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专属地址',
  `status` int(1) NULL DEFAULT 0 COMMENT '0:使用中，1：关闭',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专属域名' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_exclusive_code
-- ----------------------------
INSERT INTO `cs_exclusive_code` VALUES (10, 1, 4, 'https://www.baiducc.com/login/642dff98ed6d4a=07', 1, '2026-06-04 11:00:31', NULL);

-- ----------------------------
-- Table structure for cs_fallback_response
-- ----------------------------
DROP TABLE IF EXISTS `cs_fallback_response`;
CREATE TABLE `cs_fallback_response`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_type` int(1) NULL DEFAULT NULL COMMENT '账号类型：0 客服，1企业',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '账号id',
  `type` int(1) NULL DEFAULT NULL COMMENT '回复类型：',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复内容',
  `status` int(1) NULL DEFAULT NULL COMMENT '开关：0开，1关',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '兜底回复' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_fallback_response
-- ----------------------------

-- ----------------------------
-- Table structure for cs_form_field
-- ----------------------------
DROP TABLE IF EXISTS `cs_form_field`;
CREATE TABLE `cs_form_field`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_form_field
-- ----------------------------
INSERT INTO `cs_form_field` VALUES (1, '姓名');
INSERT INTO `cs_form_field` VALUES (2, '电话');
INSERT INTO `cs_form_field` VALUES (3, '贷款金额');
INSERT INTO `cs_form_field` VALUES (4, '年龄');

-- ----------------------------
-- Table structure for cs_friend
-- ----------------------------
DROP TABLE IF EXISTS `cs_friend`;
CREATE TABLE `cs_friend`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '黑名单自增id',
  `from_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `to_id` bigint(20) NULL DEFAULT NULL COMMENT '好友id',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '原因',
  `star` int(1) NULL DEFAULT 0 COMMENT '星标：0未选，1已选',
  `status` int(1) NULL DEFAULT 0 COMMENT '黑名单状态：0-有效 1-无效',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fromid,to_id`(`from_id` ASC, `to_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 178 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户黑名单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_friend
-- ----------------------------
INSERT INTO `cs_friend` VALUES (1, 61, 143, NULL, 0, 0, NULL, '2026-06-20 21:12:45', NULL);
INSERT INTO `cs_friend` VALUES (2, 61, 144, NULL, 0, 0, NULL, '2026-06-24 15:38:33', NULL);
INSERT INTO `cs_friend` VALUES (4, 71, 94, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (5, 71, 84, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (6, 71, 122, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (7, 1, 24, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (8, 71, 85, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (9, 71, 101, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (10, 71, 126, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (11, 71, 93, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (12, 71, 119, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (13, 72, 108, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (14, 71, 95, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (15, 62, 91, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (16, 1, 25, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (17, 71, 124, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (18, 71, 78, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (19, 71, 81, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (20, 71, 83, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (21, 71, 77, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (22, 71, 135, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (23, 72, 137, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (24, 1, 60, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (25, 1, 62, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (26, 71, 80, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (27, 71, 79, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (28, 71, 88, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (29, 62, 89, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (30, 71, 99, NULL, 0, 0, NULL, '2026-06-30 02:18:21', NULL);
INSERT INTO `cs_friend` VALUES (31, 71, 102, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (32, 73, 116, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (33, 71, 118, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (34, 71, 131, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (35, 71, 134, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (36, 71, 138, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (37, 1, 21, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (38, 1, 22, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (39, 71, 76, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (40, 71, 82, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (41, 71, 92, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (42, 62, 100, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (43, 71, 104, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (44, 62, 105, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (45, 71, 106, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (46, 73, 110, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (47, 73, 112, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (48, 73, 114, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (49, 71, 117, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (50, 71, 127, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (51, 71, 129, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (52, 71, 130, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (53, 71, 132, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (54, 72, 133, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (55, 61, 139, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (56, 61, 140, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (57, 61, 142, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (59, 1, 23, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (60, 71, 86, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (61, 71, 87, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (62, 62, 90, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (63, 62, 96, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (64, 71, 97, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (65, 71, 98, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (66, 72, 103, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (67, 71, 107, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (68, 73, 109, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (69, 73, 111, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (70, 73, 113, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (71, 74, 115, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (72, 71, 120, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (73, 71, 121, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (74, 71, 123, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (75, 71, 125, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (76, 71, 128, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (77, 71, 136, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (78, 61, 141, NULL, 0, 0, NULL, '2026-06-30 02:18:22', NULL);
INSERT INTO `cs_friend` VALUES (80, 61, 145, NULL, 0, 0, NULL, '2026-06-30 02:22:43', NULL);
INSERT INTO `cs_friend` VALUES (81, 61, 146, NULL, 0, 0, NULL, '2026-06-30 02:36:42', NULL);
INSERT INTO `cs_friend` VALUES (82, 61, 147, NULL, 0, 0, NULL, '2026-07-01 00:18:56', NULL);
INSERT INTO `cs_friend` VALUES (83, 61, 148, NULL, 0, 0, NULL, '2026-07-01 00:18:56', NULL);
INSERT INTO `cs_friend` VALUES (84, 61, 149, NULL, 0, 0, NULL, '2026-07-01 00:19:26', NULL);
INSERT INTO `cs_friend` VALUES (85, 61, 150, NULL, 0, 0, NULL, '2026-07-01 02:42:11', NULL);
INSERT INTO `cs_friend` VALUES (86, 61, 151, NULL, 0, 0, NULL, '2026-07-01 02:43:43', NULL);
INSERT INTO `cs_friend` VALUES (122, 61, 152, NULL, 0, 0, NULL, '2026-07-01 02:45:14', NULL);
INSERT INTO `cs_friend` VALUES (123, 73, 153, NULL, 0, 0, NULL, '2026-07-01 02:48:37', NULL);
INSERT INTO `cs_friend` VALUES (124, 73, 154, NULL, 0, 0, NULL, '2026-07-01 02:49:04', NULL);
INSERT INTO `cs_friend` VALUES (125, 74, 155, NULL, 0, 0, NULL, '2026-07-01 02:49:27', NULL);
INSERT INTO `cs_friend` VALUES (126, 73, 156, NULL, 0, 0, NULL, '2026-07-01 02:50:09', NULL);
INSERT INTO `cs_friend` VALUES (127, 73, 157, NULL, 0, 0, NULL, '2026-07-01 02:51:59', NULL);
INSERT INTO `cs_friend` VALUES (128, 73, 158, NULL, 0, 0, NULL, '2026-07-01 03:14:32', NULL);
INSERT INTO `cs_friend` VALUES (129, 73, 159, NULL, 0, 0, NULL, '2026-07-01 03:15:07', NULL);
INSERT INTO `cs_friend` VALUES (130, 73, 160, NULL, 0, 0, NULL, '2026-07-01 03:15:19', NULL);
INSERT INTO `cs_friend` VALUES (131, 73, 161, NULL, 0, 0, NULL, '2026-07-01 03:15:38', NULL);
INSERT INTO `cs_friend` VALUES (132, 73, 162, NULL, 0, 0, NULL, '2026-07-01 03:47:01', NULL);
INSERT INTO `cs_friend` VALUES (133, 73, 163, NULL, 0, 0, NULL, '2026-07-01 03:47:25', NULL);
INSERT INTO `cs_friend` VALUES (134, 73, 164, NULL, 0, 0, NULL, '2026-07-01 03:47:50', NULL);
INSERT INTO `cs_friend` VALUES (135, 73, 165, NULL, 0, 0, NULL, '2026-07-01 03:48:02', NULL);
INSERT INTO `cs_friend` VALUES (136, 73, 166, NULL, 0, 0, NULL, '2026-07-01 11:40:52', NULL);
INSERT INTO `cs_friend` VALUES (138, 73, 167, NULL, 0, 0, NULL, '2026-07-01 11:42:49', NULL);
INSERT INTO `cs_friend` VALUES (139, 73, 168, NULL, 0, 0, NULL, '2026-07-01 11:44:12', NULL);
INSERT INTO `cs_friend` VALUES (140, 62, 169, NULL, 0, 0, NULL, '2026-07-02 01:07:30', NULL);
INSERT INTO `cs_friend` VALUES (141, 73, 170, NULL, 0, 0, NULL, '2026-07-02 01:08:48', NULL);
INSERT INTO `cs_friend` VALUES (142, 73, 171, NULL, 0, 0, NULL, '2026-07-02 01:11:03', NULL);
INSERT INTO `cs_friend` VALUES (170, 73, 172, NULL, 0, 0, NULL, '2026-07-03 13:12:20', NULL);
INSERT INTO `cs_friend` VALUES (171, 73, 173, NULL, 0, 0, NULL, '2026-07-03 13:13:03', NULL);
INSERT INTO `cs_friend` VALUES (172, 73, 174, NULL, 0, 0, NULL, '2026-07-03 22:53:01', NULL);
INSERT INTO `cs_friend` VALUES (173, 73, 175, NULL, 0, 0, NULL, '2026-07-03 22:54:48', NULL);
INSERT INTO `cs_friend` VALUES (174, 73, 176, NULL, 0, 0, NULL, '2026-07-03 22:56:50', NULL);
INSERT INTO `cs_friend` VALUES (175, 73, 177, NULL, 0, 0, NULL, '2026-07-03 23:07:41', NULL);
INSERT INTO `cs_friend` VALUES (176, 73, 178, NULL, 0, 0, NULL, '2026-07-03 23:15:40', NULL);
INSERT INTO `cs_friend` VALUES (177, 179, 180, NULL, 0, 0, NULL, '2026-07-04 17:36:11', NULL);

-- ----------------------------
-- Table structure for cs_group
-- ----------------------------
DROP TABLE IF EXISTS `cs_group`;
CREATE TABLE `cs_group`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群名称',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群头像',
  `notice` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告',
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `send_status` int(1) NULL DEFAULT NULL COMMENT '禁言状态:0关闭，1：开启',
  `update_time` datetime NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '群信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_group
-- ----------------------------

-- ----------------------------
-- Table structure for cs_ip_address
-- ----------------------------
DROP TABLE IF EXISTS `cs_ip_address`;
CREATE TABLE `cs_ip_address`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip次数',
  `number` int(11) NULL DEFAULT 0 COMMENT '停留次数',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_ip_address
-- ----------------------------
INSERT INTO `cs_ip_address` VALUES (1, '192.168.9.2', 11, '2025-08-06 10:37:10', '2025-09-20 18:24:30');
INSERT INTO `cs_ip_address` VALUES (2, '192.168.10.3', 8, '2025-08-07 21:27:20', '2025-09-20 18:24:30');
INSERT INTO `cs_ip_address` VALUES (3, '192.168.0.100', 12, '2025-08-08 21:31:33', '2026-01-04 09:19:12');
INSERT INTO `cs_ip_address` VALUES (4, '192.168.9.56', 43, '2025-08-11 10:04:41', '2026-06-03 18:01:36');
INSERT INTO `cs_ip_address` VALUES (5, '192.168.9.13', 2, '2025-08-18 16:58:04', '2025-09-20 18:24:30');
INSERT INTO `cs_ip_address` VALUES (6, '192.168.9.30', 13, '2025-08-19 09:32:20', '2026-01-04 09:19:12');
INSERT INTO `cs_ip_address` VALUES (7, '192.168.13.140', 3, '2025-08-19 10:13:35', '2025-09-20 18:24:30');
INSERT INTO `cs_ip_address` VALUES (8, '192.168.0.105', 75, '2025-08-20 04:04:28', '2026-06-14 15:07:58');
INSERT INTO `cs_ip_address` VALUES (9, '192.168.9.69', 17, '2025-08-22 09:02:26', '2026-05-24 15:07:21');
INSERT INTO `cs_ip_address` VALUES (10, '192.168.9.41', 4, '2025-08-26 11:47:20', '2025-11-18 14:56:13');
INSERT INTO `cs_ip_address` VALUES (11, '192.168.9.59', 37, '2025-08-28 14:51:01', '2026-01-04 09:19:12');
INSERT INTO `cs_ip_address` VALUES (12, '192.168.9.54', 12, '2025-09-02 15:41:56', '2026-01-04 09:19:12');
INSERT INTO `cs_ip_address` VALUES (13, '192.168.9.45', 33, '2025-09-08 09:00:23', '2026-01-04 09:19:12');
INSERT INTO `cs_ip_address` VALUES (14, '10.10.10.6', 1, '2025-09-20 18:24:30', NULL);
INSERT INTO `cs_ip_address` VALUES (15, '10.10.10.6', 1, '2025-09-20 18:24:30', NULL);
INSERT INTO `cs_ip_address` VALUES (16, '192.168.9.5', 14, '2025-09-24 15:17:47', '2026-01-04 09:19:11');
INSERT INTO `cs_ip_address` VALUES (17, '192.168.0.104', 208, '2025-09-27 22:55:24', '2026-06-03 18:01:36');
INSERT INTO `cs_ip_address` VALUES (18, '192.168.1.4', 104, '2025-10-02 17:28:40', '2026-05-24 15:07:21');
INSERT INTO `cs_ip_address` VALUES (19, '192.168.0.101', 55, '2025-10-15 03:23:34', '2026-06-14 15:07:59');
INSERT INTO `cs_ip_address` VALUES (20, '192.168.9.80', 56, '2025-10-15 14:35:42', '2025-11-15 17:31:23');
INSERT INTO `cs_ip_address` VALUES (21, '192.168.10.5', 7, '2025-10-23 00:12:35', '2025-11-15 17:31:23');
INSERT INTO `cs_ip_address` VALUES (22, '192.168.1.3', 319, '2025-11-03 17:46:54', '2026-06-14 15:07:59');
INSERT INTO `cs_ip_address` VALUES (23, '192.168.9.68', 9, '2025-11-17 09:53:48', '2025-11-17 10:14:15');
INSERT INTO `cs_ip_address` VALUES (24, '192.168.0.106', 152, '2025-11-22 02:16:54', '2026-06-03 18:01:36');
INSERT INTO `cs_ip_address` VALUES (25, '192.168.9.53', 39, '2025-11-24 14:52:16', '2025-11-24 16:16:04');
INSERT INTO `cs_ip_address` VALUES (26, '192.168.9.85', 14, '2025-11-26 15:24:01', '2026-01-04 09:19:12');
INSERT INTO `cs_ip_address` VALUES (27, '127.0.0.1', 183, '2025-11-26 19:51:55', '2026-07-04 17:36:11');
INSERT INTO `cs_ip_address` VALUES (28, '192.168.9.72', 28, '2025-12-29 16:45:15', '2026-05-24 15:07:21');
INSERT INTO `cs_ip_address` VALUES (29, '192.168.9.78', 49, '2026-01-12 15:41:30', '2026-06-03 18:01:36');
INSERT INTO `cs_ip_address` VALUES (30, '172.20.10.2', 6, '2026-03-10 19:34:19', '2026-07-03 23:15:40');
INSERT INTO `cs_ip_address` VALUES (31, '192.168.1.2', 104, '2026-03-27 13:21:10', '2026-06-03 18:01:36');
INSERT INTO `cs_ip_address` VALUES (32, '172.20.10.4', 2, '2026-07-03 22:54:48', '2026-07-03 22:56:50');
INSERT INTO `cs_ip_address` VALUES (33, '172.20.10.3', 1, '2026-07-03 23:07:41', NULL);

-- ----------------------------
-- Table structure for cs_live_code
-- ----------------------------
DROP TABLE IF EXISTS `cs_live_code`;
CREATE TABLE `cs_live_code`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(1) NULL DEFAULT 0 COMMENT '口子类型：0，公共域名，1、专属域名，2、短域名,3、备用域名',
  `shell_type` int(1) NULL DEFAULT 0 COMMENT '口子类型：0，普通类型，1、S类型',
  `platform_type` int(1) NULL DEFAULT NULL COMMENT '平台类型：0，全网码，1：浏览器码，2:微信码,3:qq码，4：抖音码，5，微博码,6、支付宝码',
  `domain_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '口子域名',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序字段',
  `number` int(11) NULL DEFAULT 0 COMMENT '绑定数量',
  `request_number` int(11) NULL DEFAULT 0 COMMENT '口子请求次数',
  `status` int(1) NULL DEFAULT 1 COMMENT '口子状态: 0、正常，1、异常（可根据专业检测拉取是否正常）',
  `direct` int(1) NULL DEFAULT 0 COMMENT '0:正常，1：直连，2备案，3嵌套',
  `deleted` int(1) NULL DEFAULT 0 COMMENT '0、未删除，1已删除',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商户域名表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_live_code
-- ----------------------------
INSERT INTO `cs_live_code` VALUES (1, 0, 0, 2, 'https://www.baidu1.com', 1, 0, 0, 0, 0, 1, '2026-05-11 09:45:02', '2026-04-24 05:56:39', '2026-05-11 09:45:02');
INSERT INTO `cs_live_code` VALUES (2, 0, 0, 2, 'https://www.baidu2.com', 2, 0, 0, 0, 1, 1, '2026-05-11 09:45:03', '2026-04-24 05:57:06', '2026-05-11 09:45:03');
INSERT INTO `cs_live_code` VALUES (3, 0, 0, 2, 'https://baidu.com', 3, 0, 0, 0, 2, 1, '2026-05-11 09:45:03', '2026-04-24 05:57:24', '2026-05-11 09:45:03');
INSERT INTO `cs_live_code` VALUES (4, 1, 0, 0, 'https://www.baiducc.com', 4, 0, 0, 0, 1, 0, NULL, NULL, NULL);
INSERT INTO `cs_live_code` VALUES (5, 1, 0, 0, 'https://www.ceshifadsf.com', 5, 0, 0, 1, 1, 0, NULL, '2026-04-30 20:50:51', NULL);
INSERT INTO `cs_live_code` VALUES (7, 0, 0, 2, 'http://ceshi111.com', 4, 0, 0, 1, 0, 1, '2026-06-18 16:32:31', '2026-04-30 20:52:07', NULL);
INSERT INTO `cs_live_code` VALUES (8, 0, 0, 2, 'http://ceshi222.com', 5, 0, 0, 1, 0, 1, '2026-06-18 16:32:31', '2026-04-30 20:52:07', NULL);
INSERT INTO `cs_live_code` VALUES (9, 0, 0, 2, 'http://ceshi333.com', 6, 0, 0, 1, 0, 1, '2026-06-18 16:32:31', '2026-04-30 20:52:07', NULL);
INSERT INTO `cs_live_code` VALUES (10, 1, 0, 0, 'https://cdsafdf45.com', 6, 0, 0, 1, 1, 0, NULL, '2026-04-30 20:52:29', NULL);
INSERT INTO `cs_live_code` VALUES (11, 0, 0, 2, 'https://www.gonggong1.com', 1, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:03');
INSERT INTO `cs_live_code` VALUES (12, 0, 0, 2, 'https://www.gonggong2.com', 2, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:03');
INSERT INTO `cs_live_code` VALUES (13, 0, 0, 2, 'https://www.gonggong3.com', 3, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:04');
INSERT INTO `cs_live_code` VALUES (14, 0, 0, 2, 'https://www.gonggong4.com', 4, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:04');
INSERT INTO `cs_live_code` VALUES (15, 0, 0, 2, 'https://www.gonggong5.com', 5, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:04');
INSERT INTO `cs_live_code` VALUES (16, 0, 0, 2, 'https://www.gonggong6.com', 6, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:04');
INSERT INTO `cs_live_code` VALUES (17, 0, 0, 2, 'https://www.gonggong7.com', 7, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:05');
INSERT INTO `cs_live_code` VALUES (18, 0, 0, 2, 'https://www.gonggong8.com', 8, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:05');
INSERT INTO `cs_live_code` VALUES (19, 0, 0, 2, 'https://www.gonggong9.com', 9, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:05');
INSERT INTO `cs_live_code` VALUES (20, 0, 0, 2, 'https://www.gonggong10.com', 10, 0, 0, 0, 0, 1, '2026-06-18 16:32:31', '2026-05-01 12:39:23', '2026-05-11 09:45:05');
INSERT INTO `cs_live_code` VALUES (21, 3, 0, 2, 'https://www.backup1.com', 1, 0, 0, 0, 0, 0, '2026-05-11 09:45:02', '2026-05-01 12:40:44', '2026-05-11 09:45:02');
INSERT INTO `cs_live_code` VALUES (22, 3, 0, 2, 'https://www.backup2.com', 2, 0, 0, 0, 0, 0, '2026-05-11 09:45:02', '2026-05-01 12:40:44', '2026-05-11 09:45:02');
INSERT INTO `cs_live_code` VALUES (23, 3, 0, 2, 'https://www.backup3.com', 3, 0, 0, 1, 0, 0, '2026-05-11 09:41:11', '2026-05-01 12:40:44', '2026-05-11 09:41:11');
INSERT INTO `cs_live_code` VALUES (24, 3, 0, 2, 'https://www.backup4.com', 4, 0, 0, 1, 0, 0, '2026-05-11 09:41:11', '2026-05-01 12:40:44', '2026-05-11 09:41:11');
INSERT INTO `cs_live_code` VALUES (25, 3, 0, 2, 'https://www.backup5.com', 5, 0, 0, 1, 0, 0, '2026-05-11 09:41:12', '2026-05-01 12:40:44', '2026-05-11 09:41:12');
INSERT INTO `cs_live_code` VALUES (26, 3, 0, 2, 'https://www.backup6.com', 6, 0, 0, 1, 0, 0, '2026-05-11 09:41:12', '2026-05-01 12:40:44', '2026-05-11 09:41:12');
INSERT INTO `cs_live_code` VALUES (27, 3, 0, 2, 'https://www.backup7.com', 7, 0, 0, 1, 0, 0, '2026-05-11 09:41:12', '2026-05-01 12:40:44', '2026-05-11 09:41:12');
INSERT INTO `cs_live_code` VALUES (28, 3, 0, 2, 'https://www.backup8.com', 8, 0, 0, 1, 0, 0, '2026-05-11 09:41:12', '2026-05-01 12:40:44', '2026-05-11 09:41:12');
INSERT INTO `cs_live_code` VALUES (29, 3, 0, 2, 'https://www.backup9.com', 9, 0, 0, 1, 0, 0, '2026-05-11 09:41:13', '2026-05-01 12:40:44', '2026-05-11 09:41:13');
INSERT INTO `cs_live_code` VALUES (30, 3, 0, 2, 'https://www.backup10.com', 10, 0, 0, 1, 0, 0, '2026-05-11 09:41:13', '2026-05-01 12:40:44', '2026-05-11 09:41:13');
INSERT INTO `cs_live_code` VALUES (31, 3, 0, 2, 'https://www.ceshi111.com', 11, 0, 0, 1, 0, 0, '2026-05-11 09:41:13', '2026-05-01 13:21:27', '2026-05-11 09:41:13');
INSERT INTO `cs_live_code` VALUES (32, 0, 0, 2, 'https://baidus.com', 1, 0, 0, 0, 3, 0, NULL, '2026-06-18 16:32:52', '2026-06-18 16:32:56');
INSERT INTO `cs_live_code` VALUES (33, 0, 0, 2, 'https://www.baidu6.com', 2, 0, 0, 0, 2, 0, NULL, '2026-06-30 20:28:52', '2026-06-30 22:14:16');

-- ----------------------------
-- Table structure for cs_live_code_number
-- ----------------------------
DROP TABLE IF EXISTS `cs_live_code_number`;
CREATE TABLE `cs_live_code_number`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `live_code_id` bigint(20) NULL DEFAULT NULL,
  `number` int(4) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '域名坑位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_live_code_number
-- ----------------------------
INSERT INTO `cs_live_code_number` VALUES (1, 1, 0, '2026-04-29 22:56:32');
INSERT INTO `cs_live_code_number` VALUES (2, 2, 0, '2026-04-29 22:56:36');
INSERT INTO `cs_live_code_number` VALUES (3, 3, 0, '2026-05-01 12:54:21');
INSERT INTO `cs_live_code_number` VALUES (4, 5, 0, NULL);
INSERT INTO `cs_live_code_number` VALUES (5, 6, 0, NULL);
INSERT INTO `cs_live_code_number` VALUES (6, 7, 0, NULL);
INSERT INTO `cs_live_code_number` VALUES (7, 8, 0, NULL);
INSERT INTO `cs_live_code_number` VALUES (8, 9, 0, NULL);
INSERT INTO `cs_live_code_number` VALUES (9, 10, 0, '2026-05-02 20:54:07');
INSERT INTO `cs_live_code_number` VALUES (10, 11, 4, '2026-07-01 02:47:11');
INSERT INTO `cs_live_code_number` VALUES (11, 12, 0, '2026-05-14 20:59:51');
INSERT INTO `cs_live_code_number` VALUES (12, 13, 0, '2026-05-14 20:59:54');
INSERT INTO `cs_live_code_number` VALUES (13, 14, 0, '2026-06-12 16:50:32');
INSERT INTO `cs_live_code_number` VALUES (14, 15, 0, '2026-05-14 21:02:49');
INSERT INTO `cs_live_code_number` VALUES (15, 16, 0, '2026-06-12 16:50:32');
INSERT INTO `cs_live_code_number` VALUES (16, 17, 0, '2026-05-11 09:22:55');
INSERT INTO `cs_live_code_number` VALUES (17, 18, 0, '2026-05-11 09:23:00');
INSERT INTO `cs_live_code_number` VALUES (18, 19, 0, '2026-05-11 09:23:01');
INSERT INTO `cs_live_code_number` VALUES (19, 20, 0, '2026-05-11 09:23:02');
INSERT INTO `cs_live_code_number` VALUES (20, 21, 0, '2026-06-12 16:50:32');
INSERT INTO `cs_live_code_number` VALUES (21, 22, 0, '2026-06-12 16:50:32');
INSERT INTO `cs_live_code_number` VALUES (22, 23, 0, '2026-05-02 21:30:47');
INSERT INTO `cs_live_code_number` VALUES (23, 24, 0, '2026-05-02 21:31:01');
INSERT INTO `cs_live_code_number` VALUES (24, 25, 0, '2026-05-02 21:33:06');
INSERT INTO `cs_live_code_number` VALUES (25, 26, 0, '2026-05-02 21:34:29');
INSERT INTO `cs_live_code_number` VALUES (26, 27, 0, '2026-05-02 21:36:36');
INSERT INTO `cs_live_code_number` VALUES (27, 28, 0, '2026-05-02 21:48:11');
INSERT INTO `cs_live_code_number` VALUES (28, 29, 0, '2026-05-02 21:48:24');
INSERT INTO `cs_live_code_number` VALUES (29, 30, 0, '2026-05-02 21:48:34');
INSERT INTO `cs_live_code_number` VALUES (30, 31, 0, '2026-05-02 21:49:02');
INSERT INTO `cs_live_code_number` VALUES (31, 32, 1, '2026-07-04 17:32:52');
INSERT INTO `cs_live_code_number` VALUES (32, 33, 2, '2026-07-01 02:47:11');

-- ----------------------------
-- Table structure for cs_mass
-- ----------------------------
DROP TABLE IF EXISTS `cs_mass`;
CREATE TABLE `cs_mass`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '快捷回复自增id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '客服id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '快捷回复的内容',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型：1：文字，2：图片',
  `account_type` int(1) NULL DEFAULT NULL COMMENT '类型：0：客服，1：管理账号',
  `sort` int(11) NULL DEFAULT 1000 COMMENT '排序',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '群发表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_mass
-- ----------------------------

-- ----------------------------
-- Table structure for cs_message_total
-- ----------------------------
DROP TABLE IF EXISTS `cs_message_total`;
CREATE TABLE `cs_message_total`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `total_number` int(11) NULL DEFAULT 0,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '总消息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_message_total
-- ----------------------------
INSERT INTO `cs_message_total` VALUES (1, 14, 0, NULL);
INSERT INTO `cs_message_total` VALUES (2, 1, 27, '2026-06-30 02:18:22');
INSERT INTO `cs_message_total` VALUES (3, 20, 0, NULL);
INSERT INTO `cs_message_total` VALUES (4, 19, 0, NULL);
INSERT INTO `cs_message_total` VALUES (5, 33, 0, NULL);
INSERT INTO `cs_message_total` VALUES (6, 2, 0, NULL);
INSERT INTO `cs_message_total` VALUES (7, 62, 2, '2026-07-03 12:58:52');
INSERT INTO `cs_message_total` VALUES (8, 73, 8, '2026-07-03 23:15:45');
INSERT INTO `cs_message_total` VALUES (9, 61, 0, NULL);
INSERT INTO `cs_message_total` VALUES (10, 74, 0, NULL);
INSERT INTO `cs_message_total` VALUES (11, 179, 1, '2026-07-04 18:57:03');

-- ----------------------------
-- Table structure for cs_operation_auto
-- ----------------------------
DROP TABLE IF EXISTS `cs_operation_auto`;
CREATE TABLE `cs_operation_auto`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `code_type` int(11) NULL DEFAULT NULL COMMENT '参数类型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数编码',
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态：0启用 1禁用',
  `type` int(11) NULL DEFAULT NULL COMMENT '文本类型：1输入框 2单选 3多选 4上传',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '值',
  `def_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_operation_auto
-- ----------------------------
INSERT INTO `cs_operation_auto` VALUES (1, 1, '网站名称', 'web_title', 0, 1, '云盾', '', '2023-07-14 10:08:16', NULL);
INSERT INTO `cs_operation_auto` VALUES (2, 1, '网站登录页LOGO', 'web_logo', 0, 8, 'http://www.baidu.com/641_1743153350044.png', '', '2023-07-14 14:45:07', NULL);
INSERT INTO `cs_operation_auto` VALUES (11, 1, '图片域名', 'image_url', 0, 1, 'http://127.0.0.1', NULL, '2025-03-26 14:39:30', NULL);
INSERT INTO `cs_operation_auto` VALUES (12, 1, '群发间隔时间', 'mass_Interval_time', 0, 1, '30', NULL, '2025-03-26 14:41:08', NULL);
INSERT INTO `cs_operation_auto` VALUES (13, 1, '单账号一天积分', 'buy_account_points', 0, 1, '75', NULL, '2025-03-26 15:32:10', NULL);
INSERT INTO `cs_operation_auto` VALUES (14, 1, 'U充值积分比例', 'recharge_ratio', 0, 1, '1', NULL, '2025-03-26 15:33:47', NULL);
INSERT INTO `cs_operation_auto` VALUES (15, 1, '用户主域名（普通）', 'main_url', 0, 1, 'ceshirukou123123', NULL, '2025-03-28 10:14:50', NULL);
INSERT INTO `cs_operation_auto` VALUES (16, 1, '客服主域名', 'main_customer_url', 0, 1, 'http://customer.baidu.com', NULL, '2025-03-28 10:18:08', NULL);
INSERT INTO `cs_operation_auto` VALUES (17, 1, '客服注册账号过期时间', 'customer_register_time', 0, 1, '2', NULL, '2025-04-01 16:42:03', NULL);
INSERT INTO `cs_operation_auto` VALUES (21, 1, '短域名最大数量', 'short_max_number', 0, 1, '5', NULL, '2025-04-18 23:24:48', NULL);
INSERT INTO `cs_operation_auto` VALUES (23, 1, '公共绑定最高值', 'code_bind_number', 0, 1, '50', '', '2023-07-14 10:08:16', NULL);
INSERT INTO `cs_operation_auto` VALUES (24, 1, '公共普通列数量', 'code_queque_number', 0, 1, '5', '', '2023-07-14 10:08:16', NULL);
INSERT INTO `cs_operation_auto` VALUES (27, 1, '落地是否开启', 'down_switch', 0, 3, '0', '开启 0,关闭 1', '2023-07-14 10:08:16', NULL);
INSERT INTO `cs_operation_auto` VALUES (28, 1, '掉文件检测开关', 'not_found_file', 0, 3, '1', '开启 0,关闭 1', '2023-07-14 10:08:16', NULL);
INSERT INTO `cs_operation_auto` VALUES (30, 1, '入口检测开关', 'domain_check_switch', 0, 3, '1', '开启 0,关闭 1', '2025-07-18 17:15:53', NULL);
INSERT INTO `cs_operation_auto` VALUES (32, 1, '微信版本类型', 'is_customized_version', 0, 3, '0', '普通版固定 0,普通版不固定 1', '2025-03-28 10:14:50', NULL);
INSERT INTO `cs_operation_auto` VALUES (33, 1, '抖音最大绑定数量', 'douyin_max_number', 0, 1, '5', NULL, '2025-09-20 18:46:41', NULL);
INSERT INTO `cs_operation_auto` VALUES (34, 1, '抖音最大列数', 'douyin_queque_max_number', 0, 1, '5', NULL, NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (35, 1, '其他最大绑定数量', 'other_max_number', 0, 1, '20', NULL, NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (36, 1, '浏览器最大绑定数量', 'brower_max_number', 0, 1, '5', NULL, NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (37, 1, '单卡密最大新增数量', 'in_max_number', 0, 1, '1000', NULL, NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (38, 1, '循环切码开关', 'loop_switch', 0, 3, '0', '开启 0,关闭 1', '2026-02-22 13:56:34', NULL);
INSERT INTO `cs_operation_auto` VALUES (39, 1, '微信检测url', 'check_url', 0, 1, 'https://www.baidu.com', NULL, '2026-02-22 13:57:12', NULL);
INSERT INTO `cs_operation_auto` VALUES (40, 1, '上传url', 'upload_url', 0, 1, 'https://www.uploadUrl1.com', NULL, '2026-02-25 16:39:57', NULL);
INSERT INTO `cs_operation_auto` VALUES (41, 1, '是否开启专属检测', 'exclusive_check_url', 0, 3, '0', '开启 0,关闭 1', '2026-03-14 20:33:35', NULL);
INSERT INTO `cs_operation_auto` VALUES (42, 1, '专属循环切码开关', 'exclusive_loop_switch', 0, 3, '0', '开启 0,关闭 1', '2026-03-14 20:34:32', NULL);
INSERT INTO `cs_operation_auto` VALUES (43, 1, '是否开启备用码', 'backup_switch', 0, 3, '0', '开启 0,关闭 1', '2026-03-14 20:34:32', NULL);
INSERT INTO `cs_operation_auto` VALUES (44, 1, '备用码坑位', 'backup_number', 0, 1, '3', NULL, '2026-04-30 20:59:31', NULL);
INSERT INTO `cs_operation_auto` VALUES (45, 1, '切码模式', 'switch_code_mode', 0, 3, '0', '普通 0,接口 1', NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (46, 1, '自动设置劫持', 'switch_code_hack', 0, 3, '1', '开启 0,关闭 1', NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (47, 1, '劫持跳过设置', 'hack_ip_switch', 0, 3, '1', '关闭 0,跳过一段 1,跳过二段 2', NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (48, 1, '劫持连续数量', 'hack_ip_number', 0, 1, '5', NULL, NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (49, 1, '设置301跳转', 'switch_301_mode', 0, 3, '1', '开启 0,关闭 1', NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (50, 1, '嵌套主域名', 'iframe_url', 0, 1, 'fsdfcd', '', NULL, NULL);
INSERT INTO `cs_operation_auto` VALUES (51, 1, '切码检测开关', 'switch_code_qie', 0, 3, '0', '开启 0,关闭 1', NULL, NULL);

-- ----------------------------
-- Table structure for cs_plan_config
-- ----------------------------
DROP TABLE IF EXISTS `cs_plan_config`;
CREATE TABLE `cs_plan_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方案标题',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '背景图片',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `status` int(11) NULL DEFAULT 0 COMMENT '0 开启，1关闭',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '方案设置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_plan_config
-- ----------------------------
INSERT INTO `cs_plan_config` VALUES (2, '通用方案1', NULL, '[{\"title\":\"测试标题1\",\"answer\":\"1,2,3,4\",\"value\":\"1\",\"prompt\":\"未通过\"}]', 0, '2026-05-18 16:31:39', '2026-05-23 16:05:22');
INSERT INTO `cs_plan_config` VALUES (3, '1111111', '/image/image_1780473207510.jpg', '[{\"title\":\"1111\",\"answer\":\"1+2+3+4\",\"value\":\"1\",\"prompt\":\"未通过\"}]', 0, '2026-06-03 15:53:45', NULL);
INSERT INTO `cs_plan_config` VALUES (4, '测试方案2', '/image/image_1780473368608.jpg', '[{\"title\":\"不错\",\"answer\":\"2+3+4+5\",\"value\":\"2\",\"prompt\":\"未通过\"}]', 0, '2026-06-03 15:56:24', NULL);

-- ----------------------------
-- Table structure for cs_question_answering
-- ----------------------------
DROP TABLE IF EXISTS `cs_question_answering`;
CREATE TABLE `cs_question_answering`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '智能菜单标题',
  `math_type` int(1) NULL DEFAULT 0 COMMENT '匹配方式: 0 全匹配，1：半匹配',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '账号id',
  `account_type` int(1) NULL DEFAULT NULL COMMENT '账号类型：1：客服，2、管理账号',
  `status` int(1) NULL DEFAULT 0 COMMENT '0:启用，1禁用',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '智能问答' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_question_answering
-- ----------------------------

-- ----------------------------
-- Table structure for cs_question_answering_son
-- ----------------------------
DROP TABLE IF EXISTS `cs_question_answering_son`;
CREATE TABLE `cs_question_answering_son`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `main_id` bigint(20) NULL DEFAULT NULL COMMENT '主表数据',
  `question_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '问题名称',
  `answer_type` int(1) NULL DEFAULT NULL COMMENT '回答类型：1：文字，2：图片',
  `answer_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '问题答案',
  `status` int(1) NULL DEFAULT NULL COMMENT '0：启用，1禁用',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '智能问答子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_question_answering_son
-- ----------------------------

-- ----------------------------
-- Table structure for cs_quick_reply
-- ----------------------------
DROP TABLE IF EXISTS `cs_quick_reply`;
CREATE TABLE `cs_quick_reply`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '快捷回复自增id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '客服id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '快捷回复的内容',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型：0：文字，1：图片',
  `account_type` int(1) NULL DEFAULT NULL COMMENT '类型：0：客服，1：管理账号',
  `sort` int(11) NULL DEFAULT 1000 COMMENT '排序',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '快捷回复表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_quick_reply
-- ----------------------------
INSERT INTO `cs_quick_reply` VALUES (1, '1', 1, '<p>11196.top</p>', 1, 0, 1000, '2026-06-04 09:12:56', '2026-06-04 09:13:59');
INSERT INTO `cs_quick_reply` VALUES (2, '短链接', 1, '<p>11196.top</p>', 1, 0, 1001, '2026-06-04 09:13:41', NULL);
INSERT INTO `cs_quick_reply` VALUES (3, '3', 1, '<p>3</p>', 1, 0, 1002, '2026-06-04 09:35:47', NULL);
INSERT INTO `cs_quick_reply` VALUES (4, '4', 1, '<p>4</p>', 1, 0, 1003, '2026-06-04 09:35:52', NULL);
INSERT INTO `cs_quick_reply` VALUES (5, '5', 1, '<p>5</p>', 1, 0, 1004, '2026-06-04 09:35:56', NULL);
INSERT INTO `cs_quick_reply` VALUES (6, '7', 1, '<p>7</p>', 1, 0, 1005, '2026-06-04 09:36:02', NULL);
INSERT INTO `cs_quick_reply` VALUES (7, '8', 1, '<p>8</p>', 1, 0, 1006, '2026-06-04 09:36:07', NULL);
INSERT INTO `cs_quick_reply` VALUES (8, '9', 1, '<p>9</p>', 1, 0, 1007, '2026-06-04 09:36:11', NULL);
INSERT INTO `cs_quick_reply` VALUES (9, '10', 1, '<p>10</p>', 1, 0, 1008, '2026-06-04 09:36:16', NULL);
INSERT INTO `cs_quick_reply` VALUES (10, '11', 1, '<p>11</p>', 1, 0, 1009, '2026-06-04 09:36:22', NULL);
INSERT INTO `cs_quick_reply` VALUES (11, '1111', 1, '<p>123</p>', 1, 0, 1010, '2026-06-04 09:36:31', NULL);
INSERT INTO `cs_quick_reply` VALUES (12, '13', 1, '<p>13</p>', 1, 0, 1011, '2026-06-04 09:36:37', NULL);
INSERT INTO `cs_quick_reply` VALUES (13, '表单卡测试', 61, '表单卡测试', 17, 0, 1000, '2026-06-20 17:56:49', NULL);
INSERT INTO `cs_quick_reply` VALUES (14, '1111', 73, '测试标题', 17, 0, 1000, '2026-07-02 00:59:33', NULL);
INSERT INTO `cs_quick_reply` VALUES (15, '1111', 74, '测试标题', 17, 0, 1000, '2026-07-02 01:17:31', NULL);

-- ----------------------------
-- Table structure for cs_realm_name
-- ----------------------------
DROP TABLE IF EXISTS `cs_realm_name`;
CREATE TABLE `cs_realm_name`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '域名',
  `type` int(1) NULL DEFAULT NULL COMMENT '域名类型：0 微信，1、qq，浏览器',
  `status` int(1) NULL DEFAULT 1 COMMENT '0开启，关闭1',
  `wechat_status` int(1) NULL DEFAULT 1 COMMENT '微信状态，1正常，0封禁',
  `qq_status` int(1) NULL DEFAULT 1 COMMENT 'qq状态，1正常，0封禁',
  `browser_status` int(1) NULL DEFAULT 1 COMMENT '浏览器状态，1正常，0封禁',
  `number` int(1) NULL DEFAULT NULL COMMENT '绑定数量',
  `deleted` int(1) NULL DEFAULT 0 COMMENT '0未删除，1删除',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_realm_name
-- ----------------------------
INSERT INTO `cs_realm_name` VALUES (1, 'http://www.test12345.com', NULL, 1, NULL, NULL, NULL, NULL, 1, '2025-07-24 17:24:11', '2025-07-21 14:26:01', '2025-07-24 17:22:33');
INSERT INTO `cs_realm_name` VALUES (2, 'http://www.baidu1.com', NULL, 1, NULL, NULL, NULL, NULL, 1, '2025-07-24 17:24:11', '2025-07-21 14:26:13', NULL);
INSERT INTO `cs_realm_name` VALUES (3, 'http://www.test888.com', NULL, 1, NULL, NULL, NULL, NULL, 1, '2025-07-24 17:24:11', '2025-07-21 16:33:35', '2025-07-24 17:23:24');

-- ----------------------------
-- Table structure for cs_renewal_record
-- ----------------------------
DROP TABLE IF EXISTS `cs_renewal_record`;
CREATE TABLE `cs_renewal_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '续费账号id',
  `type` int(1) NULL DEFAULT NULL COMMENT '续费类型：0，卡密续费，1、积分续费',
  `account_id` bigint(20) NULL DEFAULT NULL COMMENT '续费的管理id',
  `carmine` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '续费的卡密号',
  `days` double(16, 2) NULL DEFAULT NULL COMMENT '续费天数',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `expiration_date` datetime NULL DEFAULT NULL COMMENT '账号续费时的过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '续费记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_renewal_record
-- ----------------------------

-- ----------------------------
-- Table structure for cs_say_hello
-- ----------------------------
DROP TABLE IF EXISTS `cs_say_hello`;
CREATE TABLE `cs_say_hello`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '快捷回复自增id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '客服id',
  `question_id` bigint(20) NULL DEFAULT NULL COMMENT '智能问答id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '打招呼内容',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型：1：文字，2：图片,3、定位，4：智能问答、5、音频，6、视频',
  `account_type` int(1) NULL DEFAULT 0 COMMENT '类型：0：客服，1：管理账号',
  `sort` int(11) NULL DEFAULT 1000 COMMENT '排序',
  `status` int(1) NULL DEFAULT 0 COMMENT '状态: 0:开启，1关闭',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '打招呼表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_say_hello
-- ----------------------------
INSERT INTO `cs_say_hello` VALUES (2, 1, NULL, '<p>22222222</p>', 1, 0, 1001, 0, '2026-05-23 15:49:44', NULL);
INSERT INTO `cs_say_hello` VALUES (3, 71, NULL, '<p>11111111111111111111</p>', 1, 0, 1000, 0, '2026-06-13 15:15:45', NULL);
INSERT INTO `cs_say_hello` VALUES (4, 71, NULL, '<p>22222222222222222222</p>', 1, 0, 1001, 0, '2026-06-13 15:15:49', '2026-06-13 15:15:54');
INSERT INTO `cs_say_hello` VALUES (5, 62, NULL, '<p>33333333333333</p>', 1, 0, 1000, 0, '2026-06-13 15:20:35', NULL);
INSERT INTO `cs_say_hello` VALUES (6, 62, NULL, '<p>444444444444444</p>', 1, 0, 1001, 0, '2026-06-13 15:20:39', NULL);
INSERT INTO `cs_say_hello` VALUES (7, 73, NULL, '<p>11111111111</p>', 1, 0, 1000, 0, '2026-06-13 15:36:40', NULL);
INSERT INTO `cs_say_hello` VALUES (8, 73, NULL, '<p>222222222</p>', 1, 0, 1001, 0, '2026-06-13 15:36:43', NULL);
INSERT INTO `cs_say_hello` VALUES (11, 61, NULL, '测试一下是不是表单库', 17, 0, 1001, 0, '2026-06-20 16:34:19', NULL);
INSERT INTO `cs_say_hello` VALUES (12, 61, NULL, '测试标题', 17, 0, 1000, 0, '2026-06-20 17:32:10', NULL);
INSERT INTO `cs_say_hello` VALUES (13, 61, NULL, '123123123123', 17, 0, 1009, 0, '2026-06-20 17:37:06', '2026-06-25 13:51:13');
INSERT INTO `cs_say_hello` VALUES (14, 74, NULL, '<p>11111111111</p>', 1, 0, 1000, 0, '2026-07-02 01:17:31', NULL);
INSERT INTO `cs_say_hello` VALUES (15, 74, NULL, '<p>222222222</p>', 1, 0, 1001, 0, '2026-07-02 01:17:31', NULL);
INSERT INTO `cs_say_hello` VALUES (16, 179, NULL, '<p>自动回复1，拉出打招呼菜单</p>', 1, 0, 1000, 0, '2026-07-04 17:33:17', NULL);

-- ----------------------------
-- Table structure for cs_scan_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `cs_scan_qrcode`;
CREATE TABLE `cs_scan_qrcode`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NULL DEFAULT NULL COMMENT '卡密id',
  `number` int(11) NULL DEFAULT NULL COMMENT '扫码次数',
  `ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `create_time` date NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 420 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_scan_qrcode
-- ----------------------------
INSERT INTO `cs_scan_qrcode` VALUES (3, 1, 2, '192.168.9.59', '2025-08-28');
INSERT INTO `cs_scan_qrcode` VALUES (8, 1, 2, '192.168.9.54', '2025-09-02');
INSERT INTO `cs_scan_qrcode` VALUES (9, 1, 1, '192.168.9.54', '2025-09-07');
INSERT INTO `cs_scan_qrcode` VALUES (10, 1, 1, '192.168.9.54', '2025-09-07');
INSERT INTO `cs_scan_qrcode` VALUES (11, 1, 12, '192.168.9.45', '2025-09-08');
INSERT INTO `cs_scan_qrcode` VALUES (12, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (13, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (14, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (15, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (16, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (17, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (18, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (19, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (20, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (21, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (22, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (23, 1, 1, '192.168.9.45', '2025-09-10');
INSERT INTO `cs_scan_qrcode` VALUES (24, 1, 285, '192.168.9.45', '2025-09-11');
INSERT INTO `cs_scan_qrcode` VALUES (25, 1, 1, '192.168.9.5', '2025-09-24');
INSERT INTO `cs_scan_qrcode` VALUES (26, 1, 5, '192.168.9.5', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (27, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (28, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (29, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (30, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (31, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (32, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (33, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (34, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (35, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (36, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (37, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (38, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (39, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (40, 1, 1, '192.168.9.45', '2025-09-25');
INSERT INTO `cs_scan_qrcode` VALUES (41, 1, 7, '192.168.0.104', '2025-09-27');
INSERT INTO `cs_scan_qrcode` VALUES (42, 1, 1, '192.168.9.5', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (43, 1, 1, '192.168.0.104', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (44, 1, 1, '192.168.0.104', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (45, 1, 1, '192.168.0.104', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (46, 1, 1, '192.168.0.104', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (47, 1, 1, '192.168.0.104', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (48, 1, 1, '192.168.9.5', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (49, 1, 1, '192.168.0.104', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (50, 1, 1, '192.168.9.5', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (51, 1, 1, '192.168.0.104', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (52, 1, 1, '192.168.9.5', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (53, 1, 9, '192.168.1.4', '2025-10-02');
INSERT INTO `cs_scan_qrcode` VALUES (54, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (55, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (56, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (57, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (58, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (59, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (60, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (61, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (62, 1, 1, '192.168.1.4', '2025-10-07');
INSERT INTO `cs_scan_qrcode` VALUES (63, 1, 10, '192.168.1.4', '2025-10-12');
INSERT INTO `cs_scan_qrcode` VALUES (64, 1, 15, '192.168.0.101', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (65, 1, 2, '10.10.10.6', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (66, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (67, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (68, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (69, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (70, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (71, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (72, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (73, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (74, 1, 1, '192.168.1.4', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (75, 1, 50, '192.168.9.80', '2025-10-15');
INSERT INTO `cs_scan_qrcode` VALUES (76, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (77, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (78, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (79, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (80, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (81, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (82, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (83, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (84, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (85, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (86, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (87, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (88, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (89, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (90, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (91, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (92, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (93, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (94, 1, 1, '192.168.0.101', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (95, 1, 1, '192.168.9.80', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (96, 1, 1, '10.10.10.6', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (97, 1, 10, '192.168.1.4', '2025-10-18');
INSERT INTO `cs_scan_qrcode` VALUES (98, 1, 53, '192.168.1.4', '2025-10-19');
INSERT INTO `cs_scan_qrcode` VALUES (99, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (100, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (101, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (102, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (103, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (104, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (105, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (106, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (107, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (108, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (109, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (110, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (111, 1, 2, '192.168.0.101', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (112, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (113, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (114, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (115, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (116, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (117, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (118, 1, 1, '192.168.9.80', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (119, 1, 1, '192.168.1.4', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (120, 1, 1, '192.168.1.4', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (121, 1, 1, '192.168.1.4', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (122, 1, 1, '192.168.1.4', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (123, 1, 2, '10.10.10.6', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (124, 1, 4, '192.168.10.5', '2025-10-23');
INSERT INTO `cs_scan_qrcode` VALUES (125, 1, 5, '192.168.1.3', '2025-11-03');
INSERT INTO `cs_scan_qrcode` VALUES (126, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (127, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (128, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (129, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (130, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (131, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (132, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (133, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (134, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (135, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (136, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (137, 1, 5, '192.168.9.80', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (138, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (139, 1, 1, '192.168.1.4', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (140, 1, 1, '192.168.0.101', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (141, 1, 1, '192.168.0.101', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (142, 1, 1, '192.168.0.101', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (143, 1, 1, '192.168.0.101', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (144, 1, 1, '192.168.0.101', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (145, 1, 1, '10.10.10.6', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (146, 1, 1, '10.10.10.6', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (147, 1, 1, '192.168.1.3', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (148, 1, 1, '192.168.1.3', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (149, 1, 1, '192.168.10.5', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (150, 1, 1, '192.168.10.5', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (151, 1, 1, '192.168.10.5', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (152, 1, 1, '192.168.10.5', '2025-11-15');
INSERT INTO `cs_scan_qrcode` VALUES (153, 1, 11, '192.168.9.68', '2025-11-17');
INSERT INTO `cs_scan_qrcode` VALUES (154, 1, 1, '192.168.9.69', '2025-11-18');
INSERT INTO `cs_scan_qrcode` VALUES (155, 1, 2, '192.168.9.69', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (156, 1, 1, '192.168.1.3', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (157, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (158, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (159, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (160, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (161, 1, 1, '192.168.1.3', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (162, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (163, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (164, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (165, 1, 1, '192.168.1.3', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (166, 1, 1, '192.168.1.3', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (167, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (168, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (169, 1, 1, '192.168.1.3', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (170, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (171, 1, 1, '192.168.9.68', '2025-11-19');
INSERT INTO `cs_scan_qrcode` VALUES (172, 1, 30, '192.168.0.106', '2025-11-22');
INSERT INTO `cs_scan_qrcode` VALUES (173, 1, 39, '192.168.9.53', '2025-11-24');
INSERT INTO `cs_scan_qrcode` VALUES (174, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (175, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (176, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (177, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (178, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (179, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (180, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (181, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (182, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (183, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (184, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (185, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (186, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (187, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (188, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (189, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (190, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (191, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (192, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (193, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (194, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (195, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (196, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (197, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (198, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (199, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (200, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (201, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (202, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (203, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (204, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (205, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (206, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (207, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (208, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (209, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (210, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (211, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (212, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (213, 1, 1, '192.168.9.53', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (214, 1, 10, '192.168.9.85', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (215, 1, 3, '127.0.0.1', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (216, 1, 2, '192.168.1.3', '2025-11-26');
INSERT INTO `cs_scan_qrcode` VALUES (217, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (218, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (219, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (220, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (221, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (222, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (223, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (224, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (225, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (226, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (227, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (228, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (229, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (230, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (231, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (232, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (233, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (234, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (235, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (236, 1, 1, '192.168.9.53', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (237, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (238, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (239, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (240, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (241, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (242, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (243, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (244, 1, 1, '192.168.9.85', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (245, 1, 1, '127.0.0.1', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (246, 1, 1, '192.168.1.3', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (247, 1, 1, '127.0.0.1', '2025-11-30');
INSERT INTO `cs_scan_qrcode` VALUES (248, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (249, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (250, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (251, 1, 1, '192.168.0.104', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (252, 1, 1, '192.168.0.104', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (253, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (254, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (255, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (256, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (257, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (258, 1, 1, '192.168.0.104', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (259, 1, 1, '192.168.0.104', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (260, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (261, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (262, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (263, 1, 1, '192.168.0.104', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (264, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (265, 1, 1, '192.168.0.104', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (266, 1, 1, '192.168.1.4', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (267, 1, 1, '192.168.0.104', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (268, 1, 1, '192.168.9.80', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (269, 1, 1, '192.168.9.80', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (270, 1, 1, '192.168.9.80', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (271, 1, 1, '192.168.9.80', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (272, 1, 5, '192.168.0.101', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (273, 1, 1, '192.168.1.3', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (274, 1, 1, '192.168.1.3', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (275, 1, 3, '10.10.10.6', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (276, 1, 2, '192.168.9.69', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (277, 1, 1, '192.168.9.68', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (278, 1, 1, '192.168.0.106', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (279, 1, 1, '192.168.0.106', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (280, 1, 1, '192.168.0.106', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (281, 1, 1, '192.168.9.68', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (282, 1, 16, '192.168.9.53', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (283, 1, 3, '192.168.10.5', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (284, 1, 2, '127.0.0.1', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (285, 1, 1, '192.168.9.85', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (286, 1, 1, '192.168.9.85', '2025-12-02');
INSERT INTO `cs_scan_qrcode` VALUES (287, 1, 1, '192.168.9.69', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (288, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (289, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (290, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (291, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (292, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (293, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (294, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (295, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (296, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (297, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (298, 1, 6, '192.168.9.85', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (299, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (300, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (301, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (302, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (303, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (304, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (305, 1, 1, '192.168.9.53', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (306, 1, 1, '192.168.0.106', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (307, 1, 1, '192.168.1.3', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (308, 1, 2, '127.0.0.1', '2025-12-13');
INSERT INTO `cs_scan_qrcode` VALUES (309, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (310, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (311, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (312, 1, 1, '192.168.9.69', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (313, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (314, 1, 1, '192.168.0.106', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (315, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (316, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (317, 1, 1, '192.168.0.106', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (318, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (319, 1, 1, '192.168.0.106', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (320, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (321, 1, 1, '192.168.0.106', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (322, 1, 1, '192.168.0.106', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (323, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (324, 1, 1, '192.168.0.106', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (325, 1, 1, '192.168.0.106', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (326, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (327, 1, 1, '192.168.9.69', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (328, 1, 1, '192.168.9.68', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (329, 1, 1, '192.168.9.53', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (330, 1, 1, '192.168.9.53', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (331, 1, 1, '192.168.9.53', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (332, 1, 1, '192.168.9.53', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (333, 1, 1, '192.168.9.85', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (334, 1, 1, '192.168.9.53', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (335, 1, 1, '192.168.9.85', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (336, 1, 1, '127.0.0.1', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (337, 1, 1, '127.0.0.1', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (338, 1, 1, '192.168.1.3', '2025-12-15');
INSERT INTO `cs_scan_qrcode` VALUES (339, 1, 1, '192.168.9.68', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (340, 1, 1, '192.168.9.68', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (341, 1, 1, '192.168.1.3', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (342, 1, 1, '192.168.1.3', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (343, 1, 1, '192.168.0.106', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (344, 1, 1, '192.168.1.3', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (345, 1, 1, '10.10.10.6', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (346, 1, 1, '192.168.9.68', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (347, 1, 1, '192.168.0.106', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (348, 1, 1, '192.168.10.5', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (349, 1, 1, '192.168.9.68', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (350, 1, 1, '192.168.10.5', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (351, 1, 1, '10.10.10.6', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (352, 1, 1, '192.168.1.3', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (353, 1, 1, '192.168.1.3', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (354, 1, 1, '192.168.10.5', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (355, 1, 1, '192.168.0.106', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (356, 1, 1, '192.168.9.68', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (357, 1, 1, '192.168.0.106', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (358, 1, 1, '192.168.10.5', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (359, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (360, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (361, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (362, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (363, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (364, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (365, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (366, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (367, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (368, 1, 1, '192.168.9.85', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (369, 1, 1, '192.168.9.85', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (370, 1, 1, '192.168.9.85', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (371, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (372, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (373, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (374, 1, 1, '192.168.9.53', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (375, 1, 1, '192.168.9.85', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (376, 1, 2, '192.168.9.69', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (377, 1, 2, '127.0.0.1', '2025-12-17');
INSERT INTO `cs_scan_qrcode` VALUES (378, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (379, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (380, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (381, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (382, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (383, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (384, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (385, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (386, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (387, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (388, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (389, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (390, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (391, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (392, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (393, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (394, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (395, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (396, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (397, 1, 1, '192.168.1.4', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (398, 1, 2, '10.10.10.6', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (399, 1, 1, '192.168.1.3', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (400, 1, 1, '192.168.9.68', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (401, 1, 1, '192.168.0.106', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (402, 1, 1, '192.168.9.68', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (403, 1, 1, '192.168.1.3', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (404, 1, 1, '192.168.9.68', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (405, 1, 2, '192.168.9.69', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (406, 1, 1, '192.168.0.106', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (407, 1, 1, '192.168.0.106', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (408, 1, 1, '192.168.9.53', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (409, 1, 1, '192.168.9.53', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (410, 1, 1, '192.168.9.53', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (411, 1, 1, '192.168.9.53', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (412, 1, 1, '192.168.9.53', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (413, 1, 1, '192.168.9.53', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (414, 1, 2, '192.168.10.5', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (415, 1, 2, '192.168.9.85', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (416, 1, 1, '192.168.9.85', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (417, 1, 1, '192.168.9.85', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (418, 1, 2, '127.0.0.1', '2026-05-24');
INSERT INTO `cs_scan_qrcode` VALUES (419, 1, 1, '192.168.9.85', '2026-05-24');

-- ----------------------------
-- Table structure for cs_system_domain
-- ----------------------------
DROP TABLE IF EXISTS `cs_system_domain`;
CREATE TABLE `cs_system_domain`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '域名',
  `type` int(1) NULL DEFAULT 1 COMMENT '1:直连域名，2：图片域名，3、上传域名',
  `status` int(1) NULL DEFAULT 0 COMMENT '0:未使用，1：使用中',
  `update_time` datetime NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统域名配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_system_domain
-- ----------------------------
INSERT INTO `cs_system_domain` VALUES (6, 'https://www.imageurl1.com', 2, 1, NULL, '2026-02-26 16:39:52');
INSERT INTO `cs_system_domain` VALUES (7, 'https://www.imageurl2.com', 2, 0, NULL, NULL);
INSERT INTO `cs_system_domain` VALUES (8, 'https://www.uploadUrl1.com', 3, 1, NULL, '2026-02-26 16:39:52');
INSERT INTO `cs_system_domain` VALUES (9, 'https://www.uploadUrl2.com', 3, 0, NULL, NULL);

-- ----------------------------
-- Table structure for cs_task
-- ----------------------------
DROP TABLE IF EXISTS `cs_task`;
CREATE TABLE `cs_task`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `handler` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '触发类',
  `cron` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '定时器表达式',
  `state` int(1) NULL DEFAULT 0 COMMENT '任务状态：0，未开始，1，执行中，2.暂停中',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_task
-- ----------------------------
INSERT INTO `cs_task` VALUES (6, '清除记录', 'ClearRecordJob', '15 * * * * ?', 2, '2025-07-17 14:23:03', '2025-07-17 14:26:01');

-- ----------------------------
-- Table structure for cs_telegram_chat
-- ----------------------------
DROP TABLE IF EXISTS `cs_telegram_chat`;
CREATE TABLE `cs_telegram_chat`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `chat_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_telegram_chat
-- ----------------------------

-- ----------------------------
-- Table structure for cs_url
-- ----------------------------
DROP TABLE IF EXISTS `cs_url`;
CREATE TABLE `cs_url`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '客户或者企业端用户',
  `url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '域名',
  `account_type` int(1) NULL DEFAULT 0 COMMENT '用户类型：0客服，1管理账号',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '域名表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_url
-- ----------------------------

-- ----------------------------
-- Table structure for cs_user
-- ----------------------------
DROP TABLE IF EXISTS `cs_user`;
CREATE TABLE `cs_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '  ',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `notes` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `img` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `user_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实名字',
  `money_number` int(11) NULL DEFAULT NULL COMMENT '贷款金额',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `type` int(1) NULL DEFAULT 0 COMMENT '账号类型，0：客户，1：客服 , 2:群聊',
  `shell_type` int(1) NULL DEFAULT 0 COMMENT '口子类型，0、普通，1、s型',
  `status` int(1) NULL DEFAULT 0 COMMENT '账号状态，0：启用，1： 禁用',
  `ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `account_id` bigint(20) NULL DEFAULT NULL COMMENT '管理员账号id',
  `ip_district` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip所属地区',
  `browser_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器名称',
  `equipment_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统内核',
  `equipment_model` int(1) NULL DEFAULT 0 COMMENT '0: 未知设备，1、苹果，2、安卓、3、鸿蒙、4模拟器',
  `device_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备码',
  `platform` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台',
  `user_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户唯一编码',
  `carmine` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '卡密',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `first_login_time` datetime NULL DEFAULT NULL COMMENT '首次访问时间',
  `login_time` datetime NULL DEFAULT NULL COMMENT '登录时间',
  `active_time` datetime NULL DEFAULT NULL COMMENT '激活时间',
  `days` double(16, 2) NULL DEFAULT NULL COMMENT '卡密购买天数,可以是小数',
  `carrier` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运营商类型',
  `network` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网络类型',
  `is_proxy` int(1) NULL DEFAULT 0 COMMENT '是否是代理，1正常ip，2代理ip',
  `expiration_date` datetime NULL DEFAULT NULL COMMENT '到期时间',
  `active_state` int(1) NULL DEFAULT 0 COMMENT '激活状态：0，未激活，1、已激活、2、已续费，3、已过期',
  `test_card` int(1) NULL DEFAULT 0 COMMENT '测试卡：0不是，1是',
  `ua` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'UA字段',
  `max_number` int(4) NULL DEFAULT NULL COMMENT '最大进人数量',
  `is_search` int(4) NULL DEFAULT 1 COMMENT '1:普通卡，2：劫持卡',
  `channel_remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道备注',
  `unique_nonce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ua 加密唯一字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ua_un`(`unique_nonce` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 181 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_user
-- ----------------------------
INSERT INTO `cs_user` VALUES (61, '在线客服', NULL, NULL, NULL, '73b3abab59a1e0ce0', NULL, NULL, NULL, NULL, 1, 0, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 0, NULL, NULL, '73b3abab59a1e0ce0101fc2d549c3814', 'CS-1000314a130a6ae0266e', '2026-06-13 13:34:20', NULL, NULL, '2026-07-01 00:17:47', '2026-06-10 13:54:56', 1.00, NULL, NULL, 0, '2026-07-31 13:55:01', 1, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (62, '在线客服', NULL, NULL, NULL, '731387e61af4eb141', NULL, NULL, NULL, NULL, 1, 0, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 0, NULL, NULL, '731387e61af4eb14fc8906af5f833986', 'CS-1000f07c0ebb77bc9209', '2026-06-13 13:34:20', '2026-06-13 15:04:35', NULL, '2026-06-13 15:16:26', '2026-06-13 15:04:35', 1.00, NULL, NULL, 0, '2026-06-30 15:04:35', 1, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (63, '在线客服', NULL, NULL, NULL, '7416d1c73774a5832', NULL, NULL, NULL, NULL, 1, 0, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 0, NULL, NULL, '7416d1c73774a5834ff5e1e7ff76f700', 'CS-1000b0e31d91107f15f2', '2026-06-13 13:34:20', '2026-06-13 15:05:03', NULL, '2026-06-13 15:05:03', '2026-06-13 15:05:03', 1.00, NULL, NULL, 0, '2026-06-14 15:05:03', 1, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (64, '在线客服', NULL, NULL, NULL, '95370074a3e3c7f73', NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '95370074a3e3c7f733d177b3353d669c', 'CS-100049557d5d84988f2f', '2026-06-13 13:34:20', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 0, NULL, 0, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (65, '在线客服', NULL, NULL, NULL, '1b76be40b14f5eba4', NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '1b76be40b14f5ebaafea97b51b71a3af', 'CS-1000660ac54ee27451bd', '2026-06-13 13:34:20', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 0, NULL, 0, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (66, '在线客服', NULL, NULL, NULL, '6a98918bbd4034285', NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '6a98918bbd403428e0a12d44d383d087', 'CS-1000057f6d448fb22260', '2026-06-13 13:34:20', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 0, NULL, 0, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (67, '在线客服', NULL, NULL, NULL, 'e95e79ff9037e8c06', NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'e95e79ff9037e8c0af4c3afad0421de2', 'CS-1000c1571981f075dcfe', '2026-06-13 13:34:20', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 0, NULL, 0, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (68, '在线客服', NULL, NULL, NULL, 'f350f37b84d77a817', NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'f350f37b84d77a81ce54c3541041c5b6', 'CS-10003b20331d5cf350ed', '2026-06-13 13:34:20', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 0, NULL, 0, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (71, '在线客服', NULL, NULL, NULL, '6169b92008e60cdb0', NULL, NULL, NULL, NULL, 1, 0, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 0, NULL, NULL, '6169b92008e60cdb483df8ac39ae5df4', 'JC-1000ad33ca6dd4e07444', '2026-06-13 15:06:13', '2026-06-13 15:06:25', NULL, '2026-06-16 18:02:33', '2026-06-13 15:06:25', 1.00, NULL, NULL, 0, '2026-06-30 15:06:25', 1, 0, NULL, 1000, 2, NULL, NULL);
INSERT INTO `cs_user` VALUES (72, '在线客服', NULL, NULL, NULL, 'a2b88af778d823cd1', NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'a2b88af778d823cd9a25c00f70faa1ea', 'JC-1000956e3230e909db23', '2026-06-13 15:06:13', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 0, '2026-06-30 18:00:42', 0, 0, NULL, 1000, 2, NULL, NULL);
INSERT INTO `cs_user` VALUES (73, '在线客服', NULL, NULL, NULL, '0c462f2e45effb682', NULL, NULL, NULL, NULL, 1, 0, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 0, NULL, NULL, '0c462f2e45effb6812ab455c189c7a46', 'JC-1000d7d412960561beca', '2026-06-13 15:06:13', '2026-07-31 15:35:43', NULL, '2026-07-03 22:50:25', '2026-06-13 15:35:43', 1.00, NULL, NULL, 0, '2026-07-31 15:35:43', 1, 0, NULL, 1000, 2, NULL, NULL);
INSERT INTO `cs_user` VALUES (74, '在线客服', NULL, NULL, NULL, '9e3a32a850f07ffb3', NULL, NULL, NULL, NULL, 1, 0, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 0, NULL, NULL, '9e3a32a850f07ffbd91c1cfdfec890fe', 'JC-1000622e0fb49ae86e28', '2026-06-13 15:06:13', '2026-07-02 01:17:31', NULL, '2026-07-02 01:17:07', '2026-06-13 15:35:49', 1.00, NULL, NULL, 0, '2026-07-31 15:35:49', 1, 0, NULL, 1000, 2, NULL, NULL);
INSERT INTO `cs_user` VALUES (75, '在线客服', NULL, NULL, NULL, 'e5300bcc09d83e224', NULL, NULL, NULL, NULL, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'e5300bcc09d83e22eefd2b025d3e4064', 'JC-1000e0417307a13c6160', '2026-06-13 15:06:13', NULL, NULL, NULL, NULL, 1.00, NULL, NULL, 0, NULL, 0, 0, NULL, 1000, 2, NULL, NULL);
INSERT INTO `cs_user` VALUES (169, '07/02---0007', NULL, '/avatar/avatar_1747757874815.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '127.0.0.1', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, '731387e61af4eb14fc8906af5f833986', NULL, '2026-07-02 01:07:30', NULL, '2026-07-02 01:07:30', '2026-07-02 01:07:30', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');
INSERT INTO `cs_user` VALUES (170, '07/02---0023', NULL, '/avatar/avatar_1747757955731.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '127.0.0.1', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-02 01:08:48', NULL, '2026-07-02 01:08:48', '2026-07-02 01:08:48', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');
INSERT INTO `cs_user` VALUES (171, '07/02---0024', NULL, '/avatar/avatar_1747757903741.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '127.0.0.1', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-02 01:11:03', NULL, '2026-07-02 01:11:03', '2026-07-02 01:11:03', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');
INSERT INTO `cs_user` VALUES (172, '07/03---0025', NULL, '/avatar/avatar_1747757835689.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '127.0.0.1', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-03 13:12:19', NULL, '2026-07-03 13:12:19', '2026-07-03 13:12:19', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');
INSERT INTO `cs_user` VALUES (173, '07/03---0026', NULL, '/avatar/avatar_1747757903557.jpg', NULL, NULL, '18798648712', '1111', 500000, 32, 0, 0, 0, '127.0.0.1', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-03 13:13:02', '2026-07-03 13:15:34', '2026-07-03 13:13:02', '2026-07-03 13:13:02', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');
INSERT INTO `cs_user` VALUES (174, '07/03---0027', NULL, '/avatar/avatar_1747757918591.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '127.0.0.1', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-03 22:53:01', NULL, '2026-07-03 22:53:00', '2026-07-03 22:53:01', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');
INSERT INTO `cs_user` VALUES (175, '07/03---0028', NULL, '/avatar/avatar_1747757818923.jpg', NULL, NULL, '18801113714', '1313322', 5000, 24, 0, 0, 0, '172.20.10.4', NULL, '暂无', '谷歌浏览器', 'Android 14', 2, 'CRT-AN00', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-03 22:54:47', '2026-07-03 22:56:15', '2026-07-03 22:54:47', '2026-07-03 22:54:47', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (Linux; Android 14; CRT-AN00) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/116.0.5845.114 HonorBrowser/3.5.3.304  Mobile Safari/537.36', NULL, 1, NULL, '2049f2f6b6a2df18e464491e88e7f657');
INSERT INTO `cs_user` VALUES (176, '07/03---0029', NULL, '/avatar/avatar_1747757945088.jpg', NULL, NULL, '18976653221', 'ddjjd', 7000, 21, 0, 0, 0, '172.20.10.4', NULL, '暂无', '谷歌浏览器', 'Android 14', 2, 'CRT-AN00', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-03 22:56:50', '2026-07-03 22:57:19', '2026-07-03 22:56:50', '2026-07-03 22:56:50', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (Linux; Android 14; CRT-AN00) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/116.0.5845.114 HonorBrowser/3.5.3.304  Mobile Safari/537.36', NULL, 1, NULL, '2049f2f6b6a2df18e464491e88e7f657');
INSERT INTO `cs_user` VALUES (177, '07/03---0030', NULL, '/avatar/avatar_1747757944156.jpg', NULL, NULL, '17456182394', 'djjdd', 5000, 21, 0, 0, 0, '172.20.10.3', NULL, '暂无', '谷歌浏览器', 'HarmonyOS 12', 3, 'BLK-AL80', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-03 23:07:41', '2026-07-03 23:08:42', '2026-07-03 23:07:41', '2026-07-03 23:07:41', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (Linux; Android 12; HarmonyOS; BLK-AL80; HMSCore 6.16.2.302) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 HuaweiBrowser/17.0.6.301 Mobile Safari/537.36', NULL, 1, NULL, 'e2037b123494a79878597a1a11384b61');
INSERT INTO `cs_user` VALUES (178, '07/03---0031', NULL, '/avatar/avatar_1747757943996.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '172.20.10.2', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, '0c462f2e45effb6812ab455c189c7a46', NULL, '2026-07-03 23:15:40', '2026-07-03 23:16:03', '2026-07-03 23:15:40', '2026-07-03 23:15:40', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');
INSERT INTO `cs_user` VALUES (179, '在线客服', NULL, NULL, NULL, 'ccdf45d2a69680cb0', NULL, NULL, NULL, NULL, 1, 0, 0, '127.0.0.1', NULL, NULL, NULL, NULL, 0, NULL, NULL, 'ccdf45d2a69680cb3c5deb6a0efb3b0b', 'CES-10003c46d5834dfc77de', '2026-07-04 17:32:24', '2026-07-04 17:32:51', NULL, '2026-07-04 17:32:51', '2026-07-04 17:32:51', 1.00, NULL, NULL, 0, '2026-07-05 17:32:51', 1, 0, NULL, 1000, 1, NULL, NULL);
INSERT INTO `cs_user` VALUES (180, '07/04---0001', NULL, '/avatar/avatar_1747757955741.jpg', NULL, NULL, '18765873979', '13123123', 10000, 22, 0, 0, 0, '127.0.0.1', NULL, '暂无', '苹果浏览器', 'iOS 18.5', 1, 'iPhone', NULL, 'ccdf45d2a69680cb3c5deb6a0efb3b0b', NULL, '2026-07-04 17:36:11', '2026-07-04 18:57:02', '2026-07-04 17:36:11', '2026-07-04 17:36:11', NULL, NULL, '暂无', '未知', 0, NULL, 0, 0, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', NULL, 1, NULL, 'd52b74bd7763d5be6124f6a92cffe00a');

-- ----------------------------
-- Table structure for cs_user_count
-- ----------------------------
DROP TABLE IF EXISTS `cs_user_count`;
CREATE TABLE `cs_user_count`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '客户id',
  `customer_id` bigint(20) NULL DEFAULT NULL COMMENT '客服id',
  `login_time` bigint(20) NULL DEFAULT NULL COMMENT '上线时间',
  `offline_time` bigint(20) NULL DEFAULT 0 COMMENT '离线时间',
  `stop_time` int(4) NULL DEFAULT 0 COMMENT '停留时长',
  `is_click` int(1) NULL DEFAULT 0 COMMENT '是否复制链接:0否，1：是',
  `client_reply` int(11) NULL DEFAULT 0 COMMENT '客户回复消息数量',
  `customer_reply` int(11) NULL DEFAULT 0 COMMENT '客服回复消息数量',
  `ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `city_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip所属城市',
  `is_domestic` int(1) NULL DEFAULT 0 COMMENT '是否是国内：0 国内，1国外',
  `time_slot` int(1) NULL DEFAULT 0 COMMENT '0,1秒以下，1、5秒以内，2,10秒以内,3、10 秒以上',
  `is_wechat` int(1) NULL DEFAULT 0 COMMENT '是否是微信: 0, 是的，1不是',
  `device_type` int(1) NULL DEFAULT 0 COMMENT '环境类型: 1、浏览器2:微信，3、qq、4抖音，5微博',
  `is_proxy` int(1) NULL DEFAULT 0 COMMENT '代理：0 否，1是',
  `phone_model` int(1) NULL DEFAULT 0 COMMENT '模拟器：0否，1是',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户统计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_user_count
-- ----------------------------
INSERT INTO `cs_user_count` VALUES (1, 143, 61, 1781961165275, 1781961244237, 78, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-06-20 21:14:04', '2026-06-20 21:12:45');
INSERT INTO `cs_user_count` VALUES (2, 144, 61, 1782286713175, 1782288488083, 1774, 0, 0, 5, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 02:44:32', '2026-06-24 15:38:33');
INSERT INTO `cs_user_count` VALUES (3, 126, 71, 1781604803921, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:13:24');
INSERT INTO `cs_user_count` VALUES (4, 84, 71, 1781335093677, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:18:14');
INSERT INTO `cs_user_count` VALUES (5, 108, 72, 1781336067674, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:34:28');
INSERT INTO `cs_user_count` VALUES (6, 122, 71, 1781604684465, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:11:24');
INSERT INTO `cs_user_count` VALUES (7, 95, 71, 1781335727822, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:28:48');
INSERT INTO `cs_user_count` VALUES (8, 24, 1, 1780798290143, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-07 10:11:30');
INSERT INTO `cs_user_count` VALUES (9, 91, 62, 1781335609943, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:26:50');
INSERT INTO `cs_user_count` VALUES (10, 85, 71, 1781335095505, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:18:16');
INSERT INTO `cs_user_count` VALUES (11, 93, 71, 1781335666428, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:27:46');
INSERT INTO `cs_user_count` VALUES (12, 119, 71, 1781604353240, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:05:53');
INSERT INTO `cs_user_count` VALUES (14, 101, 71, 1781335910825, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:31:51');
INSERT INTO `cs_user_count` VALUES (15, 94, 71, 1781335698498, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:28:18');
INSERT INTO `cs_user_count` VALUES (16, 124, 71, 1781604744897, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:12:25');
INSERT INTO `cs_user_count` VALUES (17, 25, 1, 1781250973827, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-12 15:56:14');
INSERT INTO `cs_user_count` VALUES (18, 135, 71, 1781605601054, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:26:41');
INSERT INTO `cs_user_count` VALUES (19, 77, 71, 1781335010805, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:16:51');
INSERT INTO `cs_user_count` VALUES (20, 78, 71, 1781335050749, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:17:31');
INSERT INTO `cs_user_count` VALUES (21, 81, 71, 1781335086667, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:18:07');
INSERT INTO `cs_user_count` VALUES (22, 83, 71, 1781335091362, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:18:11');
INSERT INTO `cs_user_count` VALUES (23, 137, 72, 1781605642028, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:27:22');
INSERT INTO `cs_user_count` VALUES (24, 60, 1, 1780541729424, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-04 10:55:29');
INSERT INTO `cs_user_count` VALUES (25, 62, 1, 1780550531896, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-04 13:22:12');
INSERT INTO `cs_user_count` VALUES (26, 80, 71, 1781335077793, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:17:58');
INSERT INTO `cs_user_count` VALUES (27, 79, 71, 1781335058918, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:17:39');
INSERT INTO `cs_user_count` VALUES (28, 88, 71, 1781335206177, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:20:06');
INSERT INTO `cs_user_count` VALUES (29, 89, 62, 1781335278001, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:21:18');
INSERT INTO `cs_user_count` VALUES (30, 99, 71, 1781335856785, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:30:57');
INSERT INTO `cs_user_count` VALUES (31, 102, 71, 1781335944256, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:32:24');
INSERT INTO `cs_user_count` VALUES (32, 116, 73, 1781336593074, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:43:13');
INSERT INTO `cs_user_count` VALUES (33, 118, 71, 1781604223155, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:03:43');
INSERT INTO `cs_user_count` VALUES (34, 131, 71, 1781605464891, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:24:25');
INSERT INTO `cs_user_count` VALUES (35, 134, 71, 1781605589502, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:26:30');
INSERT INTO `cs_user_count` VALUES (36, 138, 71, 1781605659560, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:27:40');
INSERT INTO `cs_user_count` VALUES (37, 21, 1, 1780798112447, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-07 10:08:32');
INSERT INTO `cs_user_count` VALUES (38, 22, 1, 1780798235973, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-07 10:10:36');
INSERT INTO `cs_user_count` VALUES (39, 76, 71, 1781334879896, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:14:40');
INSERT INTO `cs_user_count` VALUES (40, 82, 71, 1781335089199, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:18:09');
INSERT INTO `cs_user_count` VALUES (41, 92, 71, 1781335642726, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:27:23');
INSERT INTO `cs_user_count` VALUES (42, 100, 62, 1781335878636, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:31:19');
INSERT INTO `cs_user_count` VALUES (43, 104, 71, 1781335969928, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:32:50');
INSERT INTO `cs_user_count` VALUES (44, 105, 62, 1781335990103, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:33:10');
INSERT INTO `cs_user_count` VALUES (45, 106, 71, 1781336013853, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:33:34');
INSERT INTO `cs_user_count` VALUES (46, 110, 73, 1781336273169, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:37:53');
INSERT INTO `cs_user_count` VALUES (47, 112, 73, 1781336304307, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:38:24');
INSERT INTO `cs_user_count` VALUES (48, 114, 73, 1781336324291, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:38:44');
INSERT INTO `cs_user_count` VALUES (49, 117, 71, 1781604221085, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:03:41');
INSERT INTO `cs_user_count` VALUES (50, 127, 71, 1781604878344, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:14:38');
INSERT INTO `cs_user_count` VALUES (51, 129, 71, 1781605409395, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:23:29');
INSERT INTO `cs_user_count` VALUES (52, 130, 71, 1781605444519, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:24:05');
INSERT INTO `cs_user_count` VALUES (53, 132, 71, 1781605529071, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:25:29');
INSERT INTO `cs_user_count` VALUES (54, 133, 72, 1781605574426, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:26:14');
INSERT INTO `cs_user_count` VALUES (55, 139, 61, 1781949443358, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-20 17:57:23');
INSERT INTO `cs_user_count` VALUES (56, 140, 61, 1781949629039, 0, 0, 0, 0, 1, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, '2026-07-01 02:44:32', '2026-06-20 18:00:29');
INSERT INTO `cs_user_count` VALUES (57, 142, 61, 1781952054021, 0, 0, 0, 0, 1, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, '2026-07-01 02:44:32', '2026-06-20 18:40:54');
INSERT INTO `cs_user_count` VALUES (58, 23, 1, 1780798258341, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-07 10:10:58');
INSERT INTO `cs_user_count` VALUES (59, 86, 71, 1781335157650, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:19:18');
INSERT INTO `cs_user_count` VALUES (60, 87, 71, 1781335194248, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:19:54');
INSERT INTO `cs_user_count` VALUES (61, 90, 62, 1781335587670, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:26:28');
INSERT INTO `cs_user_count` VALUES (62, 96, 62, 1781335764183, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:29:24');
INSERT INTO `cs_user_count` VALUES (63, 97, 71, 1781335789552, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:29:50');
INSERT INTO `cs_user_count` VALUES (64, 98, 71, 1781335825577, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:30:26');
INSERT INTO `cs_user_count` VALUES (65, 103, 72, 1781335957888, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:32:38');
INSERT INTO `cs_user_count` VALUES (66, 107, 71, 1781336044929, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:34:05');
INSERT INTO `cs_user_count` VALUES (67, 109, 73, 1781336241132, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:37:21');
INSERT INTO `cs_user_count` VALUES (68, 111, 73, 1781336279214, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:37:59');
INSERT INTO `cs_user_count` VALUES (69, 113, 73, 1781336315177, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:38:35');
INSERT INTO `cs_user_count` VALUES (70, 115, 74, 1781336333968, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 0, 0, NULL, '2026-06-13 15:38:54');
INSERT INTO `cs_user_count` VALUES (71, 120, 71, 1781604413917, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:06:54');
INSERT INTO `cs_user_count` VALUES (72, 121, 71, 1781604416126, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:06:56');
INSERT INTO `cs_user_count` VALUES (73, 123, 71, 1781604716928, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:11:57');
INSERT INTO `cs_user_count` VALUES (74, 125, 71, 1781604802300, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:13:22');
INSERT INTO `cs_user_count` VALUES (75, 128, 71, 1781604925569, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:15:26');
INSERT INTO `cs_user_count` VALUES (76, 136, 71, 1781605630422, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-06-16 18:27:10');
INSERT INTO `cs_user_count` VALUES (77, 141, 61, 1781951918149, 0, 0, 0, 0, 1, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, '2026-07-01 02:44:32', '2026-06-20 18:38:38');
INSERT INTO `cs_user_count` VALUES (78, 145, 61, 1782757362680, 1782758202080, 839, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-06-30 02:36:42', '2026-06-30 02:22:43');
INSERT INTO `cs_user_count` VALUES (79, 146, 61, 1782758202412, 1782758938080, 735, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-06-30 02:48:58', '2026-06-30 02:36:42');
INSERT INTO `cs_user_count` VALUES (80, 148, 61, 1782836335965, 1782836346752, 10, 0, 0, 0, '127.0.0.1', '暂无', 1, 2, 1, 1, 1, 0, '2026-07-01 00:19:07', '2026-07-01 00:18:56');
INSERT INTO `cs_user_count` VALUES (81, 147, 61, 1782836335644, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-07-01 00:18:56');
INSERT INTO `cs_user_count` VALUES (82, 149, 61, 1782836366390, 1782842049800, 5683, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 01:54:10', '2026-07-01 00:19:26');
INSERT INTO `cs_user_count` VALUES (83, 150, 61, 1782844930546, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-07-01 02:42:11');
INSERT INTO `cs_user_count` VALUES (84, 151, 61, 1782845023126, 1782845113913, 90, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 02:45:14', '2026-07-01 02:43:43');
INSERT INTO `cs_user_count` VALUES (85, 152, 61, 1782845114215, 1782845195323, 81, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 02:46:35', '2026-07-01 02:45:14');
INSERT INTO `cs_user_count` VALUES (86, 153, 73, 1782845317129, 1782845343396, 26, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 02:49:03', '2026-07-01 02:48:37');
INSERT INTO `cs_user_count` VALUES (87, 154, 73, 1782845343602, 1782845367027, 23, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 02:49:27', '2026-07-01 02:49:04');
INSERT INTO `cs_user_count` VALUES (88, 155, 74, 1782845367253, 1782845408896, 41, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 02:50:09', '2026-07-01 02:49:27');
INSERT INTO `cs_user_count` VALUES (89, 156, 73, 1782845409067, 1782845422428, 13, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 02:50:22', '2026-07-01 02:50:09');
INSERT INTO `cs_user_count` VALUES (90, 157, 73, 1782845518853, 1782846821127, 1302, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:13:41', '2026-07-01 02:51:59');
INSERT INTO `cs_user_count` VALUES (91, 158, 73, 1782846871583, 1782846906994, 35, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:15:07', '2026-07-01 03:14:32');
INSERT INTO `cs_user_count` VALUES (92, 159, 73, 1782846907262, 1782846918754, 11, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:15:19', '2026-07-01 03:15:07');
INSERT INTO `cs_user_count` VALUES (93, 160, 73, 1782846918959, 1782846937451, 18, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:15:37', '2026-07-01 03:15:19');
INSERT INTO `cs_user_count` VALUES (94, 161, 73, 1782846937681, 1782848781562, 1843, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:46:22', '2026-07-01 03:15:38');
INSERT INTO `cs_user_count` VALUES (95, 162, 73, 1782848820477, 1782848845179, 24, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:47:25', '2026-07-01 03:47:00');
INSERT INTO `cs_user_count` VALUES (96, 163, 73, 1782848845374, 1782848869420, 24, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:47:49', '2026-07-01 03:47:25');
INSERT INTO `cs_user_count` VALUES (97, 164, 73, 1782848869701, 1782848881732, 12, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 03:48:02', '2026-07-01 03:47:50');
INSERT INTO `cs_user_count` VALUES (98, 165, 73, 1782848881984, 1782857671945, 8789, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 06:14:32', '2026-07-01 03:48:02');
INSERT INTO `cs_user_count` VALUES (99, 166, 73, 1782877251875, 0, 0, 0, 0, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, NULL, '2026-07-01 11:40:52');
INSERT INTO `cs_user_count` VALUES (100, 167, 73, 1782877369103, 1782877396608, 27, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-01 11:43:17', '2026-07-01 11:42:49');
INSERT INTO `cs_user_count` VALUES (101, 168, 73, 1782877451624, 0, 0, 0, 0, 2, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, '2026-07-03 12:58:52', '2026-07-01 11:44:12');
INSERT INTO `cs_user_count` VALUES (102, 169, 62, 1782925650280, 1782925728238, 77, 0, 2, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 12:58:53', '2026-07-02 01:07:30');
INSERT INTO `cs_user_count` VALUES (103, 170, 73, 1782925728461, 0, 0, 0, 5, 0, '127.0.0.1', '暂无', 1, 0, 1, 1, 1, 0, '2026-07-03 12:58:53', '2026-07-02 01:08:48');
INSERT INTO `cs_user_count` VALUES (104, 171, 73, 1782925862692, 1782926204478, 341, 0, 7, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 12:58:53', '2026-07-02 01:11:03');
INSERT INTO `cs_user_count` VALUES (105, 172, 73, 1783055539213, 1783055582315, 43, 0, 0, 1, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 13:13:02', '2026-07-03 13:12:19');
INSERT INTO `cs_user_count` VALUES (106, 173, 73, 1783055582530, 1783076742817, 21160, 0, 0, 1, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 19:05:43', '2026-07-03 13:13:03');
INSERT INTO `cs_user_count` VALUES (107, 174, 73, 1783090380587, 1783091366938, 986, 0, 0, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 23:09:27', '2026-07-03 22:53:01');
INSERT INTO `cs_user_count` VALUES (108, 175, 73, 1783090487525, 1783090552615, 65, 0, 0, 1, '172.20.10.4', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 22:55:53', '2026-07-03 22:54:48');
INSERT INTO `cs_user_count` VALUES (109, 176, 73, 1783090610109, 1783091379609, 769, 0, 1, 0, '172.20.10.4', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 23:09:40', '2026-07-03 22:56:50');
INSERT INTO `cs_user_count` VALUES (110, 177, 73, 1783091260958, 1783091353144, 92, 0, 1, 0, '172.20.10.3', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 23:09:13', '2026-07-03 23:07:41');
INSERT INTO `cs_user_count` VALUES (111, 178, 73, 1783091740069, 1783091875607, 135, 0, 1, 0, '172.20.10.2', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-03 23:17:56', '2026-07-03 23:15:40');
INSERT INTO `cs_user_count` VALUES (112, 180, 179, 1783157771064, 1783162634505, 4863, 0, 10, 0, '127.0.0.1', '暂无', 1, 3, 1, 1, 1, 0, '2026-07-04 18:57:15', '2026-07-04 17:36:11');

-- ----------------------------
-- Table structure for cs_user_logs
-- ----------------------------
DROP TABLE IF EXISTS `cs_user_logs`;
CREATE TABLE `cs_user_logs`  (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作的ip地址',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作备注',
  `operate_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作名称',
  `arg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作参数',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作路径',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作function',
  `model` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作模块',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_user_logs
-- ----------------------------
INSERT INTO `cs_user_logs` VALUES (2068320950458724354, 61, '127.0.0.1', NULL, '用户登录', '[CS-1000314a130a6ae0266e, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@6ac33aff]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-06-20 21:11:57');
INSERT INTO `cs_user_logs` VALUES (2068321223990259714, 143, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=143, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=null, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=测试名字, moneyNumber=500), 143]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-20 21:13:02');
INSERT INTO `cs_user_logs` VALUES (2069686130488811522, 61, '127.0.0.1', NULL, '用户登录', '[CS-1000314a130a6ae0266e, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@22dd7543]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-06-24 15:36:41');
INSERT INTO `cs_user_logs` VALUES (2070021144689274882, 61, '127.0.0.1', NULL, '用户登录', '[CS-1000314a130a6ae0266e, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@74867732]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-06-25 13:47:55');
INSERT INTO `cs_user_logs` VALUES (2070021177782333442, 61, '127.0.0.1', NULL, '打招呼上移', '[12]', '/sayHello/top', 'sortTop', '打招呼', '2026-06-25 13:48:03');
INSERT INTO `cs_user_logs` VALUES (2070021182979076097, 61, '127.0.0.1', NULL, '打招呼下移', '[13]', '/sayHello/bottom', 'sortBottom', '打招呼', '2026-06-25 13:48:04');
INSERT INTO `cs_user_logs` VALUES (2070021975819997185, 61, '127.0.0.1', NULL, '修改打招呼', NULL, '/sayHello/update', 'updateQuickReply', '打招呼', '2026-06-25 13:51:13');
INSERT INTO `cs_user_logs` VALUES (2071660295672479745, 61, '127.0.0.1', NULL, '用户登录', '[CS-1000314a130a6ae0266e, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@3b21a7fe]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-06-30 02:21:19');
INSERT INTO `cs_user_logs` VALUES (2071660335149268994, 61, '127.0.0.1', NULL, '修改配置', '[UserSetupVO(id=56, userId=61, sideSwitch=1, audioSwitch=0, chatRecordSort=0, jumpSwitch=0, dataSwitch=1, updateTime=Sat Jun 20 17:36:59 CST 2026, createTime=Sat Jun 13 13:34:20 CST 2026, codeSwitch=0, qrcodeSwitch=0, verifyCodeSwitch=1, verifyCodeImage=null, verifyCodeTitle=null, countSwitch=1, ipNumber=20, domesticSwitch=1, secondsSwitch=1, stopSwitch=1, stopTimeNumber=0, version=2562490d810345648ded833690db0a7e, wechatSwitch=1, isProxySwitch=1, phoneModelSwitch=1, formSettings=1,3,2,4, verifyQuestionsImage=null, verifyQuestionsContent=null)]', '/userSetup/update', 'updateUserSetUp', '客服设置', '2026-06-30 02:21:28');
INSERT INTO `cs_user_logs` VALUES (2071662374965133313, 145, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=145, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=15646543123, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=测hi是1, moneyNumber=50000, age=null), 145]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-30 02:29:34');
INSERT INTO `cs_user_logs` VALUES (2071662675986182145, 145, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=145, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18564231751, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=312312, moneyNumber=60000, age=null), 145]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-30 02:30:46');
INSERT INTO `cs_user_logs` VALUES (2071663181693415425, 145, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=145, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18802548798, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=3123123, moneyNumber=10000, age=null), 145]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-30 02:32:47');
INSERT INTO `cs_user_logs` VALUES (2071664073436028930, 145, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=145, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=17756789876, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=3123, moneyNumber=123123, age=null), 145]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-30 02:36:19');
INSERT INTO `cs_user_logs` VALUES (2071664247017299969, 146, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=146, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=17712345678, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=312321, moneyNumber=60000, age=null), 146]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-30 02:37:01');
INSERT INTO `cs_user_logs` VALUES (2071664493730455553, 146, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=146, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=17712345678, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=123123, moneyNumber=12312312, age=null), 146]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-30 02:38:00');
INSERT INTO `cs_user_logs` VALUES (2071664791349878785, 146, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=146, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=17712345678, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=123123, moneyNumber=12312313, age=25), 146]', '/user/update', 'updateUserInfo', '用户管理', '2026-06-30 02:39:11');
INSERT INTO `cs_user_logs` VALUES (2071940787460919298, 61, '127.0.0.1', NULL, '用户登录', '[CS-1000314a130a6ae0266e, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@561d551f]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-06-30 20:55:53');
INSERT INTO `cs_user_logs` VALUES (2071941266383327233, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 20:57:47');
INSERT INTO `cs_user_logs` VALUES (2071941290668347393, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 20:57:53');
INSERT INTO `cs_user_logs` VALUES (2071941312684249090, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 20:57:58');
INSERT INTO `cs_user_logs` VALUES (2071941360730001409, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 20:58:10');
INSERT INTO `cs_user_logs` VALUES (2071959931775815681, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:11:58');
INSERT INTO `cs_user_logs` VALUES (2071959947277963266, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:12:01');
INSERT INTO `cs_user_logs` VALUES (2071959957583368193, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:12:04');
INSERT INTO `cs_user_logs` VALUES (2071959967666475010, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:12:06');
INSERT INTO `cs_user_logs` VALUES (2071960539345915906, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:14:22');
INSERT INTO `cs_user_logs` VALUES (2071960549781344258, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:14:25');
INSERT INTO `cs_user_logs` VALUES (2071960620283400194, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:14:42');
INSERT INTO `cs_user_logs` VALUES (2071960629670252545, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:14:44');
INSERT INTO `cs_user_logs` VALUES (2071960639703027714, 61, '127.0.0.1', NULL, '切换二维码', '[61]', '/domain/switch', 'switchQrcode', '活码域名', '2026-06-30 22:14:46');
INSERT INTO `cs_user_logs` VALUES (2071991595314909186, 61, '127.0.0.1', NULL, '用户登录', '[CS-1000314a130a6ae0266e, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@44442613]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-01 00:17:47');
INSERT INTO `cs_user_logs` VALUES (2072029173573779458, 73, '127.0.0.1', NULL, '用户登录', '[JC-1000d7d412960561beca, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@7e596a26]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-01 02:47:06');
INSERT INTO `cs_user_logs` VALUES (2072029192536227841, 73, '127.0.0.1', NULL, '切换二维码', '[73]', '/domain/switch', 'switchQrcode', '活码域名', '2026-07-01 02:47:11');
INSERT INTO `cs_user_logs` VALUES (2072162355252420609, 73, '127.0.0.1', NULL, '用户登录', '[JC-1000d7d412960561beca, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@55165f77]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-01 11:36:19');
INSERT INTO `cs_user_logs` VALUES (2072363704753655809, 73, '127.0.0.1', NULL, '用户登录', '[JC-1000d7d412960561beca, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@74e5535]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-02 00:56:25');
INSERT INTO `cs_user_logs` VALUES (2072364438941405185, 73, '127.0.0.1', NULL, '修改配置', '[UserSetupVO(id=68, userId=73, sideSwitch=1, audioSwitch=0, chatRecordSort=0, jumpSwitch=0, dataSwitch=1, updateTime=null, createTime=Sat Jun 13 15:06:13 CST 2026, codeSwitch=0, qrcodeSwitch=0, verifyCodeSwitch=1, verifyCodeImage=null, verifyCodeTitle=null, countSwitch=0, ipNumber=20, domesticSwitch=1, secondsSwitch=1, stopSwitch=1, stopTimeNumber=0, version=null, wechatSwitch=1, isProxySwitch=1, phoneModelSwitch=1, formSettings=1,2, verifyQuestionsImage=null, verifyQuestionsContent=null)]', '/userSetup/update', 'updateUserSetUp', '客服设置', '2026-07-02 00:59:20');
INSERT INTO `cs_user_logs` VALUES (2072364495635812354, 73, '127.0.0.1', NULL, '添加快捷回复', NULL, '/quickReply/add', 'addQuickReply', '快捷回复', '2026-07-02 00:59:33');
INSERT INTO `cs_user_logs` VALUES (2072365624956358658, 73, '127.0.0.1', NULL, '添加', NULL, '/autoReply/add', 'addQuickReply', '自动回复管理', '2026-07-02 01:04:02');
INSERT INTO `cs_user_logs` VALUES (2072366205049573378, 73, '127.0.0.1', NULL, '添加', NULL, '/autoReply/add', 'addQuickReply', '自动回复管理', '2026-07-02 01:06:21');
INSERT INTO `cs_user_logs` VALUES (2072366264537387010, 73, '127.0.0.1', NULL, '修改', NULL, '/autoReply/update', 'updateQuickReply', '自动回复管理', '2026-07-02 01:06:35');
INSERT INTO `cs_user_logs` VALUES (2072366313103233025, 73, '127.0.0.1', NULL, '修改', NULL, '/autoReply/update', 'updateQuickReply', '自动回复管理', '2026-07-02 01:06:46');
INSERT INTO `cs_user_logs` VALUES (2072367333057302529, 73, '127.0.0.1', NULL, '用户登录', '[JC-1000d7d412960561beca, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@4abcb6a4]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-02 01:10:50');
INSERT INTO `cs_user_logs` VALUES (2072368916516114433, 74, '127.0.0.1', NULL, '用户登录', '[JC-1000622e0fb49ae86e28, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@41e48b0d]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-02 01:17:07');
INSERT INTO `cs_user_logs` VALUES (2072369018953601025, 74, '127.0.0.1', NULL, '话术同步', '[74, JC-1000d7d412960561beca, 1, 1,2,3,4,5,6,7,8,9,10,11,12]', '/user/speech', 'setUpSynchronous', '用户管理', '2026-07-02 01:17:32');
INSERT INTO `cs_user_logs` VALUES (2072911118016622594, 73, '127.0.0.1', NULL, '用户登录', '[JC-1000d7d412960561beca, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@2dfeb4de]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-03 13:11:38');
INSERT INTO `cs_user_logs` VALUES (2072911398326153217, 73, '127.0.0.1', NULL, '修改配置', '[UserSetupVO(id=68, userId=73, sideSwitch=1, audioSwitch=0, chatRecordSort=0, jumpSwitch=0, dataSwitch=1, updateTime=Thu Jul 02 00:59:20 CST 2026, createTime=Sat Jun 13 15:06:13 CST 2026, codeSwitch=0, qrcodeSwitch=0, verifyCodeSwitch=1, verifyCodeImage=null, verifyCodeTitle=null, countSwitch=1, ipNumber=20, domesticSwitch=1, secondsSwitch=1, stopSwitch=1, stopTimeNumber=0, version=36a6f2d8ce1548cdb356984a315d1b91, wechatSwitch=1, isProxySwitch=1, phoneModelSwitch=1, formSettings=1,2,3,4, verifyQuestionsImage=null, verifyQuestionsContent=null)]', '/userSetup/update', 'updateUserSetUp', '客服设置', '2026-07-03 13:12:45');
INSERT INTO `cs_user_logs` VALUES (2072912106588909570, 173, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=173, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18798648712, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=1111, moneyNumber=500000, age=32, uniqueNonce=null), 173]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-03 13:15:34');
INSERT INTO `cs_user_logs` VALUES (2073056776602238977, 73, '127.0.0.1', NULL, '用户登录', '[JC-1000d7d412960561beca, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@7a984e63]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-03 22:50:26');
INSERT INTO `cs_user_logs` VALUES (2073058004631535617, 175, '172.20.10.4', NULL, '修改用户信息', '[UserVO(id=175, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=17756787891, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=eueiei, moneyNumber=1000, age=32, uniqueNonce=null), 175]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-03 22:55:19');
INSERT INTO `cs_user_logs` VALUES (2073058240674381825, 175, '172.20.10.4', NULL, '修改用户信息', '[UserVO(id=175, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18801113714, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=1313322, moneyNumber=5000, age=24, uniqueNonce=null), 175]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-03 22:56:15');
INSERT INTO `cs_user_logs` VALUES (2073058371096264705, 73, '127.0.0.1', NULL, '修改', NULL, '/autoReply/update', 'updateQuickReply', '自动回复管理', '2026-07-03 22:56:46');
INSERT INTO `cs_user_logs` VALUES (2073058510481375234, 176, '172.20.10.4', NULL, '修改用户信息', '[UserVO(id=176, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18976653221, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=ddjjd, moneyNumber=7000, age=21, uniqueNonce=null), 176]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-03 22:57:19');
INSERT INTO `cs_user_logs` VALUES (2073061219875930113, 177, '172.20.10.3', NULL, '修改用户信息', '[UserVO(id=177, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=15523478613, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=46465, moneyNumber=6000, age=32, uniqueNonce=null), 177]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-03 23:08:05');
INSERT INTO `cs_user_logs` VALUES (2073061376222806017, 177, '172.20.10.3', NULL, '修改用户信息', '[UserVO(id=177, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=17456182394, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=djjdd, moneyNumber=5000, age=21, uniqueNonce=null), 177]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-03 23:08:42');
INSERT INTO `cs_user_logs` VALUES (2073063226124779521, 178, '172.20.10.2', NULL, '修改用户信息', '[UserVO(id=178, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=null, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=null, moneyNumber=null, age=null, uniqueNonce=null), 178]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-03 23:16:03');
INSERT INTO `cs_user_logs` VALUES (2073339244587261954, 179, '127.0.0.1', NULL, '用户登录', '[CES-10003c46d5834dfc77de, null, SecurityContextHolderAwareRequestWrapper[ org.springframework.security.web.header.HeaderWriterFilter$HeaderWriterRequest@116d69c9]]', '/user/loginCarmine', 'loginCarmine', '用户管理', '2026-07-04 17:32:51');
INSERT INTO `cs_user_logs` VALUES (2073339353555279874, 179, '127.0.0.1', NULL, '添加打招呼', NULL, '/sayHello/add', 'addQuickReply', '打招呼', '2026-07-04 17:33:17');
INSERT INTO `cs_user_logs` VALUES (2073339502180442113, 179, '127.0.0.1', NULL, '修改配置', '[UserSetupVO(id=71, userId=179, sideSwitch=1, audioSwitch=0, chatRecordSort=0, jumpSwitch=0, dataSwitch=1, updateTime=null, createTime=Sat Jul 04 17:32:24 CST 2026, codeSwitch=0, qrcodeSwitch=0, verifyCodeSwitch=1, verifyCodeImage=null, verifyCodeTitle=null, countSwitch=0, ipNumber=20, domesticSwitch=1, secondsSwitch=1, stopSwitch=1, stopTimeNumber=0, version=null, wechatSwitch=1, isProxySwitch=1, phoneModelSwitch=1, formSettings=1,2,3,4, verifyQuestionsImage=null, verifyQuestionsContent=null)]', '/userSetup/update', 'updateUserSetUp', '客服设置', '2026-07-04 17:33:53');
INSERT INTO `cs_user_logs` VALUES (2073339604378853377, 179, '127.0.0.1', NULL, '添加', NULL, '/autoReply/add', 'addQuickReply', '自动回复管理', '2026-07-04 17:34:17');
INSERT INTO `cs_user_logs` VALUES (2073340194727141377, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=null, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=null, moneyNumber=null, age=null, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 17:36:38');
INSERT INTO `cs_user_logs` VALUES (2073340517000683521, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=null, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=null, moneyNumber=null, age=null, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 17:37:55');
INSERT INTO `cs_user_logs` VALUES (2073340943922110466, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=13456789967, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=测试111, moneyNumber=6000, age=21, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 17:39:37');
INSERT INTO `cs_user_logs` VALUES (2073341718798802945, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765413272, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=213213, moneyNumber=8000, age=78, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 17:42:41');
INSERT INTO `cs_user_logs` VALUES (2073342128469057538, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765873979, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=13123123, moneyNumber=10000, age=22, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 17:44:19');
INSERT INTO `cs_user_logs` VALUES (2073358687417712641, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765873979, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=13123123, moneyNumber=10000, age=22, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 18:50:07');
INSERT INTO `cs_user_logs` VALUES (2073358842950893569, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765873979, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=13123123, moneyNumber=10000, age=22, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 18:50:44');
INSERT INTO `cs_user_logs` VALUES (2073359014124634114, 179, '127.0.0.1', NULL, '添加', NULL, '/autoReply/add', 'addQuickReply', '自动回复管理', '2026-07-04 18:51:25');
INSERT INTO `cs_user_logs` VALUES (2073359045426724866, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765873979, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=13123123, moneyNumber=10000, age=22, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 18:51:32');
INSERT INTO `cs_user_logs` VALUES (2073359180068077570, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765873979, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=13123123, moneyNumber=10000, age=22, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 18:52:04');
INSERT INTO `cs_user_logs` VALUES (2073359289229033474, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765873979, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=13123123, moneyNumber=10000, age=22, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 18:52:30');
INSERT INTO `cs_user_logs` VALUES (2073360429974863873, 180, '127.0.0.1', NULL, '修改用户信息', '[UserVO(id=180, name=null, notes=null, img=null, password=null, confirmPassword=null, userAccount=null, phoneNumber=18765873979, type=null, shellType=null, status=null, ipAddress=null, network=null, deviceCode=null, firstLoginTime=null, accountId=null, equipmentCode=null, ipDistrict=null, carrier=null, browserName=null, platform=null, userKey=null, carmine=null, isProxy=null, createTime=null, updateTime=null, loginTime=null, equipmentModel=null, expirationDate=null, days=null, testCard=null, ua=null, maxNumber=null, activeState=null, activeTime=null, channelRemark=null, realName=13123123, moneyNumber=10000, age=22, uniqueNonce=null), 180]', '/user/update', 'updateUserInfo', '用户管理', '2026-07-04 18:57:02');

-- ----------------------------
-- Table structure for cs_user_online_status
-- ----------------------------
DROP TABLE IF EXISTS `cs_user_online_status`;
CREATE TABLE `cs_user_online_status`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(1) NULL DEFAULT 0 COMMENT '账号类型：0用户，1客服',
  `user_id` bigint(20) NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT 1 COMMENT '在线状态:1，在线，2，不在线',
  `number` int(1) NULL DEFAULT 0 COMMENT '客服端同时在线',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 116 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户在线表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cs_user_online_status
-- ----------------------------
INSERT INTO `cs_user_online_status` VALUES (1, 1, 61, 0, -38, '2026-07-01 07:44:47');
INSERT INTO `cs_user_online_status` VALUES (2, 0, 143, 0, 1, '2026-06-20 21:14:04');
INSERT INTO `cs_user_online_status` VALUES (3, 0, 144, 0, 1, '2026-06-24 16:08:08');
INSERT INTO `cs_user_online_status` VALUES (4, 0, 126, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (5, 0, 84, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (6, 0, 108, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (7, 0, 122, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (8, 0, 95, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (9, 0, 24, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (10, 0, 91, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (11, 0, 85, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (12, 0, 93, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (13, 0, 119, 1, 1, '2026-06-30 02:18:21');
INSERT INTO `cs_user_online_status` VALUES (15, 0, 101, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (16, 0, 94, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (17, 0, 124, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (18, 0, 25, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (19, 0, 135, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (20, 0, 77, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (21, 0, 78, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (22, 0, 81, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (23, 0, 83, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (24, 0, 137, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (25, 0, 60, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (26, 0, 62, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (27, 0, 80, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (28, 0, 79, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (29, 0, 88, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (30, 0, 89, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (31, 0, 99, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (32, 0, 102, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (33, 0, 116, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (34, 0, 118, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (35, 0, 131, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (36, 0, 134, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (37, 0, 138, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (38, 0, 21, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (39, 0, 22, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (40, 0, 76, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (41, 0, 82, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (42, 0, 92, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (43, 0, 100, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (44, 0, 104, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (45, 0, 105, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (46, 0, 106, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (47, 0, 110, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (48, 0, 112, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (49, 0, 114, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (50, 0, 117, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (51, 0, 127, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (52, 0, 129, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (53, 0, 130, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (54, 0, 132, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (55, 0, 133, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (56, 0, 139, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (57, 0, 140, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (58, 0, 142, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (59, 0, 23, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (60, 0, 86, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (61, 0, 87, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (62, 0, 90, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (63, 0, 96, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (64, 0, 97, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (65, 0, 98, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (66, 0, 103, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (67, 0, 107, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (68, 0, 109, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (69, 0, 111, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (70, 0, 113, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (71, 0, 115, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (72, 0, 120, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (73, 0, 121, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (74, 0, 123, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (75, 0, 125, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (76, 0, 128, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (77, 0, 136, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (78, 0, 141, 1, 1, '2026-06-30 02:18:22');
INSERT INTO `cs_user_online_status` VALUES (79, 0, 145, 0, 1, '2026-06-30 02:36:42');
INSERT INTO `cs_user_online_status` VALUES (80, 0, 146, 0, 1, '2026-06-30 02:48:58');
INSERT INTO `cs_user_online_status` VALUES (81, 0, 148, 0, 1, '2026-07-01 00:19:07');
INSERT INTO `cs_user_online_status` VALUES (82, 0, 147, 1, 1, '2026-07-01 00:18:56');
INSERT INTO `cs_user_online_status` VALUES (83, 0, 149, 0, 1, '2026-07-01 01:54:10');
INSERT INTO `cs_user_online_status` VALUES (84, 0, 150, 1, 1, '2026-07-01 02:42:11');
INSERT INTO `cs_user_online_status` VALUES (85, 0, 151, 0, 1, '2026-07-01 02:45:14');
INSERT INTO `cs_user_online_status` VALUES (86, 0, 152, 0, 1, '2026-07-01 02:46:35');
INSERT INTO `cs_user_online_status` VALUES (87, 0, 153, 0, 1, '2026-07-01 02:49:03');
INSERT INTO `cs_user_online_status` VALUES (88, 0, 154, 0, 1, '2026-07-01 02:49:27');
INSERT INTO `cs_user_online_status` VALUES (89, 0, 155, 0, 1, '2026-07-01 02:50:09');
INSERT INTO `cs_user_online_status` VALUES (90, 0, 156, 0, 1, '2026-07-01 02:50:22');
INSERT INTO `cs_user_online_status` VALUES (91, 0, 157, 0, 1, '2026-07-01 03:13:41');
INSERT INTO `cs_user_online_status` VALUES (92, 1, 73, 0, -23, '2026-07-03 23:17:56');
INSERT INTO `cs_user_online_status` VALUES (93, 0, 158, 0, 1, '2026-07-01 03:15:07');
INSERT INTO `cs_user_online_status` VALUES (94, 0, 159, 0, 1, '2026-07-01 03:15:19');
INSERT INTO `cs_user_online_status` VALUES (95, 0, 160, 0, 1, '2026-07-01 03:15:37');
INSERT INTO `cs_user_online_status` VALUES (96, 0, 161, 0, 1, '2026-07-01 03:46:22');
INSERT INTO `cs_user_online_status` VALUES (97, 0, 162, 0, 1, '2026-07-01 03:47:25');
INSERT INTO `cs_user_online_status` VALUES (98, 0, 163, 0, 1, '2026-07-01 03:47:49');
INSERT INTO `cs_user_online_status` VALUES (99, 0, 164, 0, 1, '2026-07-01 03:48:02');
INSERT INTO `cs_user_online_status` VALUES (100, 0, 165, 0, 1, '2026-07-01 06:14:32');
INSERT INTO `cs_user_online_status` VALUES (101, 0, 166, 1, 1, '2026-07-01 11:40:52');
INSERT INTO `cs_user_online_status` VALUES (102, 0, 167, 0, 1, '2026-07-01 11:43:17');
INSERT INTO `cs_user_online_status` VALUES (103, 0, 168, 1, 1, '2026-07-01 11:44:12');
INSERT INTO `cs_user_online_status` VALUES (104, 0, 169, 0, 1, '2026-07-02 01:08:48');
INSERT INTO `cs_user_online_status` VALUES (105, 0, 170, 1, 1, '2026-07-02 01:08:48');
INSERT INTO `cs_user_online_status` VALUES (106, 0, 171, 0, 1, '2026-07-02 01:16:44');
INSERT INTO `cs_user_online_status` VALUES (107, 0, 172, 0, 1, '2026-07-03 13:13:02');
INSERT INTO `cs_user_online_status` VALUES (108, 0, 173, 0, 1, '2026-07-03 19:05:43');
INSERT INTO `cs_user_online_status` VALUES (109, 0, 174, 0, 1, '2026-07-03 23:09:27');
INSERT INTO `cs_user_online_status` VALUES (110, 0, 175, 0, 1, '2026-07-03 22:55:53');
INSERT INTO `cs_user_online_status` VALUES (111, 0, 176, 0, 1, '2026-07-03 23:09:40');
INSERT INTO `cs_user_online_status` VALUES (112, 0, 177, 0, 1, '2026-07-03 23:09:13');
INSERT INTO `cs_user_online_status` VALUES (113, 0, 178, 0, 1, '2026-07-03 23:17:56');
INSERT INTO `cs_user_online_status` VALUES (114, 0, 180, 0, 1, '2026-07-04 18:57:15');
INSERT INTO `cs_user_online_status` VALUES (115, 1, 179, 0, -5, '2026-07-04 18:57:14');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME` ASC, `TRIGGER_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME` ASC, `INSTANCE_NAME` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME` ASC, `INSTANCE_NAME` ASC, `REQUESTS_RECOVERY` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME` ASC, `JOB_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME` ASC, `TRIGGER_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME` ASC, `REQUESTS_RECOVERY` ASC) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME` ASC, `JOB_GROUP` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(190) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME` ASC, `JOB_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME` ASC, `CALENDAR_NAME` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME` ASC, `TRIGGER_GROUP` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME` ASC, `TRIGGER_STATE` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME` ASC, `TRIGGER_NAME` ASC, `TRIGGER_GROUP` ASC, `TRIGGER_STATE` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME` ASC, `TRIGGER_GROUP` ASC, `TRIGGER_STATE` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME` ASC, `NEXT_FIRE_TIME` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME` ASC, `TRIGGER_STATE` ASC, `NEXT_FIRE_TIME` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME` ASC, `MISFIRE_INSTR` ASC, `NEXT_FIRE_TIME` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME` ASC, `MISFIRE_INSTR` ASC, `NEXT_FIRE_TIME` ASC, `TRIGGER_STATE` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME` ASC, `MISFIRE_INSTR` ASC, `NEXT_FIRE_TIME` ASC, `TRIGGER_GROUP` ASC, `TRIGGER_STATE` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
