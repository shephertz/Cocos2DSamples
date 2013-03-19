//
//  TransactionT.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 17/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeTransaction.h"
#import "App42Response.h"

@interface TransactionT : App42Response{
    NSString *serviceName;
    NSString *usage;
    NSString *transactionId;
    NSDate *usageDate;
    TimeTransaction *timeTransactionObject;
}

@property(nonatomic,retain)NSString *serviceName;
@property(nonatomic,retain)NSString *usage;
@property(nonatomic,retain)NSString *transactionId;
@property(nonatomic,retain)NSDate *usageDate;
@property(nonatomic,retain)TimeTransaction *timeTransactionObject;

- (id) init __attribute__((unavailable));

-(id)initWithTimeTransaction:(TimeTransaction*)timeTransactionObj;
@end
