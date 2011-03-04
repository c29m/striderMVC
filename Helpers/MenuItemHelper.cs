using System;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Html;

namespace Helpers {
    public static class MenuItemHelper {
        public static string MenuItem(this HtmlHelper helper, string linkText, string actionName, string controllerName) {
            string currentController = (string)helper.ViewContext.RouteData.Values["controller"];
            string currentAction = (string)helper.ViewContext.RouteData.Values["action"];

            StringBuilder sb = new StringBuilder();
            if(currentController.Equals(controllerName, StringComparison.InvariantCultureIgnoreCase) && currentAction.Equals(actionName, StringComparison.InvariantCultureIgnoreCase)) {
                sb.Append("<li class=\"selected\">");
            } else {
                sb.Append("<li>");
            }

            sb.Append(helper.RouteLink(linkText, "Default", new {
                controller = controllerName,
                action = actionName
            }));
            sb.Append("</li>");

            return sb.ToString();
        }
    }
}