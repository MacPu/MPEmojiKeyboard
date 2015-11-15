//
//  MPEmojiKeyboard.h
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPEmojiKeyboardKeyGroup;
@class MPEmojiKeyboardKeyCell;

typedef void(^MPKeyItemGroupPressedKeyChangedBlock)(MPEmojiKeyboardKeyGroup *keyItemsGroup, MPEmojiKeyboardKeyCell *fromCell, MPEmojiKeyboardKeyCell *toCell);
typedef void(^MPSendKeyClickedBlock)(void);

@interface MPEmojiKeyboard : UIView

@property (nonatomic, strong) NSArray *itemKeysGroups;
@property (nonatomic, assign) BOOL enableStandardSystemKeyboardClickSound;

@property (nonatomic, copy) MPKeyItemGroupPressedKeyChangedBlock keyItemGroupPressedKeyChangedBlock;
@property (nonatomic, copy) MPSendKeyClickedBlock sendKeyClickedBlock;

@property (nonatomic, weak, readonly) UIResponder<UITextInput> *textInput;
@property (nonatomic, assign) CGFloat toolsViewHeight;  //default 45.f

+ (instancetype)sharedKeyboard;

- (void)backspace;

@end


@interface UIResponder (PPYEmoticonsKeyboard)

@property (nonatomic, strong, readonly) MPEmojiKeyboard *emojiKeyboard;

- (void)switchToDefaultKeyboard;
- (void)switchToEmojiKeyboard:(MPEmojiKeyboard *)keyboard;

@end