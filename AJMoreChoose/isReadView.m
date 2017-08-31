//
//  isReadView.m
//  zhundao
//
//  Created by zhundao on 2017/8/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "isReadView.h"
#import "MyButton.h"
#define kColorA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface isReadView()


@end
@implementation isReadView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 44);
        self.backgroundColor = kColorA(250, 250, 250, 1);
        [self addSubview:self.chooseButton];
        [self addSubview:self.allChooseButton];
    }
    return self;
}
#pragma mark ---懒加载

//kColorA(11, 120, 205, 1)

- (UIButton *)chooseButton{
    if (!_chooseButton) {
        _chooseButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth-100, 0, 100, 44) title:@"标为已读" textcolor:kColorA(203, 203, 203, 1) Target:self action:@selector(chooseSome) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
        _chooseButton.userInteractionEnabled = NO;
    }
    return _chooseButton;
}

- (UIButton *)allChooseButton{
    if (!_allChooseButton) {
        _allChooseButton = [MyButton initWithButtonFrame:CGRectMake(0, 0, 50, 44) title:@"全选" textcolor:kColorA(11, 120, 205, 1) Target:self action:  @selector(chooseAll) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
    }
    return _allChooseButton;
}


#pragma mark---按钮点击事件

- (void)chooseSome {
    if ([self.readDelegate respondsToSelector:@selector(readSome)])  {
        [self.readDelegate readSome];
    }
}

- (void)chooseAll{
    if ([self.readDelegate respondsToSelector:@selector(readAll)]) {
        [self.readDelegate readAll];
    }
}

#pragma mark---动画

- (void)fadeUp{
   self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 44);
   [UIView animateWithDuration:0.25 animations:^{
       self.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 44);
   }];
}

- (void)fadeOut{
    self.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 44);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 44);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc{
    NSLog(@"read没有内存泄露");
}

@end
