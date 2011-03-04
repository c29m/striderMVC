<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<striderMVC.Models.YouTubeModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>#changoland youtube links</h2>

    <% using(Html.BeginForm()) { %>
        <p>The last 
            <%= Html.DropDownListFor(model => model.SelectedCount, Model.Count, new {onchange="form.submit();"})%>
            youtube links posted in #changoland on EFNet.  The script is still a little iffy, sometimes the titles are just wrong.</p>
        <p>
            <% foreach(var item in Model.Links) { %>
                <a href="<%=item.Element("link").Value %>" title="posted by <%=item.Element("nick").Value %> on <%=item.Element("date").Value + " @ " + item.Element("time").Value %>">
                    <%=item.Element("title").Value%>
                </a><br />
            <% } %>
        </p>
    <% } %>
</asp:Content>
