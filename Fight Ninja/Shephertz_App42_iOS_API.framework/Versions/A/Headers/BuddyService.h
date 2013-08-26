//
//  BuddyService.h
//  PAE_iOS_SDK
//
//  Created by shephertz technologies on 02/07/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "App42Service.h"
#import "Buddy.h"
#import "BuddyResponseBuilder.h"

@class App42Response;
@class GeoPoint;
@interface BuddyService : App42Service

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
 * Send friend request allow you to send the buddy request to the user.
 *
 * @param userName
 *            - Name of the user who wanted to send the request to the
 *            buddy.
 * @param buddyName
 *            - Name of buddy for whom you sending the request.
 * @param message
 *            - Message to the user.
 * @return - Buddy Object
 * @throws App42Exception
 */
-(Buddy*)sendFriendRequestFromUser:(NSString*)userName toBuddy:(NSString*) buddyName withMessage:(NSString*) message;

/**
 * Fetch all the friend request for the user.
 *
 * @param userName
 *            - Name of user for which request has to be fetched.
 * @return Buddy Object
 * @throws App42Exception
 */

-(NSArray*)getFriendRequest:(NSString *)userName;

/**
 * Accept the friend request of the user.
 *
 * @param userName
 *            - Name of the user who is going to accept the request.
 * @param buddyName
 *            - Name of the buddy whose request has to be accepted.
 * @return - Buddy Object
 * @throws App42Exception
 */

-(Buddy*)acceptFriendRequestFromBuddy:(NSString*)buddyName toUser:(NSString*)userName;

/**
 * Reject the friend request of the user
 *
 * @param userName
 *            - Name of user who is rejecting friend request.
 * @param buddyName
 *            - Name of user whose friend request has to reject.
 * @return Buddy Object
 * @throws App42Exception
 */
-(Buddy*)rejectFriendRequestFromBuddy:(NSString*)buddyName toUser:(NSString*)userName;

/**
 *
 * @param userName
 *            - Name of the user who want to create the group
 * @param groupName
 *            - Name of the group which is to be create
 * @return Buddy object
 * @throws App42Exception
 */

/**
 *
 * @param userName
 *            - Name of the user who want to fetch the friend request
 * @return buddy object
 * @throws App42Exception
 */

-(NSArray*)getAllFriends:(NSString*)userName;

-(Buddy*)createGroup:(NSString*)groupName byUser:(NSString*)userName;

/**
 *
 * @param userName
 *            - Name of the user who want to add friend in group
 * @param groupName
 *            - Name of the group in which friend had to be added
 * @param friends
 *            - List of friend which has to be added in group
 * @return Buddy object
 * @throws App42Exception
 */

-(NSArray*)addFriends:(NSArray*)friends ofUser:(NSString*)userName toGroup:(NSString*)groupName;

/**
 *
 * @param userName
 *            - Name of the user who want to checkedIn the geo location
 * @param geoPoint
 *            - geo points of user which is to chechedIn
 * @return buddy object
 * @throws App42Exception
 */
-(Buddy*)checkedInWithUser:(NSString*)userName geoLocation:(GeoPoint*)point;

/**
 *
 * @param userName
 * @param latitude
 * @param longitude
 * @param maxDistance
 * @param max
 * @return
 * @throws App42Exception
 */
-(NSArray*)getFriendsOfUser:(NSString *)userName withLatitude:(double)latitude andLongitude:(double)longitude inRadius:(double)maxDistance max:(int) max;

/**
 * Get All groups created by user
 *
 * @param userName
 *            - Name of the user for which group has to be fetched.
 * @return Buddy object
 * @throws App42Exception
 */

-(NSArray*)getAllGroups:(NSString*)userName;

/**
 * Get All friends in specific group
 *
 * @param userName
 *            : name of user who is frtching the friends in group
 * @param ownerName
 *            : name of group owner
 * @param groupName
 *            : name of group
 * @return Buddy object
 * @throws App42Exception
 */
-(NSArray*)getAllFriendsOfUser:(NSString*)userName inGroup:(NSString*)groupName ofOwner:(NSString*)ownerName;

/**
 *
 * @param userName
 *            : name of user who is frtching the friends in group
 * @param ownerName
 *            : name of group owner
 * @param groupName
 *            : name of group
 * @param callBack
 *            : Callback object for success/exception result
 * @throws App42Exception
 *
 *             public void getAllFriendsInGroup(final String userName, final
 *             String ownerName, final String groupName, final App42CallBack
 *             callBack) throws App42Exception {
 *             Util.throwExceptionIfNullOrBlank(callBack, "callBack"); new
 *             Thread() {
 * @Override public void run() { try { final ArrayList<Buddy> buddy =
 *           getAllFriendsInGroup( userName, ownerName, groupName);
 *           callBack.onSuccess(buddy); } catch (App42Exception ex) {
 *           App42Log.error(" Exception :" + ex); callBack.onException(ex);
 *           } } }.start(); }
 *
 *           //Block the friend request of the user forever
 *
 * @param userName
 *            - Name of the user who is blocking the friend request.
 * @param buddyName
 *            - Name of user whose friend request has to block.
 * @return Buddy object
 * @throws App42Exception
 */

-(Buddy*)blockFriendRequestFromBuddy:(NSString*)buddyName toUser:(NSString*)userName;

/**
 * Never get any request by this user
 *
 * @param userName
 *            : name of the user who is blocking.
 * @param buddyName
 *            : name of the user to whom to block.
 * @return Buddy object
 * @throws App42Exception
 */

-(Buddy*)blockBuddy:(NSString*)buddyName byUser:(NSString*)userName;

/**
 * Unblock User
 *
 * @param userName
 *            : name of user who is unblocking the specific buddy
 * @param buddyName
 *            : name of user to be unblocked
 * @return Buddy object
 * @throws App42Exception
 */
-(Buddy*)unblockBuddy:(NSString*)buddyName byUser:(NSString*)userName;

/**
 * Send the message to the group.
 *
 * @param userName
 *            - Name of the user who wan't to send the message.
 * @param ownerName
 *            - Name of the user who created the group for which are going
 *            to send the message
 * @param groupName
 *            - Name of the group which is created by the ownerUser.
 * @param message
 *            - Message for the receiver.
 * @return - Buddy Object
 * @throws App42Exception
 */
-(Buddy*)sendMessage:(NSString*)message fromUser:(NSString*)userName toGroup:(NSString*)groupName ofGroupOwner:(NSString*)ownerName;

/**
 *
 * @param userName
 * @param buddyName
 * @param message
 * @return
 * @throws App42Exception
 */
-(Buddy*)sendMessage:(NSString*)message toFriend:(NSString*)buddyName fromUser:(NSString*)userName;

/**
 *
 * @param userName
 * @param message
 * @return
 * @throws App42Exception
 */
-(NSArray*)sendMessageToFriends:(NSString*)message fromUser:(NSString*)userName;

/**
 *
 * @param userName
 * @return
 * @throws App42Exception
 */
-(NSArray*)getAllMessages:(NSString*) userName;

@end
