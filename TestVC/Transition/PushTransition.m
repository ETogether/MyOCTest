//
//  PushTransition.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/11/17.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "PushTransition.h"

@implementation PushTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toVC];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    toVC.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height);
    [[transitionContext containerView] addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.alpha = 0.8;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.view.alpha = 1.0;
    }];
    
}

@end
