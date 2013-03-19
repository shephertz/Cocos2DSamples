//
//  BillService.h
//  App42_iOS_SERVICE_APIs
//
//  Created by Shephertz Technology on 13/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillResponseBuilder.h"
@class Bill;

extern NSString *const JANUARY;
extern NSString *const FEBRUARY;
extern NSString *const MARCH;
extern NSString *const APRIL;
extern NSString *const MAY;
extern NSString *const JUNE;
extern NSString *const JULY;
extern NSString *const AUGUST;
extern NSString *const SEPTEMBER;
extern NSString *const OCTOBER;
extern NSString *const NOVEMBER;
extern NSString *const DECEMBER;

/**
 * AppTab - Billing service. This service is used along with the Usage service. It generates
 * Bill for a particular based on Usage Scheme. For e.g. if user sid's bill has to be seen
 * for May and 2012. This service will list all the charging transactions and calculate the bill for May
 * and tell the total usage and price. The calculation is done based on the Price which is given during
 * scheme creation, the unit of charging and corresponding usage.
 * AppTab currently just maintains the data and does calculation. How the Bill is rendered and the interface
 * with Payment Gateway is left with the App developer.
 * 
 * @see Usage
 * 
 */




/*
typedef enum BillService {
    January,February,March,April,May,June,July,August,September,October,November,December
} BillMonth;
*/


@interface BillService : NSObject{
    
    NSString *apiKey;
    NSString *secretKey;
    
}


@property (nonatomic, retain) NSString *apiKey;
@property (nonatomic, retain) NSString *secretKey;
/**
 * Get usage for Scheme based on Month and Year. This is useful to show the user
 * the charging details of the User for the Scheme
 * @param userName The user for which the charging information has to be fetched
 * @param usageName The name of the Scheme
 * @param billMonth The month name for which the usage has to be fetched  Use the constants defined for month i.e. January,February,March,April,May,June,July,August,September,October,November and December
 * @param year The year for which the usage has to be fetched e.g. 2012, 2011
 * @returns All the charging transactions with the total usage and total price for that month
 */
-(Bill*)usageTimeByMonthAndYear:(NSString*)userName usageName:(NSString*)usageName month:(NSString*)billMonth year:(int)year;
/**
 * Get usage for Scheme based on Month and Year. This is useful to show the user
 * the charging details of the User for the Scheme
 * @param userName The user for which the charging information has to be fetched
 * @param usageName The name of the Scheme
 * @param billMonth The month name for which the usage has to be fetched  Use the constants defined for month i.e. January,February,March,April,May,June,July,August,September,October,November and December
 * @param year The year for which the usage has to be fetched e.g. 2012, 2011
 * @returns All the charging transactions with the total usage and total price for that month
 * 
 */
-(Bill*)usageStorageByMonthAndYear:(NSString*)userName usageName:(NSString*)usageName month:(NSString*)billMonth year:(int)year;
/**
 * Get usage for Scheme based on Month and Year. This is useful to show the user
 * the charging details of the User for the Scheme
 * @param userName The user for which the charging information has to be fetched
 * @param usageName The name of the Scheme
 * @param billMonth The month name for which the usage has to be fetched  Use the constants defined for month i.e. January,February,March,April,May,June,July,August,September,October,November and December
 * @param year The year for which the usage has to be fetched e.g. 2012, 2011
 * @returns All the charging transactions with the total usage and total price for that month
 */
-(Bill*)usageBandwidthByMonthAndYear:(NSString*)userName usageName:(NSString*)usageName month:(NSString*)billMonth year:(int)year;
/**
 * Get usage for Scheme based on Month and Year. This is useful to show the user
 * the charging details of the User for the Scheme
 * @param userName The user for which the charging information has to be fetched
 * @param usageName The name of the Scheme
 * @param billMonth The month name for which the usage has to be fetched  Use the constants defined for month i.e. January,February,March,April,May,June,July,August,September,October,November and December
 * @param year The year for which the usage has to be fetched e.g. 2012, 2011
 * @returns All the charging transactions with the total usage and total price for that month
 */
-(Bill*)usageLevelByMonthAndYear:(NSString*)userName usageName:(NSString*)usageName month:(NSString*)billMonth year:(int)year;
/**
 * Get usage for Scheme based on Month and Year. This is useful to show the user
 * the charging details of the User for the Scheme
 * @param userName The user for which the charging information has to be fetched
 * @param usageName The name of the Scheme
 * @param billMonth The month name for which the usage has to be fetched  Use the constants defined for month i.e. January,February,March,April,May,June,July,August,September,October,November and December
 * @param year The year for which the usage has to be fetched e.g. 2012, 2011
 * @returns All the charging transactions with the total usage and total price for that month
 */
-(Bill*)usageOneTimeByMonthAndYear:(NSString*)userName usageName:(NSString*)usageName month:(NSString*)billMonth year:(int)year;
/**
 * Get usage for Scheme based on Month and Year. This is useful to show the user
 * the charging details of the User for the Scheme
 * @param userName The user for which the charging information has to be fetched
 * @param usageName The name of the Scheme
 * @param billMonth The month name for which the usage has to be fetched  Use the constants defined for month i.e. January,February,March,April,May,June,July,August,September,October,November and December
 * @param year The year for which the usage has to be fetched e.g. 2012, 2011
 * @returns All the charging transactions with the total usage and total price for that month
 */
-(Bill*)usageFeatureByMonthAndYear:(NSString*)userName usageName:(NSString*)usageName month:(NSString*)billMonth year:(int)year;
/**
 * Get usage for Scheme based on Month and Year. This is useful to show the user
 * the charging details of the User for the Scheme
 * @param userName The user for which the charging information has to be fetched
 * @param licenseName The name of the License
 * @param billMonth The month name for which the usage has to be fetched  Use the constants defined for month i.e. January,February,March,April,May,June,July,August,September,October,November and December
 * @param year The year for which the usage has to be fetched e.g. 2012, 2011
 * @returns All the charging transactions with the total usage and total price for that month
 */
-(Bill*)usageLicenseByMonthAndYear:(NSString*)userName licenseName:(NSString*)licenseName month:(NSString*)billMonth year:(int)year;

@end
