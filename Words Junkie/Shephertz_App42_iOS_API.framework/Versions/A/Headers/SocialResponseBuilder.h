//
//  SocialResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 24/07/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Social.h"
/**
 *
 * SocialResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Social
 *
 */
@interface SocialResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Social
 *
 * @param json
 *            - response in JSON format
 *
 * @return Social object filled with json data
 *
 */
-(Social*)buildResponse:(NSString*)Json;

@end
