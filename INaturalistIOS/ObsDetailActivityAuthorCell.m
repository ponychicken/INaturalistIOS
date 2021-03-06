//
//  ObsDetailActivityAuthorCell.m
//  iNaturalist
//
//  Created by Alex Shepard on 12/9/15.
//  Copyright © 2015 iNaturalist. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <UIColor-HTMLColors/UIColor+HTMLColors.h>

#import "ObsDetailActivityAuthorCell.h"

@implementation ObsDetailActivityAuthorCell

- (void)awakeFromNib {
    [self configureTextFieldColors];
}

- (void)prepareForReuse {
    [self.authorImageView sd_cancelCurrentImageLoad];
    self.authorImageView.image = nil;
    self.authorNameLabel.text = nil;
    self.dateLabel.text = nil;
    
    [self configureTextFieldColors];
}

- (void)configureTextFieldColors {
    self.authorNameLabel.textColor = [UIColor colorWithHexString:@"#8e8e93"];
    self.dateLabel.textColor = [UIColor colorWithHexString:@"#8e8e93"];
}

@end
