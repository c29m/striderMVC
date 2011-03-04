using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace striderMVC.Models {
    public class XBLInfo {
        const string REST_API = "http://xboxapi.duncanmackenzie.net/gamertag.ashx?GamerTag={0}";
        const string AVATAR_URL = "http://avatar.xboxlive.com/avatar/{0}/avatar-body.png";

        public XBLInfo(string Gamertag) {
            this.Gamertag = Gamertag;
            XDocument doc = XDocument.Load(string.Format(REST_API, this.Gamertag.Replace(" ", "+")));

            AccountStatus = doc.Root.Element("AccountStatus").Value;
            PresenceInfo = new XBLPresenceInfo(doc.Root.Element("PresenceInfo"));
            State = doc.Root.Element("State").Value;
            Gamertag = doc.Root.Element("Gamertag").Value;
            Reputation = float.Parse(doc.Root.Element("Reputation").Value);
            GamerScore = int.Parse(doc.Root.Element("GamerScore").Value);

            if(PresenceInfo.Valid) {
                ProfileURL = doc.Root.Element("ProfileUrl").Value;
                TileURL = doc.Root.Element("TileUrl").Value;
                Country = doc.Root.Element("Country").Value;
                Bio = doc.Root.Element("Bio").Value;
                Location = doc.Root.Element("Location").Value;
                ReputationImageURL = doc.Root.Element("ReputationImageUrl").Value;
                Zone = doc.Root.Element("Zone").Value;
                AvatarURL = string.Format(AVATAR_URL, this.Gamertag);

                RecentGames = (from e in doc.Root.Element("RecentGames").Elements("XboxUserGameInfo")
                               select new XBLGameInfo(e)).ToArray();
            }
        }

        public string Gamertag {
            get;
            private set;
        }
        public XBLPresenceInfo PresenceInfo {
            get;
            private set;
        }
        public string AccountStatus {
            get;
            private set;
        }
        public string State {
            get;
            private set;
        }
        public string ProfileURL {
            get;
            private set;
        }
        public string TileURL {
            get;
            private set;
        }
        public string Country {
            get;
            private set;
        }
        public float Reputation {
            get;
            private set;
        }
        public string Bio {
            get;
            private set;
        }
        public string Location {
            get;
            private set;
        }
        public string ReputationImageURL {
            get;
            private set;
        }
        public int GamerScore {
            get;
            private set;
        }
        public string Zone {
            get;
            private set;
        }
        public XBLGameInfo[] RecentGames {
            get;
            private set;
        }
        public string AvatarURL {
            get;
            private set;
        }
    }

    public class XBLPresenceInfo {
        internal XBLPresenceInfo(XElement e) {
            Valid = bool.Parse(e.Element("Valid").Value);
            LastSeen = DateTime.Parse(e.Element("LastSeen").Value);
            Online = bool.Parse(e.Element("Online").Value);

            if(Valid) {
                Info = e.Element("Info").Value;
                Info2 = e.Element("Info2").Value;
                StatusText = e.Element("StatusText").Value;
                Title = e.Element("Title").Value;
            }
        }

        public bool Valid {
            get;
            private set;
        }
        public string Info {
            get;
            private set;
        }
        public string Info2 {
            get;
            private set;
        }
        public DateTime LastSeen {
            get;
            private set;
        }
        public bool Online {
            get;
            private set;
        }
        public string StatusText {
            get;
            private set;
        }
        public string Title {
            get;
            private set;
        }
    }
    public class XBLGameInfo {
        internal XBLGameInfo(XElement e) {
            Game = new XBLGame(e.Element("Game"));
            LastPlayed = DateTime.Parse(e.Element("LastPlayed").Value);
            Achievements = int.Parse(e.Element("Achievements").Value);
            GamerScore = int.Parse(e.Element("GamerScore").Value);
            DetailsURL = e.Element("DetailsURL").Value;
        }
        public XBLGame Game {
            get;
            private set;
        }
        public DateTime LastPlayed {
            get;
            set;
        }
        public int Achievements {
            get;
            set;
        }
        public int GamerScore {
            get;
            set;
        }
        public string DetailsURL {
            get;
            set;
        }
    }
    public class XBLGame {
        internal XBLGame(XElement e) {
            Name = e.Element("Name").Value;
            TotalAchievements = int.Parse(e.Element("TotalAchievements").Value);
            TotalGamerScore = int.Parse(e.Element("TotalGamerScore").Value);
            Image32URL = e.Element("Image32Url").Value;
            Image64URL = e.Element("Image64Url").Value;
        }

        public string Name {
            get;
            private set;
        }
        public int TotalAchievements {
            get;
            private set;
        }
        public int TotalGamerScore {
            get;
            private set;
        }
        public string Image32URL {
            get;
            private set;
        }
        public string Image64URL {
            get;
            private set;
        }
    }
}
