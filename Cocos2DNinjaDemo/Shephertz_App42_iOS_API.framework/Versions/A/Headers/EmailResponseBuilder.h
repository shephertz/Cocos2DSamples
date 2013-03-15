//
//  EmailResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 10/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Email.h"
/**
 *
 * EmailResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Email
 *
 */
@interface EmailResponseBuilder : App42ResponseBuilder

/**
 * Converts the response in JSON format to the value object i.e Email
 *
 * @param json
 *            - response in JSON format
 *
 * @return Email object filled with json data
 *
 */
-(Email*)buildEmailResponse:(NSString*)Json;


@end
