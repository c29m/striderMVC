<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<striderMVC.Models.XBLInfo>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Xbox Live Gamercard // <a href="<%= Model.ProfileURL %>">striderIIDX</a></h2>
    <p>
        <img src="<%= Model.TileURL %>" alt="gamerpic" height="64" width="64" id="gamerpic" />
        <%= Model.Country %>, <%= Model.Location %> (<%= Model.Zone %>)<br />
        <%= Model.GamerScore %> GS | <%= Model.Reputation %> Rep <br />
        <%= Model.PresenceInfo.Info %><br />
        <%= Model.PresenceInfo.StatusText %>
    </p>

    <div id="xblgames">
    <% foreach(var item in Model.RecentGames) { %>
        <div id="xblgame" onmouseover="showg(this, '<%=item.Game.Name %>');" onmouseout="clearg(this, '<%=item.Game.Name %>');">
            <a href="<%=item.DetailsURL %>"><img src="<%= item.Game.Image64URL %>" alt="<%=item.Game.Name %>" /></a>
            <div style="display:none;" id="<%=item.Game.Name %>">
                <h3><%=item.Game.Name %></h3>
                Last played <%= item.LastPlayed %><br />
                <%= item.Achievements %> out of <%=item.Game.TotalAchievements  %> Achievements <br />
                <%= item.GamerScore %> out of <%= item.Game.TotalGamerScore %> Gamerscore
            </div>
        </div>
    <% } %>
    </div>

    <div id="currentGame">
        <span><label id="game" /></span><br />
    </div>

    <script type="text/javascript">
        function showg(elm, game) {
            elm.style.border = '1px solid #fff';
            elm.style.opacity = '0.6';
            var gDiv = document.getElementById(game);
            gDiv.style.display = 'inherit';
            document.getElementById('currentGame').appendChild(gDiv); 
        }

        function clearg(elm, game) {
            elm.style.border = '1px solid #000';
            elm.style.opacity = '1.0';
            var gDiv = document.getElementById(game);
            gDiv.style.display = 'none';            
        }
    </script>
</asp:Content>

