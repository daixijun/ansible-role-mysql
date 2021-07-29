# mysql

[![Build Status](https://github.com/daixijun/ansible-role-mysql/workflows/build/badge.svg)](https://github.com/daixijun/ansible-role-mysql/actions)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-mysql-660198.svg?style=flat)](https://galaxy.ansible.com/daixijun/mysql/)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/daixijun/ansible-role-mysql?sort=semver)](https://github.com/daixijun/ansible-role-mysql/tags)

用于快速部署 mysql 集群

支持以下几种集群模式:

- [x] 基于 GTID 的主从复制
- [x] 默认开启 Semi-Sync 增强半同步
- [x] 基于 MHA 架构的主从复制
- [x] MGR 单主模式(默认)
- [x] MGR 多主模式

支持的 MySQL 发行版本:

- [x] Oracle 官方 [MySQL Community Server](https://mysql.com)
- [x] 万里开源 [GreatSQL](https://gitee.com/GreatSQL/GreatSQL)
- [ ] Percona [Percona Server for MySQL](https://www.percona.com/software/mysql-database/percona-server)

## 环境要求

- Centos 7+
- Ansible 2.9+
- MySQL 8.0+

## 变量

| 变量名                                      | 类型   | 默认值                      | 变量说明                                                                                                                                                              |
| ------------------------------------------- | ------ | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| mysql_version                               | string | 8.0.23                      | mysql 版本                                                                                                                                                            |
| mysql_upgrade                               | bool   | false                       | 是否需要执行版本升级操作                                                                                                                                              |
| mysql_download_url                          | string |                             | 免安装压缩包下载地址                                                                                                                                                  |
| mysql_inventory_group                       | string | mysql                       | Ansible 主机清单中的组名， 默认为 `mysql`， 其对应的 primary 与 secondary 组名分别为 `{{ mysql_inventory_group }}_primary` 与 `{{ mysql_inventory_group }}_secondary` |
| mysql_basedir                               | string | /usr/local/mysql            | 安装目录                                                                                                                                                              |
| mysql_datadir                               | string | /data/mysql                 | 数据文件存放目录                                                                                                                                                      |
| mysql_logdir                                | string | /var/log/mysqld             | 日志存放目录                                                                                                                                                          |
| mysql_pidfile                               | string | /var/run/mysqld/mysqld.pid  | PID 文件位置                                                                                                                                                          |
| mysql_socket                                | string | /var/run/mysqld/mysqld.sock | Socket 文件位置                                                                                                                                                       |
| mysql_port                                  | int    | 3306                        | 监听端口                                                                                                                                                              |
| mysql_bind_address                          | string | 0.0.0.0                     | 监听地址                                                                                                                                                              |
| mysql_interface                             | string | ""                          | 指定网卡，默认使用除 lo 外的第一张网卡                                                                                                                                |
| mysql_default_time_zone                     | string | +8:00                       | 指定时区                                                                                                                                                              |
| mysql_character_set_server                  | string | utf8mb4                     | 默认字符集                                                                                                                                                            |
| mysql_collation_server                      | string | utf8mb4_general_ci          | 默认字符序                                                                                                                                                            |
| mysql_max_connections                       | int    | 1005                        | 最大连接数                                                                                                                                                            |
| mysql_max_user_connections                  | int    | 1000                        | 用户最大连接数，必须比 `mysql_max_connections` 小，需要给管理员预留几个连接用于处理异常情况                                                                           |
| mysql_interactive_timeout                   | int    | 28800                       | 服务器关闭交互式连接前等待活动的秒数                                                                                                                                  |
| mysql_wait_timeout                          | int    | 28800                       | 服务器关闭非交互连接之前等待活动的秒数                                                                                                                                |
| mysql_max_connect_errors                    | int    | 200                         | 最大错误连接数                                                                                                                                                        |
| mysql_root_password                         | string | ""                          | root 账号的密码                                                                                                                                                       |
| mysql_cluster_type                          | string | mgr                         | 集群类型(默认 mgr) 可选 `mgr`(Mysql Group Replication)/`ms`(Master-Slave)                                                                                             |
| mysql_cluster_name                          | string | default                     | 集群的名称， 适用于 InnodbCluster/ReplicaSet                                                                                                                          |
| mysql_mha_enabled                           | bool   | false                       | 是否开启基于 mha 主从高可用                                                                                                                                           |
| mysql_mha_config_dir                        | string | /etc/mha                    | MHA 配置文件目录                                                                                                                                                      |
| mysql_mha_manager_workdir                   | string | /var/log/mha                | MHA 工作目录，存放日志及状态信息                                                                                                                                      |
| mysql_mha_user                              | string | mha                         | 用于连接管理 mysql 的用户，需要有 `ALL` 权限                                                                                                                          |
| mysql_mha_password                          | string | ""                          | mysql 管理密码                                                                                                                                                        |
| mysql_mha_repl_user                         | string | repl                        | 用于 mysql 主从复制的账号                                                                                                                                             |
| mysql_mha_repl_password                     | string | ""                          | 用于 mysql 主从复制的密码                                                                                                                                             |
| mysql_mha_ssh_user                          | string | root                        | 节点间通信的 ssh 账号                                                                                                                                                 |
| mysql_mha_ssh_port                          | int    | 22                          | 节点间通信的 ssh 端口                                                                                                                                                 |
| mysql_mha_ping_interval                     | int    | 2                           | master 节点状态心跳间隔                                                                                                                                               |
| mysql_mha_vip                               | string | ""                          | 用于绑定到 master 节点的 VIP                                                                                                                                          |
| mysql_mha_wechat_token                      | string | ""                          | 企业微信机器人的 Key, 用于发送报警通知                                                                                                                                |
| mysql_repl_user                             | string | repl                        | 用于主从/组复制的账号                                                                                                                                                 |
| mysql_repl_password                         | string |                             | 用于主从/组复制的账号的密码                                                                                                                                           |
| mysql_group_replication_name                | uuid   | ""                          | 组复制集群名,在 mysql 中使用`SELECT UUID()`或 shell 中使用`uuidgen`生成                                                                                               |
| mysql_group_replication_single_primary_mode | bool   | true                        | MGR 集群是否为单主模式                                                                                                                                                |
| mysql_innodb_cluster_enable                 | bool   | true                        | 是否开启 Innodb Cluster                                                                                                                                               |
| mysql_innodb_cluster_username               | string | ic                          | 用于创建和管理 Innodb Cluster 的账号，需要具备 `ALL WITH GRANT OPTION` 权限                                                                                           |
| mysql_innodb_cluster_password               | string | ""                          | 管理密码                                                                                                                                                              |
| mysql_proxysql_config                       | bool   | false                       | 是否使用 proysql 做为代理层                                                                                                                                           |
| mysql_proxysql_monitor_username             | string | monitor                     | proxysql 监控 mgr 状态的账号                                                                                                                                          |
| mysql_proxysql_monitor_password             | string | ""                          | proxysql 监控 mgr 状态的密码                                                                                                                                          |
| mysql_databases                             | array  | []                          | 需要创建的业务数据库                                                                                                                                                  |
| mysql_users                                 | array  | []                          | 需要创建的用户                                                                                                                                                        |

## 依赖

collections:

- [community.mysql](https://github.com/ansible-collections/community.mysql)

## 示例

安装

```shell
ansible-galaxy collection install -r requirements.yml
```

使用

```yaml
- hosts: servers
  roles:
    - { role: mysql, mysql_version: 8.0.20 }
```

## 已知问题

- [ ] mysql_user 模块对于 mysql8.0 以上的版本，给用户授权`ALL`权限的时候会出现幂等性问题 [Idempotence all grant](https://github.com/ansible/ansible/pull/57460)

## 待办

- [x] 主从模式下支持半同步复制
- [ ] 完善 MHA 下 side-effect 测试
- [x] 支持版本更新
- [x] 支持节点重建
- [ ] MGR 集群中极端情况下所有节点都宕机后，需要找到 gtid 最大的实例为做 primary 节点重新引导集群

## 集群异常修复

### MGR 集群异步宕机后恢复

取并集，select RECEIVED_TRANSACTION_SET from performance_schema.replication_connection_status + show variables like 'gtid_executed ，然后选主最大的，作为 primary
