using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using striderMVC.Models;

namespace striderMVC.Controllers {
    public class IIDXController : ParentController {
        IIDXModel model;

        public IIDXController() {
            model = new IIDXModel();
        }

        [HttpGet]
        public ActionResult Index() {
            return View(model);
        }

        [HttpPost]
        public ActionResult Index(int style, int mode, int dj, int? song) {
            model.SetSongs(style, mode, dj);
            if(song.HasValue)
                model.SetScores(dj, song.Value);
            return View(model);
        }

        public ActionResult Raw() {
            return File(model.GetSongData(), "text/xml");
        }
    }
}
