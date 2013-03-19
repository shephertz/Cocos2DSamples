//
//  ImageProcessorResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 13/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"
#import "App42ResponseBuilder.h"
/**
 *
 * ImageProcessResponseBuilder class converts the JSON response retrieved from
 * the server to the value object i.e Image
 *
 */
@interface ImageProcessorResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Image
 *
 * @param json
 *            - response in JSON format
 *
 * @return Image object filled with json data
 *
 */
-(Image*)buildResponse:(NSString*)Json;

@end
