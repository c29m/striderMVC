using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace striderMVC.Helpers {
    public class CustomViewEngine : WebFormViewEngine {
        public override ViewEngineResult FindView(ControllerContext controllerContext, string viewName, string masterName, bool useCache) {
            if(controllerContext.HttpContext.Request.Browser.IsMobileDevice) {
                masterName = "~/Views/Shared/Mobile/Site.Master";
                useCache = false;
            }

            return base.FindView(controllerContext, viewName, masterName, useCache);
        }
    }
}