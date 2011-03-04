using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace striderMVC.Models {
    public partial class Score {
        public double GetAccuracy() {
            return (double)EXScore / (double)(Song.TotalNotes * 2);
        }
        public string GetGrade() {
            string[] grades = new[] { "F", "E", "D", "C", "B", "A", "AA", "AAA" };
            int tn = Song.TotalNotes;
            int ex = EXScore;

            for(int i = 8; i >= 2; i--) {
                int min = ((tn * 2) * i) / 9;
                if(ex >= min)
                    return grades[i - 1];
            }

            return "???";
        }
    }
}