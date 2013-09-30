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

//generate new text based on a dictionary of trigrams
-(NSString*) generateTextWithTrigramsDictionary:(NSDictionary*)trigramsDictionary{
    NSString *key = @"";
    //currently fixed to 2000 words
    //TODO: let the user to define the amount of words to generate.
    int wordsToAppend = 2000;
    //We generate the text by appending the initial key
    NSString *generatedText = [self stringByAppendingStarterKey:@""];
    key = self.starterKey;
    //get the first trigram from dictionary
    Trigram *trigram = [trigramsDictionary objectForKey:self.starterKey];
    while (wordsToAppend >= 0){
        //if the trigram doesn't exist we start again by selecting the starter
        //key
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

//Appends the starter key to the generated text.

-(NSString*) stringByAppendingStarterKey:(NSString*)generatedText{
    //if key's first word is a punctuation sign only appends the second word.
    if([self validatePunctuationSignInKey:self.starterKey AtWord:FIRST_WORD]){
        NSArray *keyWords = [self.starterKey componentsSeparatedByString:@" "];
        generatedText = [generatedText stringByAppendingString:[keyWords objectAtIndex:SECOND_WORD]];
    } else{
        //If key's second word is a punctuation sign, appends the first and
        //second word without space
        if([self validatePunctuationSignInKey:self.starterKey AtWord:SECOND_WORD]){
            NSArray *keyWords = [self.starterKey componentsSeparatedByString:@" "];
            generatedText = [generatedText stringByAppendingString:[keyWords objectAtIndex:FIRST_WORD]];
            generatedText = [generatedText stringByAppendingString:[keyWords objectAtIndex:SECOND_WORD]];
        } else{
            //just appends the key
            generatedText = [generatedText stringByAppendingString:self.starterKey];
        }
    }
    return generatedText;
}

//obtains and returns the next key that are generated from the key's second word
//of the trigram and the trigram's selected adjacent word
-(NSString *) getNextKeyWithWord:(NSString *)word AndTrigram:(Trigram*)trigram{
    NSString *newFirstWord = [[trigram.key componentsSeparatedByString:@" "] objectAtIndex:SECOND_WORD];
    NSString *newKey = [newFirstWord stringByAppendingString:@" "];
    return [newKey stringByAppendingString:word];
}

//Validate if a word in the key has a punctuation sgin 
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
