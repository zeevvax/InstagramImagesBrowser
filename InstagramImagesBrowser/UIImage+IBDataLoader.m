//
//  UIIMageView+IBDataLoader.m
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/19/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import "UIImage+IBDataLoader.h"
#import "IBDataLoader.h"
#import "IBImageCash.h"

@implementation UIImage (IBDataLoader)
+(void)imageWithURLPath:(NSString*)urlPath completionHandler:(void(^)(UIImage *image, NSError *error))onComplete{
    UIImage *cashedImage = [[IBImageCash sharedCash] imageForKey:urlPath];
    if (cashedImage){
        if (onComplete)
            onComplete(cashedImage, nil);
        return;
    }
    [[IBDataLoader sharedLoader] loadImageURLPath:urlPath completionHandler:^(NSURL *localFile, NSError *error) {
        if (error){
            if (onComplete)
                onComplete(nil, error);
        }
        else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                [[IBImageCash sharedCash] addImage:image withKey:urlPath];
                if (onComplete)
                    dispatch_async(dispatch_get_main_queue(), ^{onComplete(image, error);});
            });
        }
    }];
}


@end
