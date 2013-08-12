//
//  ServiceAPI.h
//  App42_iOS_SERVICE_APIs
//
//  Created by Shephertz Technology on 17/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class basically is a factory class which builds the service for use.
 * All services can be instantiated using this class
 * 
 */

@interface ServiceAPI : NSObject
{
    
    NSString *apiKey;
    
    NSString *secretKey; 
  
}
/*!
 *set the api key of application
 */
@property(nonatomic,retain)NSString *apiKey;
/*!
 *set the secret key of application
 */
@property(nonatomic,retain)NSString *secretKey;
/*!
 *set the accept Type for connection whether it is json or xml. 
 */
//@property(nonatomic)AcceptType acceptType;
/*!
 *@return Returns the instance of User API
 */
-(id)buildUserService;
/*!
 *@return Returns the instance of EmailSender API
 */
-(id)buildEmailService;
/*!
 *@return Returns the instance of License API
 */
-(id)buildLicenseService;
/*!
 *@return Returns the instance of Bill API
 */
-(id)buildBillService;
/*!
 *@return Returns the instance of Storage API
 */
-(id)buildStorageService;
/*!
 *@return Returns the instance of Session API
 */
-(id)buildSessionService;
/*!
 *@return Returns the instance of Photo API
 */
-(id)buildPhotoService;
/*!
 *@return Returns the instance of User API
 */
-(id)buildQueueService;
/*!
 *@return Returns the instance of Usage API
 */
-(id)buildUsageService;
/*!
 *@return Returns the instance of Recommender API
 */
-(id)buildRecommenderService;
/*!
 *@return Returns the instance of Upload API
 */
-(id)buildUploadService;
/*!
 *@return Returns the instance of Catalogue API
 */
-(id)buildCatalogueService;
/*!
 *@return Returns the instance of Cart API
 */
-(id)buildCartService;
/*!
 *@return Returns the instance of Album API
 */
-(id)buildAlbumService;
/*!
 *@return Returns the instance of Log API
 */
-(id)buildLogService;
/*!
 *@return Returns the instance of Review API
 */
-(id)buildReviewService;
/*!
 *@return Returns the instance of Geo API
 */
-(id)buildGeoService;
/*!
 *@return Returns the instance of Game API
 */
-(id)buildGameService;
/*!
 *@return Returns the instance of Reward API
 */
-(id)buildRewardService;
/*!
 *@return Returns the instance of Score API
 */
-(id)buildScoreService;
/*!
 *@return Returns the instance of ScoreBoard API
 */
-(id)buildScoreBoardService;
/*!
 *@return Returns the instance of Image Processor API
 */
-(id)buildImageProcessorService;
/*!
 *@return Returns the instance of Push API
 */
-(id)buildPushService;
/*!
 *@return Returns the instance of Social API
 */
-(id)buildSocialService;
/*!
 *@return Returns the instance of Buddy API
 */
-(id)buildBuddyService;
@end
