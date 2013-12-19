﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login1.aspx.cs" Inherits="QLCV.Account.Login1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="../Styles/style_Login.css" rel="stylesheet" />
    <title>Trang Đăng Nhập</title>
</head>
<body>
    <section class="container">
        <div class="login">
            <h1>Đăng Nhập Ứng Dụng Quản Lý</h1>
            <form id="form1" runat="server">
                <p><asp:TextBox ID="txtTenUser" runat="server" placeholder="UserName hoặc Email"></asp:TextBox></p>
                <p><asp:TextBox ID="txtMatKhau" runat="server" placeholder="Password"></asp:TextBox></p>
                    <p class="remember_me">
                        <label>
                            <input type="checkbox" name="remember_me" id="remember_me">
                            Remember me on this computer
                        </label>
                    </p>
                    <p class="submit"><asp:Button ID="Button1" runat="server" Text="Đăng Nhập" OnClick="btnDangNhap_Click" /></p>
                <asp:Label ID="lblThongTin" runat="server" Text=""></asp:Label>
            </form>
        </div>
    </section>
</body>
</html>
