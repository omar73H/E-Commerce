<%@ Page Language="C#" AutoEventWireup="true" CodeFile="customerRegister.aspx.cs" Inherits="GUC_Commerce_GUI.customerRegister" %>


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
        <asp:Label ID="lbl_firstname" runat="server" Text="First name: "></asp:Label>
    
        <asp:TextBox ID="txt_firstname" runat="server"></asp:TextBox>

        <br />
    
        <br />
    
        <asp:Label ID="lbl_lastname" runat="server" Text="Last name: "></asp:Label>
    
        <asp:TextBox ID="txt_lastname" runat="server"></asp:TextBox>

        <br />
    
        <br />


        <asp:Label ID="lbl_password" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="txt_password" runat="server" TextMode="Password"></asp:TextBox>
    
        <br />
    
        <br />

        <asp:Label ID="lbl_email" runat="server" Text="Email: "></asp:Label>
    
        <asp:TextBox ID="txt_email" runat="server"></asp:TextBox>

        <br />
    
        <br />


        <asp:Button ID="btn_Register" runat="server" Text="Register as Customer" onclick="register" Width="180px"/>
    
    </div>
    </form>
</body>
</html>
