//
//  TransactionL.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 17/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LicenseTransaction.h"
#import "App42Response.h"

@interface TransactionL : App42Response{
    NSString *serviceName;
    NSString *transactionId;
    NSDate *issueDate;
    BOOL isValid;
    NSString *key;
    LicenseTransaction *licenseTransactionObj;
}

@property(nonatomic,retain)NSString *serviceName;
@property(nonatomic,retain)NSString *transactionId;
@property(nonatomic,retain)NSDate *issueDate;
@property(nonatomic,assign)BOOL isValid;
@property(nonatomic,retain)NSString *key;
@property(nonatomic,retain)LicenseTransaction *licenseTransactionObj;

- (id) init __attribute__((unavailable));

-(id)initWithLicenseTransaction:(LicenseTransaction*)licenseTransactionObject;


@end
