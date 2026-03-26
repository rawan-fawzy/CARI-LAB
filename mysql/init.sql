CREATE DATABASE IF NOT EXISTS taskflow_db;
USE taskflow_db;

CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    done BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- إضافة مهام تجريبية للتأكد من الربط
INSERT INTO tasks (title, done) VALUES 
('Setup Docker Environment', true),
('Connect Frontend to Backend', false),
('Run migrations', false);