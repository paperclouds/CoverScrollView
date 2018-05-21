//
//  CoverCollectionViewCell.m
//  CoverScrollView
//
//  Created by paperclouds on 2018/5/18.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import "CoverCollectionViewCell.h"
#import "CoverModel.h"

@implementation CoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 3;
    _bgImageView.layer.masksToBounds = YES;
    _bgImageView.layer.cornerRadius = 3;
}

- (void)setModel:(id)model{
    if ([model isKindOfClass:[CoverModel class]]) {
        CoverModel *c_model = model;
        [self.imageView setImage: [UIImage imageNamed:c_model.imageName]];
    }else{
        NSString *name = model;
        self.imageView.image = [UIImage imageNamed:name];
    }

}

@end
