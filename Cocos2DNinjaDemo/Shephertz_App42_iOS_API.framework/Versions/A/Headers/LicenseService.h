//
//  LicenseService.h
//  App42_iOS_SERVICE_APIs
//
//  Created by Shephertz Technology on 13/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LicenseResponseBuilder.h"
#import "License.h"
/**
 * AppTab - License. This service provides traditional License engine. This can be useful
 * to App developers who want to sell their applications on license keys and want to use a license manager on the cloud.
 * It allows to create a license for a particular
 * App. Once the license scheme is created. The App developer can issue lincese, revoke license and check for validity of the license
 * When a license is issued a license key is generated and returned. Which is used for revoking and checking the validity of the 
 * license. The Bill service is used to find licenses issued to a particular user.
 * 
 * @see Bill
 */
@interface LicenseService : NSObject{
    
    NSString *apiKey;
    NSString *secretKey;
}
@property (nonatomic, retain) NSString *apiKey;
@property (nonatomic, retain) NSString *secretKey;
/**
 * Creates the license scheme. A license scheme is created which takes the name, price and currency.
 * @param licenseName The name of the Scheme to be created
 * @param licensePrice Price of the Scheme to be created
 * @param licenseCurrency Currencyof the Scheme to be created
 * @param licenseDescirption Description of the Scheme to be created
 * @returns Created license Scheme
 */
-(License*)createLicense:(NSString*)licenseName licensePrice:(NSDecimalNumber*)licensePrice licenseCurrency:(NSString*)licenseCurrency licenseDescirption:(NSString*)licenseDescirption;
/**
 * Issues license based on a license scheme name. It returns a license key which has to be used in future
 * to fetch information about the license, revoke and to find validity
 * @param userName The user for whom the license has to be issued
 * @param licenseName The name of the Scheme to be issued
 * @returns Issued license Scheme
 */
-(License*)issueLicense:(NSString*)userName licenseName:(NSString*)licenseName;
/**
 * Fetches information about the license. This can be used by the App developer to
 * display license information/pricing plan about their app to their customers
 * @param licenseName The name of the Scheme
 * @returns Fetched license Scheme
 */
-(License*)getLicense:(NSString*)licenseName;
/**
 * Fetches all licenses for the App. This can be used by the App developer to
 * display license information/pricing plan about their app to their customers
 * @returns All license Schemes
 */
-(NSArray*)getAllLicenses;
/**
 * Fetches all licenses which are issued to a particular user. This can be used by the App developer
 * to show the users their order history
 * @param userName User Name for whom issued licenses have to be fetched
 * @param licenseName Name of the Scheme to be fetched
 * @returns All issued licenses
 */
-(License*)getIssuedLicenses:(NSString*)userName licenseName:(NSString*)licenseName;
/**
 * Checks whether a particular license key isValid or not
 * @param userName The user for whom the validity has to be checked
 * @param licenseName The scheme name for which the validity has to be checked
 * @param key The license key which has to be validated
 * @returns Whether the license for the user is valid or not
 */
-(License*)isValid:(NSString*)userName licenseName:(NSString*)licenseName key:(NSString*)key;
/**
 * Revokes license for a particular user. Once revoked the method isValid will return that the key is inValid.
 * Note: Once a license is revoked it cannot be again made valid
 * @param userName The user for which the license has to be revoked
 * @param licenseName The scheme name which has to be revoked
 * @param key The license key which has to be revoked
 * @returns License information which has been revoked
 */
-(License*)revokeLicense:(NSString*)userName licenseName:(NSString*)licenseName key:(NSString*)key;
@end
