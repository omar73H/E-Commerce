<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostProduct.aspx.cs" Inherits="PostProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
               <asp:HyperLink ID="HyperLink2" runat="server" href="VendorHomePage.aspx">Homepage</asp:HyperLink>
   
                   <br />
            <br />
                
         
            <asp:Label ID="pname" runat="server" Text="Product name"></asp:Label>
            <br />
            <asp:TextBox ID="pnameText" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="category" runat="server" Text="Category"></asp:Label>
            <br />
            <asp:TextBox ID="categoryText" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="pDesc" runat="server" Text="Product Description"></asp:Label>
            <br />
            <asp:TextBox ID="pDescText" runat="server" Height="91px" Width="929px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="price" runat="server" Text="Price"></asp:Label>
            <br />
            <asp:TextBox ID="priceText" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="color" runat="server" Text="Color"></asp:Label>
            <br />
            <asp:TextBox ID="colorText" runat="server"></asp:TextBox>
            <br />
            <br />
               <asp:Button ID="postProductButton" runat="server" Text="Post Product" OnClick="postProductButton_Click" />
            <br />
        </div>
    </form>
</body>
</html>
