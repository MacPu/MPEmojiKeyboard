//
//  MPEmojiKeyboardAppearence.h
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/18.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPEmojiKeyboardAppearence : NSObject

@property (nonatomic, strong) UIImage *backspaceImage;
@property (nonatomic, strong) UIColor *sendKeyBackgroundColor;
@property (nonatomic, strong) UIColor *sendKeyTextColor;
@property (nonatomic, strong) UIColor *sendKeyHightlightTextColor;
@property (nonatomic, copy) NSString *sendKeyString;
@property (nonatomic, strong) UIImage *groupButtonBackgroundImage;
@property (nonatomic, strong) UIColor *groupButtonTextColor;
@property (nonatomic, strong) UIImage *groupButtonSelectBackgroundImage;
@property (nonatomic, strong) UIColor *groupButtonSelectTextColor;  // default black

@property (nonatomic, assign) CGFloat toolsViewHeight;  //default 45.f

+ (instancetype)defaultAppearence;

@end
