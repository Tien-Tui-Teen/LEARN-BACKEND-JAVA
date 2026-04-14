USE assignment_06;
-- STORED PROCEDURE : Thủ tục lưu trữ 
-- Từ khoá : IN , OUT , INOUT
-- IN : đưa cho người khác không muốn nhận lại
-- OUT : đưa người ta cái ly muốn người ta lấy nước người ta trả lại cái ly có nước
-- INOUT : Vừa cho đi vừa nhận về
-- Giống các hàm truyền vào tham số ở ngôn ngữ bật cao
-- Xoá thủ tục
DROP PROCEDURE IF EXISTS sp_01;

-- VD: Tao thủ tục lấy ra phòng ban theo id
DELIMITER $$
CREATE PROCEDURE sp_01(IN in_department_id INT)
BEGIN
	SELECT *
    FROM department
    WHERE department_id = in_department_id;
END $$

DELIMITER ;

-- Gọi thủ tục
CALL sp_01(5);

-- FUNCTION : hàm
-- Trả về duy nhất 1 giá trị
-- Mọi tham số đều là IN
-- VD:
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS fn_01;
DELIMITER $$
CREATE FUNCTION fn_01 (in_department_id INT) RETURNS VARCHAR(50)
BEGIN
	DECLARE v_department_name VARCHAR(50);
    SELECT department_name INTO v_department_name
    FROM department
    WHERE department_id = in_department_id;
    
    RETURN  v_department_name;
END $$
DELIMITER ;

-- Sử dụng function
SELECT *
FROM department
WHERE department_name = fn_01(1);