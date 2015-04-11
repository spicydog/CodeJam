//
//  main.m
//  ProblemC-ProperShuffle
//
//  Created by Spicydog Proxy on 4/26/14.
//  Copyright (c) 2014 Spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>



NSString *directoryPath = @"";

NSString *fileName = @"C-small-attempt0";

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


            NSString* row = lines[caseNo*2+2];
            NSArray *data = [row componentsSeparatedByString:@" "];
            bool good = TRUE;
            for (int i=0; i<[data count]; i++) {
                NSString *temp = data[i];
                int number = [temp intValue];
                if (number == i) {
                    good = FALSE;
                }
            }


            if (good) {
                [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %@\n",caseNo+1,@"GOOD"]];
            } else {
                [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %@\n",caseNo+1,@"BAD"]];
            }


        }

        writeFile(finalAnswer);
        NSLog(@"%@",finalAnswer);

    }
    return 0;
}
