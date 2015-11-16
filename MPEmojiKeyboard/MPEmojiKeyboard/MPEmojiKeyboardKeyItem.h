//
//  MPEmojiKeyboardKeyItem.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/7/11.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPEmojiKeyboardKeyItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *textToInput;
@property (nonatomic, strong) UIImage *emojiImage;

@end
