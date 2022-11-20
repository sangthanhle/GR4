--Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương
trên mức lương trung bình của phòng "Nghiên cứu”
DECLARE @Tb_Luong FLOAT
SET @Tb_Luong = (SELECT AVG(LUONG) FROM NHANVIEN)
SELECT HONV + TENLOT + TENNV as 'Ho va Ten' , LUONG ,TENPHG as 'phong ban'
FROM NHANVIEN , PHONGBAN 
WHERE 
NHANVIEN.LUONG > @Tb_Luong  and 
PHONGBAN.TENPHG = N'Nghiên Cứu'  
