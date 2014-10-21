//
//  ImageBrowserTableViewCell.m
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/18/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import "ImageBrowserTableViewCell.h"
#import "IBImageInfo.h"
#import "UIImage+IBDataLoader.h"

typedef enum {
    ImageBrowserTableViewCellResolutionLow,
    ImageBrowserTableViewCellResolutionHi
} ImageBrowserTableViewCellResolution;

@interface ImageBrowserTableViewCell()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *pictureImageView;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation ImageBrowserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupNameLable];
        [self setupImageView];
        [self setupActivityIndicator];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)setupNameLable{
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont systemFontOfSize:12];
    name.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:name];
    self.nameLabel = name;
}

- (void)setupImageView{
    UIImageView *pictureImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:pictureImageView];
    self.pictureImageView = pictureImageView;
}

-(void)setupActivityIndicator{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    [self.contentView addSubview:activityIndicator];
    self.activityIndicator = activityIndicator;
}

-(void)setupViewConstarints{
    NSDictionary *viewsDictionary = @{@"nameLabel": self.nameLabel, @"pictureImageView":self.pictureImageView};
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.pictureImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;

    NSArray *nameLabelConstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[nameLabel(20)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *nameLabelConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[nameLabel]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    [self.contentView addConstraints:nameLabelConstraint_H];
    [self.contentView addConstraints:nameLabelConstraint_V];
    
    NSArray *pictureImageViewConstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[pictureImageView]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    
    NSArray *pictureImageViewConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pictureImageView]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    [self.contentView addConstraints:pictureImageViewConstraint_H];
    [self.contentView addConstraints:pictureImageViewConstraint_V];
    
    NSLayoutConstraint *activityIndicatorCenterX = [NSLayoutConstraint
                                                    constraintWithItem:self.activityIndicator
                                                    attribute:NSLayoutAttributeCenterX
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.contentView
                                                    attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                    constant:0.f];
    NSLayoutConstraint *activityIndicatorCenterY = [NSLayoutConstraint
                                                    constraintWithItem:self.activityIndicator
                                                    attribute:NSLayoutAttributeCenterY
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.contentView
                                                    attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                    constant:0.f];
    [self.contentView addConstraint:activityIndicatorCenterX];
    [self.contentView addConstraint:activityIndicatorCenterY];
    
    

}

- (void)updateConstraints {
    
    if (self.didSetupConstraints == NO){
        [self setupViewConstarints];
    }
    [super updateConstraints];
}

- (void)setImageInfo:(IBImageInfo *)imageInfo{
    _imageInfo = imageInfo;
    if (!_imageInfo){
        self.nameLabel.text = nil;
        self.pictureImageView.image = nil;
        return;
    }
    self.nameLabel.text = _imageInfo.ownerName;
    [self loadImageWithResolution:ImageBrowserTableViewCellResolutionLow];
}

-(void)loadImageWithResolution:(ImageBrowserTableViewCellResolution) resolution{
    NSString *urlPath;
    switch (resolution) {
        case ImageBrowserTableViewCellResolutionLow:
            urlPath = self.imageInfo.urlPathThumbnail;
            break;
        case ImageBrowserTableViewCellResolutionHi:
            urlPath = self.imageInfo.urlPathStandard;
            break;
        default:
            urlPath = self.imageInfo.urlPathThumbnail;
            break;
    }
    [self.activityIndicator startAnimating];
    [UIImage imageWithURLPath:urlPath completionHandler:^(UIImage *image, NSError *error){
        [self.activityIndicator stopAnimating];
        if (!error)
            self.pictureImageView.image = image;
    }];
}

-(void)loadHiResolutionImage{
    [self loadImageWithResolution:ImageBrowserTableViewCellResolutionHi];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
