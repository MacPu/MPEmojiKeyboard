//
//  MPEmojiKeyboardKeyCell.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/7/20.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardKeyCell.h"
#import "MPEmojiKeyboardKeyItem.h"

@interface MPEmojiKeyboardKeyCell()

@property (nonatomic, strong) UIButton *keyButton;

@end

@implementation MPEmojiKeyboardKeyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UIButton *keyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyButton.frame = self.contentView.frame;
    [self.contentView addSubview:keyButton];
    _keyButton = keyButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.keyButton.frame = self.contentView.frame;
}

- (void)setKeyItem:(MPEmojiKeyboardKeyItem *)keyItem
{
    _keyItem = keyItem;
    if(keyItem.title){
        [self.keyButton setImage:nil forState:UIControlStateNormal];
        [self.keyButton setTitle:keyItem.title forState:UIControlStateNormal];
    }
    else if(keyItem.emojiImage){
        [self.keyButton setImage:keyItem.emojiImage forState:UIControlStateNormal];
        [self.keyButton setTitle:nil forState:UIControlStateNormal];
    }
    else{
        [self.keyButton setImage:nil forState:UIControlStateNormal];
        [self.keyButton setTitle:nil forState:UIControlStateNormal];
    }
}

@end
