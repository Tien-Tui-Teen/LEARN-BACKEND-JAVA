-- Xoá database [nếu tồn tại]
DROP DATABASE IF EXISTS lession_01;

-- tạo database [nếu không tồn tại]
CREATE DATABASE IF NOT EXISTS lession_01;

-- chọn database muốn thao tác
USE lession_01;

-- Kiểu dữ liệu 
-- Kiểu số nguyên : 
-- TINYINT (-128 , 127 || 0 255)  
-- SMALLINT(-32768 , 32767 || 0 , 65535)
-- MEDIUMINT(-8388608 , 8388607 || 0 , 16777215)
-- INT(-2.147.483.648 , -2.147.483.647|| 0 , 4.294.967.295)
-- BIGINT(-9.223.372.036.854.775.808 , -9.223.372.036.854.775.807 || 0 , 18 . 446.744.073.709.551.615)
-- Kiểu số thực 
-- Float(4 bytes)
-- Double(8 bytes)
-- Kiểu chuỗi : CHẢ , VARCHAR
-- Kiểu logic : BOOLEAN (TRUE / FALSE)
-- kiểu thời gian : DATE (yyyy-mm-dd) , TIME(hh:mm:ss) , DATETIME(yyyy-mm-dd hh:mm:ss)
-- kiểu enum : ENUM('MALE' , 'FEMALE' , 'UNKNOWN') : Giới hạn các trạng thái có thể nhập vào

-- Xoá bảng nếu tồn tại
DROP TABLE IF EXISTS department;
-- Tạo bảng
CREATE TABLE department(
	id INT UNSIGNED PRIMARY KEY, -- Không dấu
    name VARCHAR(50),
    create_at DATETIME
);
 -- Nếu đăt tên cột là từ khoá của mySQL thì chỉ cần bọc bằng dấu nháy huyền `group` sẽ hết lỗi
 -- Thêm dữ liệu 
 INSERT INTO department(id , name , create_at)
 VALUES (1 , 'Nguyen Thien Nhan' , CURRENT_TIMESTAMP()),
		(2 , 'Bảo Vệ'            , '2023-04-30 10:22:49');

-- Hiển thị dữ liệu
TABLE department;

-- Ràng buộc dữ liệu : Yêu cầu dữ liệu phải có ràng buộc nào đó
-- ràng buộc giúp dữ liệu thống nhất
-- PRIMARY KEY : Khoá chính  (Giống với cccd , cccd mỗi người khác nhau , và đều phải có)
-- 1. Một bảng có tối đa 1 khoá chính
-- 2. Giá trị phải duy nhất và khác NULL
-- Từ khoá : AUTO_INCREMENT (tự động tăng để đảm bảo sự khác nhau của primary key)
CREATE TABLE customer(
	id INT PRIMARY KEY AUTO_INCREMENT, -- mySQL hỗ trợ id tự tăng lên (AUTO_INCREMENT)
    name VARCHAR(50),
    create_at DATETIME
);
-- VD:AUTO_INCREMENT
INSERT INTO customer(name)
VALUES 				('Phan Văn Tiến'),
					('Nguyễn Thiện Nhan');
TABLE customer;
-- VD : Khoá chính 2 cột
CREATE TABLE group_account(
	group_id INT,
    accound_id INT,
    joined_at DATETIME,
    PRIMARY KEY(group_id , account_id)
);

-- UNIQUE KEY : Duy nhất (Tập con của khoá chính)
-- VD : Ngoài cccd là khoá chính của mình thì còn những thông tin khác cần duy nhất 
-- ví dụ như : Số điện thoại , email
CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE KEY
);
-- Ví dụ lỗi 
INSERT INTO account(email)
VALUES 				('tientuiteen@gmail'),
					('tientuiteen@gmail');

-- NOT NULL 
-- NULL VS "" : NULL là không có ví tiền VS có ví tiền nhưng không có tiền
-- VS thêm null
INSERT INTO account(email)
VALUES 				(NULL),
					(NULL);
TABLE account;

-- VS NOT NULL
CREATE TABLE product(
	id INT PRIMARY KEY AUTO_INCREMENT,
    price BIGINT NOT NULL
);
INSERT INTO product(price)
VALUES 			   (NULL);

-- DEFAULT : Giá trị mặc đinh
-- dùng khi nếu người dùng không thêm dữ liệu sẽ lấy giá tri mặc định

CREATE TABLE post(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    create_at DATETIME DEFAULT NOW()
);

INSERT INTO post(title)
VALUES 			   ('MYSQL');

-- CHECK : Kiểm tra điều kiên
CREATE TABLE user(
	id INT PRIMARY KEY AUTO_INCREMENT,
    age INT CHECK(age >= 18) NOT NULL
);
INSERT INTO user(age)
VALUES 			   ('20');


-- FOREIGN KEY : Khoá ngoại
CREATE TABLE student(
	id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT ,
    FOREIGN KEY (post_id) REFERENCES post(id)
);
INSERT INTO student(post_id)
VALUES 			   (1);

TABLE student

-- ON UPDATE CASCADE ON DELETE CASCADE :
-- ví dụ  : phòng ban số 1 có rất nhiều nhân viên phòng ban 2 cũng vậy
-- dùng lệnh xoá xoá từng nhân vien thì được nhưng xoá phòng ban thì 
-- mySQL sẽ có những các sử lí : khi xoá phòng ban thì sẽ không cho phép xoá
-- CASCADE : nếu như phòng ban số 1 bị xoá thì các nhân viên trong phòng sẽ bị xoá
-- giống cha làm gì con làm đấy
-- Ngoài ra có thể dùng setNull
