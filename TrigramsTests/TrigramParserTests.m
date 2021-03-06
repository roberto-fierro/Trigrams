//
//  TrigramParserTests.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TrigramParserTests.h"
#import "TextReader.h"
#import "TrigramsGenerator.h"
#import "Trigram.h"


@implementation TrigramParserTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void) testParsingTrigramsWithString{
    NSString *fileName = @"test kata";
    TextReader *reader = [[TextReader alloc] init];
    NSArray *paragraphs = [reader readTextFromFileName:fileName];
    TrigramsGenerator *parser = [[TrigramsGenerator alloc] init];
    STAssertNotNil(parser.trigramsDictionary, @"Something happen while accessing dictionary %@", parser.trigramsDictionary);
    [paragraphs enumerateObjectsUsingBlock:^(id anObject, NSUInteger idx, BOOL *stop) {
        NSString *paragraph = (NSString*)anObject;
        [parser generateTrigramsWithParagraph:paragraph];
    }];
    STAssertNotNil(parser.trigramsDictionary, @"Something happen while accessing dictionary %@", parser.trigramsDictionary);
    
    [parser.trigramsDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        STAssertNotNil(object, @"Something happen while accessing object %@", object);
        NSLog(@"%@",object);
        
    }];
}




@end
