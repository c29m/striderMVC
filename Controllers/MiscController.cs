using System;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using striderMVC.Models;

namespace striderMVC.Controllers {
    public class MiscController : ParentController {
        public ActionResult NFO() {
            return View();
        }

        public ActionResult Gamercard() {         
            return View(new XBLInfo("striderIIDX"));            
        }

        public ActionResult YouTube(int? selectedcount) {
            return View(new YouTubeModel(selectedcount));
        }
    }
}
