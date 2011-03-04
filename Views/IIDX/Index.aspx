<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<striderMVC.Models.IIDXModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>beatmaniaIIDX Scores</h2>

    <% using(Html.BeginForm()) { %>
        <div style="float:left; padding-right:8px;">
            <strong>Style</strong><br />
            <%= Html.DropDownList("Style", Model.StyleList, new {onchange="form.submit();"})%>
        </div>        
        <div style="float:left; padding-right:8px;">
            <strong>Mode</strong><br />
            <%= Html.DropDownList("Mode", Model.ModeList, new {onchange = "form.submit();"})%>
        </div>        
        <div>
            <strong>DJ</strong><br />
            <%= Html.DropDownList("DJ", Model.DJList, new {onchange = "form.submit();"})%>
        </div>
        <br />
        <div style="float:left;">
            <%= Html.ListBox("Song", Model.SongList, new {@class = "songlist", onchange="form.submit();"})%>   
        </div>
        <div style="float:left; width:250px;">
            <% if(Model.CurrentSong != null) { %> 
                <div style="text-align:center; width:100%;">           
                <strong><%=Model.CurrentSong.SongInfo.Title %></strong><br />
                <%=Model.CurrentSong.SongInfo.Artist %><br />
                <%=Model.CurrentSong.SongInfo.Genre  %><br />
                <%=Model.CurrentSong.SongInfo.BPM %> BPM - <%=Model.CurrentSong.Difficulty %>★ <%=Model.CurrentSong.Mode.Abbr %>
                </div>
                <% if(Model.CurrentSong.Scores.Count > 0) { %>
                    <table id="scoreTable" cellpadding="3" cellspacing="0" style="width:100%">
                        <thead>
                            <tr style="background-color:#80b0da; color:#fff;">
                                <th>Grade</th><th>Score</th><th>Acc%</th><th>Date</th><th>Time</th>
                            </tr>
                        </thead>                    
                        <tbody>
                            <% foreach(var item in Model.CurrentSong.Scores.Where(s => s.DJID == Model.CurrentDJ.DJID).OrderByDescending(s => s.EXScore)) { %>
                                <tr style="padding:5px;">
                                    <td><%=item.GetGrade()%></td>
                                    <td><%=item.EXScore%></td>
                                    <td><%=item.GetAccuracy().ToString("00.0%")%></td>
                                    <td><%=item.Stamp.ToString("M/d/yy")%></td>
                                    <td><%=item.Stamp.ToString("h:mm tt") %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>                
            <% } %>
        </div>
    <% } %>
</asp:Content>
