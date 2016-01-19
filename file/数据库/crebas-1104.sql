/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/11/4 21:19:08                           */
/*==============================================================*/


drop table if exists account;

drop table if exists account_record;

drop table if exists acct_item_rel;

drop table if exists acct_item_type;

drop table if exists address;

drop table if exists area;

drop index pk_attr_id on attr_spec;

drop table if exists attr_spec;

drop index fk_community on attr_value;

drop table if exists attr_value;

drop table if exists building;

drop table if exists building_type;

drop table if exists community;

drop table if exists complaint;

drop table if exists complaint_deal;

drop table if exists extraordinary_fee;

drop table if exists meter_inst;

drop table if exists meter_read;

drop table if exists meter_spec;

drop table if exists monthly_balance;

drop table if exists monthly_balance_detail;

drop table if exists notice;

drop table if exists notice_rel;

drop table if exists opinion;

drop table if exists organization;

drop table if exists parking;

drop table if exists parking_type;

drop table if exists party_info;

drop table if exists pay_record;

drop table if exists privilege;

drop table if exists property_company;

drop table if exists role;

drop table if exists role_privilege;

drop table if exists room;

drop table if exists room_party_rel;

drop table if exists user;

drop table if exists user_auth;

drop table if exists user_org_rel;

drop table if exists vehicle;

drop index fk_parking_id on vehicle_rel;

drop table if exists vehicle_rel;

/*==============================================================*/
/* Table: account                                               */
/*==============================================================*/
create table account
(
   account_id           int not null auto_increment,
   balance              float,
   class_id             char(2) comment '10：物业公司，11：小区，12：房间',
   obj_id               int not null,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (account_id)
);

alter table account comment '账户';

/*==============================================================*/
/* Table: account_record                                        */
/*==============================================================*/
create table account_record
(
   account_record_id    int not null auto_increment,
   account_id           int not null,
   amount               float,
   last_balance         float,
   remark               varchar(1024),
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (account_record_id)
);

alter table account_record comment '账户明细';

/*==============================================================*/
/* Table: acct_item_rel                                         */
/*==============================================================*/
create table acct_item_rel
(
   acct_item_rel_id     int not null auto_increment,
   acct_item_type_id    int,
   class_id             char(2) comment '10：小区，11：楼栋或单元，12：房间',
   obj_id               int,
   price                float,
   floor                int comment '配置某个楼层的收费，用于电梯',
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (acct_item_rel_id)
);

alter table acct_item_rel comment '设置小区，楼栋的收费项目';

/*==============================================================*/
/* Table: acct_item_type                                        */
/*==============================================================*/
create table acct_item_type
(
   acct_item_type_id    int not null auto_increment,
   acct_type_name       varchar(50),
   acct_type            char(2),
   parent_acct_type_id  int,
   class_id             char(2),
   obj_id               int,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (acct_item_type_id)
);

alter table acct_item_type comment '费用类型';

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   address_id           int not null auto_increment,
   area_id              int not null,
   detail_address       varchar(50),
   primary key (address_id)
);

alter table address comment '地址';

/*==============================================================*/
/* Table: area                                                  */
/*==============================================================*/
create table area
(
   area_id              int not null auto_increment,
   area_name            varchar(50),
   area_type            char(2) comment '10：省，12：市，13：县或区',
   up_area_id           int not null,
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (area_id)
);

alter table area comment '地区';

/*==============================================================*/
/* Table: attr_spec                                             */
/*==============================================================*/
create table attr_spec
(
   attr_id              int not null auto_increment,
   attr_name            varchar(50) not null,
   attr_code            varchar(10) not null,
   class_id             char(2) comment '10：小区，',
   attr_value_type      char(2) comment '10：时间类型，11：字符类型',
   attr_type            char(2) comment '10：输入属性，11：选择属性',
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (attr_id)
);

alter table attr_spec comment '属性表';

/*==============================================================*/
/* Index: pk_attr_id                                            */
/*==============================================================*/
create unique index pk_attr_id on attr_spec
(
   attr_id
);

/*==============================================================*/
/* Table: attr_value                                            */
/*==============================================================*/
create table attr_value
(
   attr_value_id        int not null,
   attr_id              int,
   attr_value_name      varchar(50),
   attr_value           varchar(200),
   community            int not null,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (attr_value_id)
);

alter table attr_value comment '属性值表';

/*==============================================================*/
/* Index: fk_community                                          */
/*==============================================================*/
create index fk_community on attr_value
(
   community
);

/*==============================================================*/
/* Table: building                                              */
/*==============================================================*/
create table building
(
   building_id          int not null auto_increment,
   community_id         int not null,
   party_info_id        int,
   building_name        varchar(50),
   building_type        char(2) comment '10：楼栋，11：单元',
   owner_building       int not null,
   phone                varchar(20),
   floor_count          int,
   stair_area           float,
   userable_area        float,
   afforest_area        float,
   ownership_type       varchar(50),
   building_structure   varchar(50),
   upgrade_condition    varchar(50),
   finish_time          timestamp,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (building_id)
);

alter table building comment '楼栋单元';

/*==============================================================*/
/* Table: building_type                                         */
/*==============================================================*/
create table building_type
(
   building_type_id     int not null auto_increment,
   building_area        float,
   comprising_area      float,
   public_area          float,
   cost_area            float,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (building_type_id)
);

alter table building_type comment '房屋类型';

/*==============================================================*/
/* Table: community                                             */
/*==============================================================*/
create table community
(
   community_id         int not null auto_increment,
   org_id               int not null,
   company_id           int not null,
   party_info_id        int not null,
   community_name       varchar(50) not null,
   simple_name          varchar(50),
   community_area       float comment '单位',
   building_area        float,
   afforest_area        float,
   bank_acct_name       varchar(50),
   bank_name            varchar(50),
   bank_acct_nbr        varchar(20),
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (community_id)
);

alter table community comment '小区';

/*==============================================================*/
/* Table: complaint                                             */
/*==============================================================*/
create table complaint
(
   complaint_id         int not null auto_increment,
   title                varchar(200) not null,
   content              varchar(1024),
   complainter_id       int,
   complainter          varchar(50),
   complainter_phone    varchar(20),
   recorder_id          int,
   recorder             varchar(50),
   recorder_phone       varchar(20),
   result               char(2) not null,
   opinion              varchar(1024),
   remark               varchar(1024),
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (complaint_id)
);

alter table complaint comment '投诉';

/*==============================================================*/
/* Table: complaint_deal                                        */
/*==============================================================*/
create table complaint_deal
(
   complaint_deal_id    int not null auto_increment,
   complaint_id         int,
   user_id              int,
   result               varchar(1024),
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (complaint_deal_id)
);

alter table complaint_deal comment '投诉处理';

/*==============================================================*/
/* Table: extraordinary_fee                                     */
/*==============================================================*/
create table extraordinary_fee
(
   extraordinary_fee_id int not null auto_increment,
   room_id              int not null,
   acct_item_type_id    int,
   amount               float,
   user_id              int,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (extraordinary_fee_id)
);

alter table extraordinary_fee comment '其它费用';

/*==============================================================*/
/* Table: meter_inst                                            */
/*==============================================================*/
create table meter_inst
(
   meter_inst_id        int not null auto_increment,
   meter_spec_id        int not null,
   price                float comment '如果为空按规格上来，否则按配置的来',
   class_id             char(10),
   obj_id               int,
   floor                smallint comment '所属主体为当为楼栋或单元时，可设置楼层',
   elevator             varchar(6) comment '所属主体为当为楼栋或单元时，可设置电梯',
   last_read            float,
   current_read         float,
   share_charge_type    char(2) comment '10：小区用量公摊
            11：小区平均公摊
            12：楼栋用量公摊
            13：楼栋平均公摊',
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (meter_inst_id)
);

alter table meter_inst comment '费表实例';

/*==============================================================*/
/* Table: meter_read                                            */
/*==============================================================*/
create table meter_read
(
   meter_read_id        int not null auto_increment,
   meter_inst_id        int not null,
   last_read            float,
   current_read         float,
   "usage"              float comment '当期读数-上期读数',
   month                char(6) comment '年月',
   price                float comment '收费标准固化',
   fee                  float comment '本期费用，本期用量*收费标准',
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (meter_read_id)
);

alter table meter_read comment '费表读数';

/*==============================================================*/
/* Table: meter_spec                                            */
/*==============================================================*/
create table meter_spec
(
   meter_spec_id        int not null auto_increment,
   meter_type           char(2) not null comment '10：水表，11：电表，12：气表',
   parent_meter_id      int,
   meter_name           varchar(50) not null,
   unit                 char(2) comment '10：吨，11:度，12：立方米',
   price                float comment '包月',
   class_id             char(2),
   attribute_55         int,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (meter_spec_id)
);

alter table meter_spec comment '费表规格';

/*==============================================================*/
/* Table: monthly_balance                                       */
/*==============================================================*/
create table monthly_balance
(
   monthly_balance_id   int not null auto_increment,
   community_id         int not null,
   class_id             char(2),
   obj_id               int,
   month                char(6),
   sum                  float,
   surcharge_start_date timestamp,
   surcharge_rate       float,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (monthly_balance_id)
);

alter table monthly_balance comment '月结表';

/*==============================================================*/
/* Table: monthly_balance_detail                                */
/*==============================================================*/
create table monthly_balance_detail
(
   monthly_detail_id    int not null auto_increment,
   monthly_balance_id   int not null,
   fee_name             varchar(20),
   amount               float,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (monthly_detail_id)
);

alter table monthly_balance_detail comment '月结明细';

/*==============================================================*/
/* Table: notice                                                */
/*==============================================================*/
create table notice
(
   notice_id            int not null auto_increment,
   notice_type          char(2) comment '10：停水停电通知、11：缴费通知、12：物业通知、13：其他通知',
   title                varchar(200),
   content              longblob,
   create_staff         int not null,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (notice_id)
);

alter table notice comment '通知';

/*==============================================================*/
/* Table: notice_rel                                            */
/*==============================================================*/
create table notice_rel
(
   notice_rel_id        int not null auto_increment,
   notice_id            int not null,
   class_id             char(2),
   obj_id               int not null,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (notice_rel_id)
);

alter table notice_rel comment '通知关联';

/*==============================================================*/
/* Table: opinion                                               */
/*==============================================================*/
create table opinion
(
   opinion_id           int not null auto_increment,
   parent_opinion_id    int,
   title                varchar(200) not null,
   conent               longblob,
   user_id              int not null,
   class_id             char(2),
   obj_id               int not null,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (opinion_id)
);

alter table opinion comment '意见';

/*==============================================================*/
/* Table: organization                                          */
/*==============================================================*/
create table organization
(
   org_id               int not null auto_increment,
   org_name             varchar(50) not null,
   org_type             char(2) not null comment '10：物业公司，11：小区，13：其它',
   up_org_id            int not null,
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (org_id)
);

alter table organization comment '单位信息';

/*==============================================================*/
/* Table: parking                                               */
/*==============================================================*/
create table parking
(
   parking_id           int not null auto_increment,
   parking_type_id      int not null,
   parking_nbr          varchar(10),
   parking_position     varchar(100),
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (parking_id)
);

alter table parking comment '车位';

/*==============================================================*/
/* Table: parking_type                                          */
/*==============================================================*/
create table parking_type
(
   parking_type_id      int not null auto_increment,
   parking_type         varchar(20),
   price                float comment '包月',
   remark               varchar(500),
   primary key (parking_type_id)
);

alter table parking_type comment '车位类型';

/*==============================================================*/
/* Table: party_info                                            */
/*==============================================================*/
create table party_info
(
   party_info_id        int not null auto_increment,
   party_name           varchar(50) not null,
   class_id             char(3) not null comment '10：用户，11：物业，12：小区',
   obj_id               int not null,
   address_id           int,
   cert_nbr             varchar(50),
   cert_type            char(2) comment '10：身份证，11：组织机构代码证，12：营业执照',
   mobile               char(11),
   home_phone           varchar(20),
   office_phone         varchar(20),
   fax                  varchar(50),
   email                varchar(50),
   qq                   varchar(20),
   wei_xin              varchar(20),
   primary key (party_info_id)
);

alter table party_info comment '人员信息表';

/*==============================================================*/
/* Table: pay_record                                            */
/*==============================================================*/
create table pay_record
(
   pay_record_id        int not null auto_increment,
   account_record_id    int not null,
   monthly_balance_id   int not null,
   room_id              int not null,
   amount               float,
   remark               text,
   pay_method           char(10) comment '10：现金，11：预存款，12：微信支付，13：易信支付',
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (pay_record_id)
);

alter table pay_record comment '缴费记录';

/*==============================================================*/
/* Table: privilege                                             */
/*==============================================================*/
create table privilege
(
   privilege_id         int not null auto_increment,
   privilege_name       varchar(20) not null,
   path                 varchar(50),
   parent_privilege_id  int,
   privilege_code       varchar(4),
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (privilege_id)
);

alter table privilege comment '权限';

/*==============================================================*/
/* Table: property_company                                      */
/*==============================================================*/
create table property_company
(
   company_id           int not null auto_increment,
   org_id               int not null,
   party_info_id        int not null,
   company_name         varchar(50),
   simple_name          varchar(50),
   bank_acct_name       varchar(50),
   bank_name            varchar(50),
   bank_acct_nbr        varchar(20),
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (company_id)
);

alter table property_company comment '物业公司';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   role_id              int not null auto_increment,
   role_name            varchar(20) not null,
   status_cd            varchar(4) not null,
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (role_id)
);

alter table role comment '系统角色';

/*==============================================================*/
/* Table: role_privilege                                        */
/*==============================================================*/
create table role_privilege
(
   role_privilege_id    int not null auto_increment,
   role_id              int not null,
   privilege_id         int not null,
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (role_privilege_id)
);

alter table role_privilege comment '角色权限关系';

/*==============================================================*/
/* Table: room                                                  */
/*==============================================================*/
create table room
(
   room_id              int not null auto_increment,
   building_id          int not null,
   building_type_id     int,
   room_nbr             varchar(10) not null,
   floor                varchar(5) not null,
   building_structure   varchar(10),
   housing_orientation  varchar(10),
   using_state          varchar(10),
   upgrade_condition    varchar(50),
   housing_fee_rate     float,
   upgrade_start_date   timestamp,
   upgrade_end_date     timestamp,
   housed_date          timestamp,
   primary key (room_id)
);

alter table room comment '房间';

/*==============================================================*/
/* Table: room_party_rel                                        */
/*==============================================================*/
create table room_party_rel
(
   room_party_rel_id    int not null auto_increment,
   party_info_id        int not null,
   room_id              int not null,
   rel_type             char(2) comment '10：业主，11：其它',
   remark               varchar(200),
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (room_party_rel_id)
);

alter table room_party_rel comment '人员房间关联';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null auto_increment,
   account              varchar(20) not null,
   pwd                  varchar(200) not null,
   user_type            char(2) not null comment '10：系统用户，11：物业，12：业主',
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (user_id)
);

alter table user comment '用户表';

/*==============================================================*/
/* Table: user_auth                                             */
/*==============================================================*/
create table user_auth
(
   user_auth_id         int not null auto_increment,
   role_id              int,
   user_id              int not null,
   privilege_id         int,
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (user_auth_id)
);

alter table user_auth comment '用户授权';

/*==============================================================*/
/* Table: user_org_rel                                          */
/*==============================================================*/
create table user_org_rel
(
   user_org_rel_id      int not null auto_increment,
   org_id               int not null,
   user_id              int not null,
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (user_org_rel_id)
);

alter table user_org_rel comment '用户单位关系';

/*==============================================================*/
/* Table: vehicle                                               */
/*==============================================================*/
create table vehicle
(
   vehicle_id           int not null auto_increment,
   plate_nbr            varchar(10),
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (vehicle_id)
);

alter table vehicle comment '车辆';

/*==============================================================*/
/* Table: vehicle_rel                                           */
/*==============================================================*/
create table vehicle_rel
(
   vehicle_rel_id       int not null auto_increment,
   parking_type_id      int not null,
   room_id              int not null,
   vehicle_id           int not null,
   parking_id           int,
   create_date          timestamp,
   update_date          timestamp,
   status_cd            varchar(4),
   status_date          timestamp,
   primary key (vehicle_rel_id)
);

alter table vehicle_rel comment '车辆关联';

/*==============================================================*/
/* Index: fk_parking_id                                         */
/*==============================================================*/
create index fk_parking_id on vehicle_rel
(
   parking_id
);

alter table account_record add constraint fk_relationship_33 foreign key (account_id)
      references account (account_id) on delete restrict on update restrict;

alter table acct_item_rel add constraint fk_relationship_38 foreign key (acct_item_type_id)
      references acct_item_type (acct_item_type_id) on delete restrict on update restrict;

alter table address add constraint fk_relationship_1 foreign key (area_id)
      references area (area_id) on delete restrict on update restrict;

alter table attr_value add constraint fk_relationship_17 foreign key (attr_id)
      references attr_spec (attr_id) on delete restrict on update restrict;

alter table building add constraint fk_reference_12 foreign key (party_info_id)
      references party_info (party_info_id) on delete restrict on update restrict;

alter table building add constraint fk_relationship_15 foreign key (community_id)
      references community (community_id) on delete restrict on update restrict;

alter table community add constraint fk_relationship_10 foreign key (company_id)
      references property_company (company_id) on delete restrict on update restrict;

alter table community add constraint fk_relationship_14 foreign key (org_id)
      references organization (org_id) on delete restrict on update restrict;

alter table community add constraint fk_relationship_18 foreign key (party_info_id)
      references party_info (party_info_id) on delete restrict on update restrict;

alter table complaint_deal add constraint fk_reference_3 foreign key (complaint_id)
      references complaint (complaint_id) on delete restrict on update restrict;

alter table complaint_deal add constraint fk_reference_4 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table extraordinary_fee add constraint fk_relationship_28 foreign key (acct_item_type_id)
      references acct_item_type (acct_item_type_id) on delete restrict on update restrict;

alter table extraordinary_fee add constraint fk_relationship_29 foreign key (room_id)
      references room (room_id) on delete restrict on update restrict;

alter table meter_inst add constraint fk_relationship_26 foreign key (meter_spec_id)
      references meter_spec (meter_spec_id) on delete restrict on update restrict;

alter table meter_read add constraint fk_relationship_27 foreign key (meter_inst_id)
      references meter_inst (meter_inst_id) on delete restrict on update restrict;

alter table monthly_balance add constraint fk_relationship_31 foreign key (community_id)
      references community (community_id) on delete restrict on update restrict;

alter table monthly_balance_detail add constraint fk_relationship_39 foreign key (monthly_balance_id)
      references monthly_balance (monthly_balance_id) on delete restrict on update restrict;

alter table notice_rel add constraint fk_relationship_32 foreign key (notice_id)
      references notice (notice_id) on delete restrict on update restrict;

alter table parking add constraint fk_relationship_23 foreign key (parking_type_id)
      references parking_type (parking_type_id) on delete restrict on update restrict;

alter table party_info add constraint fk_relationship_13 foreign key (address_id)
      references address (address_id) on delete restrict on update restrict;

alter table pay_record add constraint fk_relationship_30 foreign key (monthly_balance_id)
      references monthly_balance (monthly_balance_id) on delete restrict on update restrict;

alter table pay_record add constraint fk_relationship_40 foreign key (account_record_id)
      references account_record (account_record_id) on delete restrict on update restrict;

alter table property_company add constraint fk_relationship_11 foreign key (party_info_id)
      references party_info (party_info_id) on delete restrict on update restrict;

alter table property_company add constraint fk_relationship_6 foreign key (org_id)
      references organization (org_id) on delete restrict on update restrict;

alter table role_privilege add constraint fk_relationship_4 foreign key (privilege_id)
      references privilege (privilege_id) on delete restrict on update restrict;

alter table role_privilege add constraint fk_relationship_5 foreign key (role_id)
      references role (role_id) on delete restrict on update restrict;

alter table room add constraint fk_reference_11 foreign key (building_type_id)
      references building_type (building_type_id) on delete restrict on update restrict;

alter table room add constraint fk_relationship_20 foreign key (building_id)
      references building (building_id) on delete restrict on update restrict;

alter table room_party_rel add constraint fk_relationship_22 foreign key (room_id)
      references room (room_id) on delete restrict on update restrict;

alter table room_party_rel add constraint fk_relationship_34 foreign key (party_info_id)
      references party_info (party_info_id) on delete restrict on update restrict;

alter table user_auth add constraint fk_relationship_3 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table user_auth add constraint fk_relationship_7 foreign key (role_id)
      references role (role_id) on delete restrict on update restrict;

alter table user_auth add constraint fk_relationship_8 foreign key (privilege_id)
      references privilege (privilege_id) on delete restrict on update restrict;

alter table user_org_rel add constraint fk_relationship_12 foreign key (org_id)
      references organization (org_id) on delete restrict on update restrict;

alter table user_org_rel add constraint fk_relationship_9 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table vehicle_rel add constraint fk_reference_13 foreign key (vehicle_id)
      references vehicle (vehicle_id) on delete restrict on update restrict;

alter table vehicle_rel add constraint fk_relationship_25 foreign key (room_id)
      references room (room_id) on delete restrict on update restrict;

alter table vehicle_rel add constraint fk_relationship_36 foreign key (parking_id)
      references parking (parking_id) on delete restrict on update restrict;

alter table vehicle_rel add constraint fk_relationship_37 foreign key (parking_type_id)
      references parking_type (parking_type_id) on delete restrict on update restrict;

