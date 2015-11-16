//
//  MPEmojiKeyboardBuilder.m
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/16.
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
        sharedKeyboard = [MPEmojiKeyboard keyboard];
        
        MPEmojiKeyboardKeyGroup *test1Group = [[MPEmojiKeyboardKeyGroup alloc] init];
        test1Group.keyItems = [MPEmojiKeyboardBuilder initEmojiItems];
        test1Group.title = @"emoji";
        
        
        MPEmojiKeyboardKeysFlowLayout *textIconsLayout = [[MPEmojiKeyboardKeysFlowLayout alloc] init];
        textIconsLayout.itemSize = CGSizeMake(80, 142/3.0);
        textIconsLayout.itemSpacing = 0;
        textIconsLayout.lineSpacing = 0;
        textIconsLayout.contentInsets = UIEdgeInsetsMake(0,0,0,0);
        
        MPEmojiKeyboardKeyGroup *textKeysGroup = [[MPEmojiKeyboardKeyGroup alloc] init];
        textKeysGroup.keyItems = [self initTextkeyItems];
        textKeysGroup.keyItemsLayout = textIconsLayout;
        textKeysGroup.keyItemCellClass = [MPEmojiKeyboardTextKeyCell class];
        textKeysGroup.title = @"(^_^)";
        
        sharedKeyboard.keysGroups = @[test1Group, textKeysGroup];
        sharedKeyboard.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
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

+ (NSArray *)initTextkeyItems
{
    NSMutableArray *textKeysItems = [[NSMutableArray alloc] init];
    NSArray *textKeys = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmotionTextKeys" ofType:@"plist"]];
    for(NSString *text in textKeys)
    {
        MPEmojiKeyboardKeyItem *item = [[MPEmojiKeyboardKeyItem alloc] init];
        item.textToInput = text;
        item.title = text;
        [textKeysItems addObject:item];
    }
    
    return textKeysItems;
}

@end
