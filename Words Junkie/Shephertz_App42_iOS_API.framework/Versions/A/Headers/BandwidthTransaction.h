//
//  BandwidthTransaction.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 16/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42Response.h"
@class Bill;

@interface BandwidthTransaction : App42Response{
    
    double cost;
    NSString *currency;  
    NSString *unit;
    double bandwidth;
    double totalUsage;
    double totalCost;
    NSMutableArray *transactionList;
    Bill *billObject;
}
@property(nonatomic,assign)double cost;
@property(nonatomic,retain)NSString *currency;
@property(nonatomic,retain)NSString *unit;
@property(nonatomic,assign)double bandwidth;
@property(nonatomic,assign)double totalUsage;
@property(nonatomic,assign)double totalCost;
@property(nonatomic,retain)NSMutableArray *transactionList;
@property(nonatomic,retain)Bill *billObject;
- (id) init __attribute__((unavailable));

-(id)initWithBill:(Bill*)billObj;

@end
