/*
 ============================================================================
 Name        : .c
 Author      : 
 Version     :
 Copyright   : Your copyright notice
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int i, t;
    int seqs, push, currCase, time;
    int oSeq[100],bSeq[100];
    char teamSeq[100];
    int oSeqs, oTarget, oIndex, oPos;
    int bSeqs, bTarget, bIndex, bPos;

    scanf("%d", &time);

    for (currCase = 0; currCase < time; currCase++)
    {
    		bSeqs = 0;
            oSeqs = 0;

            //inputs
            scanf("%d", &seqs);

            for (i=0; i < seqs; i++)
            {
                    scanf(" %c", &teamSeq[i]);

                    if (teamSeq[i] == 'O')
                    {
                            scanf("%d", &oSeq[oSeqs]);
                            oSeqs++;
                    }

                    if (teamSeq[i] == 'B')
                    {
                            scanf("%d", &bSeq[bSeqs]);
                            bSeqs++;
                    }
            }
            //Compute
            i = 0;
            push = 0;
            oIndex = 0;
            bIndex = 0;
            oPos = 1;
            bPos = 1;


            for (t=0; i < seqs; t++)
            {
                    oTarget = oSeq[oIndex];
                    bTarget = bSeq[bIndex];

                    if (oIndex < oSeqs)
                    {
                            if (oPos != oTarget)
                            {
                                    if (oPos > oTarget)
                                            oPos--;
                                    else
                                            oPos++;

                            }
                            else
                            {
                                    if (teamSeq[i] == 'O' && push == 0)
                                    {
                                            oIndex++;
                                            push = 1;
                                    }
                            }
                    }

                    if (bIndex < bSeqs)
                    {
                            if (bPos != bTarget)
                            {
                                    if (bPos > bTarget)
                                            bPos--;
                                    else
                                            bPos++;
                             }
                            else
                            {

                                    if (teamSeq[i] == 'B' && push == 0)
                                    {
                                            bIndex++;
                                            push = 1;
                                    }
                            }
                    }

                    if (push == 1)
                    {
                            i++;
                            push = 0;
                    }
            }

            printf("Case #%d: %d\n", currCase + 1, t);
    }

    return 0;
}
