//
//  AvatarResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Rajeev Ranjan on 20/11/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@interface AvatarResponseBuilder : App42ResponseBuilder

-(Avatar*)buildResponse:(NSString*)response;
-(NSArray*)buildArrayResponse:(NSString*)response;

@end
