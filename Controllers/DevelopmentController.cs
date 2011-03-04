using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using striderMVC.Models;

namespace striderMVC.Controllers {
    
    public class DevelopmentController : ParentController {
        ProjectEntities model;

        public DevelopmentController() {
            model = new ProjectEntities();            
        }

        public ActionResult Code(string file) {
            if(file == null) {
                return View(new CodeModel(Server.MapPath("~/Models/Code.xml")));
            }

            if(!System.IO.File.Exists(Server.MapPath("~/Content/Code/" + file)))
                return View("NoFile");

            return File("~/Content/Code/" + file, "text/plain");
        }

        public ActionResult Projects(int? filter) {
            model.Filter = filter;
            return View(model);
        }

        [Authorize]
        public ActionResult DeleteProject(int id) {
            Project project = model.Projects.SingleOrDefault(p => p.ID == id);
            if(project == null)
                return View("NotFound");

            ViewData["DeletedProject"] = project.Title;
            model.DeleteObject(project);
            model.SaveChanges();

            return View("Deleted");
        }

        [Authorize]
        [HttpGet]
        public ActionResult EditProject(int id) {
            Project project = model.Projects.SingleOrDefault(p => p.ID == id);
            if(project == null)
                return View("NotFound");

            return View(project);
        }

        [Authorize]
        [HttpPost]
        public ActionResult EditProject(int id, FormCollection form) {
            Project project = model.Projects.SingleOrDefault(p => p.ID == id);

            try {
                UpdateModel(project);
                model.SaveChanges();

                return RedirectToAction("Projects");
            } catch {
                return View(project);
            }
        }

        [Authorize]
        [HttpGet]
        public ActionResult CreateProject() {
            return View(new Project());
        }

        [Authorize]
        [HttpPost]
        public ActionResult CreateProject(Project project) {
            if(project == null)
                return View("Error");

            try {
                UpdateModel(project);
                model.Projects.AddObject(project);
                model.SaveChanges();

                return RedirectToAction("Projects");
            } catch {
                return View(project);
            }
        }
    }
}
