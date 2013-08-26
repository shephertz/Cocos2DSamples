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
+(NSString*)createSignatureFromDataDict:(NSMutableDictionary *)data andSecretKey:(NSString*)secretKey;
+(NSString*)getUTCTimeFormattedStamp;
+(NSString*)getUTCTimeFormattedStamp:(NSDate*)date;
+(NSString*)multipartRequestWithRequestName:(NSString*)name forFileWithPath:(NSString*)filePath queryParams:(NSMutableDictionary*)queryParams postParams:(NSMutableDictionary*)postParams headerParams:(NSMutableDictionary*)headerParams postUrl:(NSString*)postUrl;
+(NSString*)multipartRequestWithRequestName:(NSString*)name forFileData:(NSData*)fileData fileName:(NSString*)fileName queryParams:(NSMutableDictionary*)queryParams postParams:(NSMutableDictionary*)postParams headerParams:(NSMutableDictionary*)headerParams postUrl:(NSString*)postUrl;


+(NSString*)multipartRequestWithRequestName:(NSString*)name forFileWithPath:(NSString*)filePath queryParams:(NSMutableDictionary*)queryParams postParams:(NSMutableDictionary*)postParams postUrl:(NSString*)postUrl;
+(NSString*)multipartRequestWithRequestName:(NSString*)name forFileData:(NSData*)fileData fileName:(NSString*)fileName queryParams:(NSMutableDictionary*)queryParams postParams:(NSMutableDictionary*)postParams postUrl:(NSString*)postUrl;
+(void)throwExceptionIfNullOrBlank:(id)Obj :(NSString*)name;
+(void)validateMax:(int)max;
+(void)throwExceptionIfEmailNotValid:(id)obj :(NSString*)name;
+(void)throwExceptionIfNotValidExtension:(NSString*)fileName name:(NSString*)name;
+(void)throwExceptionIfNotValidImageExtension:(NSString*)fileName name:(NSString*)name;
+(void)validateHowMany:(int)howMany;
@end

