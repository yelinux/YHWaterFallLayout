//
//  YHWaterFallLayout.h
//  DemoTest
//
//  Created by chenyehong on 2021/3/8.
//  Copyright © 2021 cyh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YHWaterFallLayout;

@protocol YHWaterFallLayoutDelegate <NSObject>

-(CGSize)yHWaterFallLayout:(YHWaterFallLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional
-(CGSize)yHWaterFallLayout:(YHWaterFallLayout *)layout sizeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end

@interface YHWaterFallLayout : UICollectionViewLayout

@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
@property (nonatomic) UIEdgeInsets sectionInset;
@property (weak, nonatomic) id<YHWaterFallLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
