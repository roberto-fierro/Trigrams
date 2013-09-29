//
//  TrigramsReader.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TrigramsReader.h"

@implementation TrigramsReader


-(NSArray *)readTrigramsFromFileName:(NSString*)fileName{
    //All books will be txt files
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    // maybe for debugging...
    //NSLog(@"contents: %@", fileContents);
    
    NSArray *paragraphsArray = [fileContents componentsSeparatedByString:@"\r\n"];
    //NSLog(@"items = %d", [paragraphsArray count]);
    return paragraphsArray;
}

@end
