//
//  MPEmojiKeyboardKeysFlowLayout.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/7/11.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPEmojiKeyboardKeysFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) CGSize  itemSize;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, assign) UIEdgeInsets contentInsets;

@end
