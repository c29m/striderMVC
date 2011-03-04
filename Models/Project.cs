using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;


namespace striderMVC.Models {
    [MetadataType(typeof(ProjectMetadata))]
    public partial class Project {
    }

    public class ProjectMetadata {
        [Required(ErrorMessage = "The project title can't be blank!")]
        [StringLength(50, ErrorMessage="Title is limited to 50 characters!")]
        public object Title;

        [Required(ErrorMessage="The project summary can't be blank!")]
        [StringLength(200, ErrorMessage="The project summary is limited to 200 characters!")]
        public object Summary;

        [Required(ErrorMessage="Progress can't be blank!")]
        [Range(0, 1, ErrorMessage="Progress must be between 0 and 1!")]        
        public float Progress;
    }
}