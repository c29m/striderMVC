<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<% if (Request.IsAuthenticated) { %>
    <%= Html.ActionLink("Log Out", "LogOff", "Account") %>
    [<%= Html.Encode(Page.User.Identity.Name) %>]
<% } else { %> 
    <%= Html.ActionLink("Log In", "LogOn", "Account") %>
<% } %>
