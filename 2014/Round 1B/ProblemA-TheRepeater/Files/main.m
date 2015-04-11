//
//  main.m
//  ProblemA-TheRepeater
//
//  Created by Spicydog Proxy on 5/3/14.
//  Copyright (c) 2014 Spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>

NSArray* generateTruthTable(int size);

NSString *directoryPath = @"";

NSString *fileName = @"A-large";

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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSMutableString *finalAnswer = [[NSMutableString alloc] init];

        // Input
        NSString*input = readFile();
        NSArray *lines = [input componentsSeparatedByString:@"\n"];

        int T = [lines[0] intValue];

        int nLine = 1;

        for (int caseNo=0; caseNo<T; caseNo++)
        {
            int N = [lines[nLine++] intValue];

            NSMutableArray *strings = [[NSMutableArray alloc] init];

            for (int i=0; i<N; i++) {
                [strings addObject:[[NSMutableString alloc] initWithString:lines[nLine++]]];
            }

            NSMutableArray *checkStrings =[[NSMutableArray alloc] init];
            NSMutableArray *numberOfChars =[[NSMutableArray alloc] init];

            for (int i=0; i<[strings count]; i++) {
                char last = ' ';
                NSMutableString *check = strings[i];
                NSMutableString *checkString = [[NSMutableString alloc] init];
                NSMutableArray *numberOfChar = [[NSMutableArray alloc] init];
                int thisChar = 0;
                for(int c=0;c<[check length];c++) {

                    if (last != [check characterAtIndex:c]) {
                        last = [check characterAtIndex:c];
                        [checkString appendFormat:@"%c",last];

                        if (c>0) [numberOfChar addObject:[NSNumber numberWithInt:++thisChar]];

                        thisChar = 0;
                    } else {
                        thisChar++;
                    }

                }
                [numberOfChar addObject:[NSNumber numberWithInt:++thisChar]];
                [numberOfChars addObject:numberOfChar];
                [checkStrings addObject:checkString];
            }


            bool impossible = FALSE;
            for (int i=0; i<[checkStrings count]-1; i++) {
                if (! [checkStrings[i] isEqualToString:checkStrings[i+1]] ) {
                    impossible = TRUE;
                }
            }

            int sum = 0;

            if (!impossible) {
                int len = (int)[checkStrings[0] length];
                for (int i=0; i<len; i++) {

                    int pivot[ [numberOfChars count] ];
                    for (int j=0; j<[numberOfChars count]; j++) {
                        pivot[j] = [numberOfChars[j][i] intValue];
                    }


                    int min = INT_MAX;

//                    int c=0;
//                    while (TRUE) {
//                        int check = 0;
//                        for (int j=0; j<[numberOfChars count]; j++) {
//                            check += abs(pivot[j]-c);
//                        }
//                        c++;
//                        if (check<min) {
//                            min = check;
//                        } else {
//                            break;
//                        }
//                    }

                    for (int c=1; c<=100; c++) {
                        int check = 0;
                        for (int j=0; j<[numberOfChars count]; j++) {
                            check += abs(pivot[j]-c);
                        }
                        if (check<min) {
                            min = check;
                        }
                    }
                    sum+=min;

                }
            } else {
                sum = -1;
            }


            NSString *answer = [[NSString alloc] init];

            if (sum >= 0) {
                answer = [NSString stringWithFormat:@"%d",sum];
            } else {
                answer = @"Fegla Won";
            }


            [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %@\n",caseNo+1,answer]];


        }

        writeFile(finalAnswer);
        NSLog(@"%@",finalAnswer);

    }
    return 0;
}


