//
//  MPEmojiKeyboard.m
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/11/16.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboard.h"

@interface UIResponder (WriteableInputView)

@property (readwrite, retain) UIView *inputView;

@end

#define kMPDefaultMaxDeleteButtonSize CGSizeMake(30,30)

@interface MPEmojiKeyboard() < MPEmojiKeyboardToolsViewDelegate>

@property (nonatomic, weak, readwrite) UIResponder<UITextInput> *textInput;
@property (nonatomic, strong) MPEmojiKeyboardToolsView *toolsView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSArray *keyItemGroupViews;
@property (nonatomic, assign) CGRect keyItemGroupViewFrame;


@end

@implementation MPEmojiKeyboard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return  self;
}

- (void)commonInit
{
    if (CGRectIsEmpty(self.bounds)) {
        self.bounds = (CGRect){CGPointZero,CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 216)};
    }
    
    _appearence = [MPEmojiKeyboardAppearence defaultAppearence];
    
    self.backgroundColor = [UIColor blackColor];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;

    MPEmojiKeyboardToolsView *toolsView = [[MPEmojiKeyboardToolsView alloc] initWithFrame:self.toolsViewFrame];
    toolsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    toolsView.delegate = self;
    toolsView.appearence = _appearence;
    [self addSubview:toolsView];
    self.toolsView = toolsView;
    
}

- (CGRect)toolsViewFrame
{
    return CGRectMake(0, CGRectGetHeight(self.bounds) - _appearence.toolsViewHeight, CGRectGetWidth(self.bounds), _appearence.toolsViewHeight);
}

- (void)switchToDefaultKeyboard
{
    [self setInputViewToView:nil];
    self.textInput = nil;
}

- (void)setInputViewToView:(UIView *)view
{
    self.textInput.inputView = view;
    [self.textInput reloadInputViews];
}

- (void)switchToKeyItemGroup:(MPEmojiKeyboardKeyGroup *)keyItemGroup
{
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(MPEmojiKeyboardGroupView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.keyGroup isEqual:keyItemGroup]) {
            obj.frame = self.keyItemGroupViewFrame;
            obj.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:obj];
            *stop = YES;
        }
    }];
}

+ (instancetype)keyboard
{
    MPEmojiKeyboard *keyboard = [[MPEmojiKeyboard alloc] init];
    return keyboard;
}

- (void)attachToTextInput:(UIResponder<UITextInput> *)textInput
{
    self.textInput = textInput;
    [self setInputViewToView:self];
}

- (BOOL)textInputShouldReplaceTextInRange:(UITextRange *)range replacementText:(NSString *)replacementText
{
    
    BOOL shouldChange = YES;
    
    NSInteger startOffset = [self.textInput offsetFromPosition:self.textInput.beginningOfDocument toPosition:range.start];
    NSInteger endOffset = [self.textInput offsetFromPosition:self.textInput.beginningOfDocument toPosition:range.end];
    NSRange replacementRange = NSMakeRange(startOffset, endOffset - startOffset);
    
    if ([self.textInput isKindOfClass:UITextView.class]) {
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
            shouldChange = [textView.delegate textView:textView shouldChangeTextInRange:replacementRange replacementText:replacementText];
        }
    }
    
    if ([self.textInput isKindOfClass:UITextField.class]) {
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            shouldChange = [textField.delegate textField:textField shouldChangeCharactersInRange:replacementRange replacementString:replacementText];
        }
    }
    
    return shouldChange;
}

- (void)replaceTextInRange:(UITextRange *)range withText:(NSString *)text
{
    if (range && [self textInputShouldReplaceTextInRange:range replacementText:text]) {
        [self.textInput replaceRange:range withText:text];
    }
}

- (void)inputText:(NSString *)text
{
    [self replaceTextInRange:self.textInput.selectedTextRange withText:text];
}

- (void)backspace
{
    if (self.textInput.selectedTextRange.empty) {
        //Find the last thing we may input and delete it. And RETURN
        NSString *text = [self.textInput textInRange:[self.textInput textRangeFromPosition:self.textInput.beginningOfDocument toPosition:self.textInput.selectedTextRange.start]];
        for (MPEmojiKeyboardKeyGroup *group in self.keysGroups) {
            for (MPEmojiKeyboardKeyItem *item in group.keyItems) {
                if ([text hasSuffix:item.textToInput]) {
                    NSUInteger composedCharacterLength = item.textToInput.length;
                    UITextRange *rangeToDelete = [self.textInput textRangeFromPosition:[self.textInput positionFromPosition:self.textInput.selectedTextRange.start offset:-composedCharacterLength] toPosition:self.textInput.selectedTextRange.end];
                    if (rangeToDelete) {
                        [self replaceTextInRange:rangeToDelete withText:@""];
                        return;
                    }
                }
            }
        }
        
        //If we cannot find the text. Do a delete backward.
        UITextRange *rangeToDelete = [self.textInput textRangeFromPosition:self.textInput.selectedTextRange.start toPosition:[self.textInput positionFromPosition:self.textInput.selectedTextRange.start offset:-1]];
        [self replaceTextInRange:rangeToDelete withText:@""];
    } else {
        [self replaceTextInRange:self.textInput.selectedTextRange withText:@""];
    }
}

- (CGRect)keyItemGroupViewFrame
{
    return CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetMinY(self.toolsView.frame));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.toolsView.frame = self.toolsViewFrame;
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.frame = self.keyItemGroupViewFrame;
    }];
}

- (void)setAppearence:(MPEmojiKeyboardAppearence *)appearence
{
    _appearence = appearence;
    _toolsView.appearence = appearence;
}

#pragma mark - KeyItems

- (void)setKeysGroups:(NSArray *)keysGroups
{
    _keysGroups = [keysGroups copy];
    [self reloadKeyItemGroupViews];
    self.toolsView.keyItemGroups = keysGroups;
    
}

- (void)reloadKeyItemGroupViews
{
    [self.keyItemGroupViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    __weak typeof(self) weakSelf = self;
    self.keyItemGroupViews = nil;
    NSMutableArray *keyItemGroupViews = [NSMutableArray array];
    [self.keysGroups enumerateObjectsUsingBlock:^(MPEmojiKeyboardKeyGroup *obj, NSUInteger idx, BOOL *stop) {
        MPEmojiKeyboardGroupView *keyItemGroupView = [[MPEmojiKeyboardGroupView alloc] initWithFrame:weakSelf.keyItemGroupViewFrame];
        keyItemGroupView.keyGroup = obj;
        [keyItemGroupView setKeyItemTappedBlock:^(MPEmojiKeyboardKeyItem *keyItem) {
            [weakSelf keyItemTapped:keyItem];
        }];
        [keyItemGroupView setPressedKeyItemCellChangedBlock:^(MPEmojiKeyboardKeyCell *fromCell, MPEmojiKeyboardKeyCell *toCell) {
            if (weakSelf.keyItemGroupPressedKeyChangedBlock) {
                weakSelf.keyItemGroupPressedKeyChangedBlock(obj,fromCell,toCell);
            }
        }];
        [keyItemGroupView setBackspceItemTappedBlock:^{
            [weakSelf backspace];
        }];
        [keyItemGroupViews addObject:keyItemGroupView];
        [self addDeleteButtonForKeyGroup:obj];
    }];
    self.keyItemGroupViews = [keyItemGroupViews copy];
}

- (void)addDeleteButtonForKeyGroup:(MPEmojiKeyboardKeyGroup *)keyGroup
{
    MPEmojiKeyboardKeysFlowLayout *flowLayout = (MPEmojiKeyboardKeysFlowLayout *)keyGroup.keyItemsLayout;
    UICollectionView *collectionView = flowLayout.collectionView;
    NSInteger numberOfItemInLine = CGRectGetWidth(collectionView.frame) / (flowLayout.itemSize.width + flowLayout.itemSpacing);
    NSInteger numberOfLine = CGRectGetHeight(collectionView.frame) / (flowLayout.itemSize.height +  flowLayout.lineSpacing);
    NSInteger numberOfPage = (keyGroup.keyItems.count / (numberOfLine * numberOfItemInLine - 1)) + !!(keyGroup.keyItems.count % (numberOfLine * numberOfItemInLine - 1));
    for (int i = 0; i<numberOfPage; i++) {
        UIButton *deleButton = [[UIButton alloc] init];
        deleButton.frame = (CGRect){{(flowLayout.itemSize.width + flowLayout.itemSpacing)*(numberOfItemInLine-1)+flowLayout.itemSpacing + i*CGRectGetWidth(collectionView.frame) +(flowLayout.itemSize.width-kMPDefaultMaxDeleteButtonSize.width)/2,
            (flowLayout.itemSize.height +  flowLayout.lineSpacing)*(numberOfLine-1) +flowLayout.lineSpacing + (flowLayout.itemSize.height -kMPDefaultMaxDeleteButtonSize.height)/2},
            kMPDefaultMaxDeleteButtonSize};
        [deleButton addTarget:self action:@selector(backspace) forControlEvents:UIControlEventTouchUpInside];
        [deleButton setImage:_appearence.backspaceImage forState:UIControlStateNormal];
        deleButton.userInteractionEnabled = YES;
        deleButton.tag = i + 1000;
        [collectionView addSubview:deleButton];
        [collectionView bringSubviewToFront:deleButton];
    }
}

- (void)keyItemTapped:(MPEmojiKeyboardKeyItem *)keyItem
{
    [self inputText:keyItem.textToInput];
    [UIDevice.currentDevice playInputClick];
}

#pragma mark - MPEmojiKeyboardToolsViewDelegate

- (void)toolsView:(MPEmojiKeyboardToolsView *)toolsView didSelectedKeyItemGroup:(MPEmojiKeyboardKeyGroup *)keyItemGroup
{
    [self switchToKeyItemGroup:keyItemGroup];
}

- (void)toolsDidSelectSendKey:(MPEmojiKeyboardToolsView *)toolsView
{
    if(self.sendKeyClickedBlock){
        self.sendKeyClickedBlock();
    }
}

@end


@implementation UIResponder (MPEmojiKeyboard)

- (MPEmojiKeyboard *)emojiKeyboard
{
    if ([self.inputView isKindOfClass:[MPEmojiKeyboard class]]) {
        return (MPEmojiKeyboard *)self.inputView;
    }
    return nil;
}

- (void)switchToDefaultKeyboard
{
    [self.emojiKeyboard switchToDefaultKeyboard];
}

- (void)switchToEmojiKeyboard:(MPEmojiKeyboard *)keyboard
{
    if ([self conformsToProtocol:@protocol(UITextInput)] && [self respondsToSelector:@selector(setInputView:)]){
        [keyboard attachToTextInput:(UIResponder<UITextInput> *)self];
        [keyboard.toolsView changeKeyItemGroup:0];
    }
}

@end
