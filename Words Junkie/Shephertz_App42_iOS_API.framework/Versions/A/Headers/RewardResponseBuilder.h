//
//  RewardResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 11/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Reward.h"
/**
 *
 * RewardResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Reward
 *
 */
@interface RewardResponseBuilder : App42ResponseBuilder
/**
* Converts the response in JSON format to the value object i.e Reward
*
* @param json
*            - response in JSON format
*
* @return Reward object filled with json data
*
*/
-(Reward*)buildResponse:(NSString*)Json;
/**
 * Converts the response in JSON format to the list of value objects i.e
 * Reward
 *
 * @param json
 *            - response in JSON format
 *
 * @return List of Reward object filled with json data
 *
 */
-(NSMutableArray*)buildArrayResponse:(NSString*)Json;

@end
