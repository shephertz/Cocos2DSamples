//
//  ABTestResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Rajeev Ranjan on 17/10/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@class ABTest;

@interface ABTestResponseBuilder : App42ResponseBuilder

-(ABTest*)buildResponse:(NSString*)response;
-(ABTest*)buildABTestObject:(NSDictionary*)abTestResponseDict;
@end
