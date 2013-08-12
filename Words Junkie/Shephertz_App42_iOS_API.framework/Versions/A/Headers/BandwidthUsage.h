//
//  BandwidthUsage.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 17/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42Response.h"
@class Usage;

@interface BandwidthUsage :  NSObject{
    
    NSString *name;
    double price;
    NSString *currency;
    NSString *state;
    NSString *description;
    NSString *user;
    Usage *usageObject;
}

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *currency;
@property(nonatomic,retain)NSString *state;
@property(nonatomic,retain)NSString *description;
@property(nonatomic,retain)NSString *user;
@property(nonatomic,assign)double price;
@property(nonatomic,retain)Usage *usageObject;

- (id) init __attribute__((unavailable));

-(id)initWithUsage:(Usage*)usageObj;



@end
