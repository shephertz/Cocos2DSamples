//
//  TransactionB.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 17/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BandwidthTransaction.h"
#import "App42Response.h"

@interface TransactionB : App42Response{
    
    NSString *serviceName;
    NSString *usage;
    NSString *transactionId;
    NSDate *usageDate;
    BandwidthTransaction *bandwidthTransactionObject;
}

@property(nonatomic,retain)NSString *serviceName;
@property(nonatomic,retain)NSString *usage;
@property(nonatomic,retain)NSString *transactionId;
@property(nonatomic,retain)NSDate *usageDate;
@property(nonatomic,retain)BandwidthTransaction *bandwidthTransactionObject;

- (id) init __attribute__((unavailable));

-(id)initWithBandwidthTransaction:(BandwidthTransaction*)bandwidthTransactionObj;

@end
