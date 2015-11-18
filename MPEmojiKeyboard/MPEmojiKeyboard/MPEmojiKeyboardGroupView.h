//
//  MPEmojiKeyboardGroupView.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/10.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPEmojiKeyboardKeyItem.h"
#import "MPEmojiKeyboardKeyGroup.h"
#import "MPEmojiKeyboardKeyCell.h"
#import "MPEmojiKeyboardAppearence.h"

@interface MPEmojiKeyboardGroupView : UIView

@property (nonatomic, strong) MPEmojiKeyboardKeyGroup *keyGroup;
@property (nonatomic, weak, readonly) UIImageView *backgroundImageView;

@property (nonatomic, weak) MPEmojiKeyboardAppearence *appearence;

@property (nonatomic, copy) void (^keyItemTappedBlock)(MPEmojiKeyboardKeyItem *keyItem);
@property (nonatomic, copy) void (^pressedKeyItemCellChangedBlock)(MPEmojiKeyboardKeyCell *fromCell, MPEmojiKeyboardKeyCell *toCell);
@property (nonatomic, copy) void (^backspceItemTappedBlock)(void);

@end
