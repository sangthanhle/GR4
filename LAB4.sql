/* Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là TenNV, cột thứ 2 nhận giá trị
o “TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong
phòng mà nhân viên đó đang làm việc.
o “KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương
trong phòng mà nhân viên đó đang làm việc.*/ 
DECLARE @LUONG FLOAT
SET @LUONG = (SELECT AVG(LUONG)
				FROM NHANVIEN, PHONGBAN
				WHERE NHANVIEN.PHG = PHONGBAN.MAPHG)

SELECT TENNV, IIF(LUONG < @LUONG, N'tang luong', N'KHÔNG TĂNG LƯƠNG') AS N'XEM XÉT TĂNG LƯƠNG'
FROM NHANVIEN
/* Viết chương trình phân loại nhân viên dựa vào mức lương.
o Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì
xếp loại “nhanvien”, ngược lại xếp loại “truongphong” */
DECLARE @LTB FLOAT
SET @LTB = (SELECT AVG(LUONG) FROM NHANVIEN)
SELECT IIF(LUONG>@LTB,'truong phong','pho phong' ) 
AS ChucVu,TENNV,Luong FROM NHANVIEN

go
----- .Viết chương trình hiển thị TenNV như hình bên dưới, tùy vào cột phái của nhân viên
SELECT TENNV = CASE PHAI
WHEN 'nam' then 'Mr '+[TENNV]
WHEN 'Nữ'  then 'Ms '+ [TENNV]
ELSE TENNV
end
FROM NHANVIEN

---------

SELECT * FROM NHANVIEN
SELECT TENNV , LUONG, 'THUE'=
	CASE
	WHEN LUONG between 0 and 25000 then LUONG * (10/100)
	WHEN LUONG between 25000 and 30000 then LUONG *(12/100)
	WHEN LUONG between 30000 and 40000 then LUONG *(15/100)
	WHEN LUONG between 40000 and 50000 then LUONG *(20/100)
	ELSE LUONG * (25/100)
	 END
	 FROM NHANVIEN
------ Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
DECLARE @MACHAN INT =2
WHILE @MACHAN< (SELECT COUNT(MANV) FROM NHANVIEN)
BEGIN
	SELECT HONV, TENLOT, TENNV, MANV
	FROM NHANVIEN
	WHERE CAST(MANV AS INT)= @MACHAN
	SET @MACHAN = @MACHAN+2
END
--Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước
BEGIN TRY  
INSERT PHONGBAN
VALUES (N'Nghiep vu', 9, 033,'1977-06-02')
PRINT 'THANH CONG'
END TRY
BEGIN CATCH
PRINT 'FAIL'
print 'ERROR' + CONVERT(VARCHAR,ERROR_NUMBER(),1) + ERROR_MESSAGE()
END CATCH
-------SU DUNG RAISERROR
BEGIN TRY
	DECLARE @CHIA INT
	SET @CHIA = @CHIA/0
END TRY
BEGIN CATCH
	DECLARE @ERMESSAGE NVARCHAR(2048),
			@ERSEVERITY INT,
			@ERSTATE INT
	SELECT
			@ERMESSAGE = ERROR_MESSAGE(),
			@ERSEVERITY = ERROR_SEVERITY(),
			@ERSTATE = ERROR_STATE()
	RAISERROR (@ERMESSAGE, @ERSEVERITY, @ERSTATE)
END CATCH
------KHONG DUNG RAISERROR
BEGIN TRY
	DECLARE @CHIA INT
	SET @CHIA = @CHIA/0
END TRY
BEGIN CATCH
	DECLARE @ERMESSAGE NVARCHAR(2048),
			@ERSEVERITY INT,
			@ERSTATE INT
	SELECT
			@ERMESSAGE = ERROR_MESSAGE(),
			@ERSEVERITY = ERROR_SEVERITY(),
			@ERSTATE = ERROR_STATE()
END CATCH



-- câu 4
DECLARE @sum INT = 0, @bieni int =1 
WHILE @bieni < 11
BEGIN 
	IF(@bieni %2 = 0)
	BEGIN
		SET @sum = @sum + @bieni
	END	
	SET @bieni = @bieni + 1
END
PRINT(N'Tổng các số từ 1 đến 10 là: ')
PRINT(@sum)
GO

DECLARE @sum INT = 0, @bieni int =1 
WHILE @bieni < 11
BEGIN
	IF(@bieni %2 = 0)
	BEGIN
		IF(@bieni != 4)
		BEGIN
			SET @sum = @sum + @bieni
		END
	END		
	SET @bieni = @bieni + 1
END
PRINT(N'Tổng các số từ 1 đến 10 trừ 4 là: ')
PRINT(@sum)
GO
