//
//  MPEmojiKeyboardBuilder.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardBuilder.h"
#import "MPEmojiKeyboard.h"
#import "MPEmoji.h"

@implementation MPEmojiKeyboardBuilder

+ (MPEmojiKeyboard *)sharedKeyboard
{
    static MPEmojiKeyboard *sharedKeyboard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MPEmojiKeyboard *keyboard = [MPEmojiKeyboard keyboard];
        
        MPEmojiKeyboardKeyGroup *test1Group = [[MPEmojiKeyboardKeyGroup alloc] init];
        test1Group.keyItems = [MPEmojiKeyboardBuilder initEmojiItems];
        test1Group.title = @"emoji";
        
        
        keyboard.keysGroups = @[test1Group];
        
    });
    return sharedKeyboard;
}

+ (NSArray *)initEmojiItems
{
    NSMutableArray *emojiKeysItems = [[NSMutableArray alloc] init];
    for (NSString *string in [MPEmoji allEmoji]) {
        MPEmojiKeyboardKeyItem *item = [[MPEmojiKeyboardKeyItem alloc] init];
        item.textToInput = string;
        item.title = string;
        [emojiKeysItems addObject:item];
    }
    return emojiKeysItems;
}
@end
