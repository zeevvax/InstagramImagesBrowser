//
//  IBImageViewerViewController.m
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/19/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import "IBImageViewerViewController.h"
#import "IBImageInfo.h"
#import "UIImage+IBDataLoader.h"

@interface IBImageViewerViewController ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end

@implementation IBImageViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.imageInfo.ownerName;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupImageView];
    [self setupActivityIndicator];
    [self setupViewConstarints];
    
    [self.activityIndicator startAnimating];
    [UIImage imageWithURLPath:self.imageInfo.urlPathStandard completionHandler:^(UIImage *image, NSError *error){
        [self.activityIndicator stopAnimating];
        if (!error)
            self.imageView.image = image;
    }];

}

- (void)setupImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

-(void)setupActivityIndicator{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:activityIndicator];
    self.activityIndicator = activityIndicator;
}

-(void)setupViewConstarints{
    NSDictionary *viewsDictionary = @{@"imageView":self.imageView};
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *imageViewConstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[imageView]-0-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:viewsDictionary];
    
    NSArray *imageViewConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:viewsDictionary];
    [self.view addConstraints:imageViewConstraint_H];
    [self.view addConstraints:imageViewConstraint_V];
    
    NSLayoutConstraint *activityIndicatorCenterX = [NSLayoutConstraint
                                                    constraintWithItem:self.activityIndicator
                                                    attribute:NSLayoutAttributeCenterX
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                    attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                    constant:0.f];
    NSLayoutConstraint *activityIndicatorCenterY = [NSLayoutConstraint
                                                    constraintWithItem:self.activityIndicator
                                                    attribute:NSLayoutAttributeCenterY
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                    attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                    constant:0.f];
    [self.view addConstraint:activityIndicatorCenterX];
    [self.view addConstraint:activityIndicatorCenterY];
    
    
    
}



@end
