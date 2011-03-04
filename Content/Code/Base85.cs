using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Test.Misc {
    public static class ASCII85 {
        const int LINE_BREAK_POS = 80;

        /// <summary>
        /// Converts a byte array to an ASCII85 string.
        /// </summary>
        /// <param name="data">Data to convert</param>
        /// <param name="InsertLineBreaks">If true, inserts a line break every 80 characters.</param>
        /// <returns></returns>
        public static string ConvertTo(byte[] Data, bool InsertLineBreaks) {
            StringBuilder sb = new StringBuilder((int)(Data.Length * 1.25));
            sb.Append("<~");

            int charCount = sb.Length;
            for(int pos = 0; pos < Data.Length; pos += 4) {
                byte[] buffer = new byte[4];
                int bufferUsed = Math.Min(Data.Length - pos, 4);

                Array.Copy(Data, pos, buffer, 0, bufferUsed);

                uint val = (uint)((buffer[0] << 24) + (buffer[1] << 16) + (buffer[2] << 8) + buffer[3]);

                if(val > 0 || bufferUsed < 4) {
                    char[] ascii = new char[5];
                    for(int i = 4; i >= 0; i--) {
                        ascii[i] = (char)((val % 85) + 33);
                        val /= 85;
                    }
                    sb.Append(ascii, 0, bufferUsed + 1);
                    charCount += bufferUsed + 1;
                } else {
                    sb.Append("z");
                    charCount++;
                }

                if(InsertLineBreaks && charCount >= LINE_BREAK_POS) {
                    int goBack = charCount - LINE_BREAK_POS;
                    sb.Insert(sb.Length - goBack, "\n");
                    charCount = goBack;
                }
            }
            
            sb.Append("~>");
            return sb.ToString();
        }
        /// <summary>
        /// Converts a byte array to an ASCII85 string.
        /// </summary>
        /// <param name="data">Data to convert</param>
        /// <returns></returns>
        public static string ConvertTo(byte[] Data) {
            return ConvertTo(Data, false);
        }
        /// <summary>
        /// Converts an ASCII85 string to its original format.
        /// </summary>
        /// <param name="data">ASCII85 string</param>
        /// <returns></returns>
        public static byte[] ConvertFrom(string Data) {
            MemoryStream ms = new MemoryStream((int)(Data.Length / 1.25));
            uint[] pow85 = new uint[] { 0x31C84B1, 0x95EED, 0x1C39, 0x55, 0x1 };
            byte[] empty = new byte[4];
            uint val = 0, count = 0;
            bool processChar;

            for(int i = 0; i < Data.Length; i++) {
                char c = Data[i];
                switch(c) {
                    case 'z':
                        if(count != 0)
                            throw new Exception("'z' character illegal inside an encoded block.");
                        ms.Write(empty, 0, empty.Length);
                        processChar = false;
                        break;
                    case '<':
                        processChar = !(i == 0);
                        break;
                    case '>':
                        processChar = !(i == Data.Length - 1);
                        break;
                    case '~':
                        processChar = !(i == 1 || i == Data.Length - 2);
                        break;
                    case '\r':
                    case '\n':
                    case '\t':
                    case '\b':
                    case '\0':
                    case ' ':
                        processChar = false;
                        break;
                    default:
                        processChar = true;
                        break;
                }

                if(processChar) {
                    if(c < '!' || c > 'u')
                        throw new Exception("Decode failed; illegal character '" + c + "' at position " + i.ToString() + ".");

                    val += (uint)(c - '!') * pow85[count];
                    count++;

                    if(count == 5) {
                        for(int j = 0; j < 4; j++)
                            ms.WriteByte((byte)(val >> 24 - (j * 8)));
                        count = 0;
                        val = 0;
                    }
                }
            }

            if(count > 0) {
                if(count == 1)
                    throw new Exception("Final encoded block cannot be 1 character.");
                count--;
                val += pow85[count];

                for(int j = 0; j < count; j++)
                    ms.WriteByte((byte)(val >> 24 - (j * 8)));
            }

            //Regex regex = new Regex(@"(^<)?[\b\t\r\n\s~](>$)?");
            //Data = regex.Replace(Data, "");            

            //for(int pos = 0; pos < Data.Length; pos += 5) {
            //    if(Data[pos] == 'z') {
            //        byte[] buffer = new byte[5];
            //        ms.Write(buffer, 0, buffer.Length);
            //        pos -= 4;
            //    } else {
            //        int len = Math.Min(Data.Length - pos, 5);
            //        string encBlock = Data.Substring(pos, len) + new string('u', 5 - len);

            //        uint val = (uint)(
            //            (encBlock[0] - 33) * 52200625 +
            //            (encBlock[1] - 33) * 614125 +
            //            (encBlock[2] - 33) * 7225 +
            //            (encBlock[3] - 33) * 85 +
            //            (encBlock[4] - 33)
            //        );

            //        for(int i = 0; i < len - 1; i++)
            //            ms.WriteByte((byte)((val >> (24 - (i * 8))) & 0xFF));
            //    }
            //}

            return ms.ToArray();
        }
    }
}
