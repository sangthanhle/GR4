DECLARE @MACHAN INT =2
WHILE @MACHAN< (SELECT COUNT(MANV) FROM NHANVIEN)
BEGIN
	SELECT HONV, TENLOT, TENNV, MANV
	FROM NHANVIEN
	WHERE CAST(MANV AS INT)= @MACHAN
	SET @MACHAN = @MACHAN+2
END