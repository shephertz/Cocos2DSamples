//
//  TransactionF.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 17/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeatureTransaction.h"

@interface TransactionF : NSObject{
    
    NSString *serviceName;
    NSString *transactionId;
    NSDate *usageDate;
    FeatureTransaction *featureTransactionObject;
}

@property(nonatomic,retain)NSString *serviceName;
@property(nonatomic,retain)NSString *transactionId;
@property(nonatomic,retain)NSDate *usageDate;
@property(nonatomic,retain)FeatureTransaction *featureTransactionObject;

- (id) init __attribute__((unavailable));

-(id)initWithFeatureTransaction:(FeatureTransaction*)featureTransactionObj;

@end
