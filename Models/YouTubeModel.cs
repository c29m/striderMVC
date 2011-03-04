using System;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace striderMVC.Models {
    public class YouTubeModel {

        public YouTubeModel(int? SelectedCount) {
            this.SelectedCount = SelectedCount.HasValue ? SelectedCount.Value : 30;
            Links = new List<XElement>();
            Count = new SelectList(new[] { 
                10, 15, 30, 45
            }, this.SelectedCount);

            try {
                XDocument ytdoc = new XDocument(new XDeclaration("1.0", "utf-8", "yes"),
                    XElement.Parse("<entries>" + System.IO.File.ReadAllText(@"\\ereki\strider's public folder\.bxyt.xml") + "</entries>"));

                Links = (from e in ytdoc.Element("entries").Elements("entry")
                         orderby DateTime.ParseExact((e.Element("date").Value + " " + e.Element("time").Value), "MM-dd-yy HH:mm", new System.Globalization.CultureInfo("en-US")) descending
                         select e).Take(this.SelectedCount).ToList();
            } catch {
                Links = new List<XElement>();
            }
        }
        public int SelectedCount {
            get;
            set;
        }

        public SelectList Count {
            get;
            private set;
        }

        public IEnumerable<XElement> Links {
            get;
            set;
        }
    }
}