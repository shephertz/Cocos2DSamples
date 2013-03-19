//
//  LicenseResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 16/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "License.h"
#import "App42ResponseBuilder.h"

@interface LicenseResponseBuilder : App42ResponseBuilder

-(License*)buildResponse:(NSString*)Json;
-(NSArray*)buildArrayResponse:(NSString*)Json;

@end
