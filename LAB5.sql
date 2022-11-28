/*Bài 1 - 1*/
CREATE PROC sp_Bai1_1 @ten NVARCHAR(20)
AS
	BEGIN
		PRINT ('Xin chào: '+ @ten)
	END

EXEC sp_Bai1_1 'BAN'

go
/*Bài 1 - 2*/
CREATE PROC sp_Bai1_2 @s1 int, @s2 int
AS
	BEGIN
		DECLARE @tg int = 0;
		SET @tg = @s1 + @s2
		PRINT 'Tong la: ' + CAST(@tg AS VARCHAR(10))
	END

EXEC sp_Bai1_2 4,7
go
---1.3
CREATE PROC sp_Bai1_3 @n INT
AS
	BEGIN
		DECLARE @tong int = 0, @i int = 0;
		WHILE @i <= @n
			BEGIN
				SET @tong = @tong + @i
				SET @i = @i + 2
			END
		PRINT 'Tong chan: ' + CAST(@tong AS VARCHAR(10))
	END

EXEC sp_Bai1_3 10
go
--1.4
CREATE PROC sp_Bai1_4 @a INT, @b INT
AS
	BEGIN
		WHILE (@a != @b)
			BEGIN
				IF(@a > @b)
					SET @a = @a - @b
				ELSE
					SET @b = @b - @a
			END
			RETURN @a
	END

DECLARE @c INT
EXEC @c = sp_Bai1_4 7,5
PRINT @c
go
--2.1
CREATE PROC Bai2_1 @manv VARCHAR(10)
AS
BEGIN
	SELECT *
	FROM NHANVIEN
	WHERE MANV = @manv
END

EXEC Bai2_1 '004'
go
--2.2
CREATE PROC Bai2_2 @mada INT
AS
BEGIN
	SELECT COUNT(MANV) AS 'So luong NV', MADA, TENPHG
	FROM PHONGBAN
	INNER JOIN DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
	INNER JOIN NHANVIEN ON NHANVIEN.PHG = PHONGBAN.MAPHG
	WHERE MADA = @mada
	GROUP BY TENPHG, MADA
END

EXEC Bai2_2 1
go
--2.3
CREATE PROC Bai2_3 @mada INT, @Ddiem_DA nvarchar(15)
AS
BEGIN
	SELECT COUNT(MANV) AS 'So luong NV', MADA, DDIEM_DA, TENPHG
	FROM PHONGBAN
	INNER JOIN DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
	INNER JOIN NHANVIEN ON NHANVIEN.PHG = PHONGBAN.MAPHG
	WHERE MADA = @mada and DDIEM_DA = @Ddiem_DA
	GROUP BY TENPHG, MADA, DDIEM_DA
END

EXEC Bai2_3 1 
go
--2.4
CREATE PROC Bai2_4 @trphg VARCHAR (20)
AS
BEGIN
	SELECT HONV, TENLOT, TENNV, TENPHG, NHANVIEN.MANV
	FROM NHANVIEN
	INNER JOIN PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG
	LEFT OUTER JOIN THANNHAN ON THANNHAN.MA_NVIEN = NHANVIEN.MANV
	WHERE THANNHAN.MA_NVIEN IS NULL AND TRPHG = @trphg
END

EXEC Bai2_4 '008'
go
--2.5
CREATE PROC Bai2_5 @manv VARCHAR(10), @mapb VARCHAR(10)
AS
BEGIN
	IF EXISTS(SELECT * FROM NHANVIEN WHERE MANV = @manv AND PHG = @mapb)
		PRINT 'Nhan vien ' + @manv + ' co trong phong ban: ' + @mapb
	ELSE
		PRINT'Nhan vien ' + @manv + ' khong co trong phong ban: ' + @mapb
END

EXEC Bai2_5 '006', '4'
go
--3.1
CREATE PROC Bai3_1 @mapb INT, @tenpb NVARCHAR(20), @trphg NVARCHAR(20), @ngaync DATE
AS
BEGIN
	IF(EXISTS(SELECT * FROM PHONGBAN WHERE MAPHG = @mapb))
		PRINT 'Them khong thanh cong'
	ELSE
		BEGIN
			INSERT INTO PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
			VALUES (@mapb, @tenpb, @trphg, @ngaync)
			PRINT('Them thanh cong')
		END
END

EXEC Bai3_1 '8', 'CNTT', '008', '2019-05-16'
go
--3.2
CREATE PROC Bai3_2 @mapb INT, @tenpb NVARCHAR(20), @trphg NVARCHAR(20), @ngaync DATE
AS
BEGIN
	IF(EXISTS(SELECT * FROM PHONGBAN WHERE MAPHG = @mapb))
		UPDATE PHONGBAN
		SET TENPHG = @tenpb, TRPHG = @trphg, NG_NHANCHUC = @ngaync
		WHERE MAPHG = @mapb
	ELSE
		BEGIN
			INSERT INTO PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
			VALUES (@mapb, @tenpb, @trphg, @ngaync)
			PRINT('Cap nhat khong thanh cong')
		END
END

EXEC Bai3_2 '8', 'IT', '008', '2019-05-16'
go
--3.3
CREATE PROC Bai3_3 @honv NVARCHAR(20), @tenlot NVARCHAR(20), @tennv NVARCHAR(20), @manv NVARCHAR(10),
@ngsinh DATE, @dchi	NVARCHAR(50), @phai NVARCHAR(5), @luong FLOAT, @ma_nql NVARCHAR(5), @phg INT
AS
BEGIN
	DECLARE @age INT
	SET @age = YEAR(GETDATE()) - YEAR(@ngsinh)
	IF @phg = (SELECT MAPHG FROM PHONGBAN WHERE TENPHG = 'IT')
		BEGIN
			IF @luong < 25000
				SET @ma_nql = '009'
			ELSE SET @ma_nql = '005'

			IF (@phai = 'Nam' AND (@age >= 18 AND @age <= 65)) 
				OR (@phai = N'Nữ' AND (@age >= 18 AND @age <= 60))
				BEGIN
					INSERT INTO NHANVIEN(HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
					VALUES (@honv, @tenlot, @tennv, @manv, @ngsinh, @dchi, @phai, @luong, @ma_nql, @phg)
				END
			ELSE
				PRINT('Khong thuoc do tuoi lao dong')
		END
	ELSE
		PRINT ('Khong phai phong IT')
END

EXEC Bai3_3 'Tran', 'Van', 'Toan', '019', '2002-04-03', 'Da Lat', 'Nam', '26000', '004', '5'
EXEC Bai3_3 'Tran', 'Van', 'Toan', '019', '2002-04-03', 'Da Lat', 'Nam', '26000', '004', '6'
