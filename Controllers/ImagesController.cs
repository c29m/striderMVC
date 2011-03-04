using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using striderMVC.Models;

namespace striderMVC.Controllers {
    [HandleError]
    [Authorize]
    public class ImagesController : ParentController {
        ImageModel model;

        protected override void OnActionExecuting(ActionExecutingContext filterContext) {
            base.OnActionExecuting(filterContext);
            model = new ImageModel(Server.MapPath("~/Images/"), Url);
        }

        [HttpGet]
        public ActionResult Home() {            
            return View(model);
        }

        [HttpPost]
        public ActionResult Upload(HttpPostedFileBase file, bool thumbnail) {
            if(file == null || !file.ContentType.StartsWith("image"))
                return RedirectToAction("Home");

            model.Upload(file, thumbnail);

            return RedirectToAction("Home");
        }
    }
}
