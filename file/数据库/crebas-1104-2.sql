/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/11/4 21:19:08                           */
/*==============================================================*/

SET FOREIGN_KEY_CHECKS = 0; 
DROP TABLE IF EXISTS account;

DROP TABLE IF EXISTS account_record;

DROP TABLE IF EXISTS acct_item_rel;

DROP TABLE IF EXISTS acct_item_type;

DROP TABLE IF EXISTS address;

DROP TABLE IF EXISTS AREA;

DROP TABLE IF EXISTS attr_spec;

DROP TABLE IF EXISTS attr_value;

DROP TABLE IF EXISTS building;

DROP TABLE IF EXISTS building_type;

DROP TABLE IF EXISTS community;

DROP TABLE IF EXISTS complaint;

DROP TABLE IF EXISTS complaint_deal;

DROP TABLE IF EXISTS extraordinary_fee;

DROP TABLE IF EXISTS meter_inst;

DROP TABLE IF EXISTS meter_read;

DROP TABLE IF EXISTS meter_spec;

DROP TABLE IF EXISTS monthly_balance;

DROP TABLE IF EXISTS monthly_balance_detail;

DROP TABLE IF EXISTS notice;

DROP TABLE IF EXISTS notice_rel;

DROP TABLE IF EXISTS opinion;

DROP TABLE IF EXISTS organization;

DROP TABLE IF EXISTS parking;

DROP TABLE IF EXISTS parking_type;

DROP TABLE IF EXISTS party_info;

DROP TABLE IF EXISTS pay_record;

DROP TABLE IF EXISTS privilege;

DROP TABLE IF EXISTS property_company;

DROP TABLE IF EXISTS role;

DROP TABLE IF EXISTS role_privilege;

DROP TABLE IF EXISTS room;

DROP TABLE IF EXISTS room_party_rel;

DROP TABLE IF EXISTS USER;

DROP TABLE IF EXISTS user_auth;

DROP TABLE IF EXISTS user_org_rel;

DROP TABLE IF EXISTS vehicle;

DROP TABLE IF EXISTS vehicle_rel;

/*==============================================================*/
/* Table: account                                               */
/*==============================================================*/
CREATE TABLE account
(
   account_id           INT NOT NULL AUTO_INCREMENT,
   balance              FLOAT,
   class_id             CHAR(2) COMMENT '10：物业公司，11：小区，12：房间',
   obj_id               INT NOT NULL,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (account_id)
);

ALTER TABLE account COMMENT '账户';

/*==============================================================*/
/* Table: account_record                                        */
/*==============================================================*/
CREATE TABLE account_record
(
   account_record_id    INT NOT NULL AUTO_INCREMENT,
   account_id           INT NOT NULL,
   amount               FLOAT,
   last_balance         FLOAT,
   remark               VARCHAR(1024),
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (account_record_id)
);

ALTER TABLE account_record COMMENT '账户明细';

/*==============================================================*/
/* Table: acct_item_rel                                         */
/*==============================================================*/
CREATE TABLE acct_item_rel
(
   acct_item_rel_id     INT NOT NULL AUTO_INCREMENT,
   acct_item_type_id    INT,
   class_id             CHAR(2) COMMENT '10：小区，11：楼栋或单元，12：房间',
   obj_id               INT,
   price                FLOAT,
   FLOOR                INT COMMENT '配置某个楼层的收费，用于电梯',
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (acct_item_rel_id)
);

ALTER TABLE acct_item_rel COMMENT '设置小区，楼栋的收费项目';

/*==============================================================*/
/* Table: acct_item_type                                        */
/*==============================================================*/
CREATE TABLE acct_item_type
(
   acct_item_type_id    INT NOT NULL AUTO_INCREMENT,
   acct_type_name       VARCHAR(50),
   acct_type            CHAR(2),
   parent_acct_type_id  INT,
   class_id             CHAR(2),
   obj_id               INT,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (acct_item_type_id)
);

ALTER TABLE acct_item_type COMMENT '费用类型';

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
CREATE TABLE address
(
   address_id           INT NOT NULL AUTO_INCREMENT,
   area_id              INT NOT NULL,
   detail_address       VARCHAR(50),
   PRIMARY KEY (address_id)
);

ALTER TABLE address COMMENT '地址';

/*==============================================================*/
/* Table: area                                                  */
/*==============================================================*/
CREATE TABLE AREA
(
   area_id              INT NOT NULL AUTO_INCREMENT,
   area_name            VARCHAR(50),
   area_type            CHAR(2) COMMENT '10：省，12：市，13：县或区',
   up_area_id           INT NOT NULL,
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (area_id)
);

ALTER TABLE AREA COMMENT '地区';

/*==============================================================*/
/* Table: attr_spec                                             */
/*==============================================================*/
CREATE TABLE attr_spec
(
   attr_id              INT NOT NULL AUTO_INCREMENT,
   attr_name            VARCHAR(50) NOT NULL,
   attr_code            VARCHAR(10) NOT NULL,
   class_id             CHAR(2) COMMENT '10：小区，',
   attr_value_type      CHAR(2) COMMENT '10：时间类型，11：字符类型',
   attr_type            CHAR(2) COMMENT '10：输入属性，11：选择属性',
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (attr_id)
);

ALTER TABLE attr_spec COMMENT '属性表';

/*==============================================================*/
/* Index: pk_attr_id                                            */
/*==============================================================*/
CREATE UNIQUE INDEX pk_attr_id ON attr_spec
(
   attr_id
);

/*==============================================================*/
/* Table: attr_value                                            */
/*==============================================================*/
CREATE TABLE attr_value
(
   attr_value_id        INT NOT NULL,
   attr_id              INT,
   attr_value_name      VARCHAR(50),
   attr_value           VARCHAR(200),
   community            INT NOT NULL,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (attr_value_id)
);

ALTER TABLE attr_value COMMENT '属性值表';

/*==============================================================*/
/* Index: fk_community                                          */
/*==============================================================*/
CREATE INDEX fk_community ON attr_value
(
   community
);

/*==============================================================*/
/* Table: building                                              */
/*==============================================================*/
CREATE TABLE building
(
   building_id          INT NOT NULL AUTO_INCREMENT,
   community_id         INT NOT NULL,
   party_info_id        INT,
   building_name        VARCHAR(50),
   building_type        CHAR(2) COMMENT '10：楼栋，11：单元',
   owner_building       INT NOT NULL,
   phone                VARCHAR(20),
   floor_count          INT,
   stair_area           FLOAT,
   userable_area        FLOAT,
   afforest_area        FLOAT,
   ownership_type       VARCHAR(50),
   building_structure   VARCHAR(50),
   upgrade_condition    VARCHAR(50),
   finish_time          TIMESTAMP,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (building_id)
);

ALTER TABLE building COMMENT '楼栋单元';

/*==============================================================*/
/* Table: building_type                                         */
/*==============================================================*/
CREATE TABLE building_type
(
   building_type_id     INT NOT NULL AUTO_INCREMENT,
   building_area        FLOAT,
   comprising_area      FLOAT,
   public_area          FLOAT,
   cost_area            FLOAT,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (building_type_id)
);

ALTER TABLE building_type COMMENT '房屋类型';

/*==============================================================*/
/* Table: community                                             */
/*==============================================================*/
CREATE TABLE community
(
   community_id         INT NOT NULL AUTO_INCREMENT,
   org_id               INT NOT NULL,
   company_id           INT NOT NULL,
   party_info_id        INT NOT NULL,
   community_name       VARCHAR(50) NOT NULL,
   simple_name          VARCHAR(50),
   community_area       FLOAT COMMENT '单位',
   building_area        FLOAT,
   afforest_area        FLOAT,
   bank_acct_name       VARCHAR(50),
   bank_name            VARCHAR(50),
   bank_acct_nbr        VARCHAR(20),
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (community_id)
);

ALTER TABLE community COMMENT '小区';

/*==============================================================*/
/* Table: complaint                                             */
/*==============================================================*/
CREATE TABLE complaint
(
   complaint_id         INT NOT NULL AUTO_INCREMENT,
   title                VARCHAR(200) NOT NULL,
   content              VARCHAR(1024),
   complainter_id       INT,
   complainter          VARCHAR(50),
   complainter_phone    VARCHAR(20),
   recorder_id          INT,
   recorder             VARCHAR(50),
   recorder_phone       VARCHAR(20),
   result               CHAR(2) NOT NULL,
   opinion              VARCHAR(1024),
   remark               VARCHAR(1024),
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (complaint_id)
);

ALTER TABLE complaint COMMENT '投诉';

/*==============================================================*/
/* Table: complaint_deal                                        */
/*==============================================================*/
CREATE TABLE complaint_deal
(
   complaint_deal_id    INT NOT NULL AUTO_INCREMENT,
   complaint_id         INT,
   user_id              INT,
   result               VARCHAR(1024),
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (complaint_deal_id)
);

ALTER TABLE complaint_deal COMMENT '投诉处理';

/*==============================================================*/
/* Table: extraordinary_fee                                     */
/*==============================================================*/
CREATE TABLE extraordinary_fee
(
   extraordinary_fee_id INT NOT NULL AUTO_INCREMENT,
   room_id              INT NOT NULL,
   acct_item_type_id    INT,
   amount               FLOAT,
   user_id              INT,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (extraordinary_fee_id)
);

ALTER TABLE extraordinary_fee COMMENT '其它费用';

/*==============================================================*/
/* Table: meter_inst                                            */
/*==============================================================*/
CREATE TABLE meter_inst
(
   meter_inst_id        INT NOT NULL AUTO_INCREMENT,
   meter_spec_id        INT NOT NULL,
   price                FLOAT COMMENT '如果为空按规格上来，否则按配置的来',
   class_id             CHAR(10),
   obj_id               INT,
   FLOOR                SMALLINT COMMENT '所属主体为当为楼栋或单元时，可设置楼层',
   elevator             VARCHAR(6) COMMENT '所属主体为当为楼栋或单元时，可设置电梯',
   last_read            FLOAT,
   current_read         FLOAT,
   share_charge_type    CHAR(2) COMMENT '10：小区用量公摊
            11：小区平均公摊
            12：楼栋用量公摊
            13：楼栋平均公摊',
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (meter_inst_id)
);

ALTER TABLE meter_inst COMMENT '费表实例';

/*==============================================================*/
/* Table: meter_read                                            */
/*==============================================================*/
CREATE TABLE meter_read
(
   meter_read_id        INT NOT NULL AUTO_INCREMENT,
   meter_inst_id        INT NOT NULL,
   last_read            FLOAT,
   current_read         FLOAT,
   `usage`              FLOAT COMMENT '当期读数-上期读数',
   MONTH                CHAR(6) COMMENT '年月',
   price                FLOAT COMMENT '收费标准固化',
   fee                  FLOAT COMMENT '本期费用，本期用量*收费标准',
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (meter_read_id)
);

ALTER TABLE meter_read COMMENT '费表读数';

/*==============================================================*/
/* Table: meter_spec                                            */
/*==============================================================*/
CREATE TABLE meter_spec
(
   meter_spec_id        INT NOT NULL AUTO_INCREMENT,
   meter_type           CHAR(2) NOT NULL COMMENT '10：水表，11：电表，12：气表',
   parent_meter_id      INT,
   meter_name           VARCHAR(50) NOT NULL,
   unit                 CHAR(2) COMMENT '10：吨，11:度，12：立方米',
   price                FLOAT COMMENT '包月',
   class_id             CHAR(2),
   attribute_55         INT,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (meter_spec_id)
);

ALTER TABLE meter_spec COMMENT '费表规格';

/*==============================================================*/
/* Table: monthly_balance                                       */
/*==============================================================*/
CREATE TABLE monthly_balance
(
   monthly_balance_id   INT NOT NULL AUTO_INCREMENT,
   community_id         INT NOT NULL,
   class_id             CHAR(2),
   obj_id               INT,
   MONTH                CHAR(6),
   SUM                  FLOAT,
   surcharge_start_date TIMESTAMP,
   surcharge_rate       FLOAT,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (monthly_balance_id)
);

ALTER TABLE monthly_balance COMMENT '月结表';

/*==============================================================*/
/* Table: monthly_balance_detail                                */
/*==============================================================*/
CREATE TABLE monthly_balance_detail
(
   monthly_detail_id    INT NOT NULL AUTO_INCREMENT,
   monthly_balance_id   INT NOT NULL,
   fee_name             VARCHAR(20),
   amount               FLOAT,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (monthly_detail_id)
);

ALTER TABLE monthly_balance_detail COMMENT '月结明细';

/*==============================================================*/
/* Table: notice                                                */
/*==============================================================*/
CREATE TABLE notice
(
   notice_id            INT NOT NULL AUTO_INCREMENT,
   notice_type          CHAR(2) COMMENT '10：停水停电通知、11：缴费通知、12：物业通知、13：其他通知',
   title                VARCHAR(200),
   content              LONGBLOB,
   create_staff         INT NOT NULL,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (notice_id)
);

ALTER TABLE notice COMMENT '通知';

/*==============================================================*/
/* Table: notice_rel                                            */
/*==============================================================*/
CREATE TABLE notice_rel
(
   notice_rel_id        INT NOT NULL AUTO_INCREMENT,
   notice_id            INT NOT NULL,
   class_id             CHAR(2),
   obj_id               INT NOT NULL,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (notice_rel_id)
);

ALTER TABLE notice_rel COMMENT '通知关联';

/*==============================================================*/
/* Table: opinion                                               */
/*==============================================================*/
CREATE TABLE opinion
(
   opinion_id           INT NOT NULL AUTO_INCREMENT,
   parent_opinion_id    INT,
   title                VARCHAR(200) NOT NULL,
   conent               LONGBLOB,
   user_id              INT NOT NULL,
   class_id             CHAR(2),
   obj_id               INT NOT NULL,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (opinion_id)
);

ALTER TABLE opinion COMMENT '意见';

/*==============================================================*/
/* Table: organization                                          */
/*==============================================================*/
CREATE TABLE organization
(
   org_id               INT NOT NULL AUTO_INCREMENT,
   org_name             VARCHAR(50) NOT NULL,
   org_type             CHAR(2) NOT NULL COMMENT '10：物业公司，11：小区，13：其它',
   up_org_id            INT NOT NULL,
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (org_id)
);

ALTER TABLE organization COMMENT '单位信息';

/*==============================================================*/
/* Table: parking                                               */
/*==============================================================*/
CREATE TABLE parking
(
   parking_id           INT NOT NULL AUTO_INCREMENT,
   parking_type_id      INT NOT NULL,
   parking_nbr          VARCHAR(10),
   parking_position     VARCHAR(100),
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (parking_id)
);

ALTER TABLE parking COMMENT '车位';

/*==============================================================*/
/* Table: parking_type                                          */
/*==============================================================*/
CREATE TABLE parking_type
(
   parking_type_id      INT NOT NULL AUTO_INCREMENT,
   parking_type         VARCHAR(20),
   price                FLOAT COMMENT '包月',
   remark               VARCHAR(500),
   PRIMARY KEY (parking_type_id)
);

ALTER TABLE parking_type COMMENT '车位类型';

/*==============================================================*/
/* Table: party_info                                            */
/*==============================================================*/
CREATE TABLE party_info
(
   party_info_id        INT NOT NULL AUTO_INCREMENT,
   party_name           VARCHAR(50) NOT NULL,
   class_id             CHAR(3) NOT NULL COMMENT '10：用户，11：物业，12：小区',
   obj_id               INT NOT NULL,
   address_id           INT,
   cert_nbr             VARCHAR(50),
   cert_type            CHAR(2) COMMENT '10：身份证，11：组织机构代码证，12：营业执照',
   mobile               CHAR(11),
   home_phone           VARCHAR(20),
   office_phone         VARCHAR(20),
   fax                  VARCHAR(50),
   email                VARCHAR(50),
   qq                   VARCHAR(20),
   wei_xin              VARCHAR(20),
   PRIMARY KEY (party_info_id)
);

ALTER TABLE party_info COMMENT '人员信息表';

/*==============================================================*/
/* Table: pay_record                                            */
/*==============================================================*/
CREATE TABLE pay_record
(
   pay_record_id        INT NOT NULL AUTO_INCREMENT,
   account_record_id    INT NOT NULL,
   monthly_balance_id   INT NOT NULL,
   room_id              INT NOT NULL,
   amount               FLOAT,
   remark               TEXT,
   pay_method           CHAR(10) COMMENT '10：现金，11：预存款，12：微信支付，13：易信支付',
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (pay_record_id)
);

ALTER TABLE pay_record COMMENT '缴费记录';

/*==============================================================*/
/* Table: privilege                                             */
/*==============================================================*/
CREATE TABLE privilege
(
   privilege_id         INT NOT NULL AUTO_INCREMENT,
   privilege_name       VARCHAR(20) NOT NULL,
   path                 VARCHAR(50),
   parent_privilege_id  INT,
   privilege_code       VARCHAR(4),
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (privilege_id)
);

ALTER TABLE privilege COMMENT '权限';

/*==============================================================*/
/* Table: property_company                                      */
/*==============================================================*/
CREATE TABLE property_company
(
   company_id           INT NOT NULL AUTO_INCREMENT,
   org_id               INT NOT NULL,
   party_info_id        INT NOT NULL,
   company_name         VARCHAR(50),
   simple_name          VARCHAR(50),
   bank_acct_name       VARCHAR(50),
   bank_name            VARCHAR(50),
   bank_acct_nbr        VARCHAR(20),
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (company_id)
);

ALTER TABLE property_company COMMENT '物业公司';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
CREATE TABLE role
(
   role_id              INT NOT NULL AUTO_INCREMENT,
   role_name            VARCHAR(20) NOT NULL,
   status_cd            VARCHAR(4) NOT NULL,
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (role_id)
);

ALTER TABLE role COMMENT '系统角色';

/*==============================================================*/
/* Table: role_privilege                                        */
/*==============================================================*/
CREATE TABLE role_privilege
(
   role_privilege_id    INT NOT NULL AUTO_INCREMENT,
   role_id              INT NOT NULL,
   privilege_id         INT NOT NULL,
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (role_privilege_id)
);

ALTER TABLE role_privilege COMMENT '角色权限关系';

/*==============================================================*/
/* Table: room                                                  */
/*==============================================================*/
CREATE TABLE room
(
   room_id              INT NOT NULL AUTO_INCREMENT,
   building_id          INT NOT NULL,
   building_type_id     INT,
   room_nbr             VARCHAR(10) NOT NULL,
   FLOOR                VARCHAR(5) NOT NULL,
   building_structure   VARCHAR(10),
   housing_orientation  VARCHAR(10),
   using_state          VARCHAR(10),
   upgrade_condition    VARCHAR(50),
   housing_fee_rate     FLOAT,
   upgrade_start_date   TIMESTAMP,
   upgrade_end_date     TIMESTAMP,
   housed_date          TIMESTAMP,
   PRIMARY KEY (room_id)
);

ALTER TABLE room COMMENT '房间';

/*==============================================================*/
/* Table: room_party_rel                                        */
/*==============================================================*/
CREATE TABLE room_party_rel
(
   room_party_rel_id    INT NOT NULL AUTO_INCREMENT,
   party_info_id        INT NOT NULL,
   room_id              INT NOT NULL,
   rel_type             CHAR(2) COMMENT '10：业主，11：其它',
   remark               VARCHAR(200),
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (room_party_rel_id)
);

ALTER TABLE room_party_rel COMMENT '人员房间关联';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
CREATE TABLE USER
(
   user_id              INT NOT NULL AUTO_INCREMENT,
   account              VARCHAR(20) NOT NULL,
   pwd                  VARCHAR(200) NOT NULL,
   user_type            CHAR(2) NOT NULL COMMENT '10：系统用户，11：物业，12：业主',
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (user_id)
);

ALTER TABLE USER COMMENT '用户表';

/*==============================================================*/
/* Table: user_auth                                             */
/*==============================================================*/
CREATE TABLE user_auth
(
   user_auth_id         INT NOT NULL AUTO_INCREMENT,
   role_id              INT,
   user_id              INT NOT NULL,
   privilege_id         INT,
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (user_auth_id)
);

ALTER TABLE user_auth COMMENT '用户授权';

/*==============================================================*/
/* Table: user_org_rel                                          */
/*==============================================================*/
CREATE TABLE user_org_rel
(
   user_org_rel_id      INT NOT NULL AUTO_INCREMENT,
   org_id               INT NOT NULL,
   user_id              INT NOT NULL,
   status_cd            VARCHAR(4),
   create_date          TIMESTAMP,
   status_date          TIMESTAMP,
   update_date          TIMESTAMP,
   PRIMARY KEY (user_org_rel_id)
);

ALTER TABLE user_org_rel COMMENT '用户单位关系';

/*==============================================================*/
/* Table: vehicle                                               */
/*==============================================================*/
CREATE TABLE vehicle
(
   vehicle_id           INT NOT NULL AUTO_INCREMENT,
   plate_nbr            VARCHAR(10),
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (vehicle_id)
);

ALTER TABLE vehicle COMMENT '车辆';

/*==============================================================*/
/* Table: vehicle_rel                                           */
/*==============================================================*/
CREATE TABLE vehicle_rel
(
   vehicle_rel_id       INT NOT NULL AUTO_INCREMENT,
   parking_type_id      INT NOT NULL,
   room_id              INT NOT NULL,
   vehicle_id           INT NOT NULL,
   parking_id           INT,
   create_date          TIMESTAMP,
   update_date          TIMESTAMP,
   status_cd            VARCHAR(4),
   status_date          TIMESTAMP,
   PRIMARY KEY (vehicle_rel_id)
);

ALTER TABLE vehicle_rel COMMENT '车辆关联';

/*==============================================================*/
/* Index: fk_parking_id                                         */
/*==============================================================*/
CREATE INDEX fk_parking_id ON vehicle_rel
(
   parking_id
);

ALTER TABLE account_record ADD CONSTRAINT fk_relationship_33 FOREIGN KEY (account_id)
      REFERENCES account (account_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE acct_item_rel ADD CONSTRAINT fk_relationship_38 FOREIGN KEY (acct_item_type_id)
      REFERENCES acct_item_type (acct_item_type_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE address ADD CONSTRAINT fk_relationship_1 FOREIGN KEY (area_id)
      REFERENCES AREA (area_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE attr_value ADD CONSTRAINT fk_relationship_17 FOREIGN KEY (attr_id)
      REFERENCES attr_spec (attr_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE building ADD CONSTRAINT fk_reference_12 FOREIGN KEY (party_info_id)
      REFERENCES party_info (party_info_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE building ADD CONSTRAINT fk_relationship_15 FOREIGN KEY (community_id)
      REFERENCES community (community_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE community ADD CONSTRAINT fk_relationship_10 FOREIGN KEY (company_id)
      REFERENCES property_company (company_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE community ADD CONSTRAINT fk_relationship_14 FOREIGN KEY (org_id)
      REFERENCES organization (org_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE community ADD CONSTRAINT fk_relationship_18 FOREIGN KEY (party_info_id)
      REFERENCES party_info (party_info_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE complaint_deal ADD CONSTRAINT fk_reference_3 FOREIGN KEY (complaint_id)
      REFERENCES complaint (complaint_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE complaint_deal ADD CONSTRAINT fk_reference_4 FOREIGN KEY (user_id)
      REFERENCES USER (user_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE extraordinary_fee ADD CONSTRAINT fk_relationship_28 FOREIGN KEY (acct_item_type_id)
      REFERENCES acct_item_type (acct_item_type_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE extraordinary_fee ADD CONSTRAINT fk_relationship_29 FOREIGN KEY (room_id)
      REFERENCES room (room_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE meter_inst ADD CONSTRAINT fk_relationship_26 FOREIGN KEY (meter_spec_id)
      REFERENCES meter_spec (meter_spec_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE meter_read ADD CONSTRAINT fk_relationship_27 FOREIGN KEY (meter_inst_id)
      REFERENCES meter_inst (meter_inst_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE monthly_balance ADD CONSTRAINT fk_relationship_31 FOREIGN KEY (community_id)
      REFERENCES community (community_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE monthly_balance_detail ADD CONSTRAINT fk_relationship_39 FOREIGN KEY (monthly_balance_id)
      REFERENCES monthly_balance (monthly_balance_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE notice_rel ADD CONSTRAINT fk_relationship_32 FOREIGN KEY (notice_id)
      REFERENCES notice (notice_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE parking ADD CONSTRAINT fk_relationship_23 FOREIGN KEY (parking_type_id)
      REFERENCES parking_type (parking_type_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE party_info ADD CONSTRAINT fk_relationship_13 FOREIGN KEY (address_id)
      REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE pay_record ADD CONSTRAINT fk_relationship_30 FOREIGN KEY (monthly_balance_id)
      REFERENCES monthly_balance (monthly_balance_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE pay_record ADD CONSTRAINT fk_relationship_40 FOREIGN KEY (account_record_id)
      REFERENCES account_record (account_record_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE property_company ADD CONSTRAINT fk_relationship_11 FOREIGN KEY (party_info_id)
      REFERENCES party_info (party_info_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE property_company ADD CONSTRAINT fk_relationship_6 FOREIGN KEY (org_id)
      REFERENCES organization (org_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE role_privilege ADD CONSTRAINT fk_relationship_4 FOREIGN KEY (privilege_id)
      REFERENCES privilege (privilege_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE role_privilege ADD CONSTRAINT fk_relationship_5 FOREIGN KEY (role_id)
      REFERENCES role (role_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE room ADD CONSTRAINT fk_reference_11 FOREIGN KEY (building_type_id)
      REFERENCES building_type (building_type_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE room ADD CONSTRAINT fk_relationship_20 FOREIGN KEY (building_id)
      REFERENCES building (building_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE room_party_rel ADD CONSTRAINT fk_relationship_22 FOREIGN KEY (room_id)
      REFERENCES room (room_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE room_party_rel ADD CONSTRAINT fk_relationship_34 FOREIGN KEY (party_info_id)
      REFERENCES party_info (party_info_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE user_auth ADD CONSTRAINT fk_relationship_3 FOREIGN KEY (user_id)
      REFERENCES USER (user_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE user_auth ADD CONSTRAINT fk_relationship_7 FOREIGN KEY (role_id)
      REFERENCES role (role_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE user_auth ADD CONSTRAINT fk_relationship_8 FOREIGN KEY (privilege_id)
      REFERENCES privilege (privilege_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE user_org_rel ADD CONSTRAINT fk_relationship_12 FOREIGN KEY (org_id)
      REFERENCES organization (org_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE user_org_rel ADD CONSTRAINT fk_relationship_9 FOREIGN KEY (user_id)
      REFERENCES USER (user_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE vehicle_rel ADD CONSTRAINT fk_reference_13 FOREIGN KEY (vehicle_id)
      REFERENCES vehicle (vehicle_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE vehicle_rel ADD CONSTRAINT fk_relationship_25 FOREIGN KEY (room_id)
      REFERENCES room (room_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE vehicle_rel ADD CONSTRAINT fk_relationship_36 FOREIGN KEY (parking_id)
      REFERENCES parking (parking_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE vehicle_rel ADD CONSTRAINT fk_relationship_37 FOREIGN KEY (parking_type_id)
      REFERENCES parking_type (parking_type_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

SET FOREIGN_KEY_CHECKS = 1; 