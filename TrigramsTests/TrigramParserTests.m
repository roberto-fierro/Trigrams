//
//  TrigramParserTests.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TrigramParserTests.h"
#import "TrigramsReader.h"
#import "TrigramsParser.h"
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
    NSString *fileName = @"book1";
    TrigramsReader *reader = [[TrigramsReader alloc] init];
    NSArray *paragraphs = [reader readTrigramsFromFileName:fileName];
    TrigramsParser *parser = [[TrigramsParser alloc] init];
    STAssertNotNil(parser.trigramsDictionary, @"Something happen while accessing dictionary %@", parser.trigramsDictionary);
    [paragraphs enumerateObjectsUsingBlock:^(id anObject, NSUInteger idx, BOOL *stop) {
        NSString *paragraph = (NSString*)anObject;
        [parser parseTrigramsWithString:paragraph];
    }];
    STAssertNotNil(parser.trigramsDictionary, @"Something happen while accessing dictionary %@", parser.trigramsDictionary);
    
    [parser.trigramsDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        STAssertNotNil(object, @"Something happen while accessing object %@", object);
        NSLog(@"%@",object);
        
    }];
}

-(void) testAddingBlanckspceToPuntuationInString{
    NSString *fileName = @"book1 test";
    TrigramsReader *reader = [[TrigramsReader alloc] init];
    NSArray *paragraphs = [reader readTrigramsFromFileName:fileName];
    TrigramsParser *parser = [[TrigramsParser alloc] init];
    
    [paragraphs enumerateObjectsUsingBlock:^(id anObject, NSUInteger idx, BOOL *stop) {
        NSString *paragraph = (NSString*)anObject;
        NSLog(@"%@",[parser addBlanckspceToPuntuationInString:paragraph]);
    }];
}


@end
