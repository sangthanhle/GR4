--bài 1
/*Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân.*/
SELECT DEAN.MADA AS 'MÃ ĐỀ ÁN', TENDEAN AS 'TÊN ĐỀ ÁN', CONVERT(DECIMAL(5,2), SUM(THOIGIAN)) AS 'TỔNG SỐ GIỜ LÀM'
FROM DEAN, PHANCONG
WHERE DEAN.MADA = PHANCONG.MADA
GROUP BY DEAN.MADA, DEAN.TENDEAN

/*Xuất định dạng “tổng số giờ làm việc” kiểu varchar*/
SELECT DEAN.MADA AS 'MÃ ĐỀ ÁN', TENDEAN AS 'TÊN ĐỀ ÁN', CAST(SUM(THOIGIAN) AS VARCHAR(20)) AS 'TỔNG SỐ GIỜ LÀM'
FROM DEAN, PHANCONG
WHERE DEAN.MADA = PHANCONG.MADA
GROUP BY DEAN.MADA, DEAN.TENDEAN
/*Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3
chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace*/
SELECT TENPHG, LEFT(CAST(AVG(LUONG) AS VARCHAR(10)),3)
+REPLACE(CAST(AVG(LUONG) AS VARCHAR(10)),LEFT(CAST(AVG(LUONG) AS VARCHAR(10)),3), ',')
AS 'LƯƠNG TRUNG BÌNH' FROM NHANVIEN
INNER JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY TENPHG


/*Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu
phẩy để phân biệt phần nguyên và phần thập phân.*/
SELECT TENPHG AS 'TÊN PHÒNG BAN', CONVERT(DECIMAL(10,2), AVG(LUONG),3) AS 'LƯƠNG TRUNG BÌNH'
FROM PHONGBAN, NHANVIEN
WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY TENPHG
-- Bài 2
--Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
--Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
SELECT DEAN.MADA AS 'MÃ ĐỀ ÁN', DEAN.TENDEAN AS 'TÊN ĐỀ ÁN', CEILING (CAST(SUM(PHANCONG.THOIGIAN) AS decimal(5,2)) )AS 'TỔNG SỐ GIỜ LÀM VIỆC'
FROM DEAN, PHANCONG
WHERE DEAN.MADA = PHANCONG.MADA
GROUP BY DEAN.MADA, DEAN.TENDEAN
--Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
SELECT DEAN.MADA AS 'MÃ ĐỀ ÁN', DEAN.TENDEAN AS 'TÊN ĐỀ ÁN', FLOOR (CAST(SUM(PHANCONG.THOIGIAN) AS decimal(5,2)) )AS 'TỔNG SỐ GIỜ LÀM VIỆC'
FROM DEAN, PHANCONG
WHERE DEAN.MADA = PHANCONG.MADA
GROUP BY DEAN.MADA, DEAN.TENDEAN
--Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân
SELECT DEAN.MADA AS 'MÃ ĐỀ ÁN', DEAN.TENDEAN AS 'TÊN ĐỀ ÁN', ROUND (CAST(SUM(PHANCONG.THOIGIAN) AS decimal(5,2)),2 )AS 'TỔNG SỐ GIỜ LÀM VIỆC'
FROM DEAN, PHANCONG
WHERE DEAN.MADA = PHANCONG.MADA
GROUP BY DEAN.MADA, DEAN.TENDEAN
--Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu"
DECLARE @TB_LUONG DECIMAL(10,2)
SET @TB_LUONG = (SELECT ROUND(AVG(LUONG),2) FROM NHANVIEN)
SELECT HONV + TENLOT + TENNV AS N'HỌ VÀ TÊN',LUONG as N'LƯƠNG',TENPHG
FROM NHANVIEN ,PHONGBAN
WHERE NHANVIEN.LUONG > @TB_LUONG AND PHONGBAN.TENPHG LIKE N'Nghiên Cứu'
--BÀI 3
--Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân, thỏa các yêu cầu
--Dữ liệu cột HONV được viết in hoa toàn bộ
SELECT  UPPER (NHANVIEN.HONV ) AS 'HONV' , NHANVIEN.TENLOT , NHANVIEN.TENNV
	FROM NHANVIEN, THANNHAN
	WHERE NHANVIEN.MANV= THANNHAN.MA_NVIEN
	GROUP BY  UPPER(NHANVIEN.HONV ),NHANVIEN.TENLOT, NHANVIEN.TENNV 
	HAVING COUNT(THANNHAN.MA_NVIEN) > 2
--Dữ liệu cột TENLOT được viết chữ thường toàn bộ
	SELECT  NHANVIEN.HONV  ,LOWER ( NHANVIEN.TENLOT) AS N'TENLOT' , NHANVIEN.TENNV
	FROM NHANVIEN, THANNHAN
	WHERE NHANVIEN.MANV= THANNHAN.MA_NVIEN
	GROUP BY  NHANVIEN.HONV, LOWER ( NHANVIEN.TENLOT), NHANVIEN.TENNV 
	HAVING COUNT(THANNHAN.MA_NVIEN) > 2
--Dữ liệu chột TENNV có ký tự thứ 2 được viết in hoa, các ký tự còn lại viết thường( ví dụ: kHanh) liệu cột TENLOT được viết chữ thường toàn bộ
	SELECT  NHANVIEN.HONV  ,NHANVIEN.TENLOT , NHANVIEN.TENNV
	FROM NHANVIEN, THANNHAN
	WHERE NHANVIEN.MANV= THANNHAN.MA_NVIEN
	GROUP BY  NHANVIEN.HONV,NHANVIEN.TENLOT, NHANVIEN.TENNV 
	HAVING COUNT(THANNHAN.MA_NVIEN) > 2

--Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác như số nhà hay thành phố.
SELECT  NHANVIEN.HONV ,NHANVIEN.TENLOT , NHANVIEN.TENNV , SUBSTRING (DCHI,4,15) as N'Tên đường'
	FROM NHANVIEN, THANNHAN 
	WHERE NHANVIEN.MANV= THANNHAN.MA_NVIEN 
	GROUP BY  NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TENNV ,SUBSTRING (DCHI,4,15)
	HAVING COUNT(THANNHAN.MA_NVIEN) > 2

--Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất, hiển thị thêm một cột thay thế tên trưởng phòng bằng tên “Fpoly”

--bài 4
/*Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.*/
SELECT (HONV + ' ' + TENLOT + ' '+ TENNV) AS 'TÊN NHÂN VIÊN', CONVERT(VARCHAR,NGSINH,105) AS 'NĂM SINH'
FROM NHANVIEN
WHERE (YEAR(NGSINH) BETWEEN 1960 AND 1965)

/*Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.*/
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' '+ NHANVIEN.TENNV) as 'Họ và Tên', (YEAR(GETDATE()) - YEAR(NHANVIEN.NGSINH)) AS 'Tuổi'
	FROM NHANVIEN
/*Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy.*/
SELECT TENNV, DATENAME(WEEKDAY, YEAR(NGSINH)) AS 'NHÂN VIÊN SINH VÀO THỨ'
FROM NHANVIEN
