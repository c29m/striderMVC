<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<striderMVC.Models.Post>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Archive</h2>
    <div id="archive_tree">
        <ul class="archiveMenu">
            <% foreach(var years in Model.GroupBy(y => y.Published.Year)) { %>            
                <li>
                    <span class="toggle" onclick="toggleMenu(this);"> - </span>
                    <%= Html.RouteLink(Html.Encode(years.Key), "YMD", new{year=years.Key}) %> (<%= years.Count() %>)                
                    <ul class="archiveMenu">
                    <% foreach(var months in years.GroupBy(m => m.Published.Month)) { %>
                        <li>
                            <span class="toggle" onclick="toggleMenu(this);"> - </span>
                            <%= Html.RouteLink(new DateTime(years.Key, months.Key, 1).ToString("MMMM"), "YMD", new{year=years.Key, month=months.Key}) %> (<%= months.Count() %>)                        
                            <ul class="archiveMenu">
                                <% foreach(var post in months) { %>
                                    <li>                                    
                                        <%= Html.RouteLink(Html.Encode(post.Title), "PostBySlug", post.RouteValues) %>
                                    </li>
                                <% } %>
                            </ul>
                        </li>
                    <% } %>
                    </ul>
                </li>
            <% } %>
        </ul>
    </div>
    <script type="text/javascript">
        window.onload = function () {
            var elms = document.getElementsByTagName('span');
            for (i = 0; i < elms.length; i++)
                toggleMenu(elms[i]);
        }

        function toggleMenu(elm) {
            var s = elm;
            
            do {
                elm = elm.nextSibling;
            } while (elm && elm.tagName != 'UL');

            if (elm.style.display == 'none') {
                s.innerText = ' - ';
                elm.style.display = 'block';
            } else {
                s.innerText = ' + ';
                elm.style.display = 'none';
            }
        }
    </script>
</asp:Content>

