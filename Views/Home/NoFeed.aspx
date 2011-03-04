<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Feed Not Supported</h2>
    <p><%=ViewData["Feed"] %> feeds are not supported at this time.</p>
</asp:Content>
