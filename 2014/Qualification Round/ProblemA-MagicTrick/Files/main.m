//
//  main.m
//  ProblemA-MagicTrick
//
//  Created by Spicydog Proxy on 4/12/14.
//  Copyright (c) 2014 Spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *directoryPath = @"";

NSString *fileName = @"A-small-attempt0";

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
        NSString* input = readFile();
        NSArray *lines = [input componentsSeparatedByString:@"\n"];

        int T = [lines[0] intValue];

        for (int caseNo=0; caseNo<T; caseNo++)
        {

            // Process
            int startLine = 1+caseNo*10;

            int select1 = [lines[startLine] intValue];
            int select2 = [lines[startLine+5] intValue];

            NSArray *row1 = [lines[startLine+select1] componentsSeparatedByString:@" "];
            NSArray *row2 = [lines[startLine+select2+5] componentsSeparatedByString:@" "];


            // Compute
            int result = 0;
            int dup = 0;
            for (NSString *cardNo in row2) {
                if ([row1 containsObject:cardNo]) {
                    dup = [cardNo intValue];
                    result++;
                }
            }


            // Process
            NSString *answer;
            if(result>1)
                answer = @"Bad magician!";
            else if(result==0)
                answer = @"Volunteer cheated!";
            else
                answer = [NSString stringWithFormat:@"%d",dup];

            // Output
            [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %@\n",caseNo+1,answer]];


        }

        writeFile(finalAnswer);

    }
    return 0;
}
