<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<striderMVC.Models.CodeModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Pointless stuff I write</h2>
    <p>Classes, scripts, ect.  All the stuff I write that no one cares about.</p>
    
    <% foreach(var item in Model.Items) { %>
        <h3><%= Html.RouteLink(item.Title, "GetCode", new{file=item.Filename}) %></h3>
        <p>(<%=item.Platform %>) <%= item.Description %></p>
    <% } %>

        <h3><%= Html.ActionLink("IIDX Song Data", "Raw", "IIDX") %></h3>
        <p>(XML) Not really code, but here's my IIDX song data, scores excluded. Dynamically generated.</p>
</asp:Content>
