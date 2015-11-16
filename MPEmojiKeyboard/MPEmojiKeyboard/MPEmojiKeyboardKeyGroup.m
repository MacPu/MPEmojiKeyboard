//
//  MPEmojiKeyboardKeyGroup.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/7/11.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardKeyGroup.h"
#import "MPEmojiKeyboardKeysFlowLayout.h"
#import "MPEmojiKeyboardTextKeyCell.h"

@implementation MPEmojiKeyboardKeyGroup
@synthesize keyItemCellClass = _keyItemCellClass;

- (UICollectionViewLayout *)keyItemsLayout
{
    if (!_keyItemsLayout) {
        MPEmojiKeyboardKeysFlowLayout *layout = [[MPEmojiKeyboardKeysFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(30, 30);
        layout.contentInsets = UIEdgeInsetsMake(15, 15, 0, 5);
        layout.itemSpacing = 14;
        layout.lineSpacing = 14;
        _keyItemsLayout = layout;
    }
    return _keyItemsLayout;
}

- (Class)keyItemCellClass
{
    if(!_keyItemCellClass){
        _keyItemCellClass = [MPEmojiKeyboardTextKeyCell class];
    }
    return _keyItemCellClass;
}

- (void)setKeyItemCellClass:(Class)keyItemCellClass
{
    if ([keyItemCellClass isSubclassOfClass:[MPEmojiKeyboardTextKeyCell class]]) {
        _keyItemCellClass = keyItemCellClass;
    }else{
        NSAssert(NO, @"PPYExpressionKeyboardKeyItemGroup: Setting keyItemCellClass - keyItemCellClass must be a subclass of PPYExpressionKeyboardKeyCell.class");
    }
}
@end
