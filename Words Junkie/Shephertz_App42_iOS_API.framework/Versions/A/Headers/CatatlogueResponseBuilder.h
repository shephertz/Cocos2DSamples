//
//  CatatlogueResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 13/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42ResponseBuilder.h"
#import "Catalogue.h"
/**
 *
 * CatalogueResponseBuilder class converts the JSON response retrieved from the
 * server to the value object i.e Catalogue
 *
 */
@interface CatatlogueResponseBuilder : App42ResponseBuilder
/**
 * Converts the response in JSON format to the value object i.e Catalogue
 *
 * @param json
 *            - response in JSON format
 *
 * @return Catalogue object filled with json data
 *
 */
-(Catalogue*)buildResponse:(NSString*)Json;
/**
 * Converts the response in JSON format to the list of value objects i.e
 * Catalogue
 *
 * @param response
 *            - response in JSON format
 *
 * @return List of Catalogue object filled with json data
 *
 */
-(NSArray *)buildArrayResponse:(NSString*)Json;

@end
