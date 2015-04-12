using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CodeJam_2012___Problem_A.Speaking_in_Tongues
{
    class Program
    {
        static int assciOffet = 97;
        static int[] getFix()
        {
            int i;
            int[] fix;
            fix = new int[26];
            String a = "ejp mysljylc kd kxveddknmc re jsicpdrysi\nrbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd\nde kr kd eoya kw aej tysr re ujdr lkgc jv";
            String b = "our language is impossible to understand\nthere are twenty six factorial possibilities\nso it is okay if you want to just give up";
            a += "y qee" + "z";
            b += "a zoo" + "q";

            for (i = 0; i < a.Length; i++)
            {
                if (Char.IsLetter(a[i]))
                {
                    fix[((int)a[i] - assciOffet)] = ((int)b[i] - assciOffet);
                }
            }
            return fix;
            
        }

        static void Main(string[] args)
        {
            int i,j;
            int[] fix;
            string[] input = System.IO.File.ReadAllLines(@"input.txt");
            fix = getFix();
            string output = "";
            int n = Convert.ToInt32( input[0] );

            

            for (i = 0; i < n; i++)
            {
                string str = input[i + 1];

                output += "Case #"+(i+1)+": ";
                for (j = 0; j < str.Length; j++)
                {
                    if(Char.IsLower(str[j]) )
                        output +=  (char)( fix[(int)str[j] - assciOffet] + assciOffet);
                    else
                        output +=  str[j] ;
                }
                output +="\n" ;
            }

            Console.Write(output);
            System.IO.File.WriteAllText(@"output.txt", output);

            Console.Read();
            


        }
    }
}
