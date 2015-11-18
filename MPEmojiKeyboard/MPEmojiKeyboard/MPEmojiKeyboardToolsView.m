//
//  MPEmojiKeyboardToolsView.m
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardToolsView.h"

@interface MPEmojiKeyboardToolsView()

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation MPEmojiKeyboardToolsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UIButton *sendButton = [[UIButton alloc] init];
    [sendButton addTarget:self action:@selector(sendButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendButton];
    _sendButton = sendButton;
    
    _contentView = [[UIScrollView alloc] init];
//    [_contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mp_keyboard_tools_bg"]]];
    [_contentView setBackgroundColor:[UIColor whiteColor]];
    _contentView.alwaysBounceHorizontal = YES;
    [_contentView setContentSize:CGSizeMake(_contentView.subviews.count * 100, _contentView.frame.size.height)];
    [self addSubview:_contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.sendButton.frame = (CGRect){{self.frame.size.width - 100,0},{100,self.frame.size.height}};
    self.contentView.frame =(CGRect){{0,0},{CGRectGetWidth(self.frame) - CGRectGetWidth(_sendButton.frame),self.frame.size.height}};
}

- (void)setAppearence:(MPEmojiKeyboardAppearence *)appearence
{
    _appearence = appearence;
    _sendButton.backgroundColor = _appearence.sendKeyBackgroundColor;
    [_sendButton setBackgroundImage:_appearence.groupButtonBackgroundImage forState:UIControlStateNormal];
    [_sendButton setBackgroundImage:_appearence.groupButtonSelectBackgroundImage forState:UIControlStateHighlighted];
    [_sendButton setTitle:_appearence.sendKeyString forState:UIControlStateNormal];
    [_sendButton setTitleColor:_appearence.sendKeyTextColor forState:UIControlStateNormal];
    [_sendButton setTitleColor:_appearence.sendKeyHightlightTextColor forState:UIControlStateHighlighted];
    self.keyItemGroups = _keyItemGroups;
}

- (void)setKeyItemGroups:(NSArray *)keyItemGroups
{
    _keyItemGroups = keyItemGroups;
    [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.keyItemGroups enumerateObjectsUsingBlock:^(MPEmojiKeyboardKeyGroup *obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){{100 * idx,0}, {100,self.frame.size.height}};
        button.tag = idx+100;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(keyItemGroupChanged:) forControlEvents:UIControlEventTouchUpInside];
        if (obj.iconImage) {
            [button setImage:obj.iconImage forState:UIControlStateNormal];
            [button setImage:obj.selectIconImage forState:UIControlStateHighlighted];
        }else{
            [button setTitle:obj.title forState:UIControlStateNormal];
        }
        [_contentView addSubview:button];
    }];
    
    UIButton *selectedButon = (UIButton *)[self viewWithTag:100];
    if(selectedButon) {
        [self keyItemGroupChanged:selectedButon];
    }
}

- (void)keyItemGroupChanged:(UIButton *)sender
{
    for (int i = 0; i < self.keyItemGroups.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+100];
        [button setBackgroundImage:_appearence.groupButtonBackgroundImage forState:UIControlStateNormal];
        [button setTitleColor:_appearence.groupButtonTextColor forState:UIControlStateNormal];
    }
    [sender setBackgroundImage:_appearence.groupButtonSelectBackgroundImage forState:UIControlStateNormal];
    [sender setTitleColor:_appearence.groupButtonSelectTextColor forState:UIControlStateNormal];
    if(self.delegate && [self.delegate respondsToSelector:@selector(toolsView:didSelectedKeyItemGroup:)]){
        MPEmojiKeyboardKeyGroup *selectedGroup = [self.keyItemGroups objectAtIndex:sender.tag - 100];
        [self.delegate toolsView:self didSelectedKeyItemGroup:selectedGroup];
    }
}
-(void)changeKeyItemGroup:(NSInteger)groupIndex
{
    UIButton *button = (UIButton *)[self viewWithTag:100+groupIndex];
    if(button)
        [self keyItemGroupChanged:button];
}

- (void)sendButtonTapped:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(toolsDidSelectSendKey:)])
        [self.delegate toolsDidSelectSendKey:self];
}
@end
