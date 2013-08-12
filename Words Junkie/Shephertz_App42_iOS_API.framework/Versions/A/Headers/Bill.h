//
//  Bill.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 16/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LicenseTransaction.h"
#import "StorageTransaction.h"
#import "LevelTransaction.h"
#import "FeatureTransaction.h"
#import "BandwidthTransaction.h"
#import "TimeTransaction.h"
#import "App42Response.h"

@interface Bill : App42Response{
    
    NSString *userName;
    NSString *usageName;
    NSString *month;
    double totalUsage;
    double totalCost;
    NSString *currency;
    LicenseTransaction *licenseTransaction;
    StorageTransaction *storageTransaction;
    LevelTransaction *levelTransaction;
    FeatureTransaction *featureTransaction;
    BandwidthTransaction *bandwidthTransaction;
    TimeTransaction *timeTransaction;
    
}
@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *usageName;
@property(nonatomic,retain)NSString *month;
@property(nonatomic,assign)double totalUsage;
@property(nonatomic,assign)double totalCost;
@property(nonatomic,retain)NSString *currency;
@property(nonatomic,retain)LicenseTransaction *licenseTransaction;
@property(nonatomic,retain)StorageTransaction *storageTransaction;
@property(nonatomic,retain)LevelTransaction *levelTransaction;
@property(nonatomic,retain)FeatureTransaction *featureTransaction;
@property(nonatomic,retain)BandwidthTransaction *bandwidthTransaction;
@property(nonatomic,retain)TimeTransaction *timeTransaction;

-(id)init;

@end
