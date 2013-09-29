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

-(id) init;

-(void) parseTrigramsWithString:(NSString *)string;

-(NSString*) addBlanckspceToPuntuationInString:(NSString *) string;
@end
