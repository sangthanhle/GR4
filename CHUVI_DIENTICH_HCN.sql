--Chương trình tính diện tích, chu vi hình chữ nhật khi biết chiều dài và chiều rộng.
DECLARE @Chieu_Dai int , @Chieu_Rong int ,@Dien_Tich int , @Chu_Vi int
SET @Chieu_Dai =5;
SET @Chieu_Rong = 5;
SET @Chu_Vi = (@Chieu_Rong + @Chieu_Dai)*2
SET @Dien_Tich = @Chieu_Rong * @Chieu_Dai
SELECT @Chu_Vi AS N'CHU VI HINH CHU NHAT'
SELECT @Dien_Tich AS N'DIEN TICH HINH CHU NHAT'

