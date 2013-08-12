//
//  UserResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 09/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "User.h"

@interface UserResponseBuilder : App42ResponseBuilder
{
    
}

-(User*) buildUserResponse:(NSString*)json;
-(NSArray*)buildArrayResponse:(NSString*)json;

@end
