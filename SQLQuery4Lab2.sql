--Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
SELECT TENPHG AS N'TÊN PHÒNG',COUNT(*) AS N'SỐ LƯỢNG ĐỀ ÁN'
FROM DEAN,PHONGBAN
WHERE DEAN.PHONG=PHONGBAN.MAPHG
GROUP BY TENPHG
