//
//  TrigramsReader.h
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextReader : NSObject

-(NSArray *)readTextFromFileName:(NSString*)fileName;
@end
