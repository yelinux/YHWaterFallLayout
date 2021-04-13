//
//  WaterFallExampleItemView.m
//  YHWaterFallLayoutExample
//
//  Created by chenyehong on 2021/4/13.
//

#import "WaterFallExampleItemView.h"

@interface WaterFallExampleItemView()

@property (strong, nonatomic) UILabel *lb;

@end

@implementation WaterFallExampleItemView

-(CGSize)setData: (WaterFallExampleData*)data{
    self.lb.text = data.text;
    self.lb.backgroundColor = data.color;
    return [self.lb sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lb.frame = self.bounds;
}

-(UILabel *)lb{
    if (_lb == nil) {
        _lb = [[UILabel alloc] init];
        _lb.textColor = UIColor.blackColor;
        _lb.numberOfLines = 0;
        [self addSubview:_lb];
    }
    return _lb;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
