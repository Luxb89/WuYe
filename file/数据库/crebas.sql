/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/10/25 20:46:09                          */
/*==============================================================*/


drop table if exists area;

drop table if exists organization;

drop table if exists party_info;

drop table if exists privilege;

drop table if exists role;

drop table if exists role_privilege;

drop table if exists user;

drop table if exists user_auth;

drop table if exists user_org_rel;

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
/* Table: organization                                          */
/*==============================================================*/
create table organization
(
   org_id               int not null auto_increment,
   company_id           int not null,
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
/* Table: party_info                                            */
/*==============================================================*/
create table party_info
(
   party_info_id        int not null auto_increment,
   area_id              int not null,
   party_name           varchar(50) not null,
   party_type           char(2) comment '10：系统用户，11：物业公司负责人，12：小区负责人',
   cert_nbr             varchar(50),
   cert_type            char(2) comment '10：身份证，11：组织机构代码证，12：营业执照',
   mobile               char(11),
   address              varchar(50),
   office_phone         varchar(20),
   fax                  varchar(50),
   email                varchar(50),
   qq                   varchar(20),
   wei_xin              varchar(20),
   primary key (party_info_id)
);

alter table party_info comment '人员信息表';

/*==============================================================*/
/* Table: privilege                                             */
/*==============================================================*/
create table privilege
(
   privilege_id         int not null auto_increment,
   privilege_name       varchar(20) not null,
   path                 varchar(50),
   parent_privilege_id  int not null,
   status_cd            varchar(4),
   create_date          timestamp,
   status_date          timestamp,
   update_date          timestamp,
   primary key (privilege_id)
);

alter table privilege comment '权限';

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
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null auto_increment,
   party_info_id        int not null,
   account              varchar(20) not null,
   mobile               char(11),
   pwd                  varchar(200),
   area_name            varchar(50),
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
   role_id              int not null,
   user_id              int not null,
   privilege_id         int not null,
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

alter table party_info add constraint fk_relationship_13 foreign key (area_id)
      references area (area_id) on delete restrict on update restrict;

alter table role_privilege add constraint fk_relationship_4 foreign key (privilege_id)
      references privilege (privilege_id) on delete restrict on update restrict;

alter table role_privilege add constraint fk_relationship_5 foreign key (role_id)
      references role (role_id) on delete restrict on update restrict;

alter table user add constraint fk_relationship_11 foreign key (party_info_id)
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

