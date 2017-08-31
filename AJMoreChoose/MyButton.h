//
//  MyButton.h
//  zhundao
//
//  Created by zhundao on 2017/2/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton

+(UIButton *)initWithButtonFrame:(CGRect)frame title
                              :(NSString *)title
                        textcolor:(UIColor *)textColor
                        Target:(id)target
                        action:(SEL)action
               BackgroundColor:(UIColor *)BackgroundColor
                  cornerRadius:(CGFloat)cornerRadius
                 masksToBounds:(BOOL)masksToBounds
                     ;




@end
