<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddOffer.aspx.cs" Inherits="AddOffer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="hp" runat="server" href="VendorHomePage.aspx">Homepage</asp:HyperLink>
            <br/>
            <br/>
            <asp:Label ID="lbl_amount" runat="server" Text="Enter the amount of the Offer you wish to add"></asp:Label>
            <br/>
            <br/>
            <asp:TextBox ID="txt_amount" runat="server"></asp:TextBox>
            <br/>
            <br/>
            <asp:Label ID="lbl_ex_date" runat="server" Text="Enter the expiry date"></asp:Label>
            <br/>
            <asp:Label ID="lbl_format" runat="server" Text="format 'YYYY-MM-DD'"></asp:Label>
            <br/>
            <asp:TextBox ID="txt_ex_date" runat="server"></asp:TextBox>
            <br/>
            <br/>
            <asp:Button ID="btn_addOffer" runat="server" Text="Add Offer" OnClick="btn_addOffer_Click" />
            
        </div>
    </form>
</body>
</html>
