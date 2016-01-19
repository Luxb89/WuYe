/*
Navicat MySQL Data Transfer

Source Server         : 物业测试环境
Source Server Version : 50628
Source Host           : 120.24.5.23:3306
Source Database       : wuye

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2015-12-14 09:04:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `wx_reply`
-- ----------------------------
DROP TABLE IF EXISTS `wx_reply`;
CREATE TABLE `wx_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `author` varchar(50) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL COMMENT '描述',
  `picUrl` varchar(100) DEFAULT NULL COMMENT '图片地址',
  `url` varchar(100) DEFAULT NULL COMMENT '正文地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wx_reply
-- ----------------------------
INSERT INTO `wx_reply` VALUES ('5', '用户绑定', '杨朝文', '欢迎光临', '/images/mobile/reply_img.jpg', '/userBindings?type=userBindings');
