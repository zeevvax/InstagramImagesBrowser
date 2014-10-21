//
//  IBImageBrowserDataSource.m
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/18/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//


#import "IBImageBrowserDataSource.h"
#import "ImageBrowserViewController.h"
#import "IBDataLoader.h"
@interface IBImageBrowserDataSource() 
@property (nonatomic, strong) NSArray *imagesInfo;
@end

@implementation IBImageBrowserDataSource

- (instancetype)init{
    self = [super init];
    if (self){
        _imagesInfo = [NSArray new];
        [self loadData];
        
    }
    return self;
}

-(void)loadData{
    [[IBDataLoader sharedLoader] loadImageDataWithCompletionHandler:^(NSArray *imagesInfo, NSError *error) {
        if (!error) {
            self.imagesInfo = imagesInfo;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(imageBrowserDataSourceFinishLoadingData:withError:)])
                [self.delegate imageBrowserDataSourceFinishLoadingData:self withError:error];
        });
    }];
}

#pragma mark - ImageBrowserViewControllerDataSource
-(NSUInteger)imageBrowserViewControllerNumberOfImages:(ImageBrowserViewController*) imageBrowserVC{
    return self.imagesInfo.count;
}

-(IBImageInfo*)imageBrowserViewControllerInfoForImage:(ImageBrowserViewController*) imageBrowserVC atIndex:(NSUInteger) index{
    NSAssert(index >= 0 && index < self.imagesInfo.count, @"Request for index out of range");
    return self.imagesInfo[index];
}

-(void)imageBrowserViewControllerReloadData:(ImageBrowserViewController*) imageBrowserVC{
    [self loadData];
}

@end
