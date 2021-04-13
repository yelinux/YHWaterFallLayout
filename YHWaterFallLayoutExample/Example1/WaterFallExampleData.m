//
//  WaterFallExampleData.m
//  YHWaterFallLayoutExample
//
//  Created by chenyehong on 2021/4/13.
//

#import "WaterFallExampleData.h"

@implementation WaterFallExampleData

-(UIColor *)color{
    if (_color == nil) {
        _color = [UIColor colorWithHue:( arc4random() % 256 / 256.0 ) saturation:( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 128 / 256.0 ) + 0.5 alpha:1];
    }
    return _color;
}

@end
