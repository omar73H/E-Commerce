<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HomeLogin.aspx.cs" Inherits="GUC_Commerce_GUI.HomeLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    

        <asp:Label ID="lbl_username" runat="server" Text="Username: "></asp:Label>
    
        <asp:TextBox ID="txt_username" runat="server"></asp:TextBox>
    
        <br />
    
        <br />
        <asp:Label ID="lbl_password" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="txt_password" runat="server" TextMode="Password"></asp:TextBox>
    
        <br />
    
        <br />
        <asp:Button ID="btn_login" runat="server" Text="Login" onclick="login" Width="90px"/>
    
    </div>
        <asp:HyperLink ID="renderCustomerReg" runat="server" href="customerRegister.aspx">Register as a customer</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="renderVendorReg" runat="server" href="vendorRegister.aspx">Register as a vendor</asp:HyperLink>
    </form>
</body>
</html>
