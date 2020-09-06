<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderPayment.aspx.cs" Inherits="GUC_Commerce_GUI.OrderPayment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
               <asp:HyperLink ID="HyperLink2" runat="server" href="CustomerHomePage.aspx">Homepage</asp:HyperLink>
   
                               <br />
                   <br />
            <br />
                
         
                       <asp:Label ID="lbl_password" runat="server" Text="Enter cash amount: "></asp:Label>
    
        <asp:TextBox ID="txt_cash" runat="server"></asp:TextBox>
    
            <br />
            <br />              
                <asp:Button ID="btn_login" runat="server" Text="PayCash" onclick="Cash" Width="150px"/>
    
    <br />
           
            <br />
            
            <asp:Label ID="Label2" runat="server" Text="Enter Credit card number: "></asp:Label>
    
        <asp:TextBox ID="CVV" runat="server"></asp:TextBox>
    
    <br />
            <asp:Label ID="Label1" runat="server" Text="Enter Amount to pay: "></asp:Label>
    
        <asp:TextBox ID="txt_credit" runat="server"></asp:TextBox>
    <br />
          
     <asp:Button ID="Button1" runat="server" Text="PayCredit" onclick="Credit" Width="150px"/>
           
    
    
     <br />
            <br />              
           
        </div>
    </form>
</body>
</html>
