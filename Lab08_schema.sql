-- ===============================
-- LAB 08 - SCHEMA
-- ===============================

DROP DATABASE IF EXISTS ql_thu_vien;
CREATE DATABASE ql_thu_vien
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE ql_thu_vien;

-- ===============================
-- TABLES
-- ===============================

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category_id INT,
    publisher_id INT,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    published_year INT,
    stock INT DEFAULT 0 CHECK (stock >= 0),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('BORROWED','RETURNED') DEFAULT 'BORROWED',
    FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON DELETE RESTRICT
);

CREATE TABLE loan_items (
    loan_id INT,
    book_id INT,
    qty INT NOT NULL CHECK (qty > 0),
    PRIMARY KEY (loan_id, book_id),
    FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
        ON DELETE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);

-- ===============================
-- SAMPLE DATA
-- ===============================

INSERT INTO categories(name) VALUES
('CNTT'), ('Văn học'), ('Khoa học'), ('Thiếu nhi'), ('Kinh tế');

INSERT INTO publishers(name) VALUES
('NXB Trẻ'), ('NXB Giáo Dục'), ('NXB Kim Đồng');

INSERT INTO books(title, category_id, publisher_id, price, published_year, stock) VALUES
('Lập trình C',1,2,85000,2020,10),
('Lập trình Java',1,2,95000,2021,8),
('SQL Cơ bản',1,2,90000,2022,7),
('Dế mèn phiêu lưu ký',4,3,50000,2018,12),
('Harry Potter',4,3,120000,2019,5),
('Kinh tế vi mô',5,1,110000,2020,6),
('Kinh tế vĩ mô',5,1,115000,2021,4),
('Văn học Việt Nam',2,1,75000,2017,9),
('Văn học nước ngoài',2,1,80000,2016,3),
('Toán cao cấp',3,2,98000,2022,5),
('Vật lý đại cương',3,2,97000,2021,6),
('Hóa học cơ bản',3,2,93000,2020,4),
('Python nâng cao',1,2,105000,2023,6),
('Thiết kế Web',1,2,99000,2022,7),
('Truyện cổ tích',4,3,45000,2015,10);

INSERT INTO members(full_name, phone) VALUES
('Nguyễn Văn A','0901111111'),
('Trần Thị B','0902222222'),
('Lê Văn C','0903333333'),
('Phạm Thị D','0904444444'),
('Hoàng Văn E','0905555555'),
('Đặng Thị F','0906666666'),
('Bùi Văn G','0907777777'),
('Võ Thị H','0908888888');

INSERT INTO loans(member_id, loan_date, due_date, status) VALUES
(1,'2025-12-01','2025-12-10','RETURNED'),
(2,'2025-12-05','2025-12-15','BORROWED'),
(3,'2025-12-10','2025-12-20','BORROWED'),
(1,'2025-12-15','2025-12-25','RETURNED'),
(4,'2025-12-20','2025-12-30','BORROWED'),
(5,'2025-12-22','2026-01-02','BORROWED'),
(6,'2025-12-25','2026-01-05','BORROWED'),
(7,'2025-12-26','2026-01-06','RETURNED'),
(1,'2025-12-28','2026-01-08','BORROWED'),
(2,'2026-01-01','2026-01-11','BORROWED'),
(3,'2026-01-02','2026-01-12','BORROWED'),
(4,'2026-01-05','2026-01-15','BORROWED');

INSERT INTO loan_items VALUES
(1,1,1),(1,2,1),
(2,3,2),(2,4,1),
(3,5,1),(3,6,1),
(4,7,1),(4,8,2),
(5,9,1),(5,10,1),
(6,11,1),(6,12,2),
(7,13,1),(7,14,1),
(8,15,2),
(9,1,1),(9,3,1),
(10,4,2),(10,5,1),
(11,6,1),(11,7,1),
(12,8,1),(12,9,1),(12,10,1);
