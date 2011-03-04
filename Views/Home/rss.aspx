<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<striderMVC.Models.Post>>" %>
<% string absUrl = Request.Url.Scheme + "://" + Request.Url.Authority; %><?xml version="1.0" encoding="utf-8" standalone="yes"?>
<rss version="2.0">
  <channel>
    <title>a.b.strider-</title>
    <link><%= absUrl + Url.Action("Index", "Home")%></link>
    <description><%= ViewData["Header"] %></description>
    <language>en-us</language>
    <image>
      <title>a.b.strider-</title>
      <url><%= absUrl + Url.Content("~/Content/strider.bmp")%></url>
      <link><%= absUrl + Url.Action("Index", "Home")%></link>
      <width>48</width>
      <height>48</height>
      <description>warez mad warez</description>
    </image><% foreach(var item in Model) { %>
    <item>
      <title><%=item.Title %></title>
      <link><%=absUrl + Url.RouteUrl("PostBySlug", item.RouteValues)%></link>
      <description><![CDATA[<%=item.Text %>]]></description>
      <pubDate><%=item.Published.ToString("ddd, d MMM yyyy HH:mm:ss PDT") %></pubDate>
    </item><% } %>
  </channel>       
</rss>
