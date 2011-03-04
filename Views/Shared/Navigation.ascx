<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Helpers" %>

<ul>
    <%= Html.MenuItem("Home", "Index", "Home") %>
    <%= Html.MenuItem("Archive", "Archive", "Home") %>
    <%= Html.MenuItem("#CL YouTube", "YouTube", "Misc") %>
    <%= Html.MenuItem("Projects", "Projects", "Development") %>
    <%= Html.MenuItem("Code", "Code", "Development")%>
    <%= Html.MenuItem("IIDX", "Index", "IIDX") %>
    <%= Html.MenuItem("360", "Gamercard", "Misc") %>
    <%= Html.MenuItem("About", "NFO", "Misc") %>    
</ul>