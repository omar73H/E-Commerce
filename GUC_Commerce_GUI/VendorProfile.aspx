<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorProfile.aspx.cs" Inherits="VendorProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <!-- div1 -->
        <div>
            <asp:HyperLink ID="vhp" runat="server" href="VendorHomePage.aspx">Homepage</asp:HyperLink>
   
            <br />
            <br />
            Add Mobile number:
            <br />
            <br />
            <asp:TextBox ID="txt_mobilenum" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="btn_login" runat="server" Text="AddMobNum" onclick="addMobile" Width="128px"/>
            <br />
            <br />
         
            <asp:HyperLink ID="PostProduct" runat="server" href="PostProduct.aspx">Post Product</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="viewProduct" runat="server" href="ViewMyProducts.aspx">View and Edit My Products </asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="addOffer" runat="server" href="AddOffer.aspx">Create Offer</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="applyoffer" runat="server" href="ApplyOffer.aspx">Apply offers to My Products </asp:HyperLink>
            <br />
            <br />
             <asp:HyperLink ID="removeExpired" runat="server" href="RemoveExpiredOffer.aspx">Remove Expired Offer</asp:HyperLink>
            <br />
            <br />
            <asp:HyperLink ID="viewOff" runat="server" href="viewOffers.aspx">View Offers</asp:HyperLink>
        </div>
    </form>
    <p style="direction: ltr">
        &nbsp;</p>
</body>
</html>
