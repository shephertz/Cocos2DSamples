//
//  TransactionLvl.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 17/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelTransaction.h"
#import "App42Response.h"

@interface TransactionLvl : App42Response{
    NSString *serviceName;
    NSString *transactionId;
    NSDate *usageDate;
    LevelTransaction *levelTransactionObject;
}

@property(nonatomic,retain)NSString *serviceName;
@property(nonatomic,retain)NSString *transactionId;
@property(nonatomic,retain)NSDate *usageDate;
@property(nonatomic,retain)LevelTransaction *levelTransactionObject;

- (id) init __attribute__((unavailable));

-(id)initWithLevelTransaction:(LevelTransaction*)levelTransactionObj;

@end
