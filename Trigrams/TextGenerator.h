//
//  TextGenerator.h
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/29/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextGenerator : NSObject
@property (strong, nonatomic) NSString *starterKey;

-(NSString*) generateTextWithTrigramsDictionary:(NSDictionary*)trigramsDictionary;
@end
