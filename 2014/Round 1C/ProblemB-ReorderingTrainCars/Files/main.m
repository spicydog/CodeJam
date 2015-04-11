//
//  main.m
//  ProblemB-ReorderingTrainCars
//
//  Created by Spicydog Proxy on 5/11/14.
//  Copyright (c) 2014 spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>


NSArray* generateTruthTable(int size);

NSString *directoryPath = @"";

NSString *fileName = @"B-small-attempt1";

NSString* readFile()
{

    NSString *filePath = [NSString stringWithFormat:@"%@%@.in",directoryPath,fileName];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSData *databuffer = [filemgr contentsAtPath: filePath ];
    NSString* content = [NSString stringWithUTF8String:[databuffer bytes]];
    return  content;
}

void writeFile(NSString* content)
{
    NSString *filePath = [NSString stringWithFormat:@"%@%@.out",directoryPath,fileName];

    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}




NSArray* generatePermutation(int size)
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<size; i++) {
        [array addObject:[NSNumber numberWithInteger:i]];
    }


    NSMutableArray *permutations = nil;

    int i = 0;
    for (i = 0; i < array.count ; i++){

        if (!permutations){
            permutations = [NSMutableArray array];
            for (NSString *character in array){
                [permutations addObject:[NSArray arrayWithObject:character]];
            }

        } else {

            //make copy of permutations array and clean og array
            NSMutableArray *aCopy = [permutations copy];
            [permutations removeAllObjects];

            for (NSString *character in array){

                //loop through the copy
                for (NSArray *oldArray in aCopy){

                    //check if old string contains looping char..
                    if ([oldArray containsObject:character] == NO){

                        //update array
                        NSMutableArray *newArray = [NSMutableArray arrayWithArray:oldArray];
                        [newArray addObject:character];

                        //add to permutations
                        [permutations addObject:newArray];

                    }

                }
            }
        }
    }


    return permutations;

}




int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSMutableString *finalAnswer = [[NSMutableString alloc] init];


        NSMutableDictionary *savedPermutation = [[NSMutableDictionary alloc] init];

        // Input
        NSString *input = readFile();
        NSArray *lines = [input componentsSeparatedByString:@"\n"];

        int T = [lines[0] intValue];

        for (int caseNo=0; caseNo<T; caseNo++)
        {

            NSString *line = lines[(caseNo+1) *2];
            NSArray *trains = [[NSArray alloc] initWithArray:[line componentsSeparatedByString:@" "]];
            NSMutableArray *optimizedTrains = [[NSMutableArray alloc] init];

            for (NSString *train in trains) {
                char lastChar = [train characterAtIndex:0];
                NSMutableString *temp = [[NSMutableString alloc] init];
                [temp appendString:[NSString stringWithFormat:@"%c",lastChar]];
                for (int i=1; i<[train length]; i++) {
                    char thisChar = [train characterAtIndex:i];
                    if (thisChar!=lastChar) {
                        [temp appendString:[NSString stringWithFormat:@"%c",thisChar]];
                        lastChar = thisChar;
                    }

                }
                [optimizedTrains addObject:temp];
            }


            int size = (int)[trains count];
            NSArray *permutations = [savedPermutation objectForKey:[NSNumber numberWithInteger:size]];

            if ( permutations == nil ) {
                permutations = [[NSMutableArray alloc] initWithArray:generatePermutation(size)];
                [savedPermutation setObject:permutations forKey:[NSNumber numberWithInteger:size]];
            }

            int sumPossible = 0;
            for (NSArray *permutation in permutations) {

                NSMutableString *temp = [[NSMutableString alloc] init];

                bool marks[200];
                for (int i=0; i<200; i++) {
                    marks[i] = FALSE;
                }

                for (int i=0; i<[permutation count]; i++) {
                    [temp appendString:optimizedTrains[[permutation[i] intValue]]];
                }


                bool possible = TRUE;
                char lastChar = ' ';
                for (int i=0; i<[temp length]; i++) {
                    char thisChar = [temp characterAtIndex:i];
                    if ( lastChar != thisChar ) {
                        if (marks[thisChar]==TRUE) {
                            possible = FALSE;
                            break;
                        }
                        marks[lastChar] = TRUE;
                        lastChar = thisChar;
                    }
                }

                if (possible) {
                    sumPossible++;
                }


            }

            [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %d\n",caseNo+1,sumPossible]];


        }

        writeFile(finalAnswer);
        NSLog(@"%@",finalAnswer);

    }
    return 0;
}

