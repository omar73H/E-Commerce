 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="GUC_Commerce_GUI.MyProfile" %>
 
<!DOCTYPE httml>
 
<html xmlns="http://w...content-available-to-author-only...3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server" href="CustomerHomePage.aspx">Homepage</asp:HyperLink>
            <br />
             Add Mobile number:
            <br />
            <br />
            <asp:TextBox ID="txt_mobilenum" runat="server"></asp:TextBox>
            <br />
        <asp:Button ID="btn_login" runat="server" Text="AddMobNum" onclick="addMobile" Width="90px"/>
 
        </div>
    </div>
        <br />
        <div>
            Create a wishlist:
            <br />
            <br />
            <asp:TextBox ID="txt_wishlistname" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="createwl" runat="server" OnClick="createWishlist" Text="Create" />
        </div>
        <br />
        <div>
            Add Credit Card:
            <br />
            <asp:Label ID="lbl_ccnumber" runat="server" Text="Enter credit card number"></asp:Label>
            <br />
            <asp:TextBox ID="ccnumber" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="lbl_dateform" runat="server" Text="Enter date <br />format should be YYYY-MM-DD "></asp:Label>
            <br />
            <asp:TextBox ID="ccexpirydate" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="lbl_cvv" runat="server" Text="Enter cvv number"></asp:Label>
 
            <br />
            <asp:TextBox ID="cvv" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="addCC" runat="server" OnClick="addCC1" Text="Add Credit Card" />
        </div>
        <br />
        <asp:HyperLink ID="viemMyCart" runat="server" href="MyCart.aspx">View my cart</asp:HyperLink>
        <br />
        <asp:HyperLink ID="viewMyWishlist" runat="server" href="MyWishlist.aspx">View my wishlists</asp:HyperLink>
 
        <div>
 
 
        </div>
    </form>
</body>
</html>