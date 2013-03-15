//
//  RecommenderResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 11/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Recommender.h"
/**
 *
 * RecommenderResponseBuilder class converts the JSON response retrieved from
 * the server to the value object i.e Recommender
 *
 */
@interface RecommenderResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Recommender
 *
 * @param json
 *            - response in JSON format
 *
 * @return Recommender object filled with json data
 *
 */
-(Recommender*)buildRecommenderResponse:(NSString*)Json;

@end
