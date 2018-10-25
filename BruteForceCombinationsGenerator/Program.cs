using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BruteForceCombinationsGenerator
{
    class Program
    {
        static List<string> passwords = new List<string>();
        static void Main(string[] args)
        {
            Generate(5);
        }

        public const string CHARACTERS = "abcdefghijklmnopqrstuvwxyz";

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
    }
}
