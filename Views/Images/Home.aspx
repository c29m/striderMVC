<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<striderMVC.Models.ImageModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Images</h2>

    <% using(Html.BeginForm("Upload", "Images", FormMethod.Post, new {enctype="multipart/form-data"})) { %>
    <div id="img_upload">
        Upload Image: <input type="file" id="file" name="file" />
        Generate Thumb? <%= Html.CheckBox("thumbnail") %>
        <input type="submit" value=" Upload " />
    </div>
    <% } %>

    <table id="images">
        <thead>
            <tr>
                <th class="thumb"></th>
                <th class="name">Name</th>
                <th class="size">Size</th>
                <th class="date">Uploaded</th>
            </tr>
        </thead>
        <tbody>
            <% foreach(var img in Model.Images) { %>
            <tr>
                <td class="thumb">
                    <% if(img.HasThumbnail) { %>
                    <a href="<%= img.ThumbnailUrl %>">[T]</a>
                    <% } %>
                </td>
                <td class="name"><a href="<%= img.ImageUrl %>"><%=img.Filename %></a></td>
                <td class="size"><%=img.Size %></td>
                <td class="date"><%=img.Uploaded.ToString("yyyy-MM-dd HH:mm") %></td>
            </tr>
            <% } %>
        </tbody>
        <tfoot>
        </tfoot>
    </table>
</asp:Content>
