//
//  ImageBrowserTableViewCell.h
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/18/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IBImageInfo;

@interface ImageBrowserTableViewCell : UITableViewCell
@property (nonatomic, strong) IBImageInfo *imageInfo;
-(void)loadHiResolutionImage;
@end
