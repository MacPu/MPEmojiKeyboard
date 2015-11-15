//
//  MPEmojiKeyboardGroupView.m
//  MPEmojiKeyboard
//
//  Created by 蒲德贵 on 15/11/10.
//  Copyright © 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardGroupView.h"
#import "MPEmojiKeyboardKeysFlowLayout.h"

#define kDefaultPageControlHeight 23

@interface MPEmojiKeyboardGroupView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) MPEmojiKeyboardKeyCell *lastPressedCell;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, weak, readwrite) UIImageView *backgroundImageView;

@end

@implementation MPEmojiKeyboardGroupView


- (id)initWithFrame:(CGRect)frame
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
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
                                                                                 CGRectGetHeight(self.bounds) - kDefaultPageControlHeight,
                                                                                 CGRectGetWidth(self.bounds),
                                                                                 kDefaultPageControlHeight)];
    pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                          0,
                                                                                          CGRectGetWidth(self.bounds),
                                                                                          CGRectGetHeight(self.bounds) - kDefaultPageControlHeight)
                                                          collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewLongPress:)];
    longPressGestureRecognizer.minimumPressDuration = 0.05;
    [self.collectionView addGestureRecognizer:longPressGestureRecognizer];
    self.longPressGesture = longPressGestureRecognizer;
    
}

- (void)setKeyGroup:(MPEmojiKeyboardKeyGroup *)keyGroup
{
    _keyGroup = keyGroup;
    self.collectionView.collectionViewLayout = self.keyGroup.keyItemsLayout;
    [self.collectionView registerClass:_keyGroup.keyItemCellClass forCellWithReuseIdentifier:NSStringFromClass(_keyGroup.keyItemCellClass)];
    [self.collectionView reloadData];
}

- (void)collectionViewLongPress:(UILongPressGestureRecognizer *)longPressGesutre
{
    CGPoint pressLocation = [longPressGesutre locationInView:self.collectionView];
    NSIndexPath *__block pressIndexPath = [NSIndexPath indexPathForItem:NSNotFound inSection:NSNotFound];
    [self.collectionView.indexPathsForVisibleItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = obj;
        if (CGRectContainsPoint([[self.collectionView layoutAttributesForItemAtIndexPath:indexPath] frame], pressLocation)) {
            pressIndexPath = indexPath;
            *stop = YES;
        }
    }];
    if (pressIndexPath.item == NSNotFound || longPressGesutre.state == UIGestureRecognizerStateEnded) {
        if (self.pressedKeyItemCellChangedBlock) {
            self.pressedKeyItemCellChangedBlock(self.lastPressedCell,nil);
        }
        [self.lastPressedCell setSelected:NO];
        self.lastPressedCell = nil;
        
        if (pressIndexPath.item != NSNotFound) {
            //如果是每页最后的一个button，则是删除键，应该实现删除的功能
            if ((pressIndexPath.item + 1)%[self numberOfItemsInPerPage] == 0) {
                if(self.backspceItemTappedBlock)
                    self.backspceItemTappedBlock();
                return;
            }
            
            NSInteger numberOfItemsInPerPage = [self numberOfItemsInPerPage] - 1;
            MPEmojiKeyboardKeyItem *keyItem = [self.keyGroup.keyItems objectAtIndex:pressIndexPath.item-(pressIndexPath.item /numberOfItemsInPerPage)];
            MPEmojiKeyboardKeyItem *pressedKeyItem = keyItem;
            if (self.keyItemTappedBlock) {
                self.keyItemTappedBlock(pressedKeyItem);
            }
        }
        else if (pressIndexPath.item == NSNotFound && longPressGesutre.state == UIGestureRecognizerStateEnded){
            if([self isDeleteButtonLocation:pressLocation]){    //主要是判断是否是最后一页的那个backSpace Button
                if(self.backspceItemTappedBlock)
                    self.backspceItemTappedBlock();
                return;
            }
            
        }
    }else{
        MPEmojiKeyboardKeyCell *pressedCell = (MPEmojiKeyboardKeyCell *)[self.collectionView cellForItemAtIndexPath:pressIndexPath];
        
        if(!pressedCell.keyItem){
            if (self.pressedKeyItemCellChangedBlock) {
                self.pressedKeyItemCellChangedBlock(self.lastPressedCell,self.lastPressedCell);
                return;
            }
        }
        
        [self.lastPressedCell setSelected:NO];
        
        [pressedCell setSelected:YES];
        if (self.pressedKeyItemCellChangedBlock) {
            self.pressedKeyItemCellChangedBlock(self.lastPressedCell,pressedCell);
        }
        self.lastPressedCell = pressedCell;
    }
}

- (NSInteger)numberOfItemsInPerPage
{
    MPEmojiKeyboardKeysFlowLayout *flowLayout = (MPEmojiKeyboardKeysFlowLayout *)self.collectionView.collectionViewLayout;
    NSInteger numberOfItemInLine = CGRectGetWidth(self.collectionView.frame) / (flowLayout.itemSize.width + flowLayout.itemSpacing);
    NSInteger numberOfLine = CGRectGetHeight(self.collectionView.frame) / (flowLayout.itemSize.height +  flowLayout.lineSpacing);
    return numberOfLine*numberOfItemInLine;
}

- (NSInteger)numberOfPage
{
    NSInteger count = self.keyGroup.keyItems.count;
    NSInteger numberOfPage = (count / ([self numberOfItemsInPerPage] - 1)) + !!(count % ([self numberOfItemsInPerPage] - 1));
    return numberOfPage;
}

- (BOOL)isDeleteButtonLocation:(CGPoint)pressPoint
{
    for (int i = 0; i<[self numberOfPage]; i++) {
        UIButton *button = (UIButton *)[self.collectionView viewWithTag:i+1000];
        if (CGRectContainsPoint(button.frame, pressPoint)) {
            return YES;
        }
    }
    return NO;
    
}
#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate

-(void)refreshPageControl
{
    self.pageControl.numberOfPages = ceil(self.collectionView.contentSize.width / CGRectGetWidth(self.collectionView.bounds));
    self.pageControl.currentPage = floor(self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds));
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self refreshPageControl];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshPageControl];
    });
    
    //为了能在每个page的最后一个位置上放删除按钮，所以这里要在每一页多加一个，最后一页可能加
    
    NSInteger numberOfItems = self.keyGroup.keyItems.count;
    NSInteger numberOfItemsInPerPage = [self numberOfItemsInPerPage] - 1;
    NSInteger extraNumber = numberOfItems / numberOfItemsInPerPage ;
    return numberOfItems + extraNumber;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MPEmojiKeyboardKeyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(_keyGroup.keyItemCellClass)
                                                                             forIndexPath:indexPath];
    if(!cell)
        cell = [[MPEmojiKeyboardKeyCell alloc] init];
    NSInteger numberOfItemsInPerPage = [self numberOfItemsInPerPage] - 1;
    
    //每一页的最后一个的KeyItem设置为空，为了给删除按钮提供位置。
    if(indexPath.item != 0 && !((indexPath.item+1) %[self numberOfItemsInPerPage]) ){
        cell.keyItem = nil;
    }
    else{
        cell.keyItem = [self.keyGroup.keyItems objectAtIndex:indexPath.item-(indexPath.item /numberOfItemsInPerPage)];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSInteger numberOfItemsInPerPage = [self numberOfItemsInPerPage] - 1;
    MPEmojiKeyboardKeyItem *keyItem = [self.keyGroup.keyItems objectAtIndex:indexPath.item-(indexPath.item /numberOfItemsInPerPage)];
    if(self.keyItemTappedBlock)
        self.keyItemTappedBlock(keyItem);
}
@end
