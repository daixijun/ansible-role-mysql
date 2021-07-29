DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '自增ID',
    username VARCHAR(100) NOT NULL DEFAULT '' COMMENT '用户名',
    email VARCHAR(255) NOT NULL DEFAULT '' COMMENT '电子邮箱',
    is_admin TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否为超级管理员，0 为普通用户， 1 为超级管理员',
    created_at DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
    updated_at DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

INSERT INTO `users` (`username`, `email`, `is_admin`, `created_at`) VALUES ('admin', 'admin@example.com', 1, '2020-06-27 21:00:00');
INSERT INTO `users` (`username`, `email`, `is_admin`, `created_at`) VALUES ('alex', 'alex@example.com', 0, '2020-06-27 21:00:00');
