//
//  MPEmojiKeyboardKeyGroup.h
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/7/11.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPEmojiKeyboardKeyGroup : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImage *selectIconImage;
@property (nonatomic, strong) NSArray *keyItems;
@property (nonatomic, strong) UIFont *keyFont;
@property (nonatomic, strong) UICollectionViewLayout *keyItemsLayout;
@property (nonatomic, unsafe_unretained) Class keyItemCellClass;

@end
