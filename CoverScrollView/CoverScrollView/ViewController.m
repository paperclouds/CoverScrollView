//
//  ViewController.m
//  CoverScrollView
//
//  Created by paperclouds on 2018/5/17.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import "ViewController.h"
#import "SCAdView.h"
#import "CoverCollectionViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<SCAdViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutCoverView];
}

- (void)layoutCoverView{
    NSArray *imageArrays = @[@"1",@"2",@"3",@"4",@"5"];
    SCAdView *sdView = [[SCAdView alloc]initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = imageArrays;
        builder.viewFrame = CGRectMake(0, 100, kScreenWidth, 200);
        builder.adItemSize = CGSizeMake(120, 120);
        builder.minimumLineSpacing = -50;
        builder.secondaryItemMinAlpha = 0.85;
        builder.threeDimensionalScale = 1.45;
        builder.itemCellNibName = @"CoverCollectionViewCell";
    }];
    sdView.backgroundColor = [UIColor blackColor];
    sdView.delegate = self;
    [self.view addSubview:sdView];
}

#pragma mark - SCAdViewDelegate

-(void)sc_didClickAd:(id)adModel{
    
}

-(void)sc_scrollToIndex:(NSInteger)index{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
