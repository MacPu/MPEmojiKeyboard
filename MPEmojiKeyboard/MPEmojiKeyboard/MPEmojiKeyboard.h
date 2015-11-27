//
//  MPEmojiKeyboard.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPEmojiKeyboardKeyGroup.h"
#import "MPEmojiKeyboardKeyItem.h"
#import "MPEmojiKeyboardKeysFlowLayout.h"
#import "MPEmojiKeyboardKeyCell.h"
#import "MPEmojiKeyboardToolsView.h"
#import "MPEmojiKeyboardPressedPopupView.h"
#import "MPEmojiKeyboardGroupView.h"
#import "MPEmojiKeyboardTextKeyCell.h"
#import "MPEmojiKeyboardAppearence.h"

@class MPEmojiKeyboardKeyCell;

typedef void(^MPKeyItemGroupPressedKeyChangedBlock)(MPEmojiKeyboardKeyGroup *keyItemsGroup, MPEmojiKeyboardKeyCell *fromCell, MPEmojiKeyboardKeyCell *toCell);
typedef void(^MPSendKeyClickedBlock)(void);


@interface MPEmojiKeyboard : UIView

/**
 * the key groups that you want to show,this is a array of keysGroups
 */
@property (nonatomic, strong) NSArray<MPEmojiKeyboardKeyGroup *> *keysGroups;

/**
 * MPEmojiKeyboard can recognizer your pan gesture,this is your pan gesture call back.
 */
@property (nonatomic, copy) MPKeyItemGroupPressedKeyChangedBlock keyItemGroupPressedKeyChangedBlock;

/*
 * this will reponse your send key click action.
 */
@property (nonatomic, copy) MPSendKeyClickedBlock sendKeyClickedBlock;

/**
 * this is your input view, maybe UITextVIew, maybe UITextField etc.
 */
@property (nonatomic, weak, readonly) UIResponder<UITextInput> *textInput;

/*!
 *  you can control you keyboard UI by appearence.
 */
@property (nonatomic, strong) MPEmojiKeyboardAppearence *appearence;

/*
 * this will return a new keyboard.
 */
+ (instancetype)keyboard;

/*
 * when you invoke this function, and last word of your textInput is a emoji,this will delete a whole emoji
 * or,this will delete the last word of your textInput.
 */
- (void)backspace;

@end


@interface UIResponder (MPEmojiKeyboard)

/*
 * if emojiKeyboard is nil.it means you are using default keyboard.
 *  if not nil.it means you are using emojiKeyboard.
 */
@property (nonatomic, strong, readonly) MPEmojiKeyboard *emojiKeyboard;

/*
 * switch to default keybard
 */
- (void)switchToDefaultKeyboard;

/**
 * switch to a emoji keyboard
 */
- (void)switchToEmojiKeyboard:(MPEmojiKeyboard *)keyboard;

@end