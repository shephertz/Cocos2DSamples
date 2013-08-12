//
//  UploadResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 13/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
@class Upload;
/**
 *
 * UploadResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e User
 *
 */
@interface UploadResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Upload
 *
 * @param json
 *            - response in JSON format
 *
 * @return Upload object filled with json data
 *
 */
-(Upload*)buildResponse:(NSString*)Json;
@end
