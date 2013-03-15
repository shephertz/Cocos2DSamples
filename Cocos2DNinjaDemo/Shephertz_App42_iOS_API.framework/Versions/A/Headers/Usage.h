//
//  Usage.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 16/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42Response.h"

@interface Usage : App42Response{
    
    NSMutableArray *levelList;
    NSMutableArray *oneTimeList;
    NSMutableArray *featureList;
    NSMutableArray *bandwidthList;
    NSMutableArray *storageList;
    NSMutableArray *timeList;
    
}
@property(nonatomic,retain)NSMutableArray *levelList;
@property(nonatomic,retain)NSMutableArray *oneTimeList;
@property(nonatomic,retain)NSMutableArray *featureList;
@property(nonatomic,retain)NSMutableArray *bandwidthList;
@property(nonatomic,retain)NSMutableArray *storageList;
@property(nonatomic,retain)NSMutableArray *timeList;

@end
