//
//  MPEmojiKeyboardBuilder.m
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardBuilder.h"
#import "MPEmojiKeyboard.h"
#import "MPEmoji.h"

#define SCREENHEITH CGRectGetHeight([[UIScreen mainScreen] bounds])
#define SCREENWIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
#define IS_IPHONE_4 SCREENHEITH == 480
#define IS_IPHONE_5 SCREENHEITH == 568
#define IS_IPHONE_6 SCREENHEITH == 667
#define IS_IPHONE_6PLUS SCREENHEITH == 736

@interface UIColor (MPToolkit)

+ (UIColor *)colorWithARGB:(u_int32_t)argb;

@end

@implementation UIColor (MPToolkit)

+ (UIColor *)colorWithARGB:(u_int32_t)argb
{
    return [UIColor colorWithRed:((argb&0xff0000)>>16)/255.0 green:((argb&0xff00)>>8)/255.0 blue:(argb&0xff)/255.0 alpha:(argb>>24)/255.0];
}
@end

@interface UIImage (Color)

+(UIImage *)imageFromContextWithColor:(UIColor *)color;
+(UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size;

@end

@implementation UIImage (Color)

+(UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect=(CGRect){{0.0f,0.0f},size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *)imageFromContextWithColor:(UIColor *)color{
    
    CGSize size=CGSizeMake(1.0f, 1.0f);
    return [self imageFromContextWithColor:color size:size];
}

@end

@implementation MPEmojiKeyboardBuilder

+ (MPEmojiKeyboard *)sharedKeyboard
{
    static MPEmojiKeyboard *sharedKeyboard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MPEmojiKeyboardAppearence *appearence = [MPEmojiKeyboardAppearence defaultAppearence];
        appearence.sendKeyBackgroundColor = [UIColor colorWithARGB:0xFF107CF6];
        appearence.sendKeyTextColor = [UIColor whiteColor];
        appearence.sendKeyHightlightTextColor = [UIColor lightGrayColor];
        appearence.groupButtonBackgroundImage = [UIImage imageFromContextWithColor:[UIColor whiteColor]];
        appearence.groupButtonSelectTextColor = [UIColor blackColor];
        appearence.groupButtonTextColor = [UIColor blackColor];
        appearence.groupButtonSelectBackgroundImage = [UIImage imageFromContextWithColor:[UIColor colorWithARGB:0xFFF0F0F0]];
        
        sharedKeyboard = [MPEmojiKeyboard keyboard];
        sharedKeyboard.appearence = appearence;
        
        MPEmojiKeyboardKeyGroup *imageEmojiGroup = [[MPEmojiKeyboardKeyGroup alloc] init];
        imageEmojiGroup.keyItems = [self initImageKeyItems];
        imageEmojiGroup.iconImage = [UIImage imageNamed:@"001"];
        
        MPEmojiKeyboardKeyGroup *test1Group = [[MPEmojiKeyboardKeyGroup alloc] init];
        test1Group.keyItems = [MPEmojiKeyboardBuilder initEmojiItems];
        test1Group.keyFont = [UIFont systemFontOfSize:27];
        test1Group.title = @"😂";
        
        
        MPEmojiKeyboardKeysFlowLayout *textIconsLayout = [[MPEmojiKeyboardKeysFlowLayout alloc] init];
        textIconsLayout.itemSize = CGSizeMake(SCREENWIDTH / 4, 142/3.0);
        textIconsLayout.itemSpacing = 0;
        textIconsLayout.lineSpacing = 0;
        textIconsLayout.contentInsets = UIEdgeInsetsMake(0,0,0,0);
        
        MPEmojiKeyboardKeyGroup *textKeysGroup = [[MPEmojiKeyboardKeyGroup alloc] init];
        textKeysGroup.keyItems = [self initTextkeyItems];
        textKeysGroup.keyItemsLayout = textIconsLayout;
        textKeysGroup.keyItemCellClass = [MPEmojiKeyboardTextKeyCell class];
        textKeysGroup.title = @"(^_^)";
        
        sharedKeyboard.keysGroups = @[imageEmojiGroup ,test1Group, textKeysGroup];
        sharedKeyboard.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
        [sharedKeyboard setKeyItemGroupPressedKeyChangedBlock:^(MPEmojiKeyboardKeyGroup *keyItemsGroup, MPEmojiKeyboardKeyCell *fromCell, MPEmojiKeyboardKeyCell *toCell){
            [self sharedEmotionsKeyboardKeyItemGroup:keyItemsGroup pressedKeyCellChangedFromCell:fromCell toCell:toCell];
        }];
        
        if (textIconsLayout.collectionView) {
            UIView *textGridBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [textIconsLayout collectionViewContentSize].width, [textIconsLayout collectionViewContentSize].height)];
            textGridBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            if(IS_IPHONE_6){
                textGridBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keyboard_grid_bg_6s"]];
            }
            else if (IS_IPHONE_6PLUS){
                textGridBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keyboard_grid_bg_6p"]];
            }
            else{
                textGridBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keyboard_grid_bg"]];
            }
            [textIconsLayout.collectionView addSubview:textGridBackgroundView];
        }
        
    });
    return sharedKeyboard;
}

+ (NSArray *)initImageKeyItems
{
    NSMutableArray *imagekeyItems = [[NSMutableArray alloc] init];
    NSArray *imageKeys = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmojiIcons" ofType:@"plist"]];
    for (NSDictionary *dic in imageKeys) {
        NSString *title = [dic valueForKey:@"chs"];
        NSString *imageString = [dic valueForKey:@"png"];
        MPEmojiKeyboardKeyItem *item = [[MPEmojiKeyboardKeyItem alloc] init];
        item.title = title;
        item.emojiImage = [UIImage imageNamed:imageString];
        item.textToInput = [NSString stringWithFormat:@"[:%@:]",title];
        [imagekeyItems addObject:item];
    }
    
    return imagekeyItems;
}

+ (NSArray *)initEmojiItems
{
    NSMutableArray *emojiKeysItems = [[NSMutableArray alloc] init];
    for (NSString *string in [MPEmoji allEmoji]) {
        MPEmojiKeyboardKeyItem *item = [[MPEmojiKeyboardKeyItem alloc] init];
        item.textToInput = string;
        item.title = string;
        [emojiKeysItems addObject:item];
    }
    return emojiKeysItems;
}

+ (NSArray *)initTextkeyItems
{
    NSMutableArray *textKeysItems = [[NSMutableArray alloc] init];
    NSArray *textKeys = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmotionTextKeys" ofType:@"plist"]];
    for(NSString *text in textKeys)
    {
        MPEmojiKeyboardKeyItem *item = [[MPEmojiKeyboardKeyItem alloc] init];
        item.textToInput = text;
        item.title = text;
        [textKeysItems addObject:item];
    }
    
    return textKeysItems;
}

+ (void)sharedEmotionsKeyboardKeyItemGroup:(MPEmojiKeyboardKeyGroup *)keyItemGroup
             pressedKeyCellChangedFromCell:(MPEmojiKeyboardKeyCell *)fromCell
                                    toCell:(MPEmojiKeyboardKeyCell *)toCell
{
    static MPEmojiKeyboardPressedPopupView *pressedKeyCellPopupView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pressedKeyCellPopupView = [[MPEmojiKeyboardPressedPopupView alloc] initWithFrame:CGRectMake(0, 0, 83, 110)];
        pressedKeyCellPopupView.hidden = YES;
        [[self sharedKeyboard] addSubview:pressedKeyCellPopupView];
    });
    
    if ([[self sharedKeyboard].keysGroups indexOfObject:keyItemGroup] < 1) {
        [[self sharedKeyboard] bringSubviewToFront:pressedKeyCellPopupView];
        if (toCell) {
            pressedKeyCellPopupView.keyItem = toCell.keyItem;
            pressedKeyCellPopupView.hidden = NO;
            CGRect frame = [[self sharedKeyboard] convertRect:toCell.bounds fromView:toCell];
            pressedKeyCellPopupView.center = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame)-CGRectGetHeight(pressedKeyCellPopupView.frame)/2);
        }else{
            pressedKeyCellPopupView.hidden = YES;
        }
    }
}

@end
