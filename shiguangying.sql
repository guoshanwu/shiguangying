/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : shiguangying

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 30/06/2020 18:39:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sgy_system_auth
-- ----------------------------
DROP TABLE IF EXISTS `sgy_system_auth`;
CREATE TABLE `sgy_system_auth`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限名称',
  `sign` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限标识',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 1:正常 -1:删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sign_index`(`sign`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sgy_system_menus
-- ----------------------------
DROP TABLE IF EXISTS `sgy_system_menus`;
CREATE TABLE `sgy_system_menus`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父菜单id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单标题',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路径',
  `level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '菜单等级',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `sort` int(10) NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 1:正常 -1:删除',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sgy_system_menus
-- ----------------------------
INSERT INTO `sgy_system_menus` VALUES (1, 0, 'Dashboard', '', '1', 'dashboard', 0, 1, '2020-06-29 16:08:46', NULL);
INSERT INTO `sgy_system_menus` VALUES (2, 0, 'Nested', 'nested', '1', 'nested', 0, 1, '2020-06-29 16:09:48', NULL);
INSERT INTO `sgy_system_menus` VALUES (3, 2, 'Menu1', 'nested/menu1', '2', NULL, 0, 1, '2020-06-30 16:30:44', NULL);
INSERT INTO `sgy_system_menus` VALUES (7, 3, 'Menu1-3', 'nested/menu1/menu1-3', '3', NULL, 0, 1, '2020-06-30 16:29:53', NULL);
INSERT INTO `sgy_system_menus` VALUES (6, 3, 'Menu1-2', 'nested/menu1/menu1-2', '3', NULL, 0, 1, '2020-06-30 16:30:01', NULL);
INSERT INTO `sgy_system_menus` VALUES (5, 3, 'Menu1-1', 'nested/menu1/menu1-1', '3', NULL, 0, 1, '2020-06-30 16:30:03', NULL);
INSERT INTO `sgy_system_menus` VALUES (4, 2, 'Menu2', 'nested/menu2', '2', NULL, 0, 1, '2020-06-30 16:30:52', NULL);
INSERT INTO `sgy_system_menus` VALUES (8, 6, 'Menu1-2-1', 'nested/menu2/menu1-2-1', '4', NULL, 0, 1, '2020-06-30 16:31:13', NULL);
INSERT INTO `sgy_system_menus` VALUES (9, 6, 'Menu1-2-2', 'nested/menu2/menu1-2-2', '4', NULL, 0, 1, '2020-06-30 16:31:23', NULL);

-- ----------------------------
-- Table structure for sgy_system_role
-- ----------------------------
DROP TABLE IF EXISTS `sgy_system_role`;
CREATE TABLE `sgy_system_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `status` tinyint(1) NOT NULL COMMENT '状态 1:正常 -1:删除',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sgy_system_role_auth
-- ----------------------------
DROP TABLE IF EXISTS `sgy_system_role_auth`;
CREATE TABLE `sgy_system_role_auth`  (
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  `auth_id` int(10) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色对应的权限' ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for sgy_system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sgy_system_user_role`;
CREATE TABLE `sgy_system_user_role`  (
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `role_id` int(10) NOT NULL COMMENT '角色ID'
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户对应的角色' ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for sgy_system_users
-- ----------------------------
DROP TABLE IF EXISTS `sgy_system_users`;
CREATE TABLE `sgy_system_users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 1:正常 -1:删除',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_index`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sgy_system_users
-- ----------------------------
INSERT INTO `sgy_system_users` VALUES (1, 'admin', 'eyJpdiI6ImlWd1g5eFJIU241UTcrdHQ2a0E3UHc9PSIsInZhbHVlIjoiWThxQ056YUpFNVZDcmVkR0VaWXpWZz09IiwibWFjIjoiY2MzZWNjMGQ0NDU3NmZlZDFiMjY5YzE3OGQyODk1MzJhNjc1MGMxNTY1NjkyYzU4NjM2MDBjZWIzYjUwMDJlZSJ9', '127.0.0.1', 1, '2020-05-29 16:19:58', '2020-06-30 16:32:31');
INSERT INTO `sgy_system_users` VALUES (2, 'test', 'eyJpdiI6ImlWd1g5eFJIU241UTcrdHQ2a0E3UHc9PSIsInZhbHVlIjoiWThxQ056YUpFNVZDcmVkR0VaWXpWZz09IiwibWFjIjoiY2MzZWNjMGQ0NDU3NmZlZDFiMjY5YzE3OGQyODk1MzJhNjc1MGMxNTY1NjkyYzU4NjM2MDBjZWIzYjUwMDJlZSJ9', '127.0.0.1', 1, '2020-06-18 15:13:55', '2020-06-23 16:23:33');

SET FOREIGN_KEY_CHECKS = 1;
