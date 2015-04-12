using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CodeJam_2012___Problem_C.Recycled_Numbers
{
    class Program
    {
        static long countRecycledNumbers(long a, long b)
        {
            long i, j;
            long output = 0;
            for (i = a; i <= b; i++)
            {
                for (j = i + 1; j <= b; j++)
                {

                    if (isRecycledNumber(i.ToString(), j.ToString()))
                    {
                        //Console.WriteLine(a + "-" + b + "\t" + i + " " + j);
                        output++;
                    }
                }
            }

            Console.WriteLine(a + "-" + b + " : " + output);

            return output;
        }

        static bool isRecycledNumber(string a, string b)
        {
            
            if (a.Length != b.Length)
                return false;

            for (int k = 0; k < a.Length; k++)
            {
                if (a.IndexOf(b[k].ToString()) == -1)
                {
                    return false;
                }
            }


            for (int i = 0; i < a.Length; i++)
            {
                b = moveForward(b);
                if (a[0] == b[0])
                    if (a == b)
                        return true;
            }
            return false;
        }

        static string moveForward(string str)
        {
            int i;
            string output = "";
            for (i = 1; i < str.Length; i++)
            {
                output += str[i];
            }
            output += str[0];

            return output;
        }


        static void Main(string[] args)
        {

            long i;

            string output = "";


            string[] input = System.IO.File.ReadAllLines(@"input.txt");
            System.IO.File.WriteAllText(@"output.txt", "");

            long n = Convert.ToInt64(input[0]);


            for (i = 0; i < n; i++)
            {

                string[] ab = input[i + 1].Split(' ');
                output = "Case #" + (i + 1) + ": ";

                long o = countRecycledNumbers(Convert.ToInt64(ab[0]), Convert.ToInt64(ab[1]));
                output += o;
                System.IO.File.AppendAllText(@"output.txt", output + "\n");

            }


        }
    }
}
