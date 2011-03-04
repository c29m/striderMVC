using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace striderMVC.Models {
    
    [MetadataType(typeof(PostMetadata))]
    public partial class Post {
        protected override void OnPropertyChanged(string property) {
            base.OnPropertyChanged(property);
            if(property.Equals("Title", StringComparison.InvariantCultureIgnoreCase))
                Slug = Title.Replace(" ", "-");
        }
        public object RouteValues {
            get {
                return new {
                    year = Published.Year,
                    month = Published.Month,
                    day = Published.Day,
                    slug = Slug
                };
            }
        }
    }

    public class PostMetadata{
        [Required(ErrorMessage = "The post title can't be blank!")]
        [StringLength(100, ErrorMessage="Title is limited to 100 characters!")]
        public object Title;

        [Required(ErrorMessage = "The URL slug can't be blank!")]
        [StringLength(100, ErrorMessage = "URL slug is limited to 100 characters!")]
        [DisplayName("URL Slug")]
        [RegularExpression("^[0-9a-zA-Z-_]+", ErrorMessage="The URL slug can only contain letters, digits, dashes and underscores.")]
        public object Slug {
            get;
            set;
        }

        [Required(ErrorMessage="Oh come on, you gotta post something!")]
        public object Text;
    }
}