using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Net;

namespace Test {
    class ImgChan {
        const string EXPRESSION = "<span\\sclass=\"filesize\">.*?href=\"(?<URL>.*?)\".*?</span>";

        WebClient wc;
        DirectoryInfo dest;
        Queue<string> images;

        public ImgChan() {
            wc = new WebClient();
            wc.DownloadStringCompleted += new DownloadStringCompletedEventHandler(threadDownloaded);
            wc.DownloadFileCompleted += new System.ComponentModel.AsyncCompletedEventHandler(fileDownloaded);
        }

        public void PullImages(string ThreadLink, DirectoryInfo Destination) {
            IsProcessing = true;
            dest = Destination;

            if(!dest.Exists)
                dest.Create();

            wc.DownloadStringAsync(new Uri(ThreadLink));
        }

        void threadDownloaded(object sender, DownloadStringCompletedEventArgs e) {
            Regex regex = new Regex(EXPRESSION, RegexOptions.Multiline
                | RegexOptions.IgnoreCase
                | RegexOptions.IgnorePatternWhitespace);

            MatchCollection matches = regex.Matches(e.Result);
            images = new Queue<string>();

            foreach(Match m in matches) {
                if(m.Success) {
                    string url = m.Groups["URL"].Value;
                    images.Enqueue(url);
                }
            }

            pop();
        }

        void pop() {
            string url = images.Dequeue();
            string filename = url.Substring(url.LastIndexOf("/") + 1);
            string destPath = Path.Combine(dest.FullName, filename);
            wc.DownloadFileAsync(new Uri(url), destPath, filename);
        }

        void fileDownloaded(object sender, System.ComponentModel.AsyncCompletedEventArgs e) {
            if(images.Count > 0) {
                pop();
            } else {
                IsProcessing = false;
            }
        }

        public bool IsProcessing {
            get;
            private set;
        }
    }
}
