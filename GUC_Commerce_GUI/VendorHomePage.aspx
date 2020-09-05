<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorHomePage.aspx.cs" Inherits="GUC_Commerce_GUI.VendorHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            WELCOME
            <br />
            <br />
            <asp:HyperLink ID="postProduct" runat="server" href="VendorProfile.aspx">My Profile</asp:HyperLink>
            <br />
            <br />
            <asp:Button ID="btn_logout" runat="server" Text="LogOut" OnClick="btn_logout_Click" />
        </div>
    </form>
</body>
</html>
