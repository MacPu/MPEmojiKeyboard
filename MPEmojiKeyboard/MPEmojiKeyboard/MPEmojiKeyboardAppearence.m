//
//  MPEmojiKeyboardAppearence.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/18.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardAppearence.h"

@implementation MPEmojiKeyboardAppearence

+ (instancetype)defaultAppearence
{
    MPEmojiKeyboardAppearence *appearence = [[MPEmojiKeyboardAppearence alloc] init];
    appearence.toolsViewHeight = 45.;
    appearence.backspaceImage = [UIImage imageNamed:@"mp_keyboard_backspace"];
    appearence.sendKeyTextColor = [UIColor whiteColor];
    appearence.sendKeyHightlightTextColor = [UIColor blackColor];
    appearence.sendKeyBackgroundColor = [UIColor blueColor];
    appearence.sendKeyString = @"Send";
    appearence.groupButtonBackgroundImage = nil;
    appearence.groupButtonTextColor = [UIColor grayColor];
    appearence.groupButtonSelectBackgroundImage = nil;
    appearence.groupButtonSelectTextColor = [UIColor whiteColor];
    return appearence;
}

@end
