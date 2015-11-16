//
//  MPEmojiKeyboardKeysFlowLayout.m
//  MPEmojiKeyboard
//
//  Created by MacPu on 15/7/11.
//  Copyright (c) 2015年 MacPu. All rights reserved.
//

#import "MPEmojiKeyboardKeysFlowLayout.h"

@implementation MPEmojiKeyboardKeysFlowLayout

- (NSInteger)numberOfItems
{
    NSInteger section = 0;
    NSInteger numberOfItems = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
    return numberOfItems;
}

- (CGSize)pageSize
{
    return self.collectionView.bounds.size;
}

- (CGSize)avaliableSizePerPage
{
    return (CGSize){
        self.pageSize.width - self.contentInsets.left - self.contentInsets.right,
        self.pageSize.height - self.contentInsets.top - self.contentInsets.bottom
    };
}

- (NSInteger)numberOfItemsPerRow
{
    return floor((self.avaliableSizePerPage.width + self.itemSpacing)/(self.itemSize.width + self.itemSpacing));
}

- (NSInteger)numberOfRowsPerPage
{
    return floor((self.avaliableSizePerPage.height + self.lineSpacing)/(self.itemSize.height + self.lineSpacing));
}

- (NSInteger)numberOfItemsPerPage
{
    return self.numberOfItemsPerRow * self.numberOfRowsPerPage;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size)) {
        return NO;
    }else{
        return YES;
    }
}

- (void)prepareLayout
{
}

- (CGSize)collectionViewContentSize
{
    CGFloat width = ceil((float)self.numberOfItems/self.numberOfItemsPerPage) * self.pageSize.width;
    CGFloat height = self.pageSize.height;
    return CGSizeMake(width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    NSInteger page = floor((float)index/self.numberOfItemsPerPage);
    NSInteger row  = floor((float)(index % self.numberOfItemsPerPage)/self.numberOfItemsPerRow);
    NSInteger n    = index % self.numberOfItemsPerRow;
    CGRect frame = (CGRect){
        {page * self.pageSize.width + self.contentInsets.left + n*(self.itemSize.width + self.itemSpacing),
            self.contentInsets.top + row*(self.itemSize.height + self.lineSpacing)},
        self.itemSize
    };
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = frame;
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<self.numberOfItems; i++){
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [array addObject:attributes];
        }
    }
    return [array copy];
}


@end
