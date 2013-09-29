//
//  Trigram.h
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trigram : NSObject

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSMutableArray *adjacentWords;
@property int *count;



-(id) init;

-(id) initWithWords:(NSArray *) words;
-(void) addAdjacentWord:(NSString *)word;
-(NSString*) getAdjacentWord;
-(void)addCount;

@end
