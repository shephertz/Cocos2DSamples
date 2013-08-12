//
//  App42Response.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 05/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *App42Response class 
 * 
 */
@interface App42Response : NSObject{
    BOOL isResponseSuccess;
    NSString *strResponse;
    int totalRecords;
}
/*!
 *set and get the isResponseSuccess 
 */
@property(nonatomic,assign)BOOL isResponseSuccess;
/*!
 *set and get the strResponse 
 */
@property(nonatomic,retain)NSString *strResponse;
/*!
 *set and get the isResponseSuccess 
 */
@property(nonatomic,assign)int totalRecords;
/**
 *@return Returns the complete Json String
 */
-(NSString*)toString;

@end
