//
//  TextGenerator.m
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/29/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import "TextGeneratorTests.h"
#import "TextReader.h"
#import "TrigramsGenerator.h"
#import "Trigram.h"
#import "TextGenerator.h"

@implementation TextGeneratorTests


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


-(void) testGenerateText{
    NSString *fileName = @"book1";
    TextReader *reader = [[TextReader alloc] init];
    NSArray *paragraphs = [reader readTextFromFileName:fileName];
    TrigramsGenerator *parser = [[TrigramsGenerator alloc] init];
    [paragraphs enumerateObjectsUsingBlock:^(id anObject, NSUInteger idx, BOOL *stop) {
        NSString *paragraph = (NSString*)anObject;
        [parser generateTrigramsWithParagraph:paragraph];
    }];
    
    TextGenerator *generator = [[TextGenerator alloc] init];
    generator.starterKey = [parser getStarterKey];
    NSString *generatedText = [generator generateTextWithTrigramsDictionary:parser.trigramsDictionary];
    
    STAssertNotNil(generatedText, @"No generated text that's bad!!");
    
    NSLog(@"Generated text \n%@",generatedText);
}


@end
