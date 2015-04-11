//
//  main.m
//  ProblemC-MinesweeperMaster
//
//  Created by Spicydog Proxy on 4/13/14.
//  Copyright (c) 2014 Spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>



NSString *directoryPath = @"/Users/spicydog/Development/OS X/Google Code Jam 2014/ProblemC-MinesweeperMaster/Files/";

NSString *fileName = @"example";

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
        
        
        
        int r=5;
        int c=5;
        
        for (int i=1; i<=r; i++) {
            
        }
        
        
        
        
        
        
        
        
        
        
        
        // Input
        NSString *input = readFile();
        NSArray *lines = [input componentsSeparatedByString:@"\n"];
        
        int T = [lines[0] intValue];
        
        for (int caseNo=1; caseNo<=T; caseNo++) {
            
            NSArray *Case = [lines[caseNo] componentsSeparatedByString:@" "];
            
            int T = [Case[0] intValue];
            int R = [Case[1] intValue];
            int M = [Case[2] intValue];
            
            NSLog(@"%d %d %d",T,R,M);
            
            
            //[finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %.7f\n",caseNo,lastTotleSecodes]];
            
            
        }
        
        writeFile(finalAnswer);
        
    }
    return 0;
}
