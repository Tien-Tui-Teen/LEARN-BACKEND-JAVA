-- Thứ tự thực thi 
-- (8) SELECT
-- (1) FROM
-- (2) JOIN
-- (3) WHERE
-- (4) GROUP BY
-- (5) HAVING
-- (6) ORDER BY
-- (7) LIMIT

-- Mệnh đề SELECT
SELECT PI() , 1 + 1 , CURRENT_DATE() , NOW() , CURRENT_TIMESTAMP();

-- Mệnh đề FROM
SELECT department_id , department_name
FROM department;
-- *: Đại diện cho tất cả các cột
SELECT *
FROM DEPARTMENT;

-- Mệnh đề WHERE
-- Điều kiện cho từng bản ghi
-- Toán tử : > , >= , < , <= , = , !=
-- VD : Lấy ra phòng ban có id = 5
SELECT *
FROM department
WHERE department_id = 5;

-- Toán tử : AND , OR
-- VD: Lấy ra phòng ban có id => 3 và <= 7
SELECT *
FROM department
WHERE department_id >= 3 AND department_id <= 7;
-- Toán tử : BETWEEN ... AND ... 
-- BETWEEN có lấy dấu bằng
-- VD: Lấy ra phòng ban có id => 3 và <= 7
SELECT *
FROM department
WHERE department_id BETWEEN 3 AND 7;

-- Toán tử IN
-- VD: Lấy ra phòng ban có id là số chẳn từ 2 đến 8
SELECT *
FROM department
WHERE department_id IN (2 , 4 , 6, 8 );

SELECT *
FROM department
WHERE department_id NOT IN (1 , 3 , 5 , 7, 9 , 10);

-- Toán tử: LIKE
-- cần tìm kiếm 1 chuỗi theo khuôn mẫu
-- _: Đại diện cho 1 kí tự bất kỳ
-- %: Đại diện cho 0 hoặc nhiều ký tự bất kỳ
-- VD : Lấy ra phòng ban có tên chứa ký tự 'n'
SELECT *
FROM department
WHERE department_name LIKE '%N%';

-- Toán tử : IS NULL / IS NOT NULL
-- Lưu ý khi check NULL phải dùng IS không được dùng = hoặc !=
-- VD : Lấy ra phòng ban có tên
SELECT *
FROM department
WHERE department_name IS NOT NULL;

-- Mệnh đề ORDER BY (sắp xếp)
-- Hướng : ASC , DESC | Tăng dần , giảm dần
-- Mặc định : ASC
-- Vd : Lấy ra tất cả đề thi sắp xếp theo
-- Thời gian giảm dần
SELECT *
FROM exam
ORDER BY duration DESC;
-- Vd : Lấy ra tất cả đề thi sắp xếp theo
-- Thời gian giảm dần 
-- Ngày tạo giảm dần
SELECT *
FROM exam
ORDER BY duration DESC , created_date DESC;

-- Mệnh đề LIMIT 
-- VD : Lấy ra 5 phòng ban
SELECT  *
FROM department
LIMIT 5;

-- Các hàm tổng hợp : COUNT , SUM , MIN , MAX , AVG
-- COUNT(*) : Đếm số dòng
-- COUNT(id) : Đếm số dòng có id khác NULL
-- Chỉ thao tác với giá trị khác null
SELECT COUNT(*)
FROM department;

SELECT COUNT(*) , SUM(duration) , MIN(duration) , MAX(duration) , AVG(duration)
FROM exam;

-- Mệnh đề GROUP BY
-- Dùng để gom nhóm
-- Chỉ in được thông tin của nhóm không dùng được * và các cột khác nhóm
SELECT duration , count(exam_id)
FROM exam
GROUP BY duration;

-- Mệnh đề HAVING
-- Điều kiên cho từng nhóm
SELECT duration , COUNT(exam_id)
FROM exam
GROUP BY duration
HAVING COUNT(exam_id) > 3;

-- ALIAS : Đặt bí danh tạm thời
SELECT COUNT(*) AS department_count
FROM department;
