//
//  TransactionS.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 17/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StorageTransaction.h"

@interface TransactionS : NSObject{
    
    NSString *serviceName;
    NSString *transactionId;
    NSString *usage;
    NSDate *usageDate;
    StorageTransaction *storageTransactionObject;
}

@property(nonatomic,retain)NSString *serviceName;
@property(nonatomic,retain)NSString *transactionId;
@property(nonatomic,retain)NSDate *usageDate;
@property(nonatomic,retain)NSString *usage;
@property(nonatomic,retain)StorageTransaction *storageTransactionObject;


- (id) init __attribute__((unavailable));

-(id)initWithStorageTransaction:(StorageTransaction*)storageTransactionObj;

@end
