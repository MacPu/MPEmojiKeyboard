//
//  MPEmojiKeyboardPressedPopupView.m
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/15.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardPressedPopupView.h"

@interface MPEmojiKeyboardPressedPopupView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation MPEmojiKeyboardPressedPopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UIImage *popupBackground = [UIImage imageNamed:@"ppy_keyboard_popup"];
    UIImageView *popupBackgroundView = [[UIImageView alloc] initWithImage:popupBackground];
    [self addSubview:popupBackgroundView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:11];
    textLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:textLabel];
    self.textLabel = textLabel;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self.imageView.image){
        self.textLabel.font = [UIFont systemFontOfSize:11];
        self.imageView.frame = CGRectMake(25, 9, 32, 32);
        self.textLabel.frame = CGRectMake(10, 41, 63, 18);
    }
    else{
        self.textLabel.font = [UIFont systemFontOfSize:30];
        self.textLabel.frame = CGRectMake(10, 15, 63, 30);
    }
}

- (void)setKeyItem:(MPEmojiKeyboardKeyItem *)keyItem
{
    _keyItem = keyItem;
    self.textLabel.text = keyItem.title;
    self.imageView.image = keyItem.emojiImage;
    [self setNeedsLayout];
}

@end
