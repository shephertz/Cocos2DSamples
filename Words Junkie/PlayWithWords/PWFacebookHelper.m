
//
//  PWFacebookHelper.m
//  PlayWithWords
//
//  Created by shephertz technologies on 09/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWFacebookHelper.h"
#import "PWGameLogicLayer.h"
#import "PWGameController.h"

NSString *const FBSessionStateChangedNotification =@"com.shephertz.wordsjunkie.wordsjunkie:FBSessionStateChangedNotification";

static PWFacebookHelper *fbHelper;

@implementation PWFacebookHelper
@synthesize userId,userName,loggedInSession,delegate;

+(PWFacebookHelper *)sharedInstance
{
    if (!fbHelper)
    {
        fbHelper = [[PWFacebookHelper alloc] init];
    }
    return fbHelper;
}

-(id)init
{
    if (self=[super init])
    {
        _imageDownloadQueue	= [[NSOperationQueue alloc] init];
    }
    return self;
}



-(void)dealloc
{
    if (self.loggedInSession)
    {
        self.loggedInSession = nil;
    }
    if (self.userName)
    {
        self.userName = nil;
    }
    
    if (self.userId)
    {
        self.userId = nil;
    }
    
    if (self.userInfoDict)
    {
        self.userInfoDict = nil;
    }
    
    if (_imageDownloadQueue)
    {
        [_imageDownloadQueue release];
        _imageDownloadQueue = nil;
    }
    [super dealloc];
}

#pragma mark-
#pragma mark-- Session Management Methods --
#pragma mark-

-(void)openNewSessionWithLoginUI:(BOOL)allowLoginUI
{
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"email",
                            nil];
    
    // Attempt to open the session. If the session is not open, show the user the Facebook login UX
    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:allowLoginUI completionHandler:^(FBSession *session,FBSessionState status,NSError *error)
     {
         [self sessionStateChanged:session
                             state:status
                             error:error];
         NSLog(@"error=%@",[error description]);
     }];
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
{
    //NSArray *permissions = [[NSArray arrayWithObjects:@"user_about_me,user_photos",
                              //nil] retain];
    return [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error)
                                        {
                                            if (error)
                                            {
                                                if( self.delegate && [self.delegate respondsToSelector:@selector(fbDidNotLogin:)])
                                                {
                                                    [self.delegate fbDidNotLogin:YES];
                                                }
                                            }
                                            else
                                            {
                                                self.userInfoDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookUserInfo"];
                                                NSLog(@"userInfoDict=%@",self.userInfoDict);
                                                //[self getUserDetails];
                                                if (self.userInfoDict)
                                                {
                                                    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
                                                    self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
                                                    [[[PWGameController sharedInstance] dataManager] setPlayer1:userId];
                                                    if( self.delegate && [self.delegate respondsToSelector:@selector(userDidLoggedIn)])
                                                    {
                                                        [self.delegate userDidLoggedIn];
                                                    }
                                                }
                                                else
                                                {
                                                    [self getUserDetails];
                                                }
                                                NSLog(@"self.userName=%@",self.userName);
                                            }
                                            
                                            [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                             NSLog(@"error=%@",[error description]);
                                         }];
}

- (void)loginToFacebook
{
    // this button's job is to flip-flop the session from open to closed
    if (loggedInSession.isOpen)
    {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [loggedInSession closeAndClearTokenInformation];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"facebookUserInfo"];
        if( self.delegate && [self.delegate respondsToSelector:@selector(userDidLoggedOut)])
        {
            [self.delegate userDidLoggedOut];
        }
        
        
    }
    else
    {
        if (loggedInSession.state != FBSessionStateCreated)
        {
            // Create a new, logged out session.
            self.loggedInSession = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [loggedInSession openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error)
        {
            [self getUserDetails];
        }];
    }
}


-(void)getUserDetails
{
    if (FBSession.activeSession.isOpen)
    {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error)
        {
             if (!error)
             {//facebookUserInfo
                 self.userId = [NSString stringWithFormat:@"%@",user.id];
                 [[NSUserDefaults standardUserDefaults] setObject:user.first_name forKey:@"userName"];
                 [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
                 self.userName = user.first_name;
                 self.userInfoDict = user;
                 NSLog(@"userInfoDict=%@",self.userInfoDict);
                 [[NSUserDefaults standardUserDefaults] setObject:self.userInfoDict forKey:@"facebookUserInfo"];
                 [[[PWGameController sharedInstance] dataManager] setPlayer1:userId];
                 if( self.delegate && [self.delegate respondsToSelector:@selector(userDidLoggedIn)])
                 {
                     [self.delegate userDidLoggedIn];
                 }
             }
            NSLog(@"error=%@",[error description]);
        }];
    }
}


-(void)getFriends
{
    if (FBSession.activeSession.isOpen)
    {
        [[FBRequest requestForMyFriends] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *friends,
           NSError *error)
         {
             if (!error)
             {
                 
                 if( self.delegate && [self.delegate respondsToSelector:@selector(friendListRetrieved:)])
                 {
                     NSArray *friendInfo = (NSArray *) [friends objectForKey:@"data"];
                     [self.delegate friendListRetrieved:friendInfo];
                 }
                 
             }
             NSLog(@"error=%@",[error description]);
         }];
    }
}

-(void)shareSnapshot:(UIImage*)snapShot
{
    
    
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound)
    {
        
        [FBSession.activeSession requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
         completionHandler:^(FBSession *session, NSError *error)
         {
             if (!error)
             {
                 // re-call assuming we now have the permission
                 [self shareSnapshot:snapShot];
             }
         }];
    }
    else
    {
        [[FBRequest requestForUploadPhoto:snapShot] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *friends,
           NSError *error)
         {
             if (!error)
             {
                 
                 if( self.delegate && [self.delegate respondsToSelector:@selector(snapshotSharedToTheWall)])
                 {
                     [delegate snapshotSharedToTheWall];
                 }
                 
             }
             NSLog(@"error=%@",[error description]);
         }];
    }
}



//username: shyamchetan@yahoo.com
// password : planet

-(void)getFriendsPlayingThisGame
{
    
        // Query to fetch the active user's friends, limit to 25.
        NSString *query = @"SELECT uid, name, is_app_user FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=me()) AND is_app_user=1";
    
        // Set up the query parameter
        NSDictionary *queryParam =[NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    
        // Make the API request that uses FQL
        [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error)
                                {
                                  if (error)
                                  {
                                      NSLog(@"Error: %@", [error localizedDescription]);
                                      NSLog(@"error=%@",[error description]);
                                  }
                                  else
                                  {
                                      NSLog(@"Result: %@", result);
                                      // Get the friend data to display
                                      NSArray *friendInfo = (NSArray *) [result objectForKey:@"data"];
                                      if( self.delegate && [self.delegate respondsToSelector:@selector(friendListRetrieved:)])
                                      {
                                          [self.delegate friendListRetrieved:friendInfo];
                                          [self saveFriends:friendInfo];
                                      }
                                  }
                              }];
    
    //SELECT uid2 FROM friend WHERE uid1 = me() AND uid2 = {YOUR_FRIEND2_ID}
}

-(void)getRelationShipWithPlayerTwo
{
    // Query to fetch the active user's friends, limit to 25.
    NSString *query = [NSString stringWithFormat:@"SELECT uid2 FROM friend WHERE uid1 = me() AND uid2 = %@",[[[PWGameController sharedInstance] dataManager] player2]];
    
    // Set up the query parameter
    NSDictionary *queryParam =[NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];

    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
             NSLog(@"error=%@",[error description]);
         }
         else
         {
             NSLog(@"Result: %@", result);
             // Get the friend data to display
             NSArray *friendInfo = (NSArray *) [result objectForKey:@"data"];
             BOOL isFriend;
             if ([friendInfo count])
             {
                 isFriend = YES;
             }
             else
             {
                 isFriend = NO;
             }
             if( self.delegate && [self.delegate respondsToSelector:@selector(relationShipRetrieved:)])
             {
                 [self.delegate relationShipRetrieved:isFriend];
                 
             }
             
         }
     }];

}


-(void)saveFriends:(NSArray*)friends
{
    NSMutableArray *fbIDArray = [[NSMutableArray alloc] initWithCapacity:0];
    int count = [friends count];
    for (int i=0; i<count; i++)
    {
        [fbIDArray addObject:[NSString stringWithFormat:@"%@",[[friends objectAtIndex:i] objectForKey:@"uid"]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:fbIDArray forKey:FB_ID_ARRAY];
}

-(void)sendFriendRequest
{
    Facebook *face = [[Facebook alloc] initWithAppId:FBSession.activeSession.appID andDelegate:nil];
    face.accessToken = FBSession.activeSession.accessToken;
    face.expirationDate = FBSession.activeSession.expirationDate;
    if ([face isSessionValid])
    {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Words Junkie", @"title",
                                       @"Please accept my friend request.",  @"message",
                                       [[[PWGameController sharedInstance] dataManager] player2], @"id",
                                       nil];
        [face dialog:@"friends"
           andParams:[params mutableCopy]
         andDelegate:nil];
    }
}


/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state)
    {
        case FBSessionStateOpen:
            if (!error)
            {
                // We have a valid session
                //NSLog(@"User session found");
                [FBRequestConnection
                 startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                   NSDictionary<FBGraphUser> *user,
                                                   NSError *error)
                {
                     if (!error)
                     {
                         self.userId = user.id;
                         self.loggedInSession = FBSession.activeSession;
                     }
                 }];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


-(void)downloadFacebookImage:(NSDictionary*)dict
{
    [dict retain];
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(loadFreindsImageWithImageView:)
																			  object:dict];
	
	[_imageDownloadQueue addOperation:operation];
	
	[operation release];
    [dict release];
}


-(void)loadFreindsImageWithImageView:(NSDictionary*)dict
{
    [dict retain];
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	UIImageView *imageView = (UIImageView*)[dict objectForKey:IMAGEVIEW];
	
	
	NSFileManager *filemanager = [NSFileManager defaultManager];
	UIImage *profileImage;
	NSData *profileImageData;
	if (![filemanager fileExistsAtPath:FACEBOOKPROFILEIMAGES_FOLDER_PATH])
	{
		[filemanager createDirectoryAtPath:FACEBOOKPROFILEIMAGES_FOLDER_PATH withIntermediateDirectories:NO attributes:nil error:nil];
	}
	NSString *imagePath = [NSString stringWithFormat:@"%@/%@.png",FACEBOOKPROFILEIMAGES_FOLDER_PATH,[dict objectForKey:FB_ID]];
	
	
	profileImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",[dict objectForKey:FB_ID]]]];
	profileImage = [UIImage imageWithData:profileImageData];
	
    [profileImageData writeToFile:imagePath atomically:YES];
	[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:FACEBOOKREFRESHED];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	
	[imageView setImage:profileImage];
	
	[(UIActivityIndicatorView*)[dict objectForKey:@"activityIndicator"] stopAnimating];
	
	[dict release];
	[pool release];
}


/**
 * Called when the dialog succeeds and is about to be dismissed.
 */
- (void)dialogDidComplete:(FBDialog *)dialog
{
	NSLog(@"PUBLISHED SUCCESSFULLY");
	if( self.delegate && [self.delegate respondsToSelector:@selector(messageSharingDialogRemoved)])
	{
		[self.delegate messageSharingDialogRemoved];
	}
}

/**
 * Called when the dialog succeeds with a returning url.
 */
- (void)dialogCompleteWithUrl:(NSURL *)url
{
    
}

/**
 * Called when the dialog get canceled by the user.
 */
- (void)dialogDidNotCompleteWithUrl:(NSURL *)url
{
    
}

/**
 * Called when the dialog is cancelled and is about to be dismissed.
 */
- (void)dialogDidNotComplete:(FBDialog *)dialog
{
    
}



@end
