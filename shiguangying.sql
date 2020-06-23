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

 Date: 19/06/2020 17:56:12
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
-- Table structure for sgy_system_menu
-- ----------------------------
DROP TABLE IF EXISTS `sgy_system_menu`;
CREATE TABLE `sgy_system_menu`  (
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
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

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
INSERT INTO `sgy_system_users` VALUES (1, 'admin', '', NULL, 1, '2020-05-29 16:19:58', NULL);
INSERT INTO `sgy_system_users` VALUES (2, 'test', 'eyJpdiI6Ijc3amRzdUZOcE54bTNiM0duZzB0Tmc9PSIsInZhbHVlIjoiU0RZeHhuU3ZiNlVQdlI5dHNIRUh2dz09IiwibWFjIjoiZWMwMzI2Y2FjYjU3YmZjYzJhNmY4YTY1YjNhZTMwMTNmZGI2N2FjODgyYjUzMTMwZWMzMzE5NmJhMDZkMThmZiJ9', '127.0.0.1', 1, '2020-06-18 15:13:55', '2020-06-19 14:55:30');

SET FOREIGN_KEY_CHECKS = 1;
