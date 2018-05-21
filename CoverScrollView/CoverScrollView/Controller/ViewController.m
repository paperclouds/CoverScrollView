//
//  ViewController.m
//  CoverScrollView
//
//  Created by paperclouds on 2018/5/17.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import "ViewController.h"
#import "CoverCollectionViewCell.h"
#import "SecondViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<SCAdViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy) NSArray *imageArrays;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutCoverView];
}

- (void)layoutCoverView{
    self.imageArrays = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6"];
    self.sdView = [[SCAdView alloc]initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = self.imageArrays;
        builder.viewFrame = CGRectMake(0, 100, kScreenWidth, 200);
        builder.adItemSize = CGSizeMake(120, 120);
        builder.minimumLineSpacing = -50;
        builder.secondaryItemMinAlpha = 0.85;
        builder.threeDimensionalScale = 1.45;
        builder.itemCellNibName = @"CoverCollectionViewCell";
    }];
    self.sdView.backgroundColor = [UIColor blackColor];
    self.sdView.delegate = self;
    [self.view addSubview:self.sdView];
}

#pragma mark - SCAdViewDelegate

-(void)sc_didClickAd:(NSInteger)index{
    NSInteger count = self.imageArrays.count;
    self.currentIndex = index + 1000;
    SecondViewController *second = [[SecondViewController alloc]init];
    second.index = index % count;
    self.navigationController.delegate = second;
    [self.navigationController pushViewController:second animated:YES];
}

-(void)sc_scrollToIndex:(NSInteger)index{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
