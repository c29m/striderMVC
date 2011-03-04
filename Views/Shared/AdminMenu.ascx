<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<% if(Request.IsAuthenticated) { %>    
<h2>Admin</h2>
<ul class="menublock">
    <li><%= Html.ActionLink("New Post", "Create", "Home") %></li>
    <li><%= Html.ActionLink("New Project", "CreateProject", "Development") %></li>
    <li><%= Html.ActionLink("Manage Images", "Home", "Images")%></li>
</ul>
<% } %>