//
//  Util.h
//  App42_iOS_SERVICE_API
//
//  Created by Shephertz Technology on 07/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject{    
    NSString *appErrorCode;
}
+(NSString*)sign:(NSMutableDictionary *)data:(NSString*)secretKey;
+(NSString*)getUTCTimeFormattedStamp;
+(NSString*)getUTCTimeFormattedStamp:(NSDate*)date;
+(NSString*)multipartRequest:(NSString*)name:(NSString*)filePath:(NSMutableDictionary*)queryParams:(NSMutableDictionary*)postParams:(NSString*)postUrl;
+(NSString*)multipartRequest:(NSString*)name:(NSData*)fileData:(NSString*)fileName:(NSMutableDictionary*)queryParams:(NSMutableDictionary*)postParams:(NSString*)postUrl;
+(void)throwExceptionIfNullOrBlank:(id)Obj:(NSString*)name;
+(void)validateMax:(int)max;
+(void)throwExceptionIfEmailNotValid:(id)obj:(NSString*)name;
+(void)throwExceptionIfNotValidExtension:(NSString*)fileName name:(NSString*)name;
+(void)throwExceptionIfNotValidImageExtension:(NSString*)fileName name:(NSString*)name;
+(void)validateHowMany:(int)howMany;
@end

