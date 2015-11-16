//
//  ViewController.m
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/7/11.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import "ViewController.h"
#import "MPEmojiKeyboardBuilder.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textFile;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonDidClicked:(id)sender {
    MPEmojiKeyboard *keyboard = [MPEmojiKeyboardBuilder sharedKeyboard];
    [_textFile switchToEmojiKeyboard:keyboard];
}

@end
