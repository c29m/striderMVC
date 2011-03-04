<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<striderMVC.Models.Project>" %>

<h2><%=Model.Title %></h2>
<h5>Progress: <%=Model.Progress.ToString("P") %>
<% if(Request.IsAuthenticated) { %>
    | <%= Html.ActionLink("Edit", "EditProject", new{id=Model.ID}) %>
    | <%= Html.ActionLink("Delete", "DeleteProject", new {id = Model.ID}, new {onClick="return confirm('Are you sure you want to delete the \"" + Model.Title + "\" project?');"})%>
<% } %>
</h5>
<div style="width:300px; height:15px; border:1px solid #000;text-align:left;">    
    <div style="height:100%; width:<%=Model.Progress.ToString("0.00%")%>; background-color:#80b0da;">        
    </div>    
</div>
<p style="border-bottom:1px solid #ddd;"><%=Model.Summary %></p>