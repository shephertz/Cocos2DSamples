//
//  StorageResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 13/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
@class Storage;
/**
 *
 * StorageResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Storage
 *
 */
@interface StorageResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Storage
 *
 * @param json
 *            - response in JSON format
 *
 * @return Storage object filled with json data
 *
 */
-(Storage*)buildResponse:(NSString*)Json;

@end
