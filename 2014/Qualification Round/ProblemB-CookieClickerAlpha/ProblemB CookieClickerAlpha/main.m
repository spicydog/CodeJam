//
//  main.m
//  ProblemB CookieClickerAlpha
//
//  Created by Spicydog Proxy on 4/12/14.
//  Copyright (c) 2014 Spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>



NSString *directoryPath = @"/Users/spicydog/Development/OS X/Google Code Jam 2014/ProblemB CookieClickerAlpha/Files/";

NSString *fileName = @"B-large";

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
        
        for (int caseNo=1; caseNo<=T; caseNo++) {
            
            NSArray *Case = [lines[caseNo] componentsSeparatedByString:@" "];
            
            double C = [Case[0] doubleValue];
            double F = [Case[1] doubleValue];
            double X = [Case[2] doubleValue];
            
            
            double target = X;
            double farmPrice = C;
            double prodectPerFarm = F;
            
            double initialProductPerSecond = 2;
            
            
            double secondForThisFarm = 0;
            double totalSeconds = 0;
            
            double productPerSecond = initialProductPerSecond;
            
            double lastTotleSecodes = INFINITY;
            
            double sum = 0;
            
            for (long nFarm = 0; ;nFarm++)
            {
                if(nFarm==0)
                    secondForThisFarm = 0;
                else
                    secondForThisFarm = farmPrice/productPerSecond;
                    
                sum += secondForThisFarm;
                productPerSecond = initialProductPerSecond + nFarm * prodectPerFarm;
                
                totalSeconds = sum + target/productPerSecond;
                
                if( lastTotleSecodes > totalSeconds )
                {
                    lastTotleSecodes = totalSeconds;
                }
                else
                {
                    break;
                }
                
            }
            
            [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %.7f\n",caseNo,lastTotleSecodes]];
            
            
        }
        
        writeFile(finalAnswer);
        
    }
    return 0;
}
