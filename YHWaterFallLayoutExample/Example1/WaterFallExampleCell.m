//
//  WaterFallExampleCell.m
//  YHWaterFallLayoutExample
//
//  Created by chenyehong on 2021/4/13.
//

#import "WaterFallExampleCell.h"

@implementation WaterFallExampleCell

-(void)layoutSubviews{
    [super layoutSubviews];
    self.itemView.frame = self.contentView.bounds;
}

-(WaterFallExampleItemView *)itemView{
    if (_itemView == nil) {
        _itemView = [[WaterFallExampleItemView alloc] init];
        [self.contentView addSubview:_itemView];
    }
    return _itemView;
}

@end
