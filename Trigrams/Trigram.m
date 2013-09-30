//
//  Trigram.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "Trigram.h"
#import <stdlib.h>

@implementation Trigram

@synthesize key = _key;
@synthesize adjacentWords = _adjacentWords;
@synthesize count = _count;

-(id) init {
    self = [super init];
    if (self) {
        return(self);
    }
    return nil;
}

// Initialize a trigram with a array of 3 words
-(id) initWithWords:(NSArray *) words{
    self = [self init];
    if([words count] != 3){
        NSLog(@"Three words exactly for a Trigram.");
    }
    _key = [self generateKeyWithWords:words];
    _adjacentWords = [[NSMutableArray alloc] init];
    _count = [NSNumber numberWithInt:0];
    [self.adjacentWords addObject:[words objectAtIndex:THIRD_WORD]];
    return(self);
}

-(NSString *) description{
    NSString *description = @"";
    description = [description stringByAppendingFormat:@"**** Trigram **** \nTrigram Key: %@\n",self.key];
    description = [description stringByAppendingFormat:@"Trigram Count: %@\nTrigram Adjacent Words:\n",self.count];
    for (NSString *word in self.adjacentWords) {
        description = [description stringByAppendingFormat:@"%@\n", word];
    }
    description = [description stringByAppendingString:@"\n**** End ****\n"];
    
    return description;
}

//Create the kwy for this trigram 
-(NSString*) generateKeyWithWords: (NSArray*)words{
    NSString *key = [NSString stringWithFormat: @"%@ %@", [words objectAtIndex:FIRST_WORD], [words objectAtIndex:SECOND_WORD]];
    return key;
}

//The third word on the initWithWords array is the adjacent word, it is save it
//in adjacentWords array
-(void) addAdjacentWord:(NSString *)word{
    [self.adjacentWords addObject:word];
}

//Selects randomly a adjacent word 
-(NSString*) getAdjacentWord{
    int randomNumber = arc4random() % [self.adjacentWords count];
    return [self.adjacentWords objectAtIndex:randomNumber];
}

//Add 1 to the count of occurrences of this key in the text
-(void) addCount {
    int value = [_count intValue];
    _count = [NSNumber numberWithInt:value + 1];
}




@end
