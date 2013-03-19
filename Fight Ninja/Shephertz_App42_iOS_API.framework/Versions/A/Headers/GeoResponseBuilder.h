//
//  GeoResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 11/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Geo.h"
/**
 *
 * GeoResponseBuilder class converts the JSON response retrieved from the server
 * to the value object i.e Geo
 *
 */
@interface GeoResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Geo
 *
 * @param json
 *            - response in JSON format
 *
 * @return Geo object filled with json data
 *
 */
-(Geo*)buildResponse:(NSString*)Json;
/**
 * Converts the response in JSON format to the list of value objects i.e Geo
 *
 * @param json
 *            - response in JSON format
 *
 * @return List of Geo Points object filled with json data
 *
 */
-(NSArray*)buildArrayResponse:(NSString*)Json;

@end
