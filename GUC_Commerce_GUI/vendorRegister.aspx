<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vendorRegister.aspx.cs" Inherits="GUC_Commerce_GUI.vendorRegister" %>


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

        <asp:Label ID="lbl_company_name" runat="server" Text="Company Name: "></asp:Label>
    
        <asp:TextBox ID="txt_company_name" runat="server"></asp:TextBox>

        <br />
    
        <br />

        <asp:Label ID="lbl_bank_acc_no" runat="server" Text="Bank account number: "></asp:Label>
    
        <asp:TextBox ID="txt_bank_acc_no" runat="server"></asp:TextBox>

        <br />
    
        <br />



        <asp:Button ID="btn_Register" runat="server" Text="Register as Vendor" onclick="register" Width="180px"/>
    
    </div>
    </form>
</body>
</html>
