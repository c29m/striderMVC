using System;

namespace Utilities.Math {
    /// <summary>
    /// Class for handing basic faction math.
    /// </summary>
    public class Fraction {
        #region  Variables
        int _num, _den;
        #endregion

        #region  Constructors
        /// <summary>
        /// Takes a literal fraction string.
        /// </summary>
        /// <param name="LiteralFraction">Fraction string, i.e. "1/2", "5/7".</param>
        public Fraction(string LiteralFraction) {
            try {
                if(LiteralFraction.IndexOf(@"/") > 0) {
                    string[] f = LiteralFraction.Split('/');
                    _num = int.Parse(f[0]);
                    _den = int.Parse(f[1]);
                } else {
                    int temp = int.Parse(LiteralFraction);

                    if(temp < 0)
                        throw new Exception("Can only accept positive integers.");
                    _num = temp;
                    _den = 1;
                }
            } catch {
                throw new Exception("Invalid fraction.");
            }
        }
        /// <summary>
        /// Takes a whole number with a literal fraction string.  They will be added together for the fraction value.
        /// </summary>
        /// <param name="WholeNumber">Any whole number.</param>
        /// <param name="LiteralFraction">Fraction string, i.e. "1/2", "5/7".</param>
        public Fraction(int WholeNumber, string LiteralFraction) {
            if(WholeNumber < 0)
                throw new Exception("Can only accept positive integers.");

            try {
                if(LiteralFraction.IndexOf(@"/") > 0) {
                    string[] f = LiteralFraction.Split('/');
                    _num = int.Parse(f[0]);
                    _den = int.Parse(f[1]);

                    _num = (_num) + (_den * WholeNumber);
                } else {
                    int temp = int.Parse(LiteralFraction);

                    if(temp < 0)
                        throw new Exception("Can only accept positive integers.");
                    _num = temp;
                    _den = 1;

                    _num = (_num) + (_den * WholeNumber);
                }
            } catch {
                throw new Exception("Invalid fraction.");
            }
        }
        /// <summary>
        /// Takes a numerator and denominator
        /// </summary>
        /// <param name="Numerator">Starting numerator</param>
        /// <param name="Denominator">Starting denominator</param>
        public Fraction(int Numerator, int Denominator) {
            _num = Numerator;
            _den = Denominator;
        }
        /// <summary>
        /// Takes a whole number.  The numerator will be the whole number, the denominator will be 1.
        /// </summary>
        /// <param name="WholeNumber">Any whole number.</param>
        public Fraction(int WholeNumber) {
            if(WholeNumber < 0)
                throw new Exception("Can only accept positive integers.");

            _num = WholeNumber;
            _den = 1;
        }
        #endregion

        #region  Operators
        /// <summary>
        /// Implicitly converts an integer to a Fraction instance.
        /// </summary>
        /// <param name="theNum">Integer to convert.</param>
        /// <returns>new Fraction based on the integer.</returns>
        /// <example>Fraction myFraction = 5;</example>
        public static implicit operator Fraction(int theNum) {
            return new Fraction(theNum);
        }
        /// <summary>
        /// Explicitly converts a fraction instance to a float.
        /// </summary>
        /// <param name="theFraction">Fraction to convert</param>
        /// <returns>Fraction numerator divided by fraction denominator.</returns>
        /// <example>float fractionValue = (float)myFraction;</example>
        public static explicit operator float(Fraction theFraction) {
            // Converts a fraction to an int.
            return (float)theFraction.Numerator / (float)theFraction.Denominator;
        }


        /// <summary>
        /// Adds 2 fractions together.
        /// </summary>
        /// <param name="lhs">Left hand side fraction</param>
        /// <param name="rhs">Right hand side fraction</param>
        /// <returns>Sum of lhs and rhs.</returns>
        public static Fraction operator +(Fraction lhs, Fraction rhs) {
            if(lhs.Denominator == rhs.Denominator)
                return new Fraction(lhs.Numerator + rhs.Numerator, lhs.Denominator);

            int LCD = Fraction.LowestCommonDenominator(lhs, rhs);

            int prod1 = (LCD == lhs.Denominator) ? lhs.Numerator : lhs.Numerator * (LCD / lhs.Denominator);
            int prod2 = (LCD == rhs.Denominator) ? rhs.Numerator : rhs.Numerator * (LCD / rhs.Denominator);

            return new Fraction(prod1 + prod2, LCD);
        }
        /// <summary>
        /// Multiplies 2 fractions together.
        /// </summary>
        /// <param name="lhs">Left hand side fraction</param>
        /// <param name="rhs">Right hand side fraction</param>
        /// <returns>Product of lhs and rhs.</returns>
        public static Fraction operator *(Fraction lhs, Fraction rhs) {
            int newNum = lhs.Numerator * rhs.Numerator;
            int newDen = lhs.Denominator * rhs.Denominator;

            return new Fraction(newNum, newDen);
        }
        /// <summary>
        /// Checks to see if 2 fractions have the same value.
        /// </summary>
        /// <param name="lhs">Left hand side fraction</param>
        /// <param name="rhs">Right hand side fraction</param>
        /// <returns>true if the values are the same, otherwise false.</returns>
        public static bool operator ==(Fraction lhs, Fraction rhs) {
            if((lhs.Numerator == rhs.Numerator) &&
                (lhs.Denominator == rhs.Denominator))
                return true;
            return false;
        }
        /// <summary>
        /// Checks to see if 2 fractions do not have the same value.
        /// </summary>
        /// <param name="lhs">Left hand side fraction</param>
        /// <param name="rhs">Right hand side fraction</param>
        /// <returns>true if the values don't match, otherwise false.</returns>
        public static bool operator !=(Fraction lhs, Fraction rhs) {
            return !(lhs == rhs);
        }
        #endregion

        #region  Static Methods
        /// <summary>
        /// Returns the greatest common factor between 2 numbers.
        /// </summary>
        /// <param name="Number1">Any positive whole number.</param>
        /// <param name="Number2">Any positive whole number.</param>
        /// <returns>The largest integer that these numbers can both be evenly divided by.</returns>
        public static int GreatestCommonFactor(int Number1, int Number2) {
            if(Number2.Equals(0))
                return Number1;
            else
                return GreatestCommonFactor(Number2, Number1 % Number2);
        }
        /// <summary>
        /// Returns the greatest common factor between the numerator &amp; denominator of a fraction.
        /// </summary>
        /// <param name="inputFraction">The fraction to find the GCF for.</param>
        /// <returns>The largest integer that these numbers can both be evenly divided by.</returns>
        public static int GreatestCommonFactor(Fraction inputFraction) {
            return Fraction.GreatestCommonFactor(inputFraction.Numerator, inputFraction.Denominator);
        }

        /// <summary>
        /// Returns a new fraction with reduced values, if values can be reduced.
        /// </summary>
        /// <param name="SourceFraction">Fraction you want to reduce.</param>
        /// <returns>Reduced fraction.  i.e., a source fraction with a value of 5/10 will return a new fraction of 1/2.</returns>
        public static Fraction Reduce(Fraction SourceFraction) {
            int gcf = Fraction.GreatestCommonFactor(SourceFraction);

            int num = SourceFraction.Numerator / gcf;
            int den = SourceFraction.Denominator / gcf;

            return new Fraction(num, den);
        }
        /// <summary>
        /// Returns the lowest common denominator between 2 fractions.
        /// </summary>
        /// <param name="Fraction1">First fraction</param>
        /// <param name="Fraction2">Second fraction</param>
        /// <returns>The smallest common multiple between the given fractions.</returns>
        public static int LowestCommonDenominator(Fraction Fraction1, Fraction Fraction2) {
            Fraction f1 = Fraction1;
            Fraction f2 = Fraction2;

            if(f1.Denominator > f2.Denominator)
                if(f1.Denominator % f2.Denominator == 0)
                    if(f1.Denominator > Fraction.GreatestCommonFactor(f1.Denominator, f2.Denominator))
                        return f1.Denominator;
                    else
                        return f1.Denominator / Fraction.GreatestCommonFactor(f1.Denominator, f2.Denominator);

            if(f2.Denominator > f1.Denominator)
                if(f2.Denominator % f1.Denominator == 0)
                    if(f2.Denominator > Fraction.GreatestCommonFactor(f1.Denominator, f2.Denominator))
                        return f2.Denominator;
                    else
                        return f2.Denominator / Fraction.GreatestCommonFactor(f1.Denominator, f2.Denominator);

            return (f1.Denominator * f2.Denominator) / Fraction.GreatestCommonFactor(f1.Denominator, f2.Denominator);
        }
        #endregion

        #region  Methods
        /// <summary>
        /// Checks to see if the given object is the same as this Fraction object.
        /// </summary>
        /// <param name="obj">Object to check.</param>
        /// <returns>true of the object is the same, otherwise false.</returns>
        public override bool Equals(object obj) {
            if(!(obj is Fraction))
                return false;
            return this == (Fraction)obj;
        }

        /// <summary>
        /// Returns the fraction converted to a string.
        /// </summary>
        /// <returns>Numerator/Denominator</returns>
        public override string ToString() {
            return _num.ToString() + @"/" + _den.ToString();
        }

        /// <summary>
        /// Serves as a hash function for a particular type, suitable for use in hashing algorithms and data structures like a hash table.
        /// </summary>
        /// <returns>A hash code for the current object.</returns>
        public override int GetHashCode() {
            return _num ^ _den;
        }

        /// <summary>
        /// Returns the proper string value of this fraction, reducing fractions if it can be done.  Returns just the whole number if the numerator is 0.
        /// </summary>
        /// <returns>WholeNumber Numerator/Denominator</returns>
        public string ToReducedString() {
            Fraction x = Fraction.Reduce(this);
            int n = x.Numerator;
            int d = x.Denominator;

            if(n < d)
                return x.ToString();

            int wholes = n / d;
            int parts = n % d;

            if(parts.Equals(0))
                return wholes.ToString();
            else
                return string.Format("{0} {1}/{2}", wholes, parts, d);
        }
        #endregion

        #region  Properties
        /// <summary>
        /// This fraction's numerator.
        /// </summary>
        public int Numerator {
            get {
                return _num;
            }
        }
        /// <summary>
        /// This fraction's denominator.
        /// </summary>
        public int Denominator {
            get {
                return _den;
            }
        }
        /// <summary>
        /// The greatest common factor of the numerator and denominator.
        /// </summary>
        public int GCF {
            get {
                return Fraction.GreatestCommonFactor(this);
            }
        }
        /// <summary>
        /// Returns a float representing the numerator divided by the denominator.  You can also explicitly cast this fraction as a float.
        /// </summary>
        public float Value {
            get {
                return (float)_num / (float)_den;
            }
        }
        #endregion
    }
}