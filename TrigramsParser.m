//
//  TrigramsParser.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TrigramsParser.h"
#import "Trigram.h"

@implementation TrigramsParser{
    NSMutableDictionary *trigramsDictionary;
}

-(NSArray *) arrayOfWordsFromString:(NSString *) string{
    return [string componentsSeparatedByString:@" "];
}

-(void) parseTrigramsWithArrayOfWords:(NSArray *)words{
    if(words == nil || [words count] < 3){
        return;
    }
    
    for(int index=0; index < [words count]; index++){
        
        NSArray *trigramWords = [NSArray arrayWithObjects:words[index], words[index+1], words[index+2],nil];
        
        Trigram *trigram = [[Trigram alloc] initWithWords:trigramWords];
        
        if( [trigramsDictionary objectForKey:trigram.key] ){
            [[trigramsDictionary objectForKey:trigram.key] addCount];
            [[trigramsDictionary objectForKey:trigram.key] addAdjacentWord:trigramWords[2]];
        } else {
            [trigram addCount];
            [trigramsDictionary setObject:trigram forKey:trigram.key];
        }
        
    }
}




@end
