//
//  EOCFadeView.h
//  EOCWeChart
//
//  Created by leo on 2018/5/30.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EOCFadeView : UIView

+ (EOCFadeView *)fadeWithController:(UIViewController *)controller;
- (void)animateFrom:(CGRect)rect animateTo:(CGRect)toRect;
//- (void)startAnimation;
//- (void)stopAnimation;
@end
