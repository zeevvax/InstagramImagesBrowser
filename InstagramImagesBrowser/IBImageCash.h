//
//  IBImageCash.h
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/19/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

@interface IBImageCash : NSObject
+ (IBImageCash *)sharedCash;
-(void)addImage:(UIImage *) image withKey:(NSString *) key;
-(UIImage *)imageForKey:(NSString *)key;
@end
