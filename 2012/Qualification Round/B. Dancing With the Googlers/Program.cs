using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CodeJam_2012___Problem_B.Dancing_With_the_Googlers
{
    class Program
    {
        static int[] getNormal(int total)
        {
            //Console.WriteLine(total.ToString());
            int[] score = new int[3];
            int i,rest;
            score[0] = score[1] = score[2] = Convert.ToInt32( Math.Floor( Convert.ToDouble(total) / 3 ) );
            rest = total - score[0] * 3;

            i = 0;
            while (rest > 0)
            {
                score[i] += 1;
                rest -= 1;
                i = +1;
                if (i > 3)
                    i = 0;
            }

            return score;
        }

        static int[] getSerprise(int total)
        {
            
            int[] score = getNormal(total);

            if (score[2] == 0 || score[0] == 10)
                return score;


            if (score[0] - score[2] == 0)
            {
                score[0] += 1;
                score[2] -= 1;
            }
            else
            {
                if (score[1] - score[2] != 0)
                {
                    score[0] += 1;
                    score[1] -= 1;
                }
            }

            return score;
        }

        static int getAnwser(int[] total,int s, int p)
        {
            int output = 0;
            var result = from element in total
                         orderby element descending
                         select element;

            foreach (var score in result)
            {
                int[] triplet = getNormal( Convert.ToInt32(score) );
                //Console.WriteLine(triplet[0].ToString());

                if (triplet[0] >= p)
                {
                    output += 1;
                    Console.WriteLine(score.ToString() + " = " + triplet[0].ToString() + " " + triplet[1].ToString() + " " + triplet[2].ToString());
                }
                else
                {
                    if (s > 0)
                    {
                        triplet = getSerprise(Convert.ToInt32(score));
                        if (triplet[0] >= p)
                        {
                            output += 1;
                            s -= 1;
                            Console.WriteLine(score.ToString() + " = " + triplet[0].ToString() + " " + triplet[1].ToString() + " " + triplet[2].ToString());
                        }
                        else
                        {
                            Console.WriteLine(score.ToString() + " = " + triplet[0].ToString() + " " + triplet[1].ToString() + " " + triplet[2].ToString());
                            break;
                        }
                    }
                    else
                    {
                        Console.WriteLine(score.ToString() + " = " + triplet[0].ToString() + " " + triplet[1].ToString() + " " + triplet[2].ToString());
                        break;
                    }
                }
            }

            return output;
        }

        static void Main(string[] args)
        {
            int i,j;
            string output = "";
            string[] input = System.IO.File.ReadAllLines(@"input.txt");
            System.IO.File.WriteAllText(@"output.txt", "");
            int t = Convert.ToInt32(input[0]);

            for (i = 0; i < t; i++)
            {

                output = "";
                output += "\n" + input[i + 1] + "\n";
                Console.Write(output);

                string[] param = input[i + 1].Split(' ');
                int n = Convert.ToInt32(param[0]);
                int s = Convert.ToInt32(param[1]);
                int p = Convert.ToInt32(param[2]);
                int[] total = new int[n];
                for (j = 0; j < n; j++)
                {
                    total[j] = Convert.ToInt32(param[j + 3]);
                }
                

                output = "Case #" + (i + 1) + ": ";
                output += getAnwser(total, s, p).ToString();
                output += "\n";
                Console.Write(output);

                System.IO.File.AppendAllText(@"output.txt", output);
            }
            Console.ReadKey();
        }
    }
}
