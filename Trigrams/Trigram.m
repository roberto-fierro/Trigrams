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
        NSLog(@"_init: %@", self);
    }
    return(self);
}

-(id) initWithWords:(NSArray *) words{
    self = [self init];
    if([words count] != 3){
        //Error Notification
        NSLog(@"Three words exactly for a Trigram.");
    }
    self.key = [self generateKeyWithWords:words];
    self.adjacentWords = [[NSMutableArray alloc] init];
    [self.adjacentWords addObject:words[2]];
    return(self);
}

-(NSString*) generateKeyWithWords: (NSArray*)words{
    NSString *key = [NSString stringWithFormat: @"%@ %@", words[0], words[1]];
    return key;
}

-(void) addAdjacentWord:(NSString *)word{
    [self.adjacentWords addObject:word];
}

-(NSString*) getAdjacentWord{
    int randomNumber = arc4random() % [self.adjacentWords count];
    return [self.adjacentWords objectAtIndex:randomNumber];
}

-(void) addCount {
    self.count++;
}



@end
