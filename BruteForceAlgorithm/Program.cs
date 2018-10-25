using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace BruteForceAlgorithm
{
    class Program
    {
        //private static bool TestCallback(ref char[] testChars)
        //{
        //    var pw = new string(testChars);
        //    try
        //    {
        //        using (ZipFile archive = new ZipFile("Passwords.zip")
        //        {
        //            Password = pw,
        //            Encryption = EncryptionAlgorithm.WinZipAes256,
        //        })
        //        {
        //            archive.ExtractAll(@"c:\temp\", ExtractExistingFileAction.OverwriteSilently);
        //        }

        //        Console.WriteLine("Extracted with password {0}", pw);
        //        return true;
        //    }
        //    catch (BadPasswordException)
        //    {
        //        return false;
        //    }
        //}

        static List<string> passwords = new List<string>();

        public const string CHARACTERS = "snafu";

        public static void Generate(int length, string combination = "")
        {
            if (combination.Length == length)
            {
                passwords.Add(combination);
                return;
            }
            else
            {
                for (int i = 0; i < CHARACTERS.Length; i++)
                {
                    var test = combination;
                    test += CHARACTERS[i];
                    Generate(length, test);
                }
            }
        }

        private static int taskNumber = 0;
        private static bool stop = false;

        private static void Crack(ref int firstIdx, ref int lastIdx)
        {
            bool found = false;
            int number = ++taskNumber;
            string outputPath = $@"C:\temp\task{number}\";
            string[] filenames = new string[0];

            //Console.WriteLine("Task {2} running through {0} to {1}", firstIdx, lastIdx, number);

            if (!File.Exists("Passwords.zip"))
            {
                Console.WriteLine("could not find file");
                return;
            }
            if (!Directory.Exists(outputPath))
            {
                Directory.CreateDirectory(outputPath);
            }

            for (int i = firstIdx; i < lastIdx; i++)
            {
                if (stop)
                {
                    if (!found)
                    {
                        Directory.Delete(outputPath, true);
                    }
                    else
                    {
                        foreach (var file in Directory.GetFiles(outputPath))
                        {
                            File.Move(file, file.Replace($@"task{number}\", ""));
                        }
                        Directory.Delete(outputPath, true);
                    }
                    //Console.WriteLine("Task {1} finished {0}", DateTime.Now, number);
                    return;
                }
                try
                {
                    ZipFile archive = new ZipFile("Passwords.zip")
                    {
                        Password = passwords[i],
                        Encryption = EncryptionAlgorithm.WinZipAes256,
                        ExtractExistingFile = ExtractExistingFileAction.OverwriteSilently,
                    };

                    archive.ExtractAll(outputPath);
                    stop = true;
                    found = true; ;
                    Console.WriteLine("Task {1} found the password: {0}", passwords[i], number);
                }
                catch (BadPasswordException)
                {
                    continue;
                }
            }
        }

        static void Main(string[] args)
        {
            Generate(5);

            int c = passwords.Count / 5;

            for (int i = 0; i < passwords.Count; i += c)
            {
                int f = i;
                int l = f + c - 1;
                Task.Factory.StartNew(() => Crack(ref f, ref l));
            }


            Console.ReadLine();
        }
    }
}
