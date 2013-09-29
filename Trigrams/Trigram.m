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

-(id) initWithWords:(NSArray *) words{
    self = [self init];
    if([words count] != 3){
        //Error Notification
        NSLog(@"Three words exactly for a Trigram.");
    }
    _key = [self generateKeyWithWords:words];
    _adjacentWords = [[NSMutableArray alloc] init];
    _count = [NSNumber numberWithInt:0];
    [self.adjacentWords addObject:[words objectAtIndex:2]];
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

-(NSString*) generateKeyWithWords: (NSArray*)words{
    NSString *key = [NSString stringWithFormat: @"%@ %@", [words objectAtIndex:0], [words objectAtIndex:1]];
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
    int value = [_count intValue];
    _count = [NSNumber numberWithInt:value + 1];
}




@end
