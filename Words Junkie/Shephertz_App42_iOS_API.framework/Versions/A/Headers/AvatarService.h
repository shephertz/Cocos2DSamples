//
//  AvatarService.h
//  PAE_iOS_SDK
//
//  Created by Rajeev Ranjan on 20/11/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@class Avatar;
@interface AvatarService : App42Service

- (id) init __attribute__((unavailable));
/**
 * This is a constructor that takes
 *
 * @param apiKey
 * @param secretKey
 * @param baseURL
 *
 */
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;

/**
 * Upload your own avatar from binary.
 *
 * @param name
 *            - Name of avatar to be created.
 * @param userName
 *            - Name of the user who is creating avatar
 * @param filePath
 *            - The local path for the file
 * @param description
 *            - Description of the avatar
 * @return Avatar Object
 * @throws App42Exception
 */
-(Avatar*) createAvatarWithName:(NSString*)name userName:(NSString*)userName filePath:(NSString*)filePath description:(NSString*)description;


/**
 * Import your avatar from Facebook based of given access token.
 *
 * @param avatarName
 *            - Name of avatar to be created.
 * @param userName
 *            - Name of the user who is creating avatar
 * @param accessToken
 *            - Facebook Access Token that has been received after
 *            authorization
 * @param description
 *            - Description of the avatar
 * @return Avatar Object
 * @throws App42Exception
 */
-(Avatar*)createAvatarFromFacebookWithName:(NSString*)avatarName userName:(NSString*)userName accessToken:(NSString*)accessToken description:(NSString*)description;

/**
 * Create avatar from any web media using URL
 *
 * @param avatarName
 *            - Name of avatar to be created
 * @param userName
 *            - Name of the user who is creating avatar
 * @param webUrl
 *            - WebURL of photo which you want to create
 * @param description
 *            - Description of the avatar
 * @return Avatar Object
 * @throws App42Exception
 */
-(Avatar*)createAvatarFromWebURLWithName:(NSString*)avatarName userName:(NSString*)userName webUrl:(NSString*)webUrl description:(NSString*)description;

/**
 * Get detail description of avatar
 *
 * @param userName
 *            - Name of the user for which avatar is to fetched
 * @param avatarName
 *            - Name of the avatar is to be fetched
 * @return Avatar Object
 * @throws App42Exception
 */
-(Avatar*)getAvatarByName:(NSString*)avatarName userName:(NSString*)userName;

/**
 * View all avatars.
 *
 * @param userName
 *            - Name of the user for which avatar is to fetched
 * @return Array of Avatar Objects
 * @throws App42Exception
 */
-(NSArray*)getAllAvatarsForUser:(NSString*)userName;

/**
 * View the latest avatar uploaded by user.
 *
 *
 * @param userName
 *            - Name of the user for which current avatar is to fetch
 * @return Avatar Object
 * @throws App42Exception
 */
-(Avatar*)getCurrentAvatar:(NSString*)userName;

/**
 * Change your current avatar from existing avatars in app.
 *
 * @param userName
 *            - Name of the user for which avatar is to updated.
 * @param avatarName
 *            - Name of the avatar to be updated.
 * @return Avatar Object
 * @throws App42Exception
 */
-(Avatar*)changeCurrentAvatarWithName:(NSString*)avatarName forUser:(NSString*)userName;


@end
