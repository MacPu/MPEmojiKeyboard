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
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.sendButton.frame = (CGRect){{self.frame.size.width/3*2,0},{self.frame.size.width/3,self.frame.size.height}};
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
}

- (void)setKeyItemGroups:(NSArray *)keyItemGroups
{
    _keyItemGroups = keyItemGroups;
    NSInteger count = keyItemGroups.count;
    [self.keyItemGroups enumerateObjectsUsingBlock:^(MPEmojiKeyboardKeyGroup *obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = (CGRect){{(self.frame.size.width/3*2)/count * idx,0}, {(self.frame.size.width/3*2)/count,self.frame.size.height}};
        button.backgroundColor = [UIColor redColor];
        [button setBackgroundImage:[UIImage imageNamed:@"test1"] forState:UIControlStateNormal];
        button.tag = idx+100;
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        CALayer *leftLayer = [[CALayer alloc] init];
        leftLayer.frame = CGRectMake(CGRectGetWidth(button.frame) - 0.5, 0, 0.5, CGRectGetHeight(button.frame));
        leftLayer.backgroundColor = [UIColor grayColor].CGColor;
        [button.layer addSublayer:leftLayer];
        
        [button addTarget:self action:@selector(keyItemGroupChanged:) forControlEvents:UIControlEventTouchUpInside];
        if (obj.iconImage) {
            [button setImage:obj.iconImage forState:UIControlStateNormal];
            [button setImage:obj.selectIconImage forState:UIControlStateHighlighted];
        }else{
            [button setTitle:obj.title forState:UIControlStateNormal];
        }
        [self addSubview:button];
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
        [button setBackgroundImage:[UIImage imageNamed:@"ppy_keyboard_tools_bg"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [sender setBackgroundImage:[UIImage imageNamed:@"ppy_keyboard_gray_bg"] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
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
