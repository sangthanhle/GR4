--Cho biêt nhân viên có lương cao nhất
DECLARE @MaxSalary FLOAT
SET @MaxSalary = (SELECT MAX(LUONG) FROM NHANVIEN)
SELECT HONV + TENLOT + TENNV as 'Ho va Ten' , LUONG
FROM NHANVIEN
WHERE LUONG = @MaxSalary

