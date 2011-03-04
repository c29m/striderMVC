using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;

namespace striderMVC.Models {
    public class ImageModel {
        DirectoryInfo dir, thumbDir;

        public ImageModel(string ImagePath, System.Web.Mvc.UrlHelper url) {
            dir = new DirectoryInfo(ImagePath);
            thumbDir = dir.GetDirectories("t").FirstOrDefault();

            if(!dir.Exists)
                dir.Create();
            if(thumbDir == null || !thumbDir.Exists)
                thumbDir = dir.CreateSubdirectory("t");

            Images = from f in dir.GetFiles()
                     let exists = File.Exists(Path.Combine(thumbDir.FullName, f.Name))
                     select new Img {
                         Filename = f.Name,
                         ImageUrl = url.Content("~/Images/" + f.Name),
                         Uploaded = f.CreationTime,
                         Size = f.Length,
                         HasThumbnail = exists,
                         ThumbnailUrl = exists ? url.Content("~/Images/t/" + f.Name) : null
                     };
        }

        public void Upload(HttpPostedFileBase file, bool createThumb) {
            Image img = Image.FromStream(file.InputStream);
            img.Save(dir.FullName + file.FileName);

            if(createThumb) {
                int w = (int)Math.Round(img.Width * .20);
                int h = (int)Math.Round(img.Height * .20);
                Bitmap thumb = new Bitmap(img, w, h);
                thumb.Save(Path.Combine(thumbDir.FullName, file.FileName));
            }
        }

        public IEnumerable<Img> Images {
            get;
            private set;
        }
    }

    public class Img {
        public string Filename {
            get;
            set;
        }
        public string ImageUrl {
            get;
            set;
        }
        public DateTime Uploaded {
            get;
            set;
        }
        public long Size {
            get;
            set;
        }
        public bool HasThumbnail {
            get;
            set;
        }
        public string ThumbnailUrl {
            get;
            set;
        }
    }
}