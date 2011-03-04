using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace striderMVC {
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication {
        public static void RegisterRoutes(RouteCollection routes) {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "YMD",
                "Archive/{year}/{month}/{day}",
                new {
                    controller = "Home",
                    action = "Archive",
                    year = UrlParameter.Optional,
                    month = UrlParameter.Optional,
                    day = UrlParameter.Optional
                }
            );

            routes.MapRoute(
                "Feeds",
                "Feeds/{type}",
                new {
                    controller = "Home",
                    action = "Feed",
                    type = "rss"
                }
            );

            routes.MapRoute(
                "GetCode",
                "Development/Code/{file}",
                new {
                    controller = "Development",
                    action = "Code",
                    file = UrlParameter.Optional
                }
            );

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new {
                    controller = "Home",
                    action = "Index",
                    id = UrlParameter.Optional
                } // Parameter defaults
            );

            routes.MapRoute(
                "PostBySlug",
                "{year}/{month}/{day}/{slug}",
                new {
                    controller = "Home",
                    action = "Archive",
                    year = UrlParameter.Optional,
                    month = UrlParameter.Optional,
                    day = UrlParameter.Optional,
                    slug = UrlParameter.Optional
                }
            );
        }

        protected void Application_Start() {
            ViewEngines.Engines.Clear();
            ViewEngines.Engines.Add(new striderMVC.Helpers.CustomViewEngine());

            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
        }
    }
}