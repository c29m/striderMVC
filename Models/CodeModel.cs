using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace striderMVC.Models {
    public class CodeModel {        
        public CodeModel(string CodeXmlPath) {
            XDocument doc = XDocument.Load(CodeXmlPath);
            Items = from e in doc.Root.Elements("item")
                    select new CodeItem {
                        Title = e.Attribute("title").Value,
                        Filename = e.Attribute("filename").Value,
                        Platform = e.Attribute("platform").Value,
                        Description = e.Attribute("description").Value
                    };
        }
        public IEnumerable<CodeItem> Items {
            get;
            private set;
        }
    }

    public class CodeItem {
        public string Title {
            get;
            set;
        }
        public string Filename {
            get;
            set;
        }
        public string Platform {
            get;
            set;
        }
        public string Description {
            get;
            set;
        }
    }
}