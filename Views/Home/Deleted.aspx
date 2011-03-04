<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Post Deleted</h2>

    <p>"<%= ViewData["DeletedTitle"] %>" has been deleted.</p>
</asp:Content>

