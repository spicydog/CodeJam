//
//  main.m
//  ProblemD-DeceitfulWar
//
//  Created by Spicydog Proxy on 4/12/14.
//  Copyright (c) 2014 Spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>


NSString *directoryPath = @"/Users/spicydog/Development/OS X/Google Code Jam 2014/ProblemD-DeceitfulWar/Files/";

NSString *fileName = @"D-large";

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

NSMutableArray* removeFirstElement(NSMutableArray *array)
{
    [array removeObjectAtIndex:0];
    return array;
}

NSMutableArray* removeLastElement(NSMutableArray *array)
{
    [array removeLastObject];
    return array;
}

NSMutableArray* removeElementAtIndex(NSMutableArray *array,int index)
{
    [array removeObjectAtIndex:index];
    return array;
}

int playWar(NSMutableArray *blocks1, NSMutableArray *blocks2)
{
    
    // blocks1 always show the highest value
    // blocks2 try to obtimize, if it can't win, don't waste, burn the smallest one
    
    int win = 0; // win of blocks1
    int n = (int)[blocks1 count];
    for (int turn=1; turn<n; turn++) {
        if( [blocks1[0] doubleValue] > [blocks2[0] doubleValue] ) {
            //blocks1 win
            blocks2 = removeLastElement(blocks2);
            blocks1 = removeFirstElement(blocks1);
            win++;
        } else {
            //blocks2 wins
            int i;
            for (i=0; i<[blocks2 count]; i++){
                if ([blocks2[i] doubleValue] < [blocks1[0] doubleValue]) {
                    blocks2 = removeElementAtIndex(blocks2, i-1);
                    break;
                }
            }
            blocks1 = removeFirstElement(blocks1);
        }
    }
    
    // Last one, just compare
    if( [blocks1[0] doubleValue] > [blocks2[0] doubleValue] )
        win+=1;
    
    return win;
}


int playDeceitfulWar(NSMutableArray *blocks1, NSMutableArray *blocks2)
{
    
    int win = 0; // win of blocks1
    int n = (int)[blocks1 count];
    
    
    for (int turn=1; turn<n; turn++) {
        
        if( [blocks1[0] doubleValue] > [blocks2[0] doubleValue] ) {
            //blocks1 win
            blocks2 = removeFirstElement(blocks2);
            blocks1 = removeFirstElement(blocks1);
            win++;
            
        } else {
            blocks2 = removeFirstElement(blocks2);
            blocks1 = removeLastElement(blocks1);
        }
        
    }
    
    // Last one, just compare
    if( [blocks1[0] doubleValue] > [blocks2[0] doubleValue] )
        win+=1;
    
    return win;
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
            
            // Process input
            int startLine = caseNo*3+2;
            
            NSArray *row1 = [lines[startLine+0] componentsSeparatedByString:@" "];
            NSArray *row2 = [lines[startLine+1] componentsSeparatedByString:@" "];
            
            NSMutableArray *tempRow1 = [[NSMutableArray alloc] init];
            NSMutableArray *tempRow2 = [[NSMutableArray alloc] init];
            for (int i=0; i<[row1 count]; i++) {
                [tempRow1 addObject: [NSNumber numberWithFloat:[row1[i] floatValue]]];
                [tempRow2 addObject: [NSNumber numberWithFloat:[row2[i] floatValue]]];
            }
            
            
            // Sort with high values first
            NSArray *naomiBlocks = [[[tempRow1 sortedArrayUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects];
            NSArray *kenBlocks = [[[tempRow2 sortedArrayUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects];
            
            // Compute
            int war = playWar( [[NSMutableArray alloc] initWithArray:naomiBlocks],
                               [[NSMutableArray alloc] initWithArray:kenBlocks]);
            
            
            int deceitfulWar = playDeceitfulWar([[NSMutableArray alloc]
                                                  initWithArray:naomiBlocks],
                                                [[NSMutableArray alloc]
                                                  initWithArray:kenBlocks]);
            
            
            
            
            
            
            // Output
            [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %d %d\n",caseNo+1,deceitfulWar,war]];
            
            
        }
        
        writeFile(finalAnswer);
        
    }
    return 0;
}