<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<striderMVC.Models.Post>" %>

<script src="<%= Url.Content("~/Scripts/MicrosoftAjax.js") %>" type="text/javascript"></script>
<script src="<%= Url.Content("~/Scripts/MicrosoftMvcValidation.js") %>" type="text/javascript"></script>

<% Html.EnableClientValidation(); %>

<% using (Html.BeginForm()) {%>
    <div id="postform">
        <%: Html.ValidationSummary(true) %>
        <% if(!Request.Browser.IsMobileDevice) { %>
        <script type="text/javascript" src="<%= Url.Content("~/Scripts/tiny_mce/tiny_mce.js") %>"></script>
        <script type="text/javascript">
            tinyMCE.init({
                mode: "textareas",
                theme: "advanced",
                plugins: "preview,advimage,advlink",
                relative_urls: false,
                remove_script_host: false,
                document_base_url: "<%= string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Request.ApplicationPath) %>",
		        theme_advanced_toolbar_location : "top",
		        theme_advanced_toolbar_align: "left",
                theme_advanced_buttons1: "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,forecolor,backcolor",                               
                theme_advanced_buttons3: "formatselect,fontselect,fontsizeselect,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,preview"
            });
        </script>
        <% } %>
        <script type="text/javascript">
            /* copying the title as the slug (only if the slug is blank or empty), replacing spaces with dashes.*/
            function copyToSlug(title) {                     
                if (Slug.value.trim().length == 0)
                    Slug.value = title.value.replace(/ /g, '-');
            }
        </script>
        <fieldset>
            <p id="post_author">
                Author: <%= Model.Author %>
                <%: Html.HiddenFor(model => model.Author) %>
                <%: Html.HiddenFor(model => model.Mobile) %>
            </p>
            <p>
                <div class="editor-label">
                    <%: Html.LabelFor(model => model.Title) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(model => model.Title, new {style="width:100%;", onBlur="copyToSlug(this);"})%>
                    <%: Html.ValidationMessageFor(model => model.Title) %>
                </div>
                <br />
                <div class="editor-label">
                    <%: Html.LabelFor(model => model.Slug) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(model => model.Slug, new {style = "width:100%;"})%>
                    <%: Html.ValidationMessageFor(model => model.Slug) %>
                </div>
            </p>
            <p>
                <div class="editor-label">
                    <%: Html.LabelFor(model => model.Text) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextAreaFor(model => model.Text, new {style="width:100%; height:400px;"})%>
                    <%: Html.ValidationMessageFor(model => model.Text) %>
                </div>
            </p>
            <p>
                <input type="submit" value="Save" name="action" />
            </p>
        </fieldset>
    </div>
<% } %>


