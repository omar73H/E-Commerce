<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomerHomePage.aspx.cs" Inherits="GUC_Commerce_GUI.CustomerHomePage" %>

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
                   <asp:HyperLink ID="viewProducts" runat="server" href="ourProducts.aspx">View available Products ordered by their price ascendingly</asp:HyperLink>
            <br />
            <br />
                
            <asp:HyperLink ID="MyProfile" runat="server" href="MyProfile.aspx">My Profile</asp:HyperLink>
                <br />
            <br />
                     
            Make Order:
            <br />
        <asp:Button ID="btn_login" runat="server" Text="OrderNow" onclick="makeOrder" Width="90px"/>
          <br />
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" href="OrderPayment.aspx">Payment</asp:HyperLink>
                <br />
            <br />
               Cancel Order:
            <br />
        <asp:Button ID="Button1" runat="server" Text="Cancel Order " onclick="CancelOrder" Width="120px"/>
            <br />
            <br />
            <br />
            <asp:Button ID="logout" runat="server" Text="LogOut" OnClick="logout_Click" />
          <br />
         
         
        </div>
    </form>
</body>
</html>
