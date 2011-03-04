<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<striderMVC.Models.Project>" %>

<script src="<%= Url.Content("~/Scripts/MicrosoftAjax.js") %>" type="text/javascript"></script>
<script src="<%= Url.Content("~/Scripts/MicrosoftMvcValidation.js") %>" type="text/javascript"></script>

<% Html.EnableClientValidation(); %>

<% using (Html.BeginForm()) {%>
    <%: Html.ValidationSummary(true) %>

    <fieldset>            
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Title) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Title, new {style = "width:100%;"}) %>
            <%: Html.ValidationMessageFor(model => model.Title) %>
        </div>
            
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Summary) %>
        </div>
        <div class="editor-field">
            <%: Html.TextAreaFor(model => model.Summary, new {style = "width:100%; height:200px;"})%>
            <%: Html.ValidationMessageFor(model => model.Summary) %>
        </div>
            
        <div class="editor-label">
            <%: Html.LabelFor(model => model.Progress) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.Progress) %>
            <%: Html.ValidationMessageFor(model => model.Progress) %>
        </div>
        <br />
        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
<% } %>


