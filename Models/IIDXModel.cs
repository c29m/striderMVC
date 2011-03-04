using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Web;
using System.Web.Mvc;

namespace striderMVC.Models {
    public class IIDXModel {
        IIDXEntities model;

        public IIDXModel() {
            model = new IIDXEntities();
            var orderedStyles = model.Styles.OrderBy(s => s.StyleOrder);
            StyleList = new SelectList(orderedStyles, "StyleID", "StyleName");
            ModeList = new SelectList(model.Modes, "ModeID", "Abbr");
            DJList = new SelectList(model.DJs, "DJID", "DJName");
            SetSongs(orderedStyles.First().StyleID, model.Modes.First().ModeID, model.DJs.First().DJID);
        }

        public void SetSongs(int styleid, int modeid, int djid) {
            SongList = new SelectList(model.Songs.Where(s => s.SongInfo.StyleID == styleid && s.ModeID == modeid).OrderBy(s => s.SongInfo.Title), "SongID", "SongInfo.Title");
            CurrentDJ = model.DJs.SingleOrDefault(d => d.DJID == djid);
        }

        public void SetScores(int djid, int songid) {
            CurrentSong = model.Songs.SingleOrDefault(s => s.SongID == songid);
        }

        public System.IO.Stream GetSongData() {
            XDocument doc = new XDocument(new XDeclaration("1.0", "utf-8", "yes"),
                new XComment(string.Format("Generated on {0:MM/dd/yyyy HH:mm}\r\n" +
                                           "Data collected by strider- for the purposes of personal score keeping.",
                                           DateTime.Now)),
                new XElement("IIDXData",
                    from songinfo in model.SongInfoes.ToList()
                    orderby songinfo.Style.StyleOrder, songinfo.Title
                    select new XElement("Song",
                        new XElement("Title", songinfo.Title),
                        new XElement("Artist", songinfo.Artist),
                        new XElement("Genre", songinfo.Genre),
                        new XElement("BPM", songinfo.BPM),
                        new XElement("Style", songinfo.Style.StyleName),
                        new XElement("Modes",
                            from song in songinfo.Songs.ToList()
                            orderby song.SongID
                            select new XElement("Mode",
                                new XAttribute("Name", song.Mode.Abbr),
                                new XAttribute("Difficulty", song.Difficulty),
                                new XAttribute("TotalNotes", song.TotalNotes)
                            )
                        ),
                        new XElement("Revivals",
                            from rev in songinfo.CSRevivals.ToList()
                            orderby rev.Style.StyleOrder
                            select new XElement("Style", rev.Style.StyleName)
                        )
                    )
                )
            );

            return new System.IO.MemoryStream(System.Text.Encoding.UTF8.GetBytes(doc.ToString()));
        }

        public DJ CurrentDJ {
            get;
            private set;
        }
        public Song CurrentSong {
            get;
            private set;
        }

        public SelectList SongList {
            get;
            private set;
        }

        public SelectList StyleList {
            get;
            private set;
        }
        public SelectList ModeList {
            get;
            private set;
        }
        public SelectList DJList {
            get;
            private set;
        }
    }
}