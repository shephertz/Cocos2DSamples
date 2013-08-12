//
//  CartResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 13/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
@class Cart;
/**
 *
 * CartResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Cart
 *
 */

@interface CartResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Cart
 *
 * @param json
 *            - response in JSON format
 *
 * @return Cart object filled with json data
 *
 */
-(Cart*)buildResponse:(NSString*)Json;
/**
 * Converts the response in JSON format to the list of value objects i.e
 * Cart
 *
 * @param json
 *            - response in JSON format
 *
 * @return List of Cart object filled with json data
 *
 */
-(NSArray *)buildArrayResponse:(NSString*)Json;

@end
