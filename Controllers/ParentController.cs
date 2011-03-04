using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace striderMVC.Controllers {
    public abstract class ParentController : Controller {
        public ParentController() {
            striderMVC.Models.HeaderEntities model = new Models.HeaderEntities();
            int num = new Random().Next(0, model.Headers.Count());
            ViewData["Header"] = model.Headers.OrderBy(h => h.Id).Skip(num).First().Value;
        }
    }
}
