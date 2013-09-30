//
//  TrigramsReader.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TextReader.h"

@implementation TextReader

// Read a txt file from Gutember Project and returns an array of the paragraph
//contained in the text, paragraph are obtained spliting the string with DOS
//line endings
-(NSArray *)readTextFromFileName:(NSString*)fileName{
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
