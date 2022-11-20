--Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
DECLARE @Tb_Luong FLOAT 
SET @Tb_Luong = (SELECT AVG(LUONG) FROM NHANVIEN)
SELECT TENPHG AS N'Tên phòng ban',COUNT(*) AS N'Số nhân viên'
FROM PHONGBAN , NHANVIEN
WHERE NHANVIEN.PHG=PHONGBAN.MAPHG AND @Tb_Luong >30000
GROUP BY TENPHG
