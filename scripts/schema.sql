-- This is the schema of simo's MariaDB in Heroku

CREATE TABLE `users` (
  `email` varchar(320) CHARACTER SET utf8 NOT NULL,
  `timestamp` timestamp NOT NULL,
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci

CREATE TABLE `requests` (
    id INT(7) NOT NULL AUTO_INCREMENT,
    `path` varchar(2000) NOT NULL,
    `status_code` char(3) NOT NULL,
    -- MariaDB automatically assigns the following properties to the column:
    -- DEFAULT CURRENT_TIMESTAMP
    -- ON UPDATE CURRENT_TIMESTAMP
    `timestamp` timestamp NOT NULL,
    PRIMARY KEY (id)
)

alter table users
add `timestamp` timestamp NOT NULL;
