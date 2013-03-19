//
//  License.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 16/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42Response.h"

@interface License : App42Response{
    
    NSString *name;
    double price;
    NSString *currency;
    NSString *state;
    NSString *description;
    NSString *user;
    NSDate *issueDate;
    NSString *key;
    BOOL valid;
    
}
@property(nonatomic,retain)NSString *name;
@property(nonatomic,assign)double price;
@property(nonatomic,retain)NSString *currency;
@property(nonatomic,retain)NSString *state;
@property(nonatomic,retain)NSString *description;
@property(nonatomic,assign)NSString *user;
@property(nonatomic,retain)NSDate *issueDate;
@property(nonatomic,retain)NSString *key;
@property(nonatomic,assign)BOOL valid;

@end
