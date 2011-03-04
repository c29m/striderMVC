using System;
using System.Security.Cryptography;
using System.Collections.Generic;
using System.Text;
using System.Linq;

namespace Utilities.Misc {
    public class RandomKey {
        #region - Constants -
        const string ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const string DIGIT = "1234568790";
        const string OTHER = "!@#$%^&*-+";
        const int MAX_KEY_LENGTH = 24;
        #endregion

        #region - Instance Variables -
        bool _mustHaveDigit, _mustHaveOther, _incDigit, _incOther;
        #endregion

        #region - Constructor -
        /// <summary>
        /// Initializes a new RandomKey class with a key length of 8.
        /// </summary>
        public RandomKey()
            : this(8) {
        }
        /// <summary>
        /// Initializes a new RandomKey class with a given key length, with a max length of 24.
        /// </summary>
        /// <param name="KeyLength">Length of generated keys</param>
        public RandomKey(int KeyLength) {            
            _mustHaveDigit = _mustHaveOther = true;
            _incDigit = _incOther = true;
            
            this.KeyLength = KeyLength;
            if(this.KeyLength > MAX_KEY_LENGTH)
                this.KeyLength = MAX_KEY_LENGTH;
        }
        #endregion

        #region - Methods -
        public override string ToString() {
            return "Random Key Generator";
        }
        char[] getAvailableChars() {
            var charSet = new List<char>(
                ALPHA.ToCharArray().Union(ALPHA.ToLower().ToCharArray())
            );

            if(_incDigit)
                charSet.AddRange(DIGIT.ToCharArray());
            if(_incOther)
                charSet.AddRange(OTHER.ToCharArray());

            return charSet.ToArray();
        }
        /// <summary>
        /// Generates a random key.
        /// </summary>
        public KeyHash Obtain() {            
            bool valid;
            char[] key, available = getAvailableChars();
            Random r = new Random();

            do {
                key = available.OrderBy(c => r.Next(0, available.Length)).Take(KeyLength).ToArray();
                valid = (RequireDigit ? key.Any(c => Char.IsDigit(c)) : true) && (RequireOther ? key.Any(c => !Char.IsLetterOrDigit(c)) : true);
            } while(!valid);

            return new KeyHash(new string(key));
        }
        #endregion

        #region - Properties -
        /// <summary>
        /// Gets and sets whether or not a generated key has to contain at least 1 digit.  If set to true, sets IncludeDigits to true
        /// </summary>
        public bool RequireDigit {
            get {
                return _mustHaveDigit;
            }
            set {
                if(value)
                    IncludeDigits = true;
                _mustHaveDigit = value;
            }
        }
        /// <summary>
        /// Gets and sets whether or not a generated key has to contain at least 1 'other' character.  If set to true, sets IncludeOther to true.
        /// </summary>
        public bool RequireOther {
            get {
                return _mustHaveOther;
            }
            set {
                if(value)
                    IncludeOthers = true;
                _mustHaveOther = value;
            }
        }
        /// <summary>
        /// Gets and sets whether or not to include digits in the key.  If set to false, sets RequireDigits to false.
        /// </summary>
        public bool IncludeDigits {
            get {
                return _incDigit;
            }
            set {
                if(!value && _mustHaveDigit)
                    _mustHaveDigit = false;
                _incDigit = value;
            }
        }
        /// <summary>
        /// Gets and sets whether or not to include 'other' characters in a key.  If set to false, sets RequireOther to false.
        /// </summary>
        public bool IncludeOthers {
            get {
                return _incOther;
            }
            set {
                if(!value && _mustHaveOther)
                    _mustHaveOther = false;
                _incOther = value;
            }
        }
        /// <summary>
        /// Gets and sets the length of generated keys.
        /// </summary>
        public int KeyLength {
            get;
            set;
        }
        #endregion
    }

    public class KeyHash {
        #region - Constructor -
        internal KeyHash(string rndKey) {
            if(rndKey == null)
                throw new Exception("Key cannot be null.");
            Value = rndKey;
            MD5 = getHash("MD5");
            SHA1 = getHash("SHA1");
        }
        #endregion

        #region - Methods -
        /// <summary>
        /// Returns the unhashed generated key.
        /// </summary>
        /// <returns></returns>
        public override string ToString() {
            return Value;
        }
        string getHash(string type) {
            try {
                HashAlgorithm hogger = HashAlgorithm.Create(type);
                StringBuilder sb = new StringBuilder();

                byte[] hash = hogger.ComputeHash(Encoding.UTF8.GetBytes(Value));
                for(int i = 0; i < hash.Length; i++)
                    sb.Append(hash[i].ToString("x2"));

                return sb.ToString();
            } catch {
                return null;
            }
        }
        #endregion

        #region - Properties -
        /// <summary>
        /// Gets a custom hash based on a hash type, or null if the hash type is not recognized.
        /// </summary>
        /// <param name="HashType">MD5, SHA, SHA1, SHA256, SHA384, SHA512</param>
        /// <returns></returns>
        public string this[string HashType] {
            get {
                return getHash(HashType);
            }
        }

        /// <summary>
        /// Gets the plain-text generated key.
        /// </summary>
        public string Value {
            get;
            private set;
        }
        /// <summary>
        /// Gets the MD5 hash of the generated key.
        /// </summary>
        public string MD5 {
            get;
            private set;
        }
        /// <summary>
        /// Gets the SHA1 hash of the generated key.
        /// </summary>
        public string SHA1 {
            get;
            private set;
        }        
        #endregion
    }
}
