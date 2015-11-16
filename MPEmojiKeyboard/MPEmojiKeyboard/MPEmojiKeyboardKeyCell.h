//
//  MPEmojiKeyboardKeyCell.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/7/20.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPEmojiKeyboardKeyItem;

@interface MPEmojiKeyboardKeyCell : UICollectionViewCell

@property (nonatomic, strong) MPEmojiKeyboardKeyItem *keyItem;
@property (nonatomic, weak, readonly) UIButton *keyButton;

@end
