using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Web;

namespace striderMVC.Models {
    public partial class PostEntities {
        
        public Post GetPost(int id) {
            return Posts.SingleOrDefault(p => p.ID == id);
        }

        public IEnumerable<Post> ArchivePosts(int? Year, int? Month, int? Day, string Slug) {
            var posts = Posts.AsQueryable();

            if(Year.HasValue)
                posts = posts.Where(p => p.Published.Year == Year.Value);
            if(Month.HasValue)
                posts = posts.Where(p => p.Published.Month == Month.Value);
            if(Day.HasValue)
                posts = posts.Where(p => p.Published.Day == Day.Value);
            if(!string.IsNullOrWhiteSpace(Slug))
                posts = posts.Where(p => p.Slug.Equals(Slug, StringComparison.InvariantCultureIgnoreCase));

            return posts.OrderByDescending(p => p.Published);
        }

        public IEnumerable<Post> LatestPosts(int Count) {
            return Posts.OrderByDescending(p => p.Published).Take(Count);
        }

        public IEnumerable<Post> Feed() {
            return Posts.OrderByDescending(p => p.Published).Take(20);
        }

        public IEnumerable<Post> PostsBySlug(string slug) {
            return Posts.Where(p => p.Slug.Equals(slug, StringComparison.InvariantCultureIgnoreCase)).OrderByDescending(p => p.Published);
        }

        public IEnumerable<Post> Find(string criteria) {
            return Posts.Where(p => p.Title.ToLower().Contains(criteria.ToLower()) || p.Text.ToLower().Contains(criteria.ToLower()));
        }
    }
}