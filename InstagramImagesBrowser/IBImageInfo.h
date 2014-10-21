//
//  IBImageInfo.h
//  InstagramImagesBrowser
//
//  Created by Zeev Vax on 10/18/14.
//  Copyright (c) 2014 Zeev Vax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBImageInfo : NSObject
@property (nonatomic, strong) NSString  *ownerName;
@property (nonatomic, strong) NSString  *urlPathThumbnail;
@property (nonatomic, strong) NSString  *urlPathStandard;
@end
