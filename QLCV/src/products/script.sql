USE [master]
GO
/****** Object:  Database [QuanLyCongVan]    Script Date: 29/12/2013 3:17:02 PM ******/
CREATE DATABASE [QuanLyCongVan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyCongVan', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyCongVan.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyCongVan_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyCongVan_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyCongVan] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyCongVan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyCongVan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyCongVan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLyCongVan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyCongVan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyCongVan] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyCongVan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyCongVan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyCongVan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyCongVan] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QuanLyCongVan]
GO
/****** Object:  StoredProcedure [dbo].[CongVan_CT]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_CT]
@So int
AS
		SELECT CV.Ma,CV.So, TenCV,TrichYeu, TenFile, NgayPH,YKienLD, YKienCV, TenTT, TenUser AS NguoiGoi, ThoiGianGui, ThoiGianDoc, ThoiGianDuyet, ThoiGianSoan,
	(SELECT TenUser FROM UserN, CV_UserN_TT CT WHERE UserN.Ma = CT.Ma_UserNhan AND CUT.So_CV = CT.So_CV AND CUT.Ma_TT = CT.Ma_TT AND CUT.Ma_User = CT.Ma_User AND CUT.Ma_UserNhan = CT.Ma_UserNhan) AS NguoiNhan
	FROM CongVan CV, TinhTrang TT, UserN U, CV_UserN_TT CUT
	WHERE CV.So = CUT.So_CV AND CUT.Ma_TT = TT.Ma AND CUT.Ma_User = U.Ma
	ORDER BY CV.So DESC

GO
/****** Object:  StoredProcedure [dbo].[CongVan_Den]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_Den]
(
	@Ma int
)
AS
BEGIN
	SELECT CV.Ma,CV.So, TenCV,TrichYeu, TenFile, NgayPH,YKienLD, YKienCV, TenTT, TenUser AS NguoiGoi, ThoiGianGui, ThoiGianDoc
	FROM CongVan CV, TinhTrang TT, UserN U, CV_UserN_TT CUT
	WHERE CV.So = CUT.So_CV AND CUT.Ma_TT = TT.Ma AND CUT.Ma_User = U.Ma AND Ma_UserNhan = @Ma
	ORDER BY ThoiGianGui DESC 
END
GO
/****** Object:  StoredProcedure [dbo].[CongVan_DS]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_DS]
AS
	SELECT CV.Ma,CV.So, TenCV,TrichYeu, TenFile, NgayPH,YKienLD, YKienCV, TenTT, TenUser AS NguoiGoi, ThoiGianGui, ThoiGianSoan,
	(SELECT TenUser FROM UserN, CV_UserN_TT CT WHERE UserN.Ma = CT.Ma_UserNhan AND CUT.So_CV = CT.So_CV AND CUT.Ma_TT = CT.Ma_TT AND CUT.Ma_User = CT.Ma_User AND CUT.Ma_UserNhan = CT.Ma_UserNhan) AS NguoiNhan
	FROM CongVan CV, TinhTrang TT, UserN U, CV_UserN_TT CUT
	WHERE CV.So = CUT.So_CV AND CUT.Ma_TT = TT.Ma AND CUT.Ma_User = U.Ma
	ORDER BY CV.So

GO
/****** Object:  StoredProcedure [dbo].[CongVan_DuThao]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_DuThao]
@So_CV int,
@Ma_User tinyint,
@Ma_UserNhan tinyint
AS
		IF ((NOT EXISTS(SELECT So_CV FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan )) 
			AND (NOT EXISTS(SELECT Ma_TT FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan))
			AND (NOT EXISTS(SELECT Ma_User FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan))
			AND (NOT EXISTS(SELECT Ma_UserNhan FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan)))
				BEGIN
				DECLARE @So int
				SET @So = 1
				WHILE  (@So in (SELECT So FROM CongVan))
				SET @So = @So +1
					INSERT INTO CV_UserN_TT(So,So_CV,Ma_TT,Ma_User,Ma_UserNhan) VALUES (@So,@So_CV,6,@Ma_User,@Ma_UserNhan)
				END
		ELSE
			RAISERROR (N'Thêm không thành công-Đã tồn tại.',16,1)
GO
/****** Object:  StoredProcedure [dbo].[CongVan_Ma]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_Ma]
AS
SELECT top 1 Ma
from CongVan
order by ThoiGianSoan desc

GO
/****** Object:  StoredProcedure [dbo].[CongVan_Sua]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_Sua]
@Ma varchar(9),
@So int,
@Ma_LCV tinyint,
@TenCV nvarchar(100),
@TrichYeu nvarchar(500),
@TenFile nvarchar(100),
@NgayPH smalldatetime
--@YKienLD nvarchar(500),
--@YKienCV nvarchar(500)
AS
	IF(@Ma not in (SELECT Ma FROM CongVan WHERE So <> @So) AND (@TenCV not in(SELECT TenCV FROM CongVan WHERE So <> @So)) AND ((@TenFile not in(SELECT TenFile FROM CongVan WHERE So <> @So))))
		BEGIN
			UPDATE CongVan
			SET @Ma = @Ma,
				@Ma_LCV = @Ma_LCV,
				@TenCV = @TenCV,
				@TrichYeu = @TrichYeu,
				@TenFile = @TenFile,
				@NgayPH = @NgayPH
				--@YKienLD = @YKienLD,
				--@YKienCV = @YKienCV,
			WHERE So = @So
		END
	ELSE
				RAISERROR ('Sửa không thành công-Mã công văn hoặc tên công văn hoặc tên file đã tồn tại.',16,1)

GO
/****** Object:  StoredProcedure [dbo].[CongVan_Them]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_Them]
--@Ma varchar(9),
@Ma_LCV tinyint,
@TenCV nvarchar(100),
@TrichYeu nvarchar(500),
@TenFile nvarchar(100),
--@NgayPH smalldatetime,
@YKienLD nvarchar(500),
@YKienCV nvarchar(500)
AS	
		IF (@TenFile not in(SELECT TenFile FROM CongVan))
			BEGIN
				DECLARE @So varchar(9)
				DECLARE @ThoiGianSoan smalldatetime
				DECLARE @NamThangNgay nchar(6)
				SELECT @NamThangNgay =SUBSTRING (CONVERT(nvarchar,GETDATE(),103),9,2)
									  +SUBSTRING (CONVERT(nvarchar,GETDATE(),103),4,2)
									  +SUBSTRING (CONVERT(nvarchar,GETDATE(),103),1,2)
				SELECT So
				FROM CongVan
				WHERE So LIKE @NamThangNgay+'%'
				SET @So = @NamThangNgay+'001'
				WHILE (EXISTS(SELECT * FROM CongVan WHERE So = @So))
				SET @So = CONVERT(int,@So) + 1
				INSERT INTO CongVan(So,Ma_LCV,TenCV,TrichYeu,TenFile,YKienLD,YKienCV,ThoiGianSoan) VALUES(@So,@Ma_LCV,@TenCV,@TrichYeu,@TenFile,@YKienLD,@YKienCV,GETDATE())
			END
		ELSE 
				RAISERROR (N'Thêm không thành công - Tên file đã tồn tại.',16,1)
GO
/****** Object:  StoredProcedure [dbo].[CongVan_Theo_TinhTrang]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_Theo_TinhTrang]
@Ma tinyint -- mã tình trạng
AS
	SELECT CV.Ma, TrichYeu,TenUser AS NguoiGoi, ThoiGianGui, ThoiGianDoc, ThoiGianDuyet, ThoiGianSoan
	FROM TinhTrang TT, CongVan CV, CV_UserN_TT CUT, UserN U
	WHERE TT.Ma = @Ma AND TT.Ma = CUT.Ma_TT AND CUT.So_CV = CV.So AND CUT.Ma_User = U.Ma
	ORDER BY CV.So DESC

GO
/****** Object:  StoredProcedure [dbo].[CongVan_TrinhDuyet]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_TrinhDuyet]
@So_CV int,  --trong dự thảo
@Ma_UserNhan tinyint
AS
		BEGIN
		 DECLARE @ThoiGianGui smalldatetime
		 UPDATE CV_UserN_TT
		 SET Ma_TT = 2,
			 Ma_UserNhan = @Ma_UserNhan,
			 ThoiGianGui = GETDATE()
			WHERE So_CV = @So_CV
		END
GO
/****** Object:  StoredProcedure [dbo].[CongVan_Xoa]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CongVan_Xoa]
@So int
AS
			DELETE CongVan
			WHERE So = @So

GO
/****** Object:  StoredProcedure [dbo].[CV_U_TT_CT]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CV_U_TT_CT]
@So int
AS
		SELECT CV.Ma,CV.So, TenCV,TrichYeu, TenFile, NgayPH,YKienLD, YKienCV, TenTT,TenUser AS NguoiGoi, ThoiGianGui, ThoiGianDoc,ThoiGianDuyet,ThoiGianSoan,
	(SELECT TenUser FROM UserN, CV_UserN_TT CT WHERE UserN.Ma = CT.Ma_UserNhan AND CUT.So_CV = CT.So_CV AND CUT.Ma_TT = CT.Ma_TT AND CUT.Ma_User = CT.Ma_User AND CUT.Ma_UserNhan = CT.Ma_UserNhan) AS NguoiNhan
	FROM CongVan CV, TinhTrang TT, UserN U, CV_UserN_TT CUT
	WHERE CV.So = CUT.So_CV AND CUT.Ma_TT = TT.Ma AND CUT.Ma_User = U.Ma
	ORDER BY CV.So DESC

GO
/****** Object:  StoredProcedure [dbo].[CV_U_TT_DS]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CV_U_TT_DS]
AS
	SELECT CV.Ma,CV.So, TenCV,TrichYeu, TenFile, NgayPH,YKienLD, YKienCV, TenTT, TenUser AS NguoiGoi, ThoiGianGui, ThoiGianDoc,ThoiGianDuyet,ThoiGianSoan,
	(SELECT TenUser FROM UserN, CV_UserN_TT CT WHERE UserN.Ma = CT.Ma_UserNhan AND CUT.So_CV = CT.So_CV AND CUT.Ma_TT = CT.Ma_TT AND CUT.Ma_User = CT.Ma_User AND CUT.Ma_UserNhan = CT.Ma_UserNhan) AS NguoiNhan
	FROM CongVan CV, TinhTrang TT, UserN U, CV_UserN_TT CUT
	WHERE CV.So = CUT.So_CV AND CUT.Ma_TT = TT.Ma AND CUT.Ma_User = U.Ma
	ORDER BY CV.So

GO
/****** Object:  StoredProcedure [dbo].[CV_U_TT_Them]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CV_U_TT_Them]
@So_CV int,
@Ma_TT tinyint,
@Ma_User tinyint,
@Ma_UserNhan tinyint,
@ThoiGianGui smalldatetime
AS
		IF ((NOT EXISTS(SELECT So_CV FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_TT = @Ma_TT AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan )) 
			AND (NOT EXISTS(SELECT Ma_TT FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_TT = @Ma_TT AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan))
			AND (NOT EXISTS(SELECT Ma_User FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_TT = @Ma_TT AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan))
			AND (NOT EXISTS(SELECT Ma_UserNhan FROM CV_UserN_TT WHERE So_CV = @So_CV AND Ma_TT = @Ma_TT AND Ma_User = @Ma_User AND Ma_UserNhan = @Ma_UserNhan)))
				BEGIN
				DECLARE @So int
				SET @So = 1
				WHILE  (@So in (SELECT So FROM CongVan))
				SET @So = @So +1
					INSERT INTO CV_UserN_TT(So,So_CV,Ma_TT,Ma_User,Ma_UserNhan,ThoiGianGui) VALUES (@So,@So_CV,@Ma_TT,@Ma_User,@Ma_UserNhan,@ThoiGianGui)
				END
		ELSE
			RAISERROR (N'Thêm không thành công-Đã tồn tại.',16,1)

GO
/****** Object:  StoredProcedure [dbo].[CV_U_TT_Xoa]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CV_U_TT_Xoa]
@So int
AS
		DELETE CV_UserN_TT
		WHERE So = @So

GO
/****** Object:  StoredProcedure [dbo].[LoaiCV_CT]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LoaiCV_CT]
@Ma tinyint
AS
		BEGIN
			SELECT *
			FROM LoaiCV
			WHERE Ma = @Ma
		END

GO
/****** Object:  StoredProcedure [dbo].[LoaiCV_DS]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LoaiCV_DS]
AS
	SELECT Ma, TenLCV
	FROM LoaiCV
	ORDER BY Ma

GO
/****** Object:  StoredProcedure [dbo].[NhanVien_CT]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NhanVien_CT]
@Ma tinyint
AS
		BEGIN
			SELECT NV.Ma, Ho +' '+ TenNV AS HoTenNV, TenUser,AnhNV,DienThoai,NU.Ma, AnhNV
			FROM NhanVien NV, UserN U, NhomUser NU
			WHERE NV.Ma = U.Ma AND U.Ma = Ma_User
		END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_DS]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NhanVien_DS]
AS
	SELECT NV.Ma, Ho +' '+ TenNV AS HoTenNV, TenUser,AnhNV,DienThoai,NU.Ma, AnhNV
	FROM NhanVien NV, UserN U, NhomUser NU
	WHERE NV.Ma = U.Ma AND U.Ma = Ma_User
	ORDER BY NV.Ma
GO
/****** Object:  StoredProcedure [dbo].[NhomUser_CT]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NhomUser_CT]
@Ma tinyint
AS
		BEGIN
			SELECT *
			FROM NhomUser
			WHERE Ma = @Ma
		END

GO
/****** Object:  StoredProcedure [dbo].[NhomUser_DS]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NhomUser_DS]
AS
	SELECT Ma, TenNhom
	FROM NhomUser
	ORDER BY Ma
GO
/****** Object:  StoredProcedure [dbo].[TinhTrang_CT]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TinhTrang_CT]
@Ma tinyint
AS
		BEGIN
			SELECT *
			FROM TinhTrang
			WHERE Ma = @Ma
		END
GO
/****** Object:  StoredProcedure [dbo].[TinhTrang_DS]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TinhTrang_DS]
AS
	SELECT Ma, TenTT
	FROM TinhTrang
	ORDER BY Ma
GO
/****** Object:  StoredProcedure [dbo].[User_Nhom]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_Nhom]
(
	@Ma int
)
AS
BEGIN
SELECT NU.Ma
FROM NhomUser NU, UserN U
WHERE Ma_User = U.Ma AND U.Ma = @Ma
END
GO
/****** Object:  StoredProcedure [dbo].[UserN_DangNhap]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserN_DangNhap]
@TenUser nvarchar(100),
@MatKhau nvarchar(100)
AS
	IF (@TenUser in (SELECT TenUser FROM UserN WHERE PWDCOMPARE(@MatKhau,MatKhau) =1))
		BEGIN
			SELECT U.Ma, Ma_NV, TenUser, MatKhau, Ho, TenNV, NU.Ma AS MaNhom
			FROM UserN U,NhanVien NV, NhomUser NU
			WHERE PWDCOMPARE(@MatKhau,MatKhau) = 1 AND TenUser = @TenUser  AND NV.Ma = U.Ma_NV AND NU.Ma_User = U.Ma
		END
	ELSE
		RAISERROR (N'Email đăng nhập hoặc mật khẩu không hợp lệ.',16,1)

GO
/****** Object:  StoredProcedure [dbo].[UserN_DoiMatKhau]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserN_DoiMatKhau]
@TenUser nvarchar(100),
@MatKhauCu nvarchar(100),
@MatKhauMoi nvarchar(100),
@MatKhauXN nvarchar(100)
AS
	IF(@TenUser in(SELECT TenUser FROM UserN))
		BEGIN
			DECLARE @MatKhau nvarchar(100)
			SET @MatKhau = (SELECT MatKhau FROM UserN WHERE TenUser = @TenUser)
			IF(PWDCOMPARE(@MatKhauCu,@MatKhau)= 1)
				BEGIN 
					IF(@MatKhauMoi = @MatKhauXN)
						BEGIN 
							UPDATE UserN
							SET MatKhau = PWDENCRYPT(@MatKhauMoi)
							WHERE TenUser = @TenUser
						END
					ELSE
						RAISERROR (N'Mật khẩu mới và mật khẩu xác nhận mới không trùng nhau.',16,1)
				END
			ELSE
				RAISERROR (N'Sai mật khẩu.',16,1)
		END
	ELSE
		RAISERROR (N'Địa chỉ mail không hợp lệ.',16,1)

GO
/****** Object:  StoredProcedure [dbo].[UserN_DS]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROC [dbo].[UserN_DS]
AS
	SELECT Ma, TenUser
	FROM UserN
	ORDER BY Ma
GO
/****** Object:  StoredProcedure [dbo].[UserN_Quyen]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserN_Quyen]
(
	@Ma int
)
AS
BEGIN
SELECT CN.Ma, TenCN, Me, ThuTuc
FROM ChucNang CN, PhanQuyen PQ, UserN U
WHERE CN.Ma = Ma_CN AND Ma_User = @Ma AND Ma_User = U.Ma
END
GO
/****** Object:  StoredProcedure [dbo].[UserN_Sua]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserN_Sua]
@Ma tinyint,
@Ma_NV tinyint,
@TenUser nvarchar(100),
@IsUser bit
AS
	IF((@TenUser not in(SELECT TenUser FROM UserN WHERE Ma <> @Ma)))
		BEGIN
			UPDATE UserN
			SET Ma_NV = @Ma_NV,
				TenUser = @TenUser,
				IsUser = @IsUser
			WHERE Ma = @Ma 
		END
	ELSE
		RAISERROR (N'Sửa không thành công-Email đã tồn tại.',16,1)
GO
/****** Object:  StoredProcedure [dbo].[UserN_Them]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserN_Them]
@Ma_NV tinyint,
@TenUser nvarchar(100),
@IsUser bit
AS
	IF(@TenUser not in(SELECT TenUser FROM UserN))
		BEGIN
			DECLARE @Ma tinyint
			DECLARE @MatKhau nvarchar(100)
			SET @Ma = 1
			SET @MatKhau = @TenUser
			WHILE (@Ma in (SELECT Ma FROM UserN))
				SET @Ma = @Ma +1
			INSERT INTO UserN(Ma,Ma_NV,TenUser,MatKhau,IsUser)
			VALUES (@Ma,@Ma_NV,@TenUser,PWDENCRYPT (@MatKhau),@IsUser)
		END
	ELSE
			RAISERROR (N'Thêm không thành công-Email nhân viên đã tồn tại trong hệ thống.',16,1)
GO
/****** Object:  Table [dbo].[ChucNang]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChucNang](
	[Ma] [varchar](10) NOT NULL,
	[TenCN] [nvarchar](50) NOT NULL,
	[STT] [tinyint] NOT NULL,
	[Me] [varchar](10) NOT NULL,
	[ThuTuc] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TenCN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CongVan]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CongVan](
	[Ma] [varchar](9) NULL,
	[So] [varchar](9) NOT NULL,
	[Ma_LCV] [tinyint] NOT NULL,
	[TenCV] [nvarchar](100) NULL,
	[TrichYeu] [nvarchar](500) NULL,
	[TenFile] [nvarchar](100) NULL,
	[NgayPH] [smalldatetime] NULL,
	[YKienLD] [nvarchar](500) NULL,
	[YKienCV] [nvarchar](500) NULL,
	[ThoiGianSoan] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[So] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CV_UserN_TT]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CV_UserN_TT](
	[So] [int] NOT NULL,
	[So_CV] [varchar](9) NOT NULL,
	[Ma_TT] [tinyint] NOT NULL,
	[Ma_User] [tinyint] NOT NULL,
	[Ma_UserNhan] [tinyint] NULL,
	[ThoiGianGui] [smalldatetime] NULL,
	[ThoiGianDoc] [smalldatetime] NULL,
	[ThoiGianDuyet] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[So] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiCV]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiCV](
	[Ma] [tinyint] NOT NULL,
	[TenLCV] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TenLCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[Ma] [tinyint] NOT NULL,
	[Ma_PB] [tinyint] NOT NULL,
	[Ho] [nvarchar](50) NOT NULL,
	[TenNV] [nvarchar](15) NOT NULL,
	[NgaySinh] [smalldatetime] NOT NULL,
	[GioiTinh] [bit] NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[DienThoai] [nvarchar](12) NOT NULL,
	[AnhNV] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhomUser]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomUser](
	[Ma] [tinyint] NOT NULL,
	[TenNhom] [nvarchar](20) NOT NULL,
	[Ma_User] [tinyint] NOT NULL,
 CONSTRAINT [PK_NhomUser] PRIMARY KEY CLUSTERED 
(
	[Ma] ASC,
	[Ma_User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhanQuyen]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhanQuyen](
	[Ma_CN] [varchar](10) NOT NULL,
	[Ma_User] [tinyint] NOT NULL,
 CONSTRAINT [PK_PhanQuyen] PRIMARY KEY CLUSTERED 
(
	[Ma_CN] ASC,
	[Ma_User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhongBan]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongBan](
	[Ma] [tinyint] NOT NULL,
	[TenPB] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TenPB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhTrang]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTrang](
	[Ma] [tinyint] NOT NULL,
	[TenTT] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TenTT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserN]    Script Date: 29/12/2013 3:17:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserN](
	[Ma] [tinyint] NOT NULL,
	[Ma_NV] [tinyint] NOT NULL,
	[TenUser] [nvarchar](100) NOT NULL,
	[MatKhau] [nvarchar](100) NOT NULL,
	[IsUser] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CongVan]  WITH CHECK ADD FOREIGN KEY([Ma_LCV])
REFERENCES [dbo].[LoaiCV] ([Ma])
GO
ALTER TABLE [dbo].[CV_UserN_TT]  WITH CHECK ADD FOREIGN KEY([Ma_TT])
REFERENCES [dbo].[TinhTrang] ([Ma])
GO
ALTER TABLE [dbo].[CV_UserN_TT]  WITH CHECK ADD FOREIGN KEY([Ma_User])
REFERENCES [dbo].[UserN] ([Ma])
GO
ALTER TABLE [dbo].[CV_UserN_TT]  WITH CHECK ADD FOREIGN KEY([So_CV])
REFERENCES [dbo].[CongVan] ([So])
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([Ma_PB])
REFERENCES [dbo].[PhongBan] ([Ma])
GO
ALTER TABLE [dbo].[NhomUser]  WITH CHECK ADD FOREIGN KEY([Ma_User])
REFERENCES [dbo].[UserN] ([Ma])
GO
ALTER TABLE [dbo].[PhanQuyen]  WITH CHECK ADD FOREIGN KEY([Ma_CN])
REFERENCES [dbo].[ChucNang] ([Ma])
GO
ALTER TABLE [dbo].[PhanQuyen]  WITH CHECK ADD FOREIGN KEY([Ma_User])
REFERENCES [dbo].[UserN] ([Ma])
GO
ALTER TABLE [dbo].[UserN]  WITH CHECK ADD FOREIGN KEY([Ma_NV])
REFERENCES [dbo].[NhanVien] ([Ma])
GO
USE [master]
GO
ALTER DATABASE [QuanLyCongVan] SET  READ_WRITE 
GO
