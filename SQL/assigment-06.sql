DROP DATABASE IF EXISTS assignment_06;
CREATE DATABASE assignment_06;
USE assignment_06;

-- Tạo bảng department
DROP TABLE IF EXISTS department;
CREATE TABLE department (
	department_id INT PRIMARY KEY AUTO_INCREMENT,
	department_name VARCHAR(50)
);

-- Tạo bảng position
DROP TABLE IF EXISTS position;
CREATE TABLE position (
	position_id INT PRIMARY KEY AUTO_INCREMENT,
	position_name ENUM("Dev", "Test", "Scrum Master", "PM") 
);

-- Tạo bảng account
DROP TABLE IF EXISTS account;
CREATE TABLE account (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50),
    username VARCHAR(50),
    full_name VARCHAR(50),
    department_id INT,
    position_id INT,
    created_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (department_id)
        REFERENCES department (department_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (position_id)
        REFERENCES position (position_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tạo bảng group
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
	group_id INT PRIMARY KEY AUTO_INCREMENT,
	group_name VARCHAR(50),
	creator_id INT,
	created_date DATE DEFAULT (CURRENT_DATE),
	FOREIGN KEY (creator_id)
		REFERENCES account (account_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tạo bảng group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account (
	group_id INT,
	account_id INT,
	joined_date DATE DEFAULT (CURRENT_DATE),
	PRIMARY KEY (group_id, account_id),
	FOREIGN KEY (group_id)
		REFERENCES `group` (group_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (account_id)
		REFERENCES account (account_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tạo bảng type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question (
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	type_name ENUM("Essay", "Multiple-Choice") 
);

-- Tạo bảng category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question (
	category_id INT PRIMARY KEY AUTO_INCREMENT,
	category_name VARCHAR(50) 
);

-- Tạo bảng question
DROP TABLE IF EXISTS question;
CREATE TABLE question (
	question_id INT PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(50),
	category_id INT,
	type_id INT,
	creator_id INT,
	created_date DATE DEFAULT (CURRENT_DATE),
	FOREIGN KEY (category_id)
		REFERENCES category_question (category_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (type_id)
		REFERENCES type_question (type_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (creator_id)
		REFERENCES account (account_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tạo bảng answer
DROP TABLE IF EXISTS answer;
CREATE TABLE answer (
	answer_id INT PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(50),
	question_id INT,
	is_correct BOOLEAN,
	FOREIGN KEY (question_id)
		REFERENCES question (question_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tạo bảng exam
DROP TABLE IF EXISTS exam;
CREATE TABLE exam (
	exam_id INT PRIMARY KEY AUTO_INCREMENT,
	code CHAR(10),
	title VARCHAR(50),
	category_id INT,
	duration INT,
	creator_id INT,
	created_date DATE DEFAULT (CURRENT_DATE),
	FOREIGN KEY (category_id)
		REFERENCES category_question (category_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (creator_id)
		REFERENCES account (account_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tạo bảng exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question (
	exam_id INT,
	question_id INT,
	PRIMARY KEY (exam_id, question_id),
	FOREIGN KEY (exam_id)
		REFERENCES exam (exam_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (question_id)
		REFERENCES question (question_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Thêm dữ liệu cho bảng department
INSERT INTO department  (department_name)
VALUES                  ("Marketing"    ),
                        ("Sale"         ),
                        ("Bảo vệ"       ),
                        ("Nhân sự"      ),
                        ("Kỹ thuật"     ),
                        ("Tài chính"    ),
                        ("Phó giám đốc" ),
                        ("Giám đốc"     ),
                        ("Thư kí"       ),
                        ("Bán hàng"     ); 

-- Thêm dữ liệu cho bảng position
INSERT INTO position    (position_name )
VALUES                  ("Dev"         ),
                        ("Test"        ),
                        ("Scrum Master"),
                        ("PM"          );

-- Thêm dữ liệu cho bảng account
INSERT INTO account (email                           , username      , full_name           , department_id, position_id, created_date)
VALUES              ("haidang29productions@gmail.com", "dangblack"   , "Nguyen Hai Dang"   , 1            , 1          , "2019-01-15"),
                    ("account1@gmail.com"            , "quanganh"    , "Tong Quang Anh"    , 1            , 2          , "2020-02-25"),
                    ("account2@gmail.com"            , "vanchien"    , "Nguyen Van Chien"  , 1            , 3          , "2021-03-17"),
                    ("account3@gmail.com"            , "cocoduongqua", "Duong Do"          , 3            , 4          , "2022-03-08"),
                    ("account4@gmail.com"            , "doccocaubai" , "Nguyen Chien Thang", 4            , 4          , "2015-03-20"),
                    ("dapphatchetngay@gmail.com"     , "khabanh"     , "Ngo Ba Kha"        , 6            , 3          , "2016-04-05"),
                    ("songcodaoly@gmail.com"         , "huanhoahong" , "Bui Xuan Huan"     , 2            , 2          , "2017-04-14"),
                    ("sontungmtp@gmail.com"          , "tungnui"     , "Nguyen Thanh Tung" , 8            , 1          , "2018-04-18"),
                    ("duongghuu@gmail.com"           , "duongghuu"   , "Duong Van Huu"     , 9            , 2          , "2023-04-07"),
                    ("vtiaccademy@gmail.com"         , "vtiaccademy" , "Vi Ti Ai"          , 2            , 1          , "2024-04-29");

-- Thêm dữ liệu cho bảng group
INSERT INTO `group` (group_name        , creator_id, created_date)
VALUES              ("Testing System"  , 1        , "2019-03-15"),
                    ("Developement"    , 1        , "2020-03-27"),
                    ("VTI Sale 01"     , 2        , "2021-03-09"),
                    ("VTI Sale 02"     , 3        , "2022-01-10"),
                    ("VTI Sale 03"     , 3        , "2023-08-28"),
                    ("VTI Creator"     , 6        , "2024-08-06"),
                    ("VTI Marketing 01", 3        , "2024-10-17"),
                    ("Management"      , 8        , "2020-11-28"),
                    ("Chat with love"  , 9        , "2022-11-09"),
                    ("Vi Ti Ai"        , 3        , "2022-12-10");

-- Thêm dữ liệu cho bảng group_account
INSERT INTO group_account   (group_id, account_id, joined_date )
VALUES                      (1      , 1        , "2019-03-05"),
                            (2      , 1        , "2020-11-17"),
                            (3      , 1        , "2021-09-29"),
                            (4      , 1        , "2022-12-10"),
                            (5      , 5        , "2022-04-28"),
                            (2      , 6        , "2023-08-26"),
                            (7      , 2        , "2024-02-07"),
                            (3      , 8        , "2020-05-18"),
                            (2      , 2        , "2020-02-04"),
                            (10     , 10       , "2020-12-10");

-- Thêm dữ liệu cho bảng type_question
INSERT INTO type_question (type_name) VALUES ("Essay"), ("Multiple-Choice"); 

-- Thêm dữ liệu cho bảng category_question
INSERT INTO category_question   (category_name)
VALUES                          ("Java"       ),
                                ("ASP.NET"    ),
                                ("ADO.NET"    ),
                                ("SQL"        ),
                                ("Postman"    ),
                                ("Ruby"       ),
                                ("Python"     ),
                                ("C++"        ),
                                ("C Sharp"    ),
                                ("PHP"        ); 

-- Thêm dữ liệu cho bảng question
INSERT INTO question    (content          , category_id, type_id, creator_id, created_date)
VALUES                  ("Câu hỏi về Java", 1          , 1      , 1         , "2020-04-05"),
                        ("Câu Hỏi về PHP" , 1          , 2      , 2         , "2020-04-05"),
                        ("Hỏi về C#"      , 9          , 2      , 5         , "2020-04-06"),
                        ("Hỏi về Ruby"    , 6          , 1      , 5         , "2020-04-06"),
                        ("Hỏi về Postman" , 5          , 1      , 5         , "2020-04-06"),
                        ("Hỏi về ADO.NET" , 5          , 2      , 6         , "2020-04-06"),
                        ("Hỏi về ASP.NET" , 5          , 1      , 1         , "2020-04-06"),
                        ("Hỏi về C++"     , 5          , 1      , 8         , "2020-04-07"),
                        ("Hỏi về SQL"     , 4          , 2      , 3         , "2020-04-07"),
                        ("Hỏi về Python"  , 7          , 1      , 10        , "2020-04-07");

-- Thêm dữ liệu cho bảng answer
INSERT INTO answer  (content     , question_id, is_correct)
VALUES              ("Trả lời 01", 1          , 0         ),
                    ("Trả lời 02", 1          , 1         ),
                    ("Trả lời 03", 1          , 0         ),
                    ("Trả lời 04", 1          , 1         ),
                    ("Trả lời 05", 2          , 1         ),
                    ("Trả lời 06", 3          , 1         ),
                    ("Trả lời 07", 4          , 0         ),
                    ("Trả lời 08", 8          , 0         ),
                    ("Trả lời 09", 9          , 1         ),
                    ("Trả lời 10", 10         , 1         );

-- Thêm dữ liệu cho bảng exam
INSERT INTO exam    (code     , title           , category_id, duration, creator_id, created_date)
VALUES              ("VTIQ001", "Đề thi C#"     , 1          , 60      , 1         , "2019-04-05"),
                    ("VTIQ002", "Đề thi PHP"    , 1          , 60      , 1         , "2019-04-05"),
                    ("VTIQ003", "Đề thi C++"    , 9          , 120     , 2         , "2019-04-07"),
                    ("VTIQ004", "Đề thi Java"   , 2          , 60      , 3         , "2020-04-08"),
                    ("VTIQ005", "Đề thi Ruby"   , 2          , 120     , 4         , "2020-04-10"),
                    ("VTIQ006", "Đề thi Postman", 2          , 60      , 6         , "2020-04-05"),
                    ("VTIQ007", "Đề thi SQL"    , 2          , 60      , 1         , "2020-04-05"),
                    ("VTIQ008", "Đề thi Python" , 8          , 60      , 8         , "2020-04-07"),
                    ("VTIQ009", "Đề thi ADO.NET", 4          , 90      , 3         , "2020-04-07"),
                    ("VTIQ010", "Đề thi ASP.NET", 7          , 90      , 1         , "2020-04-08");

-- Thêm dữ liệu cho bảng exam_question
INSERT INTO exam_question   (question_id, exam_id)
VALUES                      (1         , 1      ),
                            (2         , 2      ),
                            (3         , 1      ),
                            (4         , 4      ),
                            (5         , 1      ),
                            (6         , 2      ),
                            (7         , 1      ),
                            (8         , 8      ),
                            (9         , 2      ),
                            (10        , 10     );
                            
                            
                            
                            
                            
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó.
DELIMITER $$
CREATE PROCEDURE qs_01(IN name_department VARCHAR(100))
BEGIN
    SELECT *
    FROM account
	JOIN department USING (department_id)
    WHERE department_name = name_department;
END $$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE qs_011(IN name_department VARCHAR(100))
BEGIN
	SELECT *
    FROM account
    WHERE department_id = 
		(SELECT department_id
        FROM department
        WHERE name_department = department_name);
END $$
DELIMITER ;
CALL qs_01('Marketing');
CALL qs_011('Marketing');

-- Cach dung bien de lam phang cau lenh bang cach gan gia tri vao bien
DELIMITER $$
CREATE PROCEDURE qs_012 (IN name_department VARCHAR(100))
BEGIN
	DECLARE v_department_id INT; -- Bien 
    
    SELECT department_id INTO v_department_id
    FROM department
    WHERE department_name = name_department;
    
    SELECT *
    FROM account 
    WHERE department_id = v_department_id;
END $$
DELIMITER ;
-- Question 2: Tạo store để in ra số lượng account trong mỗi group.
DELIMITER $$
CREATE PROCEDURE qs_02(IN group_id INT)
BEGIN
	SELECT COUNT(account_id)
    FROM group_account
    GROUP BY group_id
    HAVING group_id = group_id;
END $$
DELIMITER ;
CALL qs_02(1);
-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại.
DROP PROCEDURE IF EXISTS qs_03;
DELIMITER $$
CREATE PROCEDURE qs_03()
BEGIN 
	WITH c1 AS (
	SELECT question_id , type_id
	FROM question
	WHERE MONTH(created_date) = MONTH(CURRENT_DATE)
	)
	SELECT type_question.* , COUNT(question_id)
	FROM type_question 
	LEFT JOIN c1 USING (type_id)
	GROUP BY type_id;
END $$
DELIMITER ;
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất.

DROP FUNCTION IF EXISTS ft_04
DELIMITER \\
CREATE FUNCTION ft_04() RETURNS INT
BEGIN 
	DECLARE get_id INT;
	WITH count_question AS (
        SELECT type_id, COUNT(*) AS total
        FROM question
        GROUP BY type_id
    )
    SELECT type_id INTO get_id
    FROM count_question
    WHERE total = (
        SELECT MAX(total) FROM count_question );
            
    RETURN get_id;
END \\
DELIMITER ;
SELECT ft_04();
DROP PROCEDURE IF EXISTS qs_04;
DELIMITER $$
CREATE PROCEDURE qs_04()
BEGIN
    WITH count_question AS (
        SELECT type_id, COUNT(*) AS total
        FROM question
        GROUP BY type_id
    )
    SELECT type_id
    FROM count_question
    WHERE total = (
        SELECT MAX(total) FROM count_question
);
END $$

DELIMITER ;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question.
DROP FUNCTION IF EXISTS ft_05;
DELIMITER \\
CREATE FUNCTION ft_05() RETURNS VARCHAR(50)
BEGIN
	DECLARE find_name VARCHAR(50);
	SELECT type_name INTO find_name
    FROM type_question
    WHERE type_id = (SELECT ft_04());
    
    RETURN find_name;
END \\
DELIMITER ;
SELECT ft_05();
-- Cach su dung lai query cua qs_04
DROP PROCEDURE IF EXISTS qs_05

DELIMITER $$

CREATE PROCEDURE qs_05()
BEGIN
    WITH count_question AS (
		SELECT type_id , COUNT(question_id) AS total
        FROM question
        GROUP BY type_id
	)
    SELECT type_id , type_name
    FROM count_question
    LEFT JOIN type_question USING(type_id)
    WHERE total = 
		(SELECT MAX(total)
        FROM count_question);
END $$
DELIMITER ;
CALL qs_05();

-- Cach su dung PROCEDURE co bien INOUT cua qs_04
DROP PROCEDURE IF EXISTS qs_04;
DELIMITER $$
CREATE PROCEDURE qs_04(OUT name_type INT)
BEGIN
    WITH count_question AS (
        SELECT type_id, COUNT(*) AS total
        FROM question
        GROUP BY type_id
    )
    SELECT type_id INTO name_type
    FROM count_question
    WHERE total = (
        SELECT MAX(total) FROM count_question
);
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS qs_05;
DELIMITER $$
CREATE PROCEDURE qs_05()
BEGIN
	DECLARE find_type_by_id INT;
    CALL qs_04(find_type_by_id);
    
    SELECT type_name
    FROM type_question
    WHERE type_id = find_type_by_id;
END $$
DELIMITER ;
CALL qs_05();
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào.
DROP PROCEDURE IF EXISTS qs_06

DELIMITER $$
CREATE PROCEDURE qs_06(IN input_string VARCHAR(50))
BEGIN
	DECLARE pattern VARCHAR(50) DEFAULT CONCAT('%' , input_string , '%');
    
	SELECT 'group' AS type , group_name AS result 
    FROM `group`
    WHERE group_name LIKE CONCAT('%' , input_string , '%')
	UNION 
    SELECT 'account' AS type , username AS result
    FROM account
    WHERE username LIKE CONCAT('%' , input_string , '%');
END $$
DELIMITER ;

CALL qs_06('g');
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS qs_07;
DELIMITER $$
CREATE PROCEDURE qs_07 (IN input_fullname VARCHAR(50) , IN input_email VARCHAR(50))
BEGIN
	DECLARE v_username VARCHAR(50);
	DECLARE v_positionid INT;
    DECLARE v_departmentid INT;
    
    SELECT SUBSTRING_INDEX(input_email , "@" , 1) INTO v_username;
    
    SELECT position_id INTO v_positionid
    FROM position
    WHERE position_name = "Dev";
    
    SELECT department_id INTO v_departmentid
    FROM department
    WHERE department_name = "Phong Cho";
    
	INSERT INTO account (username , full_name , email , position_id , department_id)
	VALUES				(v_username , input_fullname , input_email , v_positionid , v_departmentid);
    
	SELECT * 
    FROM account
    WHERE email = input_email;
END $$
DELIMITER ;
CALL qs_07('Nguyen Thien Nhan Tre Trau' , 'Nhancuden@gmail.com');
	
-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS qs_08;
DELIMITER $$
CREATE PROCEDURE qs_08 (IN input ENUM('Essay' , 'Multiple-Coice'))
BEGIN
	DECLARE input_type_id INT;
    SELECT type_id INTO input_type_id
    FROM type_question
    WHERE type_name = input;
    
    WITH max_length AS (
		SELECT * , CHAR_LENGTH(content) AS conten_length
        FROM question
        WHERE type_id = input_type_id
    )
	SELECT *
    FROM max_length
    WHERE conten_length = 
		(SELECT MAX(conten_length)
        FROM max_length);
END $$
DELIMITER ;
CALL qs_08('Essay');
-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS qs_09
DELIMITER $$
CREATE PROCEDURE qs_09(IN delete_exam_by_id INT)
BEGIN 
	DELETE FROM exam_question
    WHERE exam_id = delete_exam_by_id;
	DELETE FROM exam 
    WHERE exam_id = delete_exam_by_id;
END $$
DELIMITER ;
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS qs_11;
DELIMITER $$
CREATE PROCEDURE qs_11(IN input_departmentname VARCHAR(50))
BEGIN	
	DECLARE get_departmentid VARCHAR(50);
    
    SELECT department_id INTO get_departmentid
    FROM department
    WHERE department_name = "phong cho";
        
    UPDATE account
    SET 
		department_id = get_departmentid
	WHERE department_id =
		(SELECT department_id
		FROM department
		WHERE department_name = input_departmentname);
	
END $$
DELIMITER ;

CALL qs_11("Marketing");

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
-- Cach thay chua
DROP PROCEDURE IF EXISTS qs_12;
DELIMITER $$
CREATE PROCEDURE qs_12()
BEGIN
	DECLARE v_current_year INT DEFAULT YEAR(CURRENT_DATE); 
	WITH RECURSIVE genmonth (month) AS(
	SELECT 1 
    UNION 
    SELECT month + 1
    FROM genmonth
    WHERE month < 12
	) , c2 AS (
		SELECT * , MONTH(created_date) AS month
        FROM account
        WHERE YEAR(created_date) = v_current_year)
	SELECT month , COUNT(account_id)
    FROM genmonth 
    LEFT JOIN c2 USING (month)
    GROUP BY month;
END $$
DELIMITER ;

-- BEST 
DROP PROCEDURE IF EXISTS qs_12;
DELIMITER $$

CREATE PROCEDURE qs_12()
BEGIN
    DECLARE v_current_year INT DEFAULT YEAR(CURRENT_DATE);

    WITH RECURSIVE genmonth AS (
        SELECT 1 AS month
        UNION ALL
        SELECT month + 1
        FROM genmonth
        WHERE month < 12
    ),
    account_month AS (
        SELECT account_id , MONTH(created_date) AS month
        FROM account
        WHERE YEAR(created_date) = v_current_year
    )
    
    SELECT g.month, COUNT(a.account_id) AS total_account
    FROM genmonth g
    LEFT JOIN account_month a ON g.month = a.month
    GROUP BY g.month;
END $$
DELIMITER ;

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
-- hint
SELECT CURRENT_DATE - INTERVAL 10 MONTH;

DROP PROCEDURE IF EXISTS qs_13;
DELIMITER $$
CREATE PROCEDURE qs_13()
BEGIN
	WITH RECURSIVE gen_time (m) AS (
		SELECT CURRENT_DATE - INTERVAL 1 MONTH
        UNION ALL
        SELECT m - INTERVAL 1 MONTH 
        FROM gen_time
        WHERE m > CURRENT_DATE - INTERVAL 6 MONTH
	), take_yearmonth AS ( 
		SELECT YEAR(m) AS year, MONTH(m) AS month
        FROM gen_time
	), count_question AS (
		SELECT * , YEAR(created_date) AS year , MONTH(created_date) AS month
		FROM question 
		WHERE created_date >= CURRENT_DATE - INTERVAL 6 MONTH
    )
	SELECT year , month , IF(
							COUNT(question_id) = 0 , 
                            'Khong co cau hoi nao trong thang' , 
                            COUNT(question_id)
                            ) AS question_count 
    FROM take_yearmonth
    LEFT JOIN count_question USING (year, month)
    GROUP BY year , month;
END $$
DELIMITER ;
-- 6 . 7 . 11 . 12 , 13


-- =============================
-- NHÓM 1: ANALYTICS NÂNG CAO
-- =============================

-- Bài 1:
-- Tìm top 3 account tạo nhiều question nhất trong 6 tháng gần đây
-- Trả về: account_id, full_name, total_question
-- Nếu có nhiều account bằng nhau thì vẫn giữ lại tất cả
DROP PROCEDURE IF EXISTS qsa_01;
DELIMITER \\

CREATE PROCEDURE qsa_01()
BEGIN 
    WITH question_count AS (
        SELECT 
            creator_id,
            COUNT(*) AS total_question
        FROM question
        WHERE created_date >= CURRENT_DATE - INTERVAL 6 MONTH
        GROUP BY creator_id
    ),
    ranked AS (
        SELECT *,
               DENSE_RANK() OVER (ORDER BY total_question DESC) AS rnk
        FROM question_count
    )
    
    SELECT a.account_id, a.full_name, r.total_question
    FROM ranked r
    JOIN account a ON a.account_id = r.creator_id
    WHERE r.rnk <= 3;

END \\

DELIMITER ;
-- Bài 2:
-- Thống kê mỗi category:
-- - Tổng số question
-- - Phần trăm số question của category đó so với toàn bộ hệ thống
DROP PROCEDURE IF EXISTS qsa_02;
DELIMITER \\
CREATE PROCEDURE qsa_02()
BEGIN 
	SELECT category_id , COUNT(question_id) AS count_question , CONCAT((COUNT(question_id) / (SELECT COUNT(*) FROM question) * 100.0) , '%') AS one_for_all
    FROM question
    GROUP BY category_id;
END \\
DELIMITER ;
CALL qsa_02();
-- Bài 3:
-- Thống kê theo tháng trong năm hiện tại:
-- - Số lượng question
-- - Số lượng exam
-- - Tỷ lệ question / exam
DROP PROCEDURE IF EXISTS qsa_03;
DELIMITER \\

CREATE PROCEDURE qsa_03()
BEGIN
    WITH RECURSIVE gen_month(m) AS (
        SELECT 1
        UNION ALL
        SELECT m + 1
        FROM gen_month
        WHERE m < MONTH(CURRENT_DATE)
    ),
    count_question AS (
        SELECT 
            MONTH(created_date) AS m, 
            COUNT(*) AS question_count
        FROM question 
        WHERE YEAR(created_date) = YEAR(CURRENT_DATE)
        GROUP BY MONTH(created_date)
    ),
    count_exam AS (
        SELECT 
            MONTH(created_date) AS m, 
            COUNT(*) AS exam_count
        FROM exam
        WHERE YEAR(created_date) = YEAR(CURRENT_DATE)
        GROUP BY MONTH(created_date)
    )
    
    SELECT 
        g.m,
        COALESCE(q.question_count, 0) AS question_count,
        COALESCE(e.exam_count, 0) AS exam_count,
        CASE 
            WHEN COALESCE(e.exam_count, 0) = 0 THEN NULL
            ELSE ROUND(q.question_count * 1.0 / e.exam_count, 2)
        END AS ratio
    FROM gen_month g
    LEFT JOIN count_question q USING (m)
    LEFT JOIN count_exam e USING (m)
    ORDER BY g.m;

END \\

DELIMITER ;
-- Bài 4:
-- Tìm tất cả question không có answer đúng (is_correct = 1)
DROP PROCEDURE IF EXISTS qsa_04;
DELIMITER \\
CREATE PROCEDURE qsa_04()
BEGIN
    WITH correct_answer AS (
        SELECT DISTINCT question_id
        FROM answer
        WHERE is_correct = 1
    )
    
    SELECT q.question_id
    FROM question q
    LEFT JOIN correct_answer c ON q.question_id = c.question_id
    WHERE c.question_id IS NULL;

END \\
DELIMITER ;

SELECT q.question_id
FROM question q
WHERE NOT EXISTS (
    SELECT 1
    FROM answer a
    WHERE a.question_id = q.question_id
      AND a.is_correct = 1
);
-- =============================
-- NHÓM 2: PROCEDURE + BUSINESS LOGIC
-- =============================

-- Bài 5:
-- Viết store xóa 1 account theo account_id
-- Yêu cầu:
-- - Xóa trong group_account
-- - Xóa question do account tạo
-- - Xóa exam do account tạo
-- - In ra số record đã xóa ở từng bảng
DROP PROCEDURE IF EXISTS qsa_05;
DELIMITER \\

CREATE PROCEDURE qsa_05(IN input_account_id INT)
BEGIN
    DECLARE count_delete_group INT DEFAULT 0;
    DECLARE count_delete_question INT DEFAULT 0;
    DECLARE count_delete_exam INT DEFAULT 0;

    -- handler rollback nếu lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- group_account
    SELECT COUNT(*) INTO count_delete_group
    FROM group_account
    WHERE account_id = input_account_id;

    DELETE FROM group_account
    WHERE account_id = input_account_id;

    -- question
    SELECT COUNT(*) INTO count_delete_question
    FROM question
    WHERE creator_id = input_account_id;

    DELETE FROM question
    WHERE creator_id = input_account_id;

    -- exam
    SELECT COUNT(*) INTO count_delete_exam
    FROM exam
    WHERE creator_id = input_account_id;

    DELETE FROM exam
    WHERE creator_id = input_account_id;

    COMMIT;

    -- output
    SELECT 'group' AS type , count_delete_group
    UNION ALL
    SELECT 'question', count_delete_question
    UNION ALL
    SELECT 'exam', count_delete_exam;

END \\

DELIMITER ;    
CALL qsa_05(4);
-- Bài 6:
-- Viết store tạo exam mới
-- Yêu cầu:
-- - Insert vào bảng exam
-- - Insert nhiều question vào exam_question
-- - Nếu có question không tồn tại thì rollback toàn bộ

-- Bài 7:
-- Viết store tạo question kèm 4 answer
-- Yêu cầu:
-- - Phải có ít nhất 1 answer đúng
-- - Nếu không có thì rollback
DROP PROCEDURE IF EXISTS qsa_07;
DELIMITER \\
CREATE PROCEDURE qsa_07(IN conten_question VARCHAR(50) , 
						IN creator_id_question INT , 
						IN conten_answer1 VARCHAR(50) , 
						IN correct_answer1 BOOLEAN , 
						IN conten_answer2 VARCHAR(50) ,
						IN correct_answer2 BOOLEAN, 
						IN conten_answer3 VARCHAR(50) , 
						IN correct_answer3 BOOLEAN , 
						IN conten_answer4 VARCHAR(50) , 
						IN correct_answer4 BOOLEAN)
BEGIN 
	DECLARE take_question_id INT;
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;
        RESIGNAL;
	END;
    START TRANSACTION;
    
	IF correct_answer1 = 0 
	   AND correct_answer2 = 0 
	   AND correct_answer3 = 0 
	   AND correct_answer4 = 0 
	THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Phai co it nhat 1 answer dung';
	END IF;
    INSERT INTO question (content , creator_id)
    VALUES 				 (conten_question , creator_id_question);
    
    SET take_question_id = LAST_INSERT_ID();
    
    -- SELECT MAX(question_id) INTO take_question_id FROM question;
    
    INSERT INTO answer (content , question_id , is_correct)
    VALUES 			   (conten_answer1, take_question_id , correct_answer1),
					   (conten_answer2, take_question_id , correct_answer2),
					   (conten_answer3, take_question_id , correct_answer3),
					   (conten_answer4, take_question_id , correct_answer4);
    COMMIT;
END \\

CALL qsa_07('Câu hỏi về Java' , 1 , 'Trả lời 11' , 1 ,  'Trả lời 12' , 1 ,  'Trả lời 13' , 1 , 'Trả lời 14' , 1);

-- =============================
-- NHÓM 3: DATA INTEGRITY
-- =============================

-- Bài 8:
-- Viết store không cho phép insert question nếu account chưa tham gia group nào
DROP PROCEDURE IF EXISTS qsa_08;
DELIMITER \\

CREATE PROCEDURE qsa_08(
    IN content_question VARCHAR(50),
    IN category_question INT,
    IN type_question INT,
    IN creator_question INT
)
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1 
        FROM group_account 
        WHERE account_id = creator_question
    )
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'creator chua tham gia group';
    END IF;

    INSERT INTO question (content, category_id, type_id, creator_id)
    VALUES (content_question, category_question, type_question, creator_question);

    COMMIT;
END \\

DELIMITER ;
CALL qsa_08('Câu hỏi về Java' , 1 , 1 , 4);
    
	
-- Bài 9:
-- Viết store không cho phép xóa department nếu vẫn còn account thuộc department đó
-- Nếu vi phạm thì báo lỗi
DROP PROCEDURE IF EXISTS qsa_09;
DELIMITER \\
CREATE PROCEDURE qsa_09(IN input_department_id INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        RESIGNAL;
	END;
    START TRANSACTION;
    IF EXISTS (
		SELECT 1 
		FROM account
		WHERE department_id = input_department_id
	)
    THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Van con account trong department';
	END IF;
    DELETE FROM department
    WHERE department_id = input_department_id;
END \\
DELIMITER ;

CALL qsa_09 (2);
-- =============================
-- NHÓM 4: QUERY NÂNG CAO
-- =============================

-- Bài 10:
-- Với mỗi department, tìm account tạo nhiều question nhất
-- Trả về: department_id, account_id, total_question
DROP PROCEDURE IF EXISTS qsa_10;
DELIMITER \\

CREATE PROCEDURE qsa_10()
BEGIN
    WITH c_question AS (
        SELECT creator_id, COUNT(*) AS total_question
        FROM question
        GROUP BY creator_id
    ),
    dept_question AS (
        SELECT 
            a.department_id,
            a.account_id,
            COALESCE(cq.total_question, 0) AS total_question
        FROM account a
        LEFT JOIN c_question cq ON a.account_id = cq.creator_id
        WHERE a.department_id IS NOT NULL
    ),
    max_per_dept AS (
        SELECT 
            department_id,
            MAX(total_question) AS max_question
        FROM dept_question
        GROUP BY department_id
    )
    SELECT 
        d.department_id,
        d.account_id,
        d.total_question
    FROM dept_question d
    JOIN max_per_dept m
        ON d.department_id = m.department_id
        AND d.total_question = m.max_question;
END \\

DELIMITER ;

-- Tong hop cac question theo creator_id
-- tong hop moi department va moi creator_id trong department do co bao nhieu question
-- tao 1 to nhap xem department do co nhan vien tao max question la bao nhieu
-- lay bang tong hop department va creator_id join voi bang max_dept_question de lay department_id va max_count_question 
DROP PROCEDURE IF EXISTS qsa_10;
DELIMITER \\
CREATE PROCEDURE qsa_10()
BEGIN
	WITH question_count AS (
		SELECT creator_id , COUNT(question_id) as count_question
        FROM question
        GROUP BY creator_id
    ) , dept_question AS (
		SELECT department_id , 
			   a.account_id , 
               COALESCE(qc.count_question , 0) AS count_question
        FROM account as a
        LEFT JOIN question_count as qc ON a.account_id = qc.creator_id
        WHERE department_id IS NOT NULL
	) , max_dept_question AS (
		SELECT department_id , MAX(count_question) AS count_question
        FROM dept_question
        GROUP BY department_id
	)
    SELECT d.department_id , d.account_id , d.count_question
    FROM dept_question as d
    JOIN max_dept_question AS md ON d.department_id = md.department_id AND d.count_question = md.count_question;
END \\
DELIMITER ;
-- Bài 11:
-- Tìm question xuất hiện trong nhiều exam nhất
DROP PROCEDURE IF EXISTS qsa_11;
DELIMITER \\

CREATE PROCEDURE qsa_11()
BEGIN
    WITH find_max AS (
        SELECT 
            question_id, 
            COUNT(exam_id) AS total_exam
        FROM exam_question
        GROUP BY question_id
    )
    SELECT question_id
    FROM find_max
    WHERE total_exam = (
        SELECT MAX(total_exam)
        FROM find_max
    );
END \\

DELIMITER ;
-- Bài 12:
-- Tìm account chưa từng tạo question nào
DROP PROCEDURE IF EXISTS qsa_12;
DELIMITER \\
CREATE PROCEDURE qsa_12()
BEGIN 
	SELECT a.account_id
	FROM account a
	WHERE NOT EXISTS (
		SELECT 1
		FROM question q
		WHERE q.creator_id = a.account_id
);
END \\
DELIMITER ;
-- Bài 13:
-- Với mỗi account:
-- - Đếm số question
-- - Xếp hạng theo số question (dùng RANK)
DROP PROCEDURE IF EXISTS qsa_13
DELIMITER \\
CREATE PROCEDURE qsa_13()
BEGIN 
	WITH count_question AS (
		SELECT creator_id , COUNT(question_id) AS c_question
        FROM question
        GROUP BY creator_id
	) 
    SELECT a.* , q.c_question , RANK() OVER (ORDER BY c_question DESC) AS rnk
    FROM account as a
    JOIN count_question as q ON a.account_id = q.creator_id;
END \\
DELIMITER ;
-- =============================
-- NHÓM 5: TỐI ƯU TRUY VẤN
-- =============================

-- Bài 14:
-- Viết lại bài “type question có nhiều question nhất” bằng 3 cách:
-- 1. Subquery
-- 2. JOIN
-- 3. Window function
-- Sau đó dùng EXPLAIN để so sánh performance

-- BAI TAP SIGNAL
-- Bai 1
-- Viết store tạo account
-- Yêu cầu:
-- - email không được NULL
-- - email phải chứa '@'
-- - nếu sai → SIGNAL lỗi
-- - nếu đúng → insert vào bảng account

-- Bai2
-- Viết store tạo question
-- Yêu cầu:
-- - creator_id phải tồn tại trong account
-- - nếu không tồn tại → SIGNAL lỗi
-- - nếu tồn tại → insert question

-- Bai3
-- Viết store thêm account vào group
-- Input: account_id, group_id

-- Yêu cầu:
-- 1. account phải tồn tại
-- 2. group phải tồn tại
-- 3. account chưa nằm trong group đó
-- 4. nếu vi phạm bất kỳ điều nào → SIGNAL
-- 5. nếu hợp lệ → insert vào group_account
-- 6. dùng transaction + rollback nếu lỗi