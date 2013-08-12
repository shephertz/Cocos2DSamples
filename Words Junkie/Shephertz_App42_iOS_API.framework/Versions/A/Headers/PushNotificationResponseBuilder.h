//
//  PushNotificationResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 20/06/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "App42ResponseBuilder.h"
#import "App42ResponseBuilder.h"
@class PushNotification;

@interface PushNotificationResponseBuilder : App42ResponseBuilder

-(PushNotification*)buildPushResponse:(NSString*)Json;

@end
