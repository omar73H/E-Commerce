<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RemoveExpiredOffer.aspx.cs" Inherits="RemoveExpiredOffer" %>

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
            <asp:Label ID="lbl_removeEx" runat="server" Text="Enter the ID of the Expired Offer"></asp:Label>
            <br/>
            <br/>
            <asp:TextBox ID="txt_offerID" runat="server"></asp:TextBox>
            <br/>
            <br/>
            <asp:Button ID="btn_removeEx" runat="server" Text="Remove" OnClick="btn_removeEx_Click" />

        </div>
        
    </form>
</body>
</html>
