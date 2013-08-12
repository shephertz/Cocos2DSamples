//
//  QueueResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 11/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
/**
 *
 * QueueResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Queue
 *
 */
@interface QueueResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Queue
 *
 * @param json
 *            - response in JSON format
 *
 * @return Queue object filled with json data
 *
 */
-(id)buildQueueResponse:(NSString*)json;

@end
