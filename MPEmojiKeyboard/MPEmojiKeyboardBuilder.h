//
//  MPEmojiKeyboardBuilder.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPEmojiKeyboard.h"


@interface MPEmojiKeyboardBuilder : NSObject

+ (MPEmojiKeyboard *)sharedKeyboard;

+ (NSArray *)initEmojiItems;
@end
