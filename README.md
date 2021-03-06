# daixijun.mysql

[![Build Status](https://github.com/daixijun/ansible-role-mysql/workflows/build/badge.svg)](https://github.com/daixijun/ansible-role-mysql/actions)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-daixijun.mysql-660198.svg?style=flat)](https://galaxy.ansible.com/daixijun/mysql/)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/daixijun/ansible-role-mysql?sort=semver)](https://github.com/daixijun/ansible-role-mysql/tags)

用于快速部署 mysql 集群

支持以下几种集群模式:

* [x] Master-Slave 基于GTID/binlog的主从复制
* [x] MGR 单主模式(默认)
* [x] MGR 多主模式

## 环境要求

* Centos 7+
* Ansible 2.9+
* MySQL 8.0+

## 变量

| 变量名                                      | 类型       | 默认值                      | 变量说明                                                                                                                                                              |
| ------------------------------------------- | ---------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| mysql_version                               | string     | 8.0.20                      | mysql 版本                                                                                                                                                            |
| mysql_download_url                          | string     |                             | 免安装压缩包下载地址                                                                                                                                                  |
| mysql_inventory_group                       | string     | mysql                       | Ansible 主机清单中的组名， 默认为 `mysql`， 其对应的 primary 与 secondary 组名分别为 `{{ mysql_inventory_group }}_primary` 与 `{{ mysql_inventory_group }}_secondary` |
| mysql_datadir                               | string     | /data/mysql                 |                                                                                                                                                                       | 数据存放目录                               |
| mysql_logdir                                | string     | /var/log/mysqld             | 日志存放目录                                                                                                                                                          |
| mysql_pidfile                               | string     | /var/run/mysqld/mysqld.pid  | PID文件位置                                                                                                                                                           |
| mysql_socket                                | string     | /var/run/mysqld/mysqld.sock | Socket文件位置                                                                                                                                                        |
| mysql_port                                  | int        | 3306                        | 监听端口                                                                                                                                                              |
| mysql_bind_address                          | string     | 0.0.0.0                     | 监听地址                                                                                                                                                              |
| mysql_interface                             | string     |                             | 指定网卡，默认使用除lo外的第一张网卡                                                                                                                                  |
| mysql_default_time_zone                     | string     | +8:00                       | 指定时区                                                                                                                                                              |
| mysql_character_set_server                  | string     | utf8mb4                     | 默认字符集                                                                                                                                                            |
| mysql_collation_server                      | string     | utf8mb4_general_ci          | 默认字符序                                                                                                                                                            |
| mysql_max_connections                       | string/int | 1005                        | 最大连接数                                                                                                                                                            |
| mysql_max_user_connections                  | string/int | 1000                        | 用户最大连接数，必须比 `mysql_max_connections` 小，需要给管理员预留几个连接用于处理异常情况                                                                           |
| mysql_max_connect_errors                    | string/int | 200                         | 最大错误连接数                                                                                                                                                        |
| mysql_root_password                         | string     |                             | root账号的密码                                                                                                                                                        |
| mysql_cluster_type                          | string     | mgr                         | 集群类型(默认 mgr) 可选 `mgr`(Mysql Group Replication)/`ms`(Master-Slave)                                                                                             |
| mysql_cluster_role                          | string     | primary                     | Primary-Secondary 模式下的实例角色，可选                                                                                                                              | `master`, `primary` / `slave`, `secondary` |
| mysql_replication_master                    | string     |                             | Master-Slave 模式下Master实例的名称                                                                                                                                   |
| mysql_replication_based                     | string     | gtid                        | 可选基于 `gtid` 或传统 `binlog` 方式进行复制(默认 gtid)                                                                                                               |
| mysql_repl_user                             | string     | repl                        | 用于主从/组复制的账号                                                                                                                                                 |
| mysql_repl_password                         | string     |                             | 用于主从/组复制的账号的密码                                                                                                                                           |
| mysql_group_replication_name                | uuid       |                             | 组复制集群名,在mysql中使用`SELECT UUID()`或shell中使用`uuidgen`生成                                                                                                   |
| mysql_group_replication_single_primary_mode | bool       | true                        | MGR集群是否为单主模式                                                                                                                                                 |
| mysql_innodb_cluster_enable                 | bool       | true                        | 是否开启 Innodb Cluster                                                                                                                                               |
| mysql_innodb_cluster_name                   | string     | default                     | Innodb Cluster 名称                                                                                                                                                   |
| mysql_innodb_cluster_username               | string     | ic                          | 用于创建和管理 Innodb Cluster 的账号，需要具备 `ALL WITH GRANT OPTION` 权限                                                                                           |
| mysql_innodb_cluster_password               | string     | ""                          | 管理密码                                                                                                                                                              |
| mysql_proxysql_config                       | bool       | false                       | 是否使用 proysql 做为代理层                                                                                                                                           |
| mysql_proxysql_monitor_username             | string     | monitor                     | proxysql 监控mgr状态的账号                                                                                                                                            |
| mysql_proxysql_monitor_password             | string     | ""                          | proxysql 监控mgr状态的密码                                                                                                                                            |
| mysql_databases                             | array      | []                          | 需要创建的业务数据库                                                                                                                                                  |
| mysql_users                                 | array      | []                          | 需要创建的用户                                                                                                                                                        |

## 依赖

collections:

* [community.general](https://github.com/ansible-collections/community.general)

## 示例

安装

```shell
ansible-galaxy collection install -r requirements.yml
ansible-galaxy install daixijun.mysql
```

使用

```yaml
- hosts: servers
  collections:
    - community.general
  roles:
    - { role: daixijun.mysql, mysql_version: 8.0.20 }
```

## License

BSD

## 已知问题

* [ ] mysql_user 模块对于mysql8.0以上的版本，给用户授权`ALL`权限的时候会出现幂等性问题 [Idempotence all grant](https://github.com/ansible/ansible/pull/57460)
* [ ] 目前配置文件有改动时，重启mysql服务后可能会造成集群异常

## 待办

* [ ] 主从模式下支持半同步复制

## 维护者

* Xijun Dai <daixijun1990@gmail.com>
