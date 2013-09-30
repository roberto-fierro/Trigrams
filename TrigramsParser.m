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
            [[self.trigramsDictionary objectForKey:trigram.key] addAdjacentWord:[words objectAtIndex:index+2]];
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

-(NSString*) generateText{
    NSString *key = @"";
    int wordsToAppend = 0;
    NSString *generatedText = [self validateStarterKeyByAppendingString:@""];
    key = self.starterKey;
    Trigram *trigram = [self.trigramsDictionary objectForKey:self.starterKey];
    while (wordsToAppend <= 2000){
        if(trigram == nil){
            generatedText = [self validateStarterKeyByAppendingString:generatedText];
            key = self.starterKey;
            trigram = [self.trigramsDictionary objectForKey:self.starterKey];
        }
        NSString *word = [trigram getAdjacentWord];
        if([self validatePunctuationSignInKey:word AtWord:FIRST_WORD]){
            generatedText = [generatedText stringByAppendingString:word];
        } else{
            generatedText = [generatedText stringByAppendingString:@" "];
            generatedText = [generatedText stringByAppendingString:word];
        }
        key = [self getNextKeyWithWord:word AndTrigram:trigram];
        trigram = [self.trigramsDictionary objectForKey:key];
        wordsToAppend++;
    }
    
    return generatedText;
}

-(NSString*) validateStarterKeyByAppendingString:(NSString*)generatedText{
    if([self validatePunctuationSignInKey:self.starterKey AtWord:FIRST_WORD]){
        NSArray *keyWords = [self.starterKey componentsSeparatedByString:@" "];
        generatedText = [generatedText stringByAppendingString:[keyWords objectAtIndex:SECOND_WORD]];
    } else{
        if([self validatePunctuationSignInKey:self.starterKey AtWord:SECOND_WORD]){
            NSArray *keyWords = [self.starterKey componentsSeparatedByString:@" "];
            generatedText = [generatedText stringByAppendingString:[keyWords objectAtIndex:FIRST_WORD]];
            generatedText = [generatedText stringByAppendingString:[keyWords objectAtIndex:SECOND_WORD]];
        } else{
            generatedText = [generatedText stringByAppendingString:self.starterKey];
        }
    }
    return generatedText;
}

-(NSString *) getNextKeyWithWord:(NSString *)word AndTrigram:(Trigram*)trigram{
    NSString *newFirstWord = [[trigram.key componentsSeparatedByString:@" "] objectAtIndex:SECOND_WORD];
    NSString *newKey = [newFirstWord stringByAppendingString:@" "];
    return [newKey stringByAppendingString:word];
}

-(BOOL) validatePunctuationSignInKey:(NSString*) key AtWord:(int) wordIndex{
    NSString *firstWord = [[key componentsSeparatedByString:@" "] objectAtIndex:wordIndex];
    if([firstWord length] > 0){
        NSString * firstLetter = [firstWord substringToIndex:1];
        if([firstLetter isEqualToString:@"."] ||
           [firstLetter isEqualToString:@";"] ||
           [firstLetter isEqualToString:@":"] ||
           [firstLetter isEqualToString:@","]){
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}


@end
