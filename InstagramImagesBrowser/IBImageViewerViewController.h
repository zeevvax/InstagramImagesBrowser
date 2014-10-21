//
//  IBImageViewerViewController.h
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/19/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IBImageInfo;

@interface IBImageViewerViewController : UIViewController
@property (nonatomic, strong) IBImageInfo *imageInfo;

@end
