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

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottom;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MPEmojiKeyboard";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
}

- (IBAction)buttonDidClicked:(UIButton *)sender
{
    [self.textView becomeFirstResponder];
    sender.selected = !sender.selected;
    if(self.textView.emojiKeyboard){
        [self.textView switchToDefaultKeyboard];
    }
    else{
        MPEmojiKeyboard *keyboard = [MPEmojiKeyboardBuilder sharedKeyboard];
        [_textView switchToEmojiKeyboard:keyboard];
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary*info=[notification userInfo];
    CGFloat keyboardY=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;
    CGFloat keyboardAnimatoin = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    _inputViewBottom.constant = screenHeight - keyboardY;
    [UIView animateWithDuration:keyboardAnimatoin animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

@end
