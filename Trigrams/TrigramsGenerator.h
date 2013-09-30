//
//  TrigramsParser.h
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrigramsGenerator : NSObject

@property (strong, nonatomic) NSMutableDictionary *trigramsDictionary;

-(id) init;

-(void) generateTrigramsWithParagraph:(NSString *)string;
-(NSString*) getStarterKey;

@end