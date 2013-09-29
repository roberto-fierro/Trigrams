//
//  TrigramsParser.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TrigramsParser.h"
#import "Trigram.h"

@implementation TrigramsParser

@synthesize trigramsDictionary = _trigramsDictionary;
@synthesize starterKey = _starterKey;
@synthesize lastCounter = _lastCounter;

-(id) init {
    self = [super init];
    if (self) {
        //NSLog(@"_init: %@", self);
        _trigramsDictionary = [[NSMutableDictionary alloc] init];
        _lastCounter = [NSNumber numberWithInt:0];
    }
    return(self);
}

-(NSString*) addBlanckspceToPuntuationInString:(NSString *) string{
    if([string isEqualToString:@"\r"] || [string length]==0){
        return nil;
    }
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"" options: NSRegularExpressionSearch range:NSMakeRange(0, string.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"(" withString:@"" options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@")" withString:@"" options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"\\?" withString:@" ?" options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"\\." withString:@" ." options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"," withString:@" ," options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@":" withString:@" :" options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@";" withString:@" ;" options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"\\s+" withString:@" " options: NSRegularExpressionSearch range:NSMakeRange(0, cleanString.length)];
    return cleanString;
}

-(NSArray *) arrayOfWordsFromString:(NSString *) string{
    NSString *escapedString = [self addBlanckspceToPuntuationInString:string];
    return [escapedString componentsSeparatedByString:@" "];
}

-(void) parseTrigramsWithString:(NSString *)string{
    NSArray *words = [self arrayOfWordsFromString:string];
    if(words == nil || [words count] < 3){
        NSLog(@"There is a problem with this string %@", string);
        return;
    }
    
    for(int index=0; index <= [words count]-3; index++){
        
        
        
        NSArray *trigramWords = [NSArray arrayWithObjects:[words objectAtIndex:index] , [words objectAtIndex:index+1], [words objectAtIndex:index+2],nil];
        
        Trigram *trigram = [[Trigram alloc] initWithWords:trigramWords];
        
        if( [self.trigramsDictionary objectForKey:trigram.key] ){
            [[self.trigramsDictionary objectForKey:trigram.key] addCount];
            [[self.trigramsDictionary objectForKey:trigram.key] addAdjacentWord:trigramWords[2]];
        } else {
            [trigram addCount];
            [self.trigramsDictionary setObject:trigram forKey:trigram.key];
        }
        
        trigram = (Trigram*)[self.trigramsDictionary objectForKey:trigram.key];
        int currentCountForKey = [[trigram count] integerValue];
        
        if(currentCountForKey > [self.lastCounter integerValue]){
            self.lastCounter = [NSNumber numberWithInt:currentCountForKey];
            self.starterKey = trigram.key;
        }
        
    }
    
    //NSLog(@"StarterKey is: %@",[self starterKey]);
    //NSLog(@"Biggest counter is: %@",[self lastCounter]);
}


@end
