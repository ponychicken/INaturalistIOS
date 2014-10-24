//
//  ExploreListTableViewCell.m
//  Explore Prototype
//
//  Created by Alex Shepard on 10/6/14.
//  Copyright (c) 2014 iNaturalist. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <FontAwesomeKit/FAKIonIcons.h>

#import "ExploreListTableViewCell.h"
#import "ExploreObservation.h"
#import "ExploreObservationPhoto.h"
#import "UIColor+ExploreColors.h"
#import "UIImage+ExploreIconicTaxaImages.h"

static NSDateFormatter *shortFormatter;

@interface ExploreListTableViewCell () {
    UIImageView *observationImageView;
    
    UILabel *commonNameLabel;
    UILabel *scientificNameLabel;
    UILabel *observationAttrLabel;  // ID Needed, or Research Grade
    UILabel *observerNameLabel;
    UILabel *observedOnLabel;
    
    UIView *separator;  // custom separator
}
@end

@implementation ExploreListTableViewCell

// designated initializer for UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.contentView.backgroundColor = [UIColor whiteColor];
        
        observationImageView = ({
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectZero];
            iv.translatesAutoresizingMaskIntoConstraints = NO;
            
            iv.contentMode = UIViewContentModeScaleAspectFit;
            // TODO: need a default image
            
            iv;
        });
        [self.contentView addSubview:observationImageView];
        
        commonNameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textColor = [UIColor colorForIconicTaxon:nil];
            label.font = [UIFont boldSystemFontOfSize:17.0f];
            
            label;
        });
        [self.contentView addSubview:commonNameLabel];
        
        scientificNameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textColor = [UIColor blackColor];
            label.font = [UIFont italicSystemFontOfSize:14.0f];
            
            label;
        });
        [self.contentView addSubview:scientificNameLabel];
        
        observationAttrLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.hidden = YES;
            label.textAlignment = NSTextAlignmentCenter;
            
            label.layer.cornerRadius = 5.0f;
            label.clipsToBounds = YES;
            
            label;
        });
        [self.contentView addSubview:observationAttrLabel];
        
        observerNameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:14.0f];
            
            label;
        });
        [self.contentView addSubview:observerNameLabel];
        
        observedOnLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.textAlignment = NSTextAlignmentRight;
            
            label;
        });
        [self.contentView addSubview:observedOnLabel];
        
        separator = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            
            view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
            
            view;
        });
        [self.contentView addSubview:separator];
        
        if (!shortFormatter) {
            shortFormatter = [[NSDateFormatter alloc] init];
            shortFormatter.dateStyle = NSDateFormatterShortStyle;
            shortFormatter.timeStyle = NSDateFormatterNoStyle;
        }
        
        // horizontally center imageview in cell
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationImageView
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        // imageview height is cell height - 4px
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationImageView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:-4.0f]];
        // imageview is anchored 5 px from left edge of cell
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationImageView
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:0.0f
                                                          constant:4.0f]];
        // imageview is perfectly square
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationImageView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:observationImageView
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        
        // common name label - 10px from imageview
        [self addConstraint:[NSLayoutConstraint constraintWithItem:commonNameLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:observationImageView
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0f
                                                          constant:10.0f]];
        // common name label - stretch the rest of the cell width
        [self addConstraint:[NSLayoutConstraint constraintWithItem:commonNameLabel
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0f
                                                          constant:-5.0f]];
        // common name label - 5px from top of the cell
        [self addConstraint:[NSLayoutConstraint constraintWithItem:commonNameLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0f
                                                          constant:5.0f]];
        
        // scientific name label - 1 pixel indented from common name label
        [self addConstraint:[NSLayoutConstraint constraintWithItem:scientificNameLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:commonNameLabel
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0f
                                                          constant:1.0f]];
        // scientific name lable - stretch the rest of the cell width
        [self addConstraint:[NSLayoutConstraint constraintWithItem:scientificNameLabel
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0f
                                                          constant:-5.0f]];
        // scientific name label - just below common name
        [self addConstraint:[NSLayoutConstraint constraintWithItem:scientificNameLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:commonNameLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        
        // observer label - left aligned with common name
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observerNameLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:commonNameLabel
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        // observer label - width 70% of tableview cell (other 30% will go to observed on)
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observerNameLabel
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:(self.frame.size.width - 105.0f) * .7]];
        // observer label - bottom aligned with imageview bottom
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observerNameLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:observationImageView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        
        // observed on label - right aligned with cell
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observedOnLabel
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0f
                                                          constant:-5.0f]];
        // observed on label - width 30% of tableview cell (other 70% will go to observed by)
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observedOnLabel
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:0.5f
                                                          constant:(self.frame.size.width - 105.0f) * .3]];
        // observed on label - baseline aligned with observer baseline
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observedOnLabel
                                                         attribute:NSLayoutAttributeBaseline
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:observerNameLabel
                                                         attribute:NSLayoutAttributeBaseline
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        
        
        // observation attr label - left aligned with common name left
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationAttrLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:commonNameLabel
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        // observation attr label - static width
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationAttrLabel
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:100.0f]];
        // observation attr label - static height
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationAttrLabel
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:25.0f]];
        // observation attr label - above observer name label
        [self addConstraint:[NSLayoutConstraint constraintWithItem:observationAttrLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:observerNameLabel
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0f
                                                          constant:-10.0f]];
        
        // separator - height of 1px
        [self addConstraint:[NSLayoutConstraint constraintWithItem:separator
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:1.0f]];
        // separator - bottom of cell
        [self addConstraint:[NSLayoutConstraint constraintWithItem:separator
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        // separator - starts 4px to the right of the imageview
        [self addConstraint:[NSLayoutConstraint constraintWithItem:separator
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:observationImageView
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0f
                                                          constant:4.0f]];
        // separator - pinned to right
        [self addConstraint:[NSLayoutConstraint constraintWithItem:separator
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0f
                                                          constant:0.0f]];

    }
    
    return self;
}

- (void)prepareForReuse {
    observationImageView.image = nil;
    observationImageView.layer.borderColor = [UIColor clearColor].CGColor;
    observationImageView.layer.borderWidth = 0.0f;
    commonNameLabel.text = nil;
    scientificNameLabel.text = nil;
    observerNameLabel.text = nil;
    observationAttrLabel.text = nil;
    observationAttrLabel.hidden = YES;
    observedOnLabel.text = nil;
}

- (void)setObservation:(ExploreObservation *)observation {
    observationImageView.image = [UIImage imageForIconicTaxon:observation.iconicTaxonName];
    
    if (observation.observationPhotos.count > 0) {
        ExploreObservationPhoto *photo = (ExploreObservationPhoto *)observation.observationPhotos.firstObject;
        
        [observationImageView sd_setImageWithURL:[NSURL URLWithString:photo.squareURL]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           [observationImageView setNeedsDisplay];
                                       }];
    }
    
    commonNameLabel.text = observation.commonName;
    if (!commonNameLabel.text || [commonNameLabel.text isEqualToString:@""])
        commonNameLabel.text = observation.speciesGuess;
    if (!commonNameLabel.text || [commonNameLabel.text isEqualToString:@""])
        commonNameLabel.text = @"Something...";
    commonNameLabel.textColor = [UIColor colorForIconicTaxon:observation.iconicTaxonName];
    
    scientificNameLabel.text = observation.taxonName;
    observerNameLabel.text = observation.observerName;
    
    NSDate *date = [observation timeObservedAt];
    // looks like time_observed_at_utc can be null?
    if (!date)
        date = [observation observedOn];
    @synchronized(shortFormatter) {
        observedOnLabel.text = [shortFormatter stringFromDate:date];
    }
    
    if (observation.idPlease) {
        observationAttrLabel.text = @"ID PLEASE";
        observationAttrLabel.textColor = [UIColor colorForIdPleaseNotice];
        observationAttrLabel.backgroundColor = [UIColor secondaryColorForIdPleaseNotice];
        observationAttrLabel.hidden = NO;
    } else if ([observation.qualityGrade isEqualToString:@"research"]) {
        observationAttrLabel.text = @"RESEARCH";
        observationAttrLabel.textColor = [UIColor colorForResearchGradeNotice];
        observationAttrLabel.backgroundColor = [UIColor secondaryColorForResearchGradeNotice];
        observationAttrLabel.hidden = NO;
    }
}

@end