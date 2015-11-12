//
//  MPEmojiKeyboardTextKeyCell.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/12.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardTextKeyCell.h"

@implementation MPEmojiKeyboardTextKeyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.keyButton.bounds = self.bounds;
        self.keyButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.keyButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.backgroundColor = nil;
    }
}

@end
