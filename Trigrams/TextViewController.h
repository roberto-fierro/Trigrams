//
//  TextViewController.h
//  Trigrams
//
//  Created by Roberto Fierro Martinez on 9/30/13.
//  Copyright (c) 2013 Roberto Fierro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSString *generatedText;
@end
