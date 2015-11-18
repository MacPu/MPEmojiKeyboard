//
//  MPEmojiKeyboardToolsView.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPEmojiKeyboardKeyGroup.h"
#import "MPEmojiKeyboardAppearence.h"

@class MPEmojiKeyboardToolsView;

@protocol MPEmojiKeyboardToolsViewDelegate <NSObject>

- (void)toolsView:(MPEmojiKeyboardToolsView *)toolsView didSelectedKeyItemGroup:(MPEmojiKeyboardKeyGroup *)keyItemGroup;
- (void)toolsDidSelectSendKey:(MPEmojiKeyboardToolsView *)toolsView;

@end

@interface MPEmojiKeyboardToolsView : UIView

@property (nonatomic, weak) id<MPEmojiKeyboardToolsViewDelegate> delegate;
@property (nonatomic, strong) NSArray *keyItemGroups;

@property (nonatomic, weak) MPEmojiKeyboardAppearence *appearence;

- (void)changeKeyItemGroup:(NSInteger)groupIndex;

@end
