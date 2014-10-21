//
//  IBImageBrowserDataSource.h
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/18/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageBrowserViewController.h"
@protocol IBImageBrowserDataSourceDelegate;

@interface IBImageBrowserDataSource : NSObject <ImageBrowserViewControllerDataSource>
@property (nonatomic, weak) id <IBImageBrowserDataSourceDelegate> delegate;
@end

@protocol IBImageBrowserDataSourceDelegate <NSObject>
-(void)imageBrowserDataSourceFinishLoadingData:(IBImageBrowserDataSource *) imageBrowserDataSource withError:(NSError *) error;
@end