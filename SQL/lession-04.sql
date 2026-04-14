DROP DATABASE IF EXISTS lesson_04;
CREATE DATABASE lesson_04;
USE lesson_04;

DROP TABLE IF EXISTS boy;
CREATE TABLE boy (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS girl;
CREATE TABLE girl (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

INSERT INTO boy (id, name   )
VALUES          (1 , "Khoa" ),
                (2 , "Duy"  ),
                (3 , "Hùng" ),
                (4 , "Cường"),
                (6 , "LInh" );

INSERT INTO GIRl (id, naMe      )
VALUES           (1 , "THương"  ),
                 (2 , "NGọC Anh"),
                 (5 , "TrANg"   ),
                 (6 , "LiNH"    );
                 
-- mệnh đề JOIN
-- nối với nhau xem chiều ngang
-- inner join
-- vd: lấy ra các cặp có id giống nhau                 
SELECT *
FROM boy
JOIN girl ON BOy.iD=GIrl.id;
-- từ khÓA usiNg
-- điỀu kiện
-- tên cột giống nhau
-- liên kết với nhau bởi dấu =
select *
from boy
inner join girl using(id);                 

-- cHÚ Ý vIẾT trước BÊN TRái viết sau bên phải
-- left join
select *
from boy
left join girl using(id);                 
                 
-- LEFt/ RIght exCLUDINg Join
-- lấy ra phần k giao nhau 
-- giống join thêm Where A. khóa chính is null
SELECT *
FROM boy
LEFT JOIN girl USING(id)
WHERE girl.id IS NULL;

-- crOSS JOiN 1 PHần tử Ở BảNG A 
-- nỐI VỚI tẤt CẢ Các dòNg ở BảNG B
SELECT *
FROM boy
CROSS JOIN girl;

-- UNION : Hợp kết quả 2 bảng (không in ra kết quả trùng)
-- (GIốNg NHƯ khi TÌM KiẾM Sam sung không chỉ ra điện thoại mà còn ra các sản phẩm khác như tủ lạnh ....)
-- VD : Tìm kiếm account hoặc group chứa ký tự 'n'
SELECT 'account' AS type , username AS resulte
FROM account
WHERE username LIKE '%n%'
UNION
SELECT 'group' AS type , group_name AS resulte
FROM `GROUP`
WHERE grouP_name LIKE '%n%';


-- UNION ALL : có in rA DỮ liệu trùng
SELECT 1 AS NUMbER
UNION
SELECT 1 AS nuMber; -- 1
SELECT 1 AS nUMBEr
UNION ALL
SELECT 1 AS nuMBER; -- 1 1


                 
                 
                 
                 