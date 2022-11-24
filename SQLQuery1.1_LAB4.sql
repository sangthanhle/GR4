DECLARE @LUONG FLOAT
SET @LUONG = (SELECT AVG(LUONG)
				FROM NHANVIEN, PHONGBAN
				WHERE NHANVIEN.PHG = PHONGBAN.MAPHG)

SELECT TENNV, IIF(LUONG < @LUONG, 'T�NG L��NG', 'KH�NG T�NG L��NG') AS 'XEM X�T T�NG L��NG'
FROM NHANVIEN