//
//  SessionResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 05/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Session.h"
/**
 *
 * SessionResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Session
 *
 */

@interface SessionResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Session
 *
 * @param json
 *            - response in JSON format
 *
 * @return Session object filled with json data
 *
 */
-(Session*)buildSessionResponse:(NSString*)Json;

@end
