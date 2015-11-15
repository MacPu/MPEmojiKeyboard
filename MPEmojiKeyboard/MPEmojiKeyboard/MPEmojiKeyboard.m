//
//  MPEmojiKeyboard.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboard.h"

@interface UIResponder (WriteableInputView)
@property (readwrite, retain) UIView *inputView;
@end

#define kMPDefaultChangeToDefaultKeyboardNotification @"PPYExpresstionKeyboardDidSwitchToDefaultKeyboardNotification"
#define kMPDefaultKeyboardDefaultSize  CGSizeMake(320,216)
#define kMPDefaultKeyboardToolsViewDefaultHeight 45.0f
#define kMPDefaultMaxDeleteButtonSize CGSizeMake(30,30)

@implementation MPEmojiKeyboard


@end
