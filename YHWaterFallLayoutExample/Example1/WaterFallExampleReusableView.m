//
//  WaterFallExampleReusableView.m
//  YHWaterFallLayoutExample
//
//  Created by chenyehong on 2021/4/13.
//

#import "WaterFallExampleReusableView.h"

@implementation WaterFallExampleReusableView

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lb.frame = self.bounds;
}

-(UILabel *)lb{
    if (_lb == nil) {
        _lb = [[UILabel alloc] init];
        _lb.textColor = UIColor.blackColor;
        _lb.backgroundColor = UIColor.lightGrayColor;
        _lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lb];
    }
    return _lb;
}

@end
