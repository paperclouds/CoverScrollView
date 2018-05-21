//
//  ADCardTransition.m
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "ADCardTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "CoverCollectionViewCell.h"

@interface ADCardTransition ()

/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) ADCardTransitionType type;

@end

@implementation ADCardTransition

+ (instancetype)transitionWithType:(ADCardTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(ADCardTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case ADCardTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
            
        case ADCardTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}

// 执行push过渡动画
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //起始页面
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标页面
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //拿到当前点击的cell的imageView
    CoverCollectionViewCell *cell;
    NSArray *cellArray = [fromVC.sdView.collectionView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (fromVC.currentIndex == ([cellArray[i] tag])) {
            cell = (CoverCollectionViewCell *)cellArray[i];
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    //图片
    UIView *imageView = [self imageFromView:cell.imageView];
    imageView.frame = [cell.imageView convertRect:cell.imageView.bounds toView: containerView];
    
    //设置动画前的各个控件的状态
    cell.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.tableView.hidden = YES;
    
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:imageView];
    
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //图片frame
            imageView.frame = [toVC.topImageView convertRect:toVC.topImageView.bounds toView:containerView];
            toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        imageView.hidden = YES;
        toVC.topImageView.hidden = NO;
        toVC.tableView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

- (UIView *)imageFromView:(UIView *)snapView{
        UIGraphicsBeginImageContext(snapView.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [snapView.layer renderInContext:context];
        UIImage * targetImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        UIImageView * tmpView = [[UIImageView alloc] initWithImage:targetImage];
        snapView.frame = snapView.frame;
        return tmpView;
}

//执行pop过渡动画
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //取到cell
    CoverCollectionViewCell *cell;
    NSArray *cellArray = [toVC.sdView.collectionView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (toVC.currentIndex == [cellArray[i] tag]) {
            cell = (CoverCollectionViewCell *)cellArray[i];
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *imageView = containerView.subviews.lastObject;
    
    //设置初始状态
    cell.imageView.hidden = YES;
    fromVC.topImageView.hidden = YES;
    imageView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        cell.imageView.hidden = NO;
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}

@end
