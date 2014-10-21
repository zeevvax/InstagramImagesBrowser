//
//  IBImageCash.m
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/19/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IBImageCash.h"

@interface IBImageCash()
@property (nonatomic, strong) NSMutableDictionary *imageCash;

@end

@implementation IBImageCash

+ (IBImageCash *)sharedCash{
    static IBImageCash *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IBImageCash alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _imageCash = [NSMutableDictionary new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lowMemory:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

-(void)lowMemory:(NSNotification *)n{
    [self.imageCash removeAllObjects];
}

-(void)addImage:(UIImage *) image withKey:(NSString *) key{
    if (!image || !key)
        return;
    self.imageCash[key] = image;
}
-(UIImage *)imageForKey:(NSString *)key{
    return key?self.imageCash[key]:nil;
}

@end
