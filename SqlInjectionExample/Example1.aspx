<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Example1.aspx.cs" Inherits="SqlInjectionExample.Default" %>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <br />
    <div class="form-group">
        <label>Username:</label>
        <asp:TextBox CssClass="form-control" ID="txtUsername" runat="server" />
        <label>Password:</label>
		<asp:TextBox CssClass="form-control" ID="txtPassword" runat="server" />
        <p><asp:Button CssClass="btn btn-default"  ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Run Query" /></p>
    </div>
    <div class="row">
        <br />
        <asp:Label ID="lblQuery" runat="server" />
        <hr />
        <asp:Label ID="lblOutput" runat="server" />
    </div>
</asp:Content>
