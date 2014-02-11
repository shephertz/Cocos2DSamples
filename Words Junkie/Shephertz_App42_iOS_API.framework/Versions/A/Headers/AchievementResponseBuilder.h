//
//  AchievementResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Rajeev on 19/12/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@interface AchievementResponseBuilder : App42ResponseBuilder

-(Achievement*)buildResponse:(NSString*)response;
-(Achievement*)buildAchievementObject:(NSDictionary*)achievementDict;
-(NSArray*)buildArrayResponse:(NSString*) response;

@end
