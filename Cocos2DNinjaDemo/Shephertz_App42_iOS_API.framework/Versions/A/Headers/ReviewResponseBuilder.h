//
//  ReviewResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 11/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Review.h"
/**
 *
 * ReviewResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Review
 *
 */
@interface ReviewResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Review
 *
 * @param json
 *            - response in JSON format
 *
 * @return Review object filled with json data
 *
 */
-(Review*)buildResponse:(NSString*)Json;
/**
 * Converts the response in JSON format to the list of value objects i.e
 * Review
 *
 * @param json
 *            - response in JSON format
 *
 * @return List of Review object filled with json data
 *
 */
-(NSArray*)buildArrayResponse:(NSString*)Json;


@end
