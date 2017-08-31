//
//  UIButton+UIButton_RightNav.m
//  zhundao
//
//  Created by zhundao on 2017/3/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "UIButton+UIButton_RightNav.h"

@implementation UIButton (UIButton_RightNav)
+(UIButton *)initCreateButtonWithFrame:(CGRect)frame WithImageName:(NSString *)imageName Withtarget:(id)target Selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
