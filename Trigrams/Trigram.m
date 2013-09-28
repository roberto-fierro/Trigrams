//
//  Trigram.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "Trigram.h"


@implementation Trigram

@synthesize key = _key;
@synthesize adjacentWords = _adjacentWords;

-(id) init {
    self = [super init];
    if (self) {
        NSLog(@"_init: %@", self);
    }
    return(self);
}

-(id) initWithWords:(NSArray *) words{
    if([words count] != 3){
        //Error Notification
        NSLog(@"Three words exactly for a Trigram.");
    }
}

-(NSString*) generateKeyWithWords: (NSArray*)words{
    
}

@end
