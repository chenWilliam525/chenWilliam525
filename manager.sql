/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : localhost:3306
 Source Schema         : manager

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 02/12/2024 22:39:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1732882926179-1697438073596-avatar.png', 'ADMIN', '13770531457', 'admin@163.com');

-- ----------------------------
-- Table structure for complaint
-- ----------------------------
DROP TABLE IF EXISTS `complaint`;
CREATE TABLE `complaint`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '业主姓名',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '投诉时间',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '投诉内容',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '投诉建议表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of complaint
-- ----------------------------
INSERT INTO `complaint` VALUES (2, 'wy', '2024-11-28 09:33:05', '3栋楼下垃圾需要清理', '已处理');
INSERT INTO `complaint` VALUES (4, '张三', '2024-11-28 10:41:43', '5栋301热水器故障', '待处理');
INSERT INTO `complaint` VALUES (7, 'wy', '2024-11-28 11:24:40', '3栋4号电梯故障', '待处理');
INSERT INTO `complaint` VALUES (8, '张三', '2024-11-28 11:24:57', '18栋墙体外壳脱落', '已处理');
INSERT INTO `complaint` VALUES (9, '张三', '2024-11-28 11:43:41', '停车场私家车位被占用', '已处理');

-- ----------------------------
-- Table structure for fixed
-- ----------------------------
DROP TABLE IF EXISTS `fixed`;
CREATE TABLE `fixed`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '业主姓名',
  `time` datetime(0) NULL DEFAULT NULL COMMENT '发帖时间',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '发帖内容',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fixed
-- ----------------------------
INSERT INTO `fixed` VALUES (13, 'wy', '2024-12-02 21:37:21', '小区内的停车位一直不足，晚上总是找不到停车位。有些车主甚至私自占用了非停车位。大家有没有遇到过类似的问题？有没有有效的解决方法？希望物业能够在这方面采取一些措施，大家有什么建议吗？', 'B31030401', 'E593858', 'http://localhost:9090/files/OIP-C.jpg');
INSERT INTO `fixed` VALUES (14, 'wy', '2024-12-02 21:37:43', '我注意到最近小区的环境卫生状况有所下降，尤其是垃圾桶旁的垃圾没有及时清理。希望物业能够加强对公共区域的清洁和卫生维护，也希望大家能够共同爱护我们的生活环境。', 'B31030401', 'E380437', 'http://localhost:9090/files/OIP-C.jpg');
INSERT INTO `fixed` VALUES (15, 'wch', '2024-12-02 21:38:20', '近段时间小区内发生了一些盗窃事件，大家是否也有类似的担忧？我认为物业的安保措施有待加强，尤其是在夜间巡逻方面。希望物业能够增加监控设备、加强安保人员的巡逻，确保我们的社区更加安全。', 'B31030402', 'E605565', 'http://localhost:9090/files/OIP-C2.jpg');
INSERT INTO `fixed` VALUES (16, '李四', '2024-12-02 21:40:04', '物业组织的社区活动（如节日聚会、运动会等）越来越少，感觉邻里关系逐渐疏远。大家有没有参与过以前的社区活动？如果有好的建议或希望可以组织哪些活动，可以在这里讨论一下，让物业看看大家的需求。', 'B31030404', 'E913430', 'http://localhost:9090/files/OIP-C4.jpg');
INSERT INTO `fixed` VALUES (17, 'wch', '2024-12-02 21:40:36', '越来越多的居民养起了宠物，但部分宠物没有遛狗牵绳，或者在公共区域随地排泄，影响了其他居民的生活。物业是否可以加强对宠物管理的规定，要求养宠物的居民做好相应的文明养宠行为？', 'B31030402', 'E816734', 'http://localhost:9090/files/OIP-C2.jpg');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1985 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '物业费调整通知', '为了更好地提升小区的公共设施维护与管理水平，保障大家的居住环境质量，经物业管理委员会研究决定，自 2024年12月1日起，本小区物业费将作适度调整。具体调整如下：\r\n\r\n普通住宅：由原来的 2.5元/平方米 调整为 3.0元/平方米；\r\n别墅住宅：由原来的 4.0元/平方米 调整为 5.0元/平方米；\r\n此次调整将有助于提升小区的环境绿化、安保措施以及物业服务质量。感谢大家的理解与支持！如有疑问，请随时联系我们的物业服务中心。\r\n\r\n特此公告。', '2024-11-29', 'admin');
INSERT INTO `notice` VALUES (2, '停车场管理公告', '为了规范小区内停车场管理，保障每一位业主的停车需求，现将停车场管理相关事项公示如下：\r\n\r\n停车场使用时间：停车场全天候开放，但严禁占用公共车位长时间停放。\r\n停车收费标准：每日停车费用为 5元/车位，超时停车将按 10元/小时 收取。\r\n停车秩序：请按车位标线停车，确保车位使用高效。违停车辆将被拖移并处罚款。\r\n为确保大家的停车安全与方便，请广大业主积极配合执行相关管理规定。如有任何疑问，欢迎咨询物业管理处。\r\n\r\n感谢大家的支持与理解！', '2024-11-29', 'admin');
INSERT INTO `notice` VALUES (3, '绿化修复工作通知', '为进一步改善小区环境，提升绿化景观，2024年12月1日至12月5日，小区内将进行绿化修复和植被补种工作，具体安排如下：\r\n\r\n工作内容：修复受损草坪，补种绿植，修剪树木，增设花卉。\r\n影响区域：主要涉及 南区花园 和 北区绿化带，施工期间请大家避免进入施工区域。\r\n施工期间可能会产生一定的噪音和临时通行不便，敬请各位业主理解与配合。物业公司将全力保证工程的顺利进行，并在此期间确保安全措施。\r\n\r\n如有任何问题，欢迎随时联系物业服务中心。', '2024-11-29', 'admin');
INSERT INTO `notice` VALUES (4, '垃圾分类倡议', '为了响应国家号召，提高环保意识，共同建设绿色家园，小区物业决定于 2024年12月1日 起实施垃圾分类管理，现向全体业主发出如下倡议：\r\n\r\n请大家按类别正确投放垃圾，分为可回收物、厨余垃圾、有害垃圾和其他垃圾四大类。\r\n小区内各个垃圾分类投放点将在指定位置设置，请大家自觉遵守分类规则。\r\n物业将定期对垃圾分类工作进行检查，违规投放者将会受到相应处罚。\r\n我们相信，只有每一位业主的共同参与，才能让我们的家园更美好、更环保。让我们携手并肩，行动起来，守护我们的绿色家园！', '2024-11-29', 'admin');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` int(0) NOT NULL COMMENT '主键id',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章编号',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发帖人账号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发帖人姓名',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发帖时间',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发帖内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, 'E123456', 'B31030401', 'wy', '2024-12-18 13:47:31', '你好这是一篇帖子');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(0) NOT NULL,
  `time` datetime(0) NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `number`(`number`) USING BTREE,
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`number`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `account` int(0) NULL DEFAULT 0 COMMENT '注册状态',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '业主信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'B31030401', '0401', 'wy', 'http://localhost:9090/files/OIP-C.jpg', 'USER', '10401', '0401@njupt', 0, '已同意');
INSERT INTO `user` VALUES (2, 'B31030402', '0402', 'wch', 'http://localhost:9090/files/OIP-C2.jpg', 'USER', '10402', '0402@njupt', 0, '已同意');
INSERT INTO `user` VALUES (3, 'B31030403', '0403', '张三', 'http://localhost:9090/files/OIP-C3.jpg', 'USER', '10403', '0403@njupt', 0, '已同意');
INSERT INTO `user` VALUES (4, 'B31030404', '0404', '李四', 'http://localhost:9090/files/OIP-C4.jpg', 'USER', '10404', '0404@njupt', 0, '已同意');

SET FOREIGN_KEY_CHECKS = 1;
