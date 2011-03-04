<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Deleted</h2>

    <p>The "<%=ViewData["DeletedProject"] %>" project has been deleted.</p>
</asp:Content>
