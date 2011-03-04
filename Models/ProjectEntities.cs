using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace striderMVC.Models {
    public partial class ProjectEntities {
        partial void OnContextCreated() {
            ProjectFilter = new SelectList(new[] {
                new{ID=0, Value="All"},
                new{ID=1, Value="In Progress"},
                new{ID=2, Value="Completed"}
            }, "ID", "Value", 0);
        }

        public IEnumerable<Project> FilteredProjects {
            get {
                if(Filter.HasValue) {
                    switch(Filter.Value) {
                        case 1:
                            return Projects.Where(p => p.Progress < 1).OrderBy(p => p.Title);
                        case 2:
                            return Projects.Where(p => p.Progress == 1).OrderBy(p => p.Title);
                    }
                }

                return Projects.OrderBy(p => p.Title);
            }
        }

        public int? Filter {
            get;
            set;
        }

        public SelectList ProjectFilter {
            get;
            private set;
        }
    }
}