﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace QLCV.Account
{
    public class CongVan
    {
        public string Ma;
        public int So;
        public string Ten;
        public string TrichYeu;
        public string TenFile;
        public string NgayPH;
        public string YKienLD;
        public string YKienCV;
        public int Ma_LCV;
        public string ThongBao;
        public void Them()
        {
            try
            {
                SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
                SqlCommand Lenh = new SqlCommand("CongVan_Them", BaoVe);
                Lenh.CommandType = CommandType.StoredProcedure;
                SqlParameter ThamSo = new SqlParameter();
                ThamSo = Lenh.Parameters.AddWithValue("@Ma_LCV", Ma_LCV);
                ThamSo = Lenh.Parameters.AddWithValue("@Ten", Ten);
                ThamSo = Lenh.Parameters.AddWithValue("@TrichYeu", TrichYeu);
                ThamSo = Lenh.Parameters.AddWithValue("@TenFile", TenFile);
                ThamSo = Lenh.Parameters.AddWithValue("@NgayPH", NgayPH);
                ThamSo = Lenh.Parameters.AddWithValue("@YKienLD", YKienLD);
                ThamSo = Lenh.Parameters.AddWithValue("@YKienCV", YKienCV);
                BaoVe.Open();
                Lenh.ExecuteNonQuery();
                BaoVe.Close();
                ThongBao = "THÊM THÀNH CÔNG!.";
            }
            catch (Exception ex)
            {
                ThongBao = ex.Message;
            }
        }
        public void Xoa()
        {
            try
            {
                SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
                SqlCommand Lenh = new SqlCommand("CongVan_Xoa", BaoVe);
                Lenh.CommandType = CommandType.StoredProcedure;
                SqlParameter ThamSo = new SqlParameter();
                ThamSo = Lenh.Parameters.AddWithValue("@So", So);
                BaoVe.Open();
                Lenh.ExecuteNonQuery();
                BaoVe.Close();
                ThongBao = "XÓA THÀNH CÔNG!.";
            }
            catch (Exception ex)
            {
                ThongBao = ex.Message;
            }
        }
        public void Sua()
        {
            try
            {
                SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
                SqlCommand Lenh = new SqlCommand("CongVan_Sua", BaoVe);
                Lenh.CommandType = CommandType.StoredProcedure;
                SqlParameter ThamSo = new SqlParameter();
                ThamSo = Lenh.Parameters.AddWithValue("@Ma", Ma);
                ThamSo = Lenh.Parameters.AddWithValue("@So", So);
                ThamSo = Lenh.Parameters.AddWithValue("@Ma_LCV", Ma_LCV);
                ThamSo = Lenh.Parameters.AddWithValue("@Ten", Ten);
                ThamSo = Lenh.Parameters.AddWithValue("@TrichYeu", TrichYeu);
                ThamSo = Lenh.Parameters.AddWithValue("@TenFile", TenFile);
                ThamSo = Lenh.Parameters.AddWithValue("@NgayPH", NgayPH);
                BaoVe.Open();
                Lenh.ExecuteNonQuery();
                BaoVe.Close();
                ThongBao = "S?A THÀNH CÔNG!.";
            }
            catch (Exception ex)
            {
                ThongBao = ex.Message;
            }
        }
        public void CT()
        {
            SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
            SqlCommand Lenh = new SqlCommand("CongVan_CT", BaoVe);
            Lenh.CommandType = CommandType.StoredProcedure;
            SqlParameter ThamSo = new SqlParameter();
            ThamSo = Lenh.Parameters.AddWithValue("@So", So);
            SqlDataReader DocDL;
            BaoVe.Open();
            DocDL = Lenh.ExecuteReader();
            if (DocDL.Read() == true)
            {
                Ma = DocDL["Ma"].ToString();
                So = int.Parse(DocDL["So"].ToString());
                Ma_LCV = int.Parse(DocDL["Ma_LCV"].ToString());
                Ten = DocDL["Ten"].ToString();
                TrichYeu = DocDL["NgayDang"].ToString();
                TenFile = DocDL["AnhMH"].ToString();
                NgayPH = DocDL["NoiBat"].ToString();
                YKienLD = DocDL["NgayDuyet"].ToString();
                YKienCV = DocDL["KQDuyet"].ToString();
                //MaNT = int.Parse(DocDL["MaNT"].ToString());
                //MaNVDang = int.Parse(DocDL["MaNVDang"].ToString());
                //MaNVDuyet = int.Parse(DocDL["MaNVDuyet"].ToString());
            }
            BaoVe.Close();
        }
        public DataTable DS()
        {
            SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
            SqlDataAdapter XeTai = new SqlDataAdapter("CongVan_DS", BaoVe);
            DataTable ThungChua = new DataTable();
            BaoVe.Open();
            XeTai.Fill(ThungChua);
            BaoVe.Close();
            return ThungChua;
        }
    }
    public class UserN
    {
        public int Ma;
        public int Ma_NV;
        public string Ten;
        public string MatKhau;
        public string MatKhauCu;
        public string MatKhauMoi;
        public string MatKhauXN;
        public bool IsUser;
        public string ThongBao;
        public int MaNU;
        public int KetQua;
        public bool DangNhap()
        {
            try
            {
                SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
                SqlCommand Lenh = new SqlCommand("USER_DangNhap", BaoVe);
                Lenh.CommandType = CommandType.StoredProcedure;
                SqlParameter ThamSo = new SqlParameter();
                ThamSo = Lenh.Parameters.AddWithValue("@Ten", Ten);
                ThamSo = Lenh.Parameters.AddWithValue("@MatKhau", MatKhau);
                SqlDataReader DocDL;
                BaoVe.Open();
                DocDL = Lenh.ExecuteReader();
                if (DocDL.Read() == true)
                {
                    Ma = int.Parse(DocDL["Ma"].ToString());
                    Ma_NV = int.Parse(DocDL["Ma_NV"].ToString());
                    Ten = DocDL["Ten"].ToString();
                    MatKhau = DocDL["MatKhau"].ToString();
                    //MaPB = int.Parse(DocDL["MaPB"].ToString());
                    //TenPB = DocDL["TenPB"].ToString();
                    BaoVe.Close();
                    return true;
                }
                else
                {
                    BaoVe.Close();
                    return false;
                }
            }
            catch (Exception ex)
            {
                ThongBao = ex.Message;
                return false;
            }
        }
        public void DoiMatKhau()
        {
            try
            {
                SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
                SqlCommand Lenh = new SqlCommand("USER_DoiMatKhau", BaoVe);
                Lenh.CommandType = CommandType.StoredProcedure;
                SqlParameter ThamSo = new SqlParameter();
                ThamSo = Lenh.Parameters.AddWithValue("@Email", Ten);
                ThamSo = Lenh.Parameters.AddWithValue("@MatKhauCu", MatKhauCu);
                ThamSo = Lenh.Parameters.AddWithValue("@MatKhauMoi", MatKhauMoi);
                ThamSo = Lenh.Parameters.AddWithValue("@MatKhauXN", MatKhauXN);
                BaoVe.Open();
                Lenh.ExecuteNonQuery();
                BaoVe.Close();
                ThongBao = "Đ?I THÀNH CÔNG!.";
            }
            catch (Exception ex)
            {
                ThongBao = ex.Message;
            }
        }
    }
    public class CV_User_TT
    {
        public int So;
        public string Ma_CV;
        public int Ma_TT;
        public string TenTT;
        public int So_CV;
        public int Ma_User;
        public int Ma_UserNhan;
        public string TenUser;
        public string Ten;
        public string TrichYeu;
        public string TenFile;
        public string NgayPH;
        public string YKienLD;
        public string YKienCV;
        public string ThoiGianGui;
        public string ThoiGianNhan;
        public string ThongBao;
        public void Them()
        {
            try
            {
                SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
                SqlCommand Lenh = new SqlCommand("CV_U_TT_Them", BaoVe);
                Lenh.CommandType = CommandType.StoredProcedure;
                SqlParameter ThamSo = new SqlParameter();
                ThamSo = Lenh.Parameters.AddWithValue("@So_CV", So_CV);
                ThamSo = Lenh.Parameters.AddWithValue("@Ma_TT", Ma_TT);
                ThamSo = Lenh.Parameters.AddWithValue("@Ma_User", Ma_User);
                ThamSo = Lenh.Parameters.AddWithValue("@Ma_UserNhan", Ma_UserNhan);
                ThamSo = Lenh.Parameters.AddWithValue("@ThoiGianNhan", ThoiGianNhan);
                ThamSo = Lenh.Parameters.AddWithValue("@ThoiGianGui", ThoiGianGui);
                BaoVe.Open();
                Lenh.ExecuteNonQuery();
                BaoVe.Close();
                ThongBao = "THÊM THÀNH CÔNG!.";
            }
            catch (Exception ex)
            {
                ThongBao = ex.Message;
            }
        }
        public void Xoa()
        {
            try
            {
                SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
                SqlCommand Lenh = new SqlCommand("CV_U_TT_Xoa", BaoVe);
                Lenh.CommandType = CommandType.StoredProcedure;
                SqlParameter ThamSo = new SqlParameter();
                ThamSo = Lenh.Parameters.AddWithValue("@So", So);
                BaoVe.Open();
                Lenh.ExecuteNonQuery();
                BaoVe.Close();
                ThongBao = "XÓA THÀNH CÔNG!.";
            }
            catch (Exception ex)
            {
                ThongBao = ex.Message;
            }
        }
        public void CT()
        {
            SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
            SqlCommand Lenh = new SqlCommand("CV_U_TT_CT", BaoVe);
            Lenh.CommandType = CommandType.StoredProcedure;
            SqlParameter ThamSo = new SqlParameter();
            ThamSo = Lenh.Parameters.AddWithValue("@So", So);
            SqlDataReader DocDL;
            BaoVe.Open();
            DocDL = Lenh.ExecuteReader();
            if (DocDL.Read() == true)
            {
                Ma_CV = DocDL["Ma_CV"].ToString();
                So = int.Parse(DocDL["So"].ToString());
                So_CV = int.Parse(DocDL["So_CV"].ToString());
                Ten = DocDL["Ten"].ToString();
                TenTT = DocDL["TenTT"].ToString();
                TenUser = DocDL["TenUser"].ToString();
                Ma_User = int.Parse(DocDL["Ma_User"].ToString());
                Ma_UserNhan = int.Parse(DocDL["Ma_UserNhan"].ToString());
                TrichYeu = DocDL["TrichYeu"].ToString();
                TenFile = DocDL["TenFile"].ToString();
                NgayPH = DocDL["NgayPH"].ToString();
                YKienLD = DocDL["YKienLD"].ToString();
                YKienCV = DocDL["YKienCV"].ToString();
                ThoiGianGui = DocDL["ThoiGianGui"].ToString();
                ThoiGianNhan = DocDL["ThoiGianNhan"].ToString();
            }
            BaoVe.Close();
        }
        public DataTable DS()
        {
            SqlConnection BaoVe = new SqlConnection("server=(local)\\SQLExpress;uid=sa;pwd=123;database=QLCV");
            SqlDataAdapter XeTai = new SqlDataAdapter("CongVan_DS", BaoVe);
            DataTable ThungChua = new DataTable();
            BaoVe.Open();
            XeTai.Fill(ThungChua);
            BaoVe.Close();
            return ThungChua;
        }
    }
}