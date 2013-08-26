//
//  App42ResponseBuilder.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 04/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface App42ResponseBuilder : NSObject{
    
}


-(void)buildJSONObjectFromJSONDictionary:(NSDictionary *)jsonTree object:(id)Obj;
-(NSDictionary*)getServiceJsonDictionary:(NSString *)serviceName :(NSString *)json;
-(BOOL)isResponseSuccess:(NSString*)json;
-(int)totalRecords:(NSString*)json;
@end
