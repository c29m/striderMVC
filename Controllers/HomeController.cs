using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using striderMVC.Models;

namespace striderMVC.Controllers {

    [HandleError]
    public class HomeController : ParentController {
        PostEntities model;

        public HomeController() {
            model = new PostEntities();            
        }

        [HttpGet]
        public ActionResult Index() {
            return View(model.LatestPosts(5));
        }

        [HttpGet]
        public ActionResult Archive(int? Year, int? Month, int? Day, string Slug) {
            if(!Year.HasValue && !Month.HasValue && !Day.HasValue)
                return View(model.Posts.OrderByDescending(p => p.Published));

            return View("Index", model.ArchivePosts(Year, Month, Day, Slug));
        }

        [Authorize]
        public ActionResult Create() {
            return View(new Post {
                Author = User.Identity.Name,
                Mobile = Request.Browser.IsMobileDevice
            });
        }

        [Authorize]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create(Post post) {
            if(post == null)
                return View("Error");

            try {
                UpdateModel(post);
                post.Published = DateTime.Now;
                model.Posts.AddObject(post);
                model.SaveChanges();

                return RedirectToAction("Index", new {
                    slug = post.Slug
                });
            } catch {
                return View(post);
            }
        }

        [Authorize]
        public ActionResult Edit(int id) {
            Post post = model.GetPost(id);

            if(post == null)
                return View("NotFound");

            return View(post);
        }

        [Authorize]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(int id, FormCollection form) {
            Post post = model.GetPost(id);

            try {
                UpdateModel(post);
                post.Modified = DateTime.Now;
                model.SaveChanges();

                return RedirectToAction("Index", new {
                    slug = post.Slug
                });
            } catch {
                return View(post);
            }
        }

        [Authorize]
        public ActionResult Delete(int id) {
            Post post = model.GetPost(id);

            if(post == null)
                return View("NotFound");
            
            ViewData["DeletedTitle"] = post.Title;
            model.DeleteObject(post);
            model.SaveChanges();
            
            return View("Deleted");
        }

        [HttpPost]
        public ActionResult Search(string s) {
            ViewData["Search"] = s;
            return View("Index", model.Find(s));
        }

        public ActionResult Feed(string type) {
            if(ViewEngines.Engines.FindView(ControllerContext, type, null).View == null) {
                ViewData["Feed"] = type;
                return View("NoFeed");
            }

            return View(type, model.Feed());
        }
    }
}
