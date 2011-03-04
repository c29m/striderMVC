<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<striderMVC.Models.Post>" %>
        <div id="post">
        <h2>
            <%= Html.RouteLink(Html.Encode(Model.Title), "PostBySlug", Model.RouteValues)%>
            <% if(Model.Mobile) { %>
                <img src="<%= Url.Content("~/Content/mobile.gif") %>" alt="posted via mobile" title="mobile post" />
            <% } %>                
        </h2>
        <h5>
            posted by <%=Model.Author%> on <%=Model.Published%>
            <% if(Model.Author.Equals(Context.User.Identity.Name) && Model.ID > 0) { %>
                | <%= Html.ActionLink("Edit", "Edit", new {id = Model.ID})%>
                | <%= Html.ActionLink("Delete", "Delete", new {id = Model.ID}, new {onClick = "return confirm('Are you sure you want to delete \"" + Html.Encode(Model.Title) + "\"?');"})%>
            <% } %>
        </h5>
        <p>
            <%=Model.Text%>
            <% if(Model.Modified.HasValue) { %>
                <p><span class="small"><i>last modified on <%=Model.Modified.Value%></i></span></p>
            <% } %>
        </p>
        </div>