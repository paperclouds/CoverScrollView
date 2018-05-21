//
//  ViewController.h
//  CoverScrollView
//
//  Created by paperclouds on 2018/5/17.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAdView.h"

@interface ViewController : UIViewController

/**
 *  记录当前点击的indexPath
 */
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) SCAdView *sdView;

@end

