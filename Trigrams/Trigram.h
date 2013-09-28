//
//  Trigram.h
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trigram : NSObject

@property NSString *key;
@property NSMutableArray *adjacentWords;



-(id) init;

-(id) initWithWords:(NSArray *) words;

@end
