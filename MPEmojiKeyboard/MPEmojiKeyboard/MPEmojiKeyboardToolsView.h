//
//  MPEmojiKeyboardToolsView.h
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPEmojiKeyboardKeyGroup.h"

@class MPEmojiKeyboardToolsView;

@protocol MPEmojiKeyboardToolsViewDelegate <NSObject>

- (void)toolsView:(MPEmojiKeyboardToolsView *)toolsView didSelectedKeyItemGroup:(MPEmojiKeyboardKeyGroup *)keyItemGroup;
- (void)toolsDidSelectSendKey:(MPEmojiKeyboardToolsView *)toolsView;

@end

@interface MPEmojiKeyboardToolsView : UIView

@property (nonatomic, weak) id<MPEmojiKeyboardToolsViewDelegate> delegate;
@property (nonatomic, strong) NSArray *keyItemGroups;

- (void)changeKeyItemGroup:(NSInteger)groupIndex;

@end
