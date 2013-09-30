//
//  TrigramsParser.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TrigramsGenerator.h"
#import "Trigram.h"


@implementation TrigramsGenerator{
    NSNumber *lastCount;
    NSString *starterKey;
}

@synthesize trigramsDictionary = _trigramsDictionary;


-(id) init {
    self = [super init];
    if (self) {
        //NSLog(@"_init: %@", self);
        _trigramsDictionary = [[NSMutableDictionary alloc] init];
        lastCount = [NSNumber numberWithInt:0];
    }
    return(self);
}

//Quotes ('"'), parentheses ('(', ')') and new lines ('\r','\n') are ignored.
//? . , : ; are considered as words and are separated with a blank space
-(NSString*) parsePuntuationInString:(NSString *) string{
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

//Parse the string with parsePuntuationInString and returns an array of words by
//separating it with a blank spaces
-(NSArray *) getArrayOfWordsFromString:(NSString *) string{
    NSString *escapedString = [self parsePuntuationInString:string];
    return [escapedString componentsSeparatedByString:@" "];
}

//Received a paragrapgh from the original text and obtains all the trigrams that
//contained on it. Populate the trigrams dictionary and also saves the key with
//most of the ocurrences
-(void) generateTrigramsWithParagraph:(NSString *)paragraph{
    NSArray *words = [self getArrayOfWordsFromString:paragraph];
    if(words == nil || [words count] < 3){
        NSLog(@"There is a problem with this string %@", paragraph);
        return;
    }
    
    for(int index=0; index <= [words count]-3; index++){
        
        NSArray *trigramWords = [NSArray arrayWithObjects:[words objectAtIndex:index] , [words objectAtIndex:index+1], [words objectAtIndex:index+2],nil];
        
        Trigram *trigram = [[Trigram alloc] initWithWords:trigramWords];
        
        if( [self.trigramsDictionary objectForKey:trigram.key] ){
            [[self.trigramsDictionary objectForKey:trigram.key] addCount];
            [[self.trigramsDictionary objectForKey:trigram.key] addAdjacentWord:[words objectAtIndex:index+2]];
        } else {
            [trigram addCount];
            [self.trigramsDictionary setObject:trigram forKey:trigram.key];
        }
        
        //save key with most of the ocurrences
        trigram = (Trigram*)[self.trigramsDictionary objectForKey:trigram.key];
        int currentCountForKey = [[trigram count] integerValue];
        

        if(currentCountForKey > [lastCount integerValue]){
            lastCount = [NSNumber numberWithInt:currentCountForKey];
            starterKey = trigram.key;
        }

    }
}

// returns the trigram key that had the most ocurrences
-(NSString*) getStarterKey{
    return starterKey;
}




@end
