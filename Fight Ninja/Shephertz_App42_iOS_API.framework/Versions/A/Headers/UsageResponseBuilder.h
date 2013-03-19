//
//  UsageResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 16/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
@class Usage;

@interface UsageResponseBuilder : App42ResponseBuilder

-(Usage*)buildResponse:(NSString*)Json;

@end
