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

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.lb];
        self.lb.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [self.lb.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0],
            [self.lb.topAnchor constraintEqualToAnchor:self.topAnchor constant:0],
            [self.lb.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0],
            [self.lb.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0]
        ]];
    }
    return self;
}

-(CGSize)setData: (WaterFallExampleData*)data{
    self.lb.text = data.text;
    self.lb.backgroundColor = data.color;
    [self.lb setPreferredMaxLayoutWidth:self.lb.bounds.size.width];
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

-(UILabel *)lb{
    if (_lb == nil) {
        _lb = [[UILabel alloc] init];
        _lb.textColor = UIColor.blackColor;
        _lb.numberOfLines = 0;
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
