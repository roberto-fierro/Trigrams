//
//  TrigramsReaderTests.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/28/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TrigramsReaderTests.h"
#import "TrigramsReader.h"

@implementation TrigramsReaderTests

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
    TrigramsReader *reader = [[TrigramsReader alloc] init];
    NSArray *paragraphs = [reader readTrigramsFromFileName:fileName];
    STAssertNotNil(paragraphs, @"Something happen trying to read the file %@", fileName);
    
}

- (void) testReadTrigramsFromFileNameHasAtLeastOneParagraph {
    NSString *fileName = @"test kata";
    TrigramsReader *reader = [[TrigramsReader alloc] init];
    NSArray *paragraphs = [reader readTrigramsFromFileName:fileName];
    STAssertTrue([paragraphs count] > 0, @"The file is empty? the count is %i", [paragraphs count]);
}

@end
