//
//  BuddyResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 03/07/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "App42ResponseBuilder.h"
#import "Buddy.h"

@interface BuddyResponseBuilder : App42ResponseBuilder

-(Buddy*) buildResponse:(NSString*)response;
-(Buddy*)buildBuddyObject:(NSDictionary*)buddyDictionary;
-(NSArray*)buildArrayResponse:(NSString*)response;
@end
