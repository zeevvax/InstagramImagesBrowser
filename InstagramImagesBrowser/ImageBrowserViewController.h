//
//  ImageBrowserViewController.h
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/18/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IBImageInfo;
@protocol ImageBrowserViewControllerDataSource;

@interface ImageBrowserViewController : UIViewController
@property (nonatomic, strong) id<ImageBrowserViewControllerDataSource> dataSource;

@end

@protocol ImageBrowserViewControllerDataSource <NSObject>
-(NSUInteger)imageBrowserViewControllerNumberOfImages:(ImageBrowserViewController*) imageBrowserVC;
-(IBImageInfo *)imageBrowserViewControllerInfoForImage:(ImageBrowserViewController*) imageBrowserVC atIndex:(NSUInteger) index;
@optional
-(void)imageBrowserViewControllerReloadData:(ImageBrowserViewController*) imageBrowserVC;
@end
