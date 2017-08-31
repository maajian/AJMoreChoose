//
//  MyButton.m
//  zhundao
//
//  Created by zhundao on 2017/2/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
+(UIButton *)initWithButtonFrame:(CGRect)frame title:(NSString *)title textcolor:(UIColor *)textColor Target:(id)target action:(SEL)action BackgroundColor:(UIColor *)BackgroundColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds
{
    return  [[self alloc]initWithButtonFrame:frame title:title textcolor:textColor Target:target action:action BackgroundColor:BackgroundColor cornerRadius:cornerRadius masksToBounds:masksToBounds ];
}
- (instancetype)initWithButtonFrame:(CGRect)frame title:(NSString *)title textcolor:(UIColor *)textColor Target:(id)target action:(SEL)action BackgroundColor:(UIColor *)BackgroundColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds
{
    self = [super init];
    if (self) {
        self.frame = frame;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self setBackgroundColor:BackgroundColor];
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
    }
    return self;
}



@end
