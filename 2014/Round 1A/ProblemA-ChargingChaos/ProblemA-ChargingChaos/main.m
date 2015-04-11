//
//  main.m
//  ProblemA-ChargingChaos
//
//  Created by Spicydog Proxy on 4/26/14.
//  Copyright (c) 2014 Spicydog. All rights reserved.
//

#import <Foundation/Foundation.h>

NSArray* generateTruthTable(int size);

NSString *directoryPath = @"/Users/spicydog/Development/OS X/Google Code Jam 2014/Round 1A/ProblemA-ChargingChaos/Files/";

NSString *fileName = @"A-large-practice";

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
            NSLog(@"%d",caseNo);
            
            // Process
            
            NSArray *row1 = [lines[caseNo*3+2] componentsSeparatedByString:@" "];
            NSArray *row2 = [lines[caseNo*3+3] componentsSeparatedByString:@" "];
            
            
            
            NSArray *truthTable = generateTruthTable( (int)[row1[0] length] );
            
            bool possible = false;
            int bestSwitch = INT_MAX;
            for (NSString *switchBit in truthTable) {
                
                NSLog(@"%@",switchBit);

                
                NSMutableArray *data1 = [[NSMutableArray alloc] initWithArray:row1];
                for (int l=0; l<[row1 count]; l++) {
                    NSString *ele = row1[l];
                    NSMutableString *temp = [[NSMutableString alloc] init];
                    for(int i=0;i<[ele length];i++) {
                        char currentChar = [ele characterAtIndex:i];
                        if ([switchBit characterAtIndex:i]=='1') {
                            if (currentChar=='1')
                            currentChar='0';
                            else
                            currentChar='1';
                        }
                        [temp appendFormat:@"%c",currentChar];
                    }
                    data1[l] = temp;
                }
                
                NSMutableArray *data2 = [[NSMutableArray alloc] initWithArray:row2];
                int countLeft = (int)[row1 count];
                for (NSString *compare in data1) {
                    if ([data2 containsObject:compare]) {
                        [data2 removeObjectAtIndex:[data2 indexOfObject:compare]];
                        countLeft--;
                    }
                }
                
                if (countLeft==0) {
                    possible = TRUE;
                    
                    int countOne = 0;
                    for (int i=0; i<[switchBit length]; i++) {
                        if ([switchBit characterAtIndex:i]=='1') {
                            countOne++;
                        }
                    }
                    
                    if (countOne<bestSwitch) {
                        bestSwitch = countOne;
                    }
                    if (bestSwitch<2) {
                        break;
                    }
                    
                    
                }

            }
            
            NSString *answer = [[NSString alloc] init];
            if (!possible) {
                answer = @"NOT POSSIBLE";
            } else {
                answer = [NSString stringWithFormat:@"%d",bestSwitch];
            }
            
            [finalAnswer appendString:[NSString stringWithFormat:@"Case #%d: %@\n",caseNo+1,answer]];
            
            
        }
        
        writeFile(finalAnswer);
        
        NSLog(@"%@",finalAnswer);
        
    }
    return 0;
}

NSArray* generateTruthTable(int size)
{
    NSArray *array = [NSArray arrayWithObjects:@"0",@"1", nil];
    NSMutableArray *permutations = nil;
    int i = 0;
    for (i = 0; i < size ; i++){
        
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
                    //if ([oldArray containsObject:character] == NO){
                    
                    //update array
                    NSMutableArray *newArray = [NSMutableArray arrayWithArray:oldArray];
                    [newArray addObject:character];
                    
                    //add to permutations
                    [permutations addObject:newArray];
                    
                    //}
                    
                }
            }
        }
        
    }
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSArray *temp in permutations) {
        [result addObject:[temp componentsJoinedByString:@""]];
    }

    return [NSArray arrayWithArray:result];

}



