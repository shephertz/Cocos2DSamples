//
//  PushNotificationService.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 20/06/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushNotification.h"
#import "PushNotificationResponseBuilder.h"

/**
 * The service is for pushing the notifications to any device using APNS(Apple Push Notification Service).
 *  You have to upload your certificate that you have created while registering for pushNotification and you have to store your 
 *  device token with particular username. This service allows you the feature of sending message to 
 *  particular channel, particular user or to all your users.For sending message to any channel, you have to 
 *  create the channel and send the message to channel. The users which have subscribed to that channel will receive
 *  all the notification for that channel. For sending message to particular user, you have to pass username and 
 *  message. Notification will sent to the device of registered user. The most important feature you can send your message
 *  to all your device whether it is iphone, android or blackberry.  
 *  You can also send all type to notification that iOS supports i.e. alert,badge and sound. You have to send them in 
 *  Json structure like apple provides.
 *
 */

#import "App42Service.h"

extern NSString *const PRODUCTION;
extern NSString *const DEVELOPMENT;


@interface PushNotificationService : App42Service
{
    
}


-(id) init __attribute__((unavailable));
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;


/**Upload certificate file to server
 * 
 * @param password the password you have used while exporting the certificate
 * @param filePath path of certificate file
 * @param environment environment for the certificate whether it would be development or production
 * @return PushNotification Object
 */
- (PushNotification*)uploadFile:(NSString*)password filePath:(NSString*)filePath environment:(NSString*)environment;

/** Stores your device token on server with particular username
 * 
 * @param Username username with which you want your device to be registered
 * @param deviceToken device id for android phones
 * @return PushNotification Object
 */
//- (PushNotification*)storeDeviceToken:(NSString *)userName:(NSString *)deviceToken;

- (PushNotification*)registerDeviceToken:(NSString *)deviceToken withUser:(NSString *)userName;

/** Create Channel for app on which user can subscribe and get the notification for that 
 * channel
 * @param channel - channel name which you want to create
 * @param description = description for that channel
 * @return PushNotification Object
 */
- (PushNotification*)createChannelForApp:(NSString *)channel description:(NSString *)description;

/**
 * Subscribe to the channel
 * @param channel the channel name which you want to subscribe
 * @param userName username which want to subscribe
 * @param deviceToken deviceToken for which you want to subscribe
 * @param deviceType deviceType for which you want to subscribe
 * @return PushNotification Object
 */
- (PushNotification*)subscribeToChannel:(NSString *)channel userName:(NSString *)userName deviceToken:(NSString*)deviceToken deviceType:(NSString*)deviceType;

/**Unsubscribe from particular channel
 * 
 * @param channel channel name which you want to unsubscribe
 * @param userName username which want to unsubscribe
 * @return PushNotification Object
 */
- (PushNotification*)unsubscribeFromChannel:(NSString *)channel userName:(NSString *)userName deviceToken:(NSString*)deviceToken;

/** send push message to channel containing string
 * 
 * @param channel channel name which you want to send the message
 * @param message push message in string format
 * @return PushNotification Object
 */
- (PushNotification*)sendPushMessageToChannel:(NSString *)channel withMessage:(NSString *)message;

/** Send Push Message to particular channel containing Json
 * 
 * @param channel channel name which you want to send your json message
 * @param message push message in Dictionary format
 * @return PushNotification Object
 */
- (PushNotification*)sendPushMessageToChannel:(NSString *)channel withMessageDictionary:(NSDictionary *)message;

/** Send push message to all your users 
 *
 * @param message push message
 * @return PushNotification Object
 */
- (PushNotification *)sendPushMessageToAll:(NSString *)message;
/** Send push message to all iOS users
 *
 * @param message push message
 * @return PushNotification Object
 */
- (PushNotification *)sendPushMessageToiOS:(NSString *)message;
/** Send push message to all android users
 *
 * @param message push message
 * @return PushNotification Object
 */
- (PushNotification *)sendPushMessageToAndroid:(NSString *)message;

/** Send Push Message To paticular user in string format
 * 
 * @param username username which you want to send the message
 * @param message push message
 * @return PushNotification Object
 */
- (PushNotification *)sendPushMessageToUser:(NSString *)userName message:(NSString *)message;

/**Send Push Message to particular user
 * 
 * @param username username which you want to send message
 * @param message push Message in json
 * @return PushNotification Object
 */
- (PushNotification *)sendPushMessageToUser:(NSString *)userName withMessageDictionary:(NSDictionary *)message;

@end
