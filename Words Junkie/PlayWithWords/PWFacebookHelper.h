//
//  PWFacebookHelper.h
//  PlayWithWords
//
//  Created by shephertz technologies on 09/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <FacebookSDK/FacebookSDK.h>
#import "Facebook.h"
extern NSString *const FBSessionStateChangedNotification;
@protocol PWFacebookHelperDelegate;
@interface PWFacebookHelper : NSObject<FBDialogDelegate>
{
    NSOperationQueue *_imageDownloadQueue;
}
@property (nonatomic, assign) id<PWFacebookHelperDelegate> delegate;
@property(nonatomic,retain) FBSession       *loggedInSession;
@property(nonatomic,retain) NSString        *userName;
@property(nonatomic,retain) NSString        *userId;
@property(nonatomic,retain) NSDictionary    *userInfoDict;

+(PWFacebookHelper *)sharedInstance;

-(void)openNewSessionWithLoginUI:(BOOL)allowLoginUI;
-(BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
-(void)sessionStateChanged:(FBSession *)session
                     state:(FBSessionState) state
                     error:(NSError *)error;

-(void)getUserDetails;
-(void)getFriends;
-(void)shareSnapshot:(UIImage*)snapShot;
-(void)getFriendsPlayingThisGame;
-(void)downloadFacebookImage:(NSDictionary*)dict;
-(void)loadFreindsImageWithImageView:(NSDictionary*)dict;
-(void)loginToFacebook;
-(void)getRelationShipWithPlayerTwo;
-(void)sendFriendRequest;
@end



@protocol PWFacebookHelperDelegate<NSObject>

@optional

    -(void)fbDidNotLogin:(BOOL)cancelled;
    -(void)userDidLoggedOut;
    -(void)userDidLoggedIn;
    -(void)friendListRetrieved:(NSArray *)friends;
    -(void)snapshotSharedToTheWall;
    -(void)snapshotSharingFailed;
    -(void)messageSharingDialogRemoved;
    -(void)removeParentViewIncaseOfNetworkFailure;
    -(void)relationShipRetrieved:(BOOL)isFriend;

@end

