//
//  GameResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 11/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Game.h"
/**
 *
 * GameResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Game
 *
 */
@interface GameResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Game
 *
 * @param json
 *            - response in JSON format
 *
 * @return Game object filled with json data
 *
 */

-(Game*)buildResponse:(NSString*)Json;
/**
 * Converts the response in JSON format to the list of value objects i.e
 * Game
 *
 * @param json
 *            - response in JSON format
 *
 * @return List of Game object filled with json data
 *
 */
-(NSArray*)buildArrayResponse:(NSString*)Json;

@end
