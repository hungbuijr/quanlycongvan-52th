﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SoanCV : System.Web.UI.Page
{
    lanhnt.LoaiCV lcv = new lanhnt.LoaiCV();
    lanhnt.TinhTrang tt = new lanhnt.TinhTrang();
    lanhnt.CongVan cv = new lanhnt.CongVan();
    lanhnt.CV_User_TT cut = new lanhnt.CV_User_TT();
    lanhnt.UserN u = new lanhnt.UserN();
    lanhnt.WebMsgBox msg = new lanhnt.WebMsgBox();
    public static int SoLuongDaChon;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            droLCV.DataSource = lcv.DS();
            droLCV.DataBind();
           //lblTB1.Text = cv.LayMa().ToString();
            txtMaCV.ReadOnly = true;
            txtSoCV.ReadOnly = true;
            txtNgayPH.ReadOnly = true;
            cblUser.DataSource = u.LanhDao_DS();
            cblUser.DataBind();
        }
    }
    protected void btnTrinhDuyet_Click(object sender, EventArgs e)
    {
        bool bTenCV = string.IsNullOrWhiteSpace(txtTenCV.Text);
        bool bTrichYeu = string.IsNullOrWhiteSpace(txtTomTat.Text);
        bool bYKienCV = string.IsNullOrWhiteSpace(txtGopY.Text);
        bool bYKienLD = string.IsNullOrWhiteSpace(txtChiDao.Text);
        if (bTenCV == false && bTrichYeu == false && fileTep.HasFile == true)
        {
            cv.TenCV = txtTenCV.Text; 
            cv.TrichYeu = txtTomTat.Text;
            if (bYKienCV == true)
                cv.YKienCV = " ";
            else
                cv.YKienCV = txtGopY.Text;
            if (bYKienLD == true)
                cv.YKienLD = " ";
            else
                cv.YKienLD = txtChiDao.Text;
            //cv.Ma = txtMaCV.Text;
            //cv.So = int.Parse(txtSoCV.Text);
            cv.Ma_LCV = int.Parse(droLCV.SelectedValue);
            string DuongDan = "";
            DuongDan = Server.MapPath("~/src/products/");
            DuongDan = DuongDan + fileTep.FileName;
            fileTep.SaveAs(DuongDan);
            cv.TenFile = fileTep.FileName;
            cut.Ma_User = int.Parse(Session["Ma"].ToString());
            //cut.Ma_UserNhan = int.Parse(droUserN.SelectedValue);
            cv.Them();
            cut.So_CV = cv.LayMa().ToString();
            for (int i = 0; i <= cblUser.Items.Count - 1; i++)
            {
                if (cblUser.Items[i].Selected == true)
                {
                    cut.Ma_UserNhan = Convert.ToInt32(cblUser.Items[i].Value);
                    cut.TrinhDuyet();
                }
            }
            msg.ShowAndRedirect(cut.ThongBao);
            txtTenCV.Text = "";
            txtTomTat.Text = "";
            txtGopY.Text = "";
            txtMaCV.Text = "";
            txtSoCV.Text = "";
            // droLCV.Text = "";
            txtNgayPH.Text = "";
            //Redirect("~/Default.aspx");
        }
        else
            lblTB.Text = "Bạn chưa nhập đầy đủ thông tin bắt buộc";
    }
    protected void btnThoat_Click(object sender, EventArgs e)
    {
        bool bTenCV = string.IsNullOrWhiteSpace(txtTenCV.Text);
        bool bTrichYeu = string.IsNullOrWhiteSpace(txtTomTat.Text);
        bool bYKienCV = string.IsNullOrWhiteSpace(txtGopY.Text);
        bool bYKienLD = string.IsNullOrWhiteSpace(txtChiDao.Text);
        if (bTenCV == true && bTrichYeu == true && bYKienCV == true && bYKienLD == true && fileTep.HasFile == false)
            Response.Redirect("~/Default.aspx");
        else
        {
            cv.TenCV = txtTenCV.Text;
            if (bTrichYeu == true)
                cv.TrichYeu = " ";
            else
                cv.TrichYeu = txtTomTat.Text;
            if (bYKienCV == true)
                cv.YKienCV = " ";
            else
                cv.YKienCV = txtGopY.Text;
            if (bYKienLD == true)
                cv.YKienLD = " ";
            else
                cv.YKienLD = txtChiDao.Text;
            //cv.Ma = txtMaCV.Text;
            //cv.So = int.Parse(txtSoCV.Text);
            cv.Ma_LCV = int.Parse(droLCV.SelectedValue);
            string DuongDan = "";
            DuongDan = Server.MapPath("~/src/products/");
            DuongDan = DuongDan + fileTep.FileName;
            fileTep.SaveAs(DuongDan);
            cv.TenFile = fileTep.FileName;
            cut.Ma_User = int.Parse(Session["Ma"].ToString());
            //cut.Ma_UserNhan = int.Parse(droUserN.SelectedValue);
            cv.Them();
            cut.So_CV = cv.LayMa().ToString();
            for (int i = 0; i <= cblUser.Items.Count - 1; i++)
            {
                if (cblUser.Items[i].Selected == true)
                {
                    cut.Ma_UserNhan = Convert.ToInt32(cblUser.Items[i].Value);
                    cut.DuThao();
                }
            }
            
            lblTB.Text = cv.ThongBao;
            lblTB1.Text = cut.ThongBao;
            txtTenCV.Text = "";
            txtTomTat.Text = "";
            txtGopY.Text = "";
            txtMaCV.Text = "";
            txtSoCV.Text = "";
            // droLCV.Text = "";
            txtNgayPH.Text = "";
            //fileTep. = "";
            // Response.Redirect("~/Default.aspx");
        }
    }
    protected void btnXongNguoiNhan_Click(object sender, EventArgs e)
    {
        txtNguoiNhan.Text = "Đã chọn:" + "\r\n";
        for(int i=0; i<=cblUser.Items.Count - 1; i++)
        {
            if(cblUser.Items[i].Selected == true)
            {
                txtNguoiNhan.Text += cblUser.Items[i].Text.ToString() + "\r\n";
                txtNguoiNhan.Visible = true;
                SoLuongDaChon += 1;
                lbl.Text += cblUser.Items[i].Selected;
            }
        }
    }
}
  