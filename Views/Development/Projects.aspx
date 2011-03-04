<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<striderMVC.Models.ProjectEntities>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">    
    <% using(Html.BeginForm()) { %>
        <p>
            Project Filter: <%= Html.DropDownList("Filter", Model.ProjectFilter, new {onchange="form.submit();"})%>
        </p>
        <% foreach(var item in Model.FilteredProjects) { %>        
            <% Html.RenderPartial("ProjectControl", item); %>
        <% } %>
    <% } %>
</asp:Content>

