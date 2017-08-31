//
//  isReadView.h
//  zhundao
//
//  Created by zhundao on 2017/8/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol readDelegate <NSObject>

- (void)readSome;

- (void)readAll;

@end

@interface isReadView : UIView

@property(nonatomic,weak) id<readDelegate>  readDelegate;

/*! 部分已读按钮 */
@property(nonatomic,strong)UIButton *chooseButton;
/*! 全部已读按钮 */
@property(nonatomic,strong)UIButton *allChooseButton;

/*! 弹出动画 */
- (void)fadeUp ;
/*! 收回动画 */
- (void)fadeOut;


@end
