-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

DROP TABLE IF EXISTS GiangVien;

CREATE TABLE GiangVien (
	magv TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	hoten VARCHAR (30) NOT NULL UNIQUE KEY, luong INT NOT NULL
);

DROP TABLE IF EXISTS SinhVien;

CREATE TABLE SinhVien (
	masv MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	hoten VARCHAR (30) NOT NULL, 
    namsinh DATE, 
    quequan VARCHAR (100) NOT NULL
);

DROP TABLE IF EXISTS DeTai;

CREATE TABLE DeTai (
	madt MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	tendt VARCHAR (38) NOT NULL UNIQUE KEY, 
	kinhphi INT NOT NULL, 
	NoiThucTap VARCHAR (100) NOT NULL
);

DROP TABLE IF EXISTS HuongDan;

DROP TABLE IF EXISTS HuongDan;

CREATE TABLE HuongDan (
    id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    masv MEDIUMINT UNSIGNED NOT NULL,
    madt MEDIUMINT UNSIGNED,
    magv TINYINT UNSIGNED NOT NULL,
    ketqua SMALLINT UNSIGNED,
    
    CONSTRAINT fk_masv 
        FOREIGN KEY (masv) 
        REFERENCES SinhVien(masv)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_madt 
        FOREIGN KEY (madt) 
        REFERENCES DeTai(madt),
        
    CONSTRAINT fk_magv 
        FOREIGN KEY (magv) 
        REFERENCES GiangVien(magv)
);

-- Thêm ít nhất 3 bản ghi vào table
INSERT INTO GiangVien (hoten, luong)
VALUES 
    ('Nguyễn Văn A', 1500000),
    ('Trần Thị B', 2000000),
    ('Lê C', 2500000),
    ('Phạm D', 3000000),
    ('Đinh E', 3500000);

INSERT INTO SinhVien (hoten, namsinh, quequan)
VALUES 
    ('Nguyễn Văn A', '2000-01-01', 'Hà Nội'),
    ('Trần Thị B', '2001-01-01', 'Hồ Chí Minh'),
    ('Lê C', '2002-01-01', 'Đà Nẵng'),
    ('Phạm D', '2003-01-01', 'Hà Nội'),
    ('Đinh E', '2004-01-01', 'Hồ Chí Minh');

INSERT INTO DeTai (tendt, kinhphi, NoiThucTap)
VALUES 
    ('CÔNG NGHỆ SINH HỌC', 5000000, 'Hà Nội'),
    ('KỸ THUẬT CÔNG NGHIỆP', 8000000, 'Hà Nội'),
    ('KỸ THUẬT XÂY DỰNG', 9000000, 'Hồ Chí Minh');

INSERT INTO HuongDan (masv, madt, magv, ketqua)
VALUES 
    (1, 1, 1, 8),
    (2, 2, 2, 9),
    (3, 1, 3, 7),
    (4, 3, 4, 8),
    (5, NULL, 5, 3);
    

-- 2. Viết lệnh để
-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
SELECT *
FROM SinhVien
WHERE masv IN (SELECT masv
				FROM HuongDan
                WHERE madt IS NULL);

SELECT *
FROM SinhVien
LEFT JOIN HuongDan USING (masv)
WHERE madt IS NULL;

-- b) Lấy ra số sinh viên làm đề tài 'CONG NGHE SINH HOC'
SELECT COUNT(masv)
FROM HuongDan
WHERE madt = (SELECT madt
			 FROM DeTai
             WHERE tendt ='Công Nghệ Sinh Học');
-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm:
-- mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")
CREATE VIEW SinhVienInfo AS
SELECT 
    sv.masv AS 'Mã số',
    sv.hoten AS 'Họ tên',
    IFNULL(dt.tendt, 'Chưa có') AS 'Tên đề tài'
FROM SinhVien sv
LEFT JOIN HuongDan hd ON sv.masv = hd.masv
LEFT JOIN DeTai dt ON hd.madt = dt.madt;
-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900 
-- thì hiện ra thông báo "năm sinh phải > 1900"
DROP TRIGGER IF EXISTS trg_check_namsinh;
DELIMITER $$

CREATE TRIGGER trg_check_namsinh
BEFORE INSERT ON SinhVien
FOR EACH ROW
BEGIN
    IF YEAR(NEW.namsinh) <= 1900 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'nam sinh phai > 1900';
    END IF;
END$$

DELIMITER ;
-- 5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó 
-- thì sẽ tất cả thông tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi


