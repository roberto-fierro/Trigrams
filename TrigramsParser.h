//
//  TrigramsParser.h
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrigramsParser : NSObject

@property (strong, nonatomic) NSMutableDictionary *trigramsDictionary;
@property (strong, nonatomic) NSString *starterKey;
@property (strong, nonatomic) NSNumber *lastCounter;

-(id) init;

-(void) parseTrigramsWithString:(NSString *)string;

-(NSString*) addBlanckspceToPuntuationInString:(NSString *) string;

@end
