<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<striderMVC.Models.Post>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% if(ViewData["Search"] != null) { %>
        <h2>search results for '<%= ViewData["Search"] %>':</h2>
    <% } %>
    
    <% if(Model.Count() == 0) { %>
        <h2>No Posts Found</h2>
        <%if(ViewData["Slug"] == null) { %>
            <p>Ain't nothin here!</p>
        <% } else { %>
            <p>"<%= ViewData["Slug"] %>"? Never heard of it!</p>
        <% } %>
    <% } else { %>
        <% foreach(var item in Model) { %>            
        <% Html.RenderPartial("PostControl", item); %>
        <% } %>
    <% } %>
</asp:Content>

