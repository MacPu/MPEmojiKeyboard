//
//  MPEmojiKeyboardGroupView.h
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/10.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPEmojiKeyboardKeyItem.h"
#import "MPEmojiKeyboardKeyGroup.h"
#import "MPEmojiKeyboardKeyCell.h"

@interface MPEmojiKeyboardGroupView : UIView

@property (nonatomic, strong) MPEmojiKeyboardKeyGroup *keyGroup;
@property (nonatomic, weak, readonly) UIImageView *backgroundImageView;

@property (nonatomic, copy) void (^keyItemTappedBlock)(MPEmojiKeyboardKeyItem *keyItem);
@property (nonatomic, copy) void (^pressedKeyItemCellChangedBlock)(MPEmojiKeyboardKeyCell *fromCell, MPEmojiKeyboardKeyCell *toCell);
@property (nonatomic, copy) void (^backspceItemTappedBlock)(void);

@end
