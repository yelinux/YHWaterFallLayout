//
//  YHWaterFallLayout.m
//  DemoTest
//
//  Created by chenyehong on 2021/3/8.
//  Copyright © 2021 cyh. All rights reserved.
//

#import "YHWaterFallLayout.h"

@interface YHWaterFallLayout()

@property (strong, nonatomic) NSMutableArray *attributesSupArray;
@property (strong, nonatomic) NSMutableArray *attributesArray;
@property (assign, nonatomic) CGSize contentSize;

@end

@implementation YHWaterFallLayout

-(void)prepareLayout{
    [super prepareLayout];
//    NSLog(@"%s", __func__);
    [self.attributesSupArray removeAllObjects];
    [self.attributesArray removeAllObjects];
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    self.contentSize = CGSizeMake(contentWidth, 0);
    CGFloat yBegin = 0;
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for(NSInteger sectionIndex = 0 ; sectionIndex < sectionCount ; sectionIndex++){
        UICollectionViewLayoutAttributes *attrHeader = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionIndex]];
        CGRect rectHeader = attrHeader.frame;
        rectHeader.origin.x = (contentWidth - rectHeader.size.width) / 2;
        rectHeader.origin.y = yBegin;
        attrHeader.frame = rectHeader;
        [self.attributesSupArray addObject:attrHeader];
        yBegin = (attrHeader.frame.origin.y + attrHeader.frame.size.height + self.sectionInset.top);
        
        BOOL isFirstLine = YES;//是否正处理第一行
        NSMutableArray *arrayTemp = [NSMutableArray array];
        UICollectionViewLayoutAttributes *lastAttr;
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:sectionIndex];
        for(NSInteger rowIndex = 0 ; rowIndex < itemCount ; rowIndex++){
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:rowIndex inSection:sectionIndex]];
            
            if (lastAttr) {
                if (isFirstLine) {//处理第一行时，判断越界没有
                    //越界了
                    if (lastAttr.frame.origin.x + lastAttr.frame.size.width + self.minimumInteritemSpacing + attr.bounds.size.width + self.sectionInset.right > contentWidth) {
                        isFirstLine = NO;
                    }
                }
                if (isFirstLine) {//还在处理第一行
                    attr.frame = CGRectMake(lastAttr.frame.origin.x + lastAttr.frame.size.width + self.minimumInteritemSpacing, lastAttr.frame.origin.y, attr.bounds.size.width, attr.bounds.size.height);
                    [arrayTemp addObject:attr];
                } else {//处理第2~x行
                    __block UICollectionViewLayoutAttributes *target;
                    [arrayTemp enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (target == nil || target.frame.origin.y + target.bounds.size.height > obj.frame.origin.y + obj.bounds.size.height) {
                            target = obj;
                        }
                    }];
                    CGRect rect = attr.frame;
                    rect.origin.x = target.frame.origin.x;
                    rect.origin.y = (target.frame.origin.y + target.bounds.size.height + self.minimumLineSpacing);
                    attr.frame = rect;
                    [arrayTemp removeObject:target];
                    [arrayTemp addObject:attr];
                }
            } else {
                attr.frame = CGRectMake(self.sectionInset.left, yBegin, attr.bounds.size.width, attr.bounds.size.height);
                [arrayTemp addObject:attr];
            }
            lastAttr = attr;
            
            if (attr.frame.origin.y + attr.frame.size.height > yBegin) {
                yBegin = attr.frame.origin.y + attr.frame.size.height;
            }
            
            [self.attributesArray addObject:attr];
        }
        yBegin += self.sectionInset.bottom;
        
        UICollectionViewLayoutAttributes *attrFooter = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionIndex]];
        CGRect rectFooter = attrFooter.frame;
        rectFooter.origin.x = (contentWidth - rectFooter.size.width) / 2;
        rectFooter.origin.y = yBegin;
        attrFooter.frame = rectFooter;
        [self.attributesSupArray addObject:attrFooter];
        yBegin = (attrFooter.frame.origin.y + attrFooter.frame.size.height);
    }
    
    self.contentSize = CGSizeMake(contentWidth, yBegin);
}


-(CGSize)collectionViewContentSize{
//    NSLog(@"%s", __func__);
    return self.contentSize;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%s", __func__);
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(yHWaterFallLayout:sizeForSupplementaryElementOfKind:atIndexPath:)]) {
        CGSize size = [self.delegate yHWaterFallLayout:self sizeForSupplementaryElementOfKind:elementKind atIndexPath:indexPath];
        attributes.frame = CGRectMake(0, 0, size.width, size.height);
    } else {
        attributes.frame = CGRectZero;
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%s", __func__);
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize size = [self.delegate yHWaterFallLayout:self sizeForItemAtIndexPath:indexPath];
    attributes.frame = CGRectMake(0, 0, size.width, size.height);
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSLog(@"%s", __func__);
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:self.attributesSupArray];
    [array addObjectsFromArray:self.attributesArray];
    NSMutableArray *ret = [NSMutableArray array];
    
    CGRect visibleRect = {self.collectionView.contentOffset,self.collectionView.bounds.size};
    CGFloat offsetY = visibleRect.origin.y - visibleRect.size.height;
    visibleRect.origin.y = offsetY;
    visibleRect.size.height *= 3;
    for(UICollectionViewLayoutAttributes *attributes in array){
        if (!CGRectIntersectsRect(visibleRect, attributes.frame)) {
            continue;
        }
        [ret addObject:attributes];
    }
    return ret;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    NSLog(@"%s", __func__);
    if (CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size)) {
        return NO;
    }
    return YES;
}

#pragma mark - getter

-(NSMutableArray *)attributesSupArray{
    if (_attributesSupArray == nil) {
        _attributesSupArray = [NSMutableArray array];
    }
    return _attributesSupArray;
}

-(NSMutableArray *)attributesArray{
    if (_attributesArray == nil) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

@end
