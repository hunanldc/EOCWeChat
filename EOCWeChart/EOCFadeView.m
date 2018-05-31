//
//  EOCFadeView.m
//  EOCWeChart
//
//  Created by leo on 2018/5/30.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "EOCFadeView.h"
#import <QuartzCore/QuartzCore.h>

@interface EOCFadeView () <CAAnimationDelegate>

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) CGRect fromRect;
@property (assign, nonatomic) CGRect toRect;

@end

@implementation EOCFadeView

+ (EOCFadeView *)fadeWithController:(UIViewController *)controller {
    EOCFadeView *fadeView = [[EOCFadeView alloc] initWithFrame:controller.view.bounds];
    UIGraphicsBeginImageContext(controller.view.bounds.size);
    [controller.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    fadeView.imageView.image = image;
    UIGraphicsEndImageContext();
    fadeView.imageView.backgroundColor = [UIColor greenColor];
    return fadeView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)animateFrom:(CGRect)rect animateTo:(CGRect)toRect {
    self.fromRect = rect;
    self.toRect = toRect;
    [self startAnimation];
}

- (void)startAnimation {
    CGFloat duration = 10.0;
    CGPoint fromCenter = CGPointMake(CGRectGetMidX(self.fromRect), CGRectGetMidY(self.fromRect));
    CGPoint toCenter = CGPointMake(CGRectGetMidX(self.toRect), CGRectGetMidY(self.toRect));
    CGFloat scaleX = self.toRect.size.width/self.fromRect.size.width;
    CGFloat scaleY = self.toRect.size.height/self.fromRect.size.height;
    CGFloat moveX = toCenter.x - fromCenter.x;
    CGFloat moveY = toCenter.y - fromCenter.y;
    
    CATransform3D transfrom = CATransform3DMakeTranslation(moveX, moveY, 0);
    transfrom = CATransform3DScale(transfrom, scaleX, scaleY, 1);
    
    //平移+缩小
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    anim.toValue = [NSValue valueWithCATransform3D:transfrom];
    anim.duration = 1.0;
    anim.delegate = self;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anim];
    group.duration = duration;
    group.removedOnCompletion = true;
    group.fillMode = kCAFillModeForwards;
    
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = self.fromRect;
    mask.path = [UIBezierPath bezierPathWithRoundedRect:self.fromRect cornerRadius:30.0].CGPath;
    mask.fillColor = [UIColor grayColor].CGColor;
    mask.lineCap = kCALineCapRound;
    mask.lineWidth = duration;
    self.imageView.layer.mask = mask;

    [mask addAnimation:anim forKey:@"revealAnimation"];
}

- (void)stopAnimation {
}

- (void)animationDidStart:(CAAnimation *)anim {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.backgroundColor = [UIColor clearColor];
    [self removeFromSuperview];
}


@end
