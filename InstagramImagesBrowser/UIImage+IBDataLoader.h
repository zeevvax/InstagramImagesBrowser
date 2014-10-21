//
//  UIIMageView+IBDataLoader.h
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/19/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IBDataLoader)
+(void)imageWithURLPath:(NSString*)urlPath completionHandler:(void(^)(UIImage *image, NSError *error))onComplete;
@end
