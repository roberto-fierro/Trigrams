//
//  TextGenerator.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/29/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TextGenerator.h"
#import "Trigram.h"

@implementation TextGenerator
@synthesize starterKey = _starterKey;

-(NSString*) generateTextWithTrigramsDictionary:(NSDictionary*)trigramsDictionary{
    NSString *key = @"";
    int wordsToAppend = 2000;
    NSString *generatedText = [self stringByAppendingStarterKey:@""];
    key = self.starterKey;
    Trigram *trigram = [trigramsDictionary objectForKey:self.starterKey];
    while (wordsToAppend >= 0){
        if(trigram == nil){
            generatedText = [generatedText stringByAppendingString:@" "];
            generatedText = [self stringByAppendingStarterKey:generatedText];
            key = self.starterKey;
            trigram = [trigramsDictionary objectForKey:self.starterKey];
        }
        NSString *word = [trigram getAdjacentWord];
        if([self validatePunctuationSignInKey:word AtWord:FIRST_WORD]){
            generatedText = [generatedText stringByAppendingString:word];
        } else{
            generatedText = [generatedText stringByAppendingString:@" "];
            generatedText = [generatedText stringByAppendingString:word];
        }
        key = [self getNextKeyWithWord:word AndTrigram:trigram];
        trigram = [trigramsDictionary objectForKey:key];
        wordsToAppend--;
    }
    
    return generatedText;
}

-(NSString*) stringByAppendingStarterKey:(NSString*)generatedText{
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
