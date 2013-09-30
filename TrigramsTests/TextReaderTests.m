//
//  TrigramsReaderTests.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TextReaderTests.h"
#import "TextReader.h"

@implementation TextReaderTests

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

- (void) testReadTrigramsFromFileName {
    NSString *fileName = @"test kata";
    TextReader *reader = [[TextReader alloc] init];
    NSArray *paragraphs = [reader readTextFromFileName:fileName];
    STAssertNotNil(paragraphs, @"Something happen trying to read the file %@", fileName);
    
}

- (void) testReadTrigramsFromFileNameHasAtLeastOneParagraph {
    NSString *fileName = @"test kata";
    TextReader *reader = [[TextReader alloc] init];
    NSArray *paragraphs = [reader readTextFromFileName:fileName];
    STAssertTrue([paragraphs count] > 0, @"The file is empty? the count is %i", [paragraphs count]);
}

@end
