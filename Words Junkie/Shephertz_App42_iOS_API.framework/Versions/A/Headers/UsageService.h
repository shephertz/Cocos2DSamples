//
//  UsageService.h
//  App42_iOS_SERVICE_APIs
//
//  Created by shephertz technologies on 14/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsageResponseBuilder.h"
@class Usage;
/**
 * Usage is part of AppTab which a rating, metering, charging and billing engine.
 * This service allows App developers to specify the rate for a particular usage
 * parameter e.g. Level - Storage - space, Badwidth, Time, Feature, Level of game, 
 * OneTime - Which can be used for one time charging e.g. for charging for downloads
 * and License for traditional license based charging.
 * It provides methods for first creating the scheme for charging which specifies the unit of charging
 * and the associated price. Subsequently a chargeXXX call has to be made for charging. e.g.
 * If a App developer wants to charge on Storage. He can use the method createStorageCharge and specify
 * that for 10 KB/MB/GB TB the price is 10 USD
 * Once the scheme is created. The App developer can call the chargeStorage call whenever storage is utilized.
 * e.g. 5MB.
 * 
 * Using the Bill service the App developer can find out what is the monthly bill for a particular user based on his utilization
 * The bill is calculated based on scheme which is specified
 * 
 * @see Bill
 */

/**
 * Seconds Time constant for Time charge
 */
extern NSString *const SECONDS ;
/**
 * Minutes Time constant for Time charge
 */
extern NSString *const MINUTES ;
/**
 * Hours Time constant for Time charge
 */
extern NSString *const HOURS ;
/**
 * Space constant for Storage and Bandwidth
 */
extern NSString *const KB ;
/**
 * Space constant for Storage and Bandwidth
 */
extern NSString *const MB ;
/**
 * Space constant for Storage and Bandwidth
 */
extern NSString *const GB ;
/**
 * Space constant for Storage and Bandwidth
 */
extern NSString *const TB ;

/*

typedef enum UsageConstants{
    SECONDS,MINUTES,HOURS,KB,MB,GB,TB
}usageConstants;*/


@interface UsageService : NSObject{
   
    NSString *apiKey;
    NSString *secretKey;
}
@property (nonatomic, retain) NSString *apiKey;
@property (nonatomic, retain) NSString *secretKey;
/**
 * Creates the scheme for level based charging. Level based charging is suited for usage based Game charging
 * @param levelName The name of the scheme
 * @param levelPrice The price of the level scheme 
 * @param levelCurrency Currency to be used for scheme
 * @param levelDescription Description of the scheme
 * @returns Created Scheme
 */
-(Usage*)createLevelCharge:(NSString*)levelName levelPrice:(NSDecimalNumber*)levelPrice levelCurrency:(NSString*)levelCurrency levelDescription:(NSString*)levelDescription;
/**
 * Gets the information for the scheme. This method can be used by the App developer to show
 * his pricing plans to their users.
 * @param levelName The Name of scheme
 * @returns Scheme Information
 */
-(Usage*)getLevel:(NSString*)levelName;
/**
 * Remove a particular scheme. Note: A level is not physically deleted from the storage. Only the 
 * state is changed so that it is available to fetch older information
 * @param levelName The name of scheme
 * @returns Scheme Information which has been removed
 */
-(Usage*)removeLevel:(NSString*)levelName;
/**
 * Creates the scheme for one time based charging. One Time based charging is suited for downloads. e.g. App, Images, Music, Video,
 * software etc. downloads
 * @param oneTimeName The name of the scheme
 * @param oneTimePrice The price of the level scheme 
 * @param oneTimeCurrency Currency to be used for scheme
 * @param oneTimeDescription Description of the scheme
 * @returns Created Scheme
 */
-(Usage*)createOneTimeCharge:(NSString*)oneTimeName oneTimePrice:(NSDecimalNumber*)oneTimePrice oneTimeCurrency:(NSString*)oneTimeCurrency oneTimeDescription:(NSString*)oneTimeDescription;
/**
 * Gets the information for the scheme. This method can be used by the App developer to show
 * his pricing plans to their users.
 * @param oneTimeName The name of scheme
 * @returns Scheme Information
 */
-(Usage*)getOneTime:(NSString*)oneTimeName;
/**
 * Removes a particular scheme. Note: A level is not physically deleted from the storage. Only the
 * state is changed so that it is available to fetch older information
 * @param oneTimeName The name of scheme to be removed
 * @returns Scheme Information which has been removed
 */
-(Usage*)removeOneTime:(NSString*)oneTimeName;
/**
 * Creates the scheme for feature based charging. Feature based charging is suited for Software Applications.
 * E.g. Withing mobile, desktop, SaaS based charging based on features. One can charge based on no. of features one uses.
 * @param featureName The name of the scheme
 * @param featurePrice The price of the scheme 
 * @param featureCurrency Currency to be used for that scheme
 * @param featureDescription Description of the scheme
 * @returns Created Scheme
 */
-(Usage*)createFeatureCharge:(NSString*)featureName featurePrice:(NSDecimalNumber*)featurePrice featureCurrency:(NSString*)featureCurrency featureDescription:(NSString*)featureDescription;
/**
 * Gets the information for the scheme. This method can be used by the App developer to show
 * his pricing plans to their users.
 * @param featureName The name of scheme
 * @returns Returns Scheme
 */
-(Usage*)getFeature:(NSString*)featureName;
/**
 * Remove a particular scheme. Note: A level is not physically deleted from the storage. Only the 
 * state is changed so that it is available to fetch older information
 * @param featureName The name of scheme
 * @returns Scheme Information which has been removed
 */
-(Usage*)removeFeature:(NSString*)featureName;
/**
 * Creates the scheme for bandwidth based charging. It is best suited for network based bandwidth usage
 * @param bandwidthName The name of the scheme
 * @param bandwidthUsage bandwidth usage for the scheme
 * @param usageBandWidth bandwidth unit for the scheme. Use the defined constants for bandwidth unit i.e. KB,MB,GB and TB
 * @param bandwidthPrice The price of the level scheme 
 * @param bandwidthCurrency Currency to be used for the scheme
 * @param bandwidthDescription Description of the scheme
 * @returns Created Scheme
 */
-(Usage*)createBandwidthCharge:(NSString*)bandwidthName bandwidthUsage:(NSDecimalNumber*)bandwidthUsage usageBandWidth:(NSString*)usageBandWidth bandwidthPrice:(NSDecimalNumber*)bandwidthPrice bandwidthCurrency:(NSString*)bandwidthCurrency bandwidthDescription:(NSString*)bandwidthDescription;
/**
 * Gets the information for the scheme. This method can be used by the App developer to show
 * his pricing plans to their users.
 * @param bandwidthName The name of scheme
 * @returns Scheme Information
 */
-(Usage*)getBandwidth:(NSString*)bandwidthName;
/**
 * Remove a particular scheme. Note: A level is not physically deleted from the storage. Only the 
 * state is changed so that it is available to fetch older information
 * @param bandwidthName The name of the scheme to be removed
 * @returns Scheme Information which has been removed
 */
-(Usage*)removeBandwidth:(NSString*)bandwidthName;
/**
 * Creates the scheme for storage based charging. It is best suited for disk based storage usage.
 * E.g. photo Storage, file Storage, RAM usage, Secondary Storage
 * @param storageName The name of the scheme
 * @param storageSpace storage space for the scheme
 * @param usageStorage Storage units to be used for the scheme. Use the defined constants for bandwidth unit i.e. KB,MB,GB and TB
 * @param storagePrice The price of the scheme 
 * @param storageCurrency Currency to be used for that scheme
 * @param storageDescription Description of the scheme
 * @returns Created Scheme
 */
-(Usage*)createStorageCharge:(NSString*)storageName storageSpace:(NSDecimalNumber*)storageSpace usageStorage:(NSString*)usageStorage storagePrice:(NSDecimalNumber*)storagePrice storageCurrency:(NSString*)storageCurrency storageDescription:(NSString*)storageDescription;
/**
 * Gets the information for the scheme. This method can be used by the App developer to show
 * his pricing plans to their users.
 * @param storageName The name of scheme
 * @returns Scheme Information
 */
-(Usage*)getStorage:(NSString*)storageName;
/**
 * Remove a particular scheme. Note: A level is not physically deleted from the storage. Only the 
 * state is changed so that it is available to fetch older information
 * @param storageName The name of scheme
 * @returns Scheme Information which has been removed
 */
-(Usage*)removeStorage:(NSString*)storageName;
/**
 * Creates the scheme for time based charging. It is best suited for applications which want to charge based on 
 * time usage or elapsed. E.g. How long one is listening to music or watching a video. How long the person is reading
 * a online book or magazine etc.
 * @param timeName The name of the scheme
 * @param timeUsage usage time for the scheme
 * @param usageTime unit of time for the scheme. Use the defined constants for bandwidth unit i.e. HOURS,SECONDS,MINUTES
 * @param timePrice The price of the level scheme 
 * @param timeCurrency Currency used for the scheme
 * @param timeDescription Description of the scheme
 * @returns Created Scheme
 */
-(Usage*)createTimeCharge:(NSString*)timeName timeUsage:(long)timeUsage usageTime:(NSString*)usageTime timePrice:(NSDecimalNumber*)timePrice timeCurrency:(NSString*)timeCurrency timeDescription:(NSString*)timeDescription;
/**
 * Gets the information for the scheme. This method can be used by the App developer to show
 * his pricing plans to their users.
 * @param timeName The name of scheme
 * @returns Scheme Information
 */
-(Usage*)getTime:(NSString*)timeName;
/**
 * Remove a particular scheme. Note: A level is not physically deleted from the storage. Only the 
 * state is changed so that it is available to fetch older information
 * @param timeName The name of scheme
 * @returns Scheme Information which has been removed
 */
-(Usage*)removeTime:(NSString*)timeName;
/**
 * Charge on a particular scheme. A Charging record is created whenever this method is called. Which
 * is used for billing and usage behaviour analysis purpose.
 * @param chargeUser The user against whom the charging has to be done
 * @param levelName The name of scheme
 * @returns Returns charging information
 */
-(Usage*)chargeLevel:(NSString*)chargeUser levelName:(NSString*)levelName;
/**
 * Charge on a particular scheme. A Charging record is created whenever this method is called. Which
 * is used for billing and usage behaviour analysis purpose.
 * @param chargeUser The user against whom the charging has to be done
 * @param oneTimeName The name of scheme
 * @returns Returns charging information
 */
-(Usage*)chargeOneTime:(NSString*)chargeUser oneTimeName:(NSString*)oneTimeName;
/**
 * Charge on a particular scheme. A Charging record is created whenever this method is called. Which
 * is used for billing and usage behaviour analysis purpose.
 * @param chargeUser The user against whom the charging has to be done
 * @param featureName The name of scheme
 * @returns Returns charging information
 */
-(Usage*)chargeFeature:(NSString*)chargeUser featureName:(NSString*)featureName;
/**
 * Charge on a particular scheme. A Charging record is created whenever this method is called. Which
 * is used for billing and usage behaviour analysis purpose.
 * @param chargeUser The user against whom the charging has to be done
 * @param bandwidthName The name of scheme
 * @param bandwidth bandwidth for which the charging has to be done
 * @param usageBandWidth unit of bandwidth charging  Use the defined constants for bandwidth unit i.e. KB,MB,GB and TB
 * @returns Returns charging information
 */
-(Usage*)chargeBandwidth:(NSString*)chargeUser bandwidthName:(NSString*)bandwidthName bandwidth:(NSDecimalNumber*)bandwidth usageBandWidth:(NSString*)usageBandWidth;
/**
 * Charge on a particular scheme. A Charging record is created whenever this method is called. Which
 * is used for billing and usage behaviour analysis purpose.
 * @param chargeUser The user against whom the charging has to be done
 * @param storageName The name of scheme
 * @param storageSpace storage space for which the charging has to be done
 * @param usageStorage unit of storage charging. Use the defined constants for bandwidth unit i.e. KB,MB.GB and TB
 * @returns Returns charging information
 */
-(Usage*)chargeStorage:(NSString*)chargeUser storageName:(NSString*)storageName storageSpace:(NSDecimalNumber*)storageSpace usageStorage:(NSString*)usageStorage;
/**
 * Charge on a particular scheme. A Charging record is created whenever this method is called. Which
 * is used for billing and usage behaviour analysis purpose.
 * @param chargeUser The user against whom the charging has to be done
 * @param timeName The name of scheme
 * @param chargetime time for which the charging has to be done
 * @param usageTime unit of time charging. Use the defined constants for bandwidth unit i.e. HOURS,SECONDS,MINUTES
 * @returns Returns charging information
 */
-(Usage*)chargeTime:(NSString*)chargeUser timeName:(NSString*)timeName chargetime:(NSDecimalNumber*)chargetime usageTime:(NSString*)usageTime;
/**
 * Returns all the schemes for this usage type. This can be used by the App developer
 * to display their usage based pricing plan
 *
 */
-(Usage*)getAllLevelUsage;
/**
 * Returns all the schemes for this usage type. This can be used by the App developer
 * to display their usage based pricing plan
 *
 */
-(Usage*)getAllOneTimeUsage;
/**
 * Returns all the schemes for this usage type. This can be used by the App developer
 * to display their usage based pricing plan
 *
 */
-(Usage*)getAllFeatureUsage;
/**
 * Returns all the schemes for this usage type. This can be used by the App developer
 * to display their usage based pricing plan
 *
 */
-(Usage*)getAllStorageUsage;
/**
 * Returns all the schemes for this usage type. This can be used by the App developer
 * to display their usage based pricing plan
 *
 */
-(Usage*)getAllTimeUsage;
/**
 * Returns all the schemes for this usage type. This can be used by the App developer
 * to display their usage based pricing plan
 *
 */
-(Usage*)getAllBandwidthUsage;

@end
