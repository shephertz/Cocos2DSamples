//
//  NFStoryBoardManager.m
//  Cocos2DSimpleGame
//
//  Created by shephertz technologies on 14/03/13.
//
//

#import "NFStoryBoardManager.h"
#import "LeaderBoardViewController.h"
#import "RootViewController.h"
#import "Cocos2DSimpleGameAppDelegate.h"
#import "cocos2d.h"
#import "UserNameController.h"
#import "AppWarpHelper.h"
#import "HelloWorldScene.h"

static NFStoryBoardManager *nFStoryBoardManager;

@implementation NFStoryBoardManager

+(NFStoryBoardManager *)sharedNFStoryBoardManager
{
	if(nFStoryBoardManager == nil)
	{
		nFStoryBoardManager = [[self alloc] init];
	}
	return nFStoryBoardManager;
}

- (id) init
{
	self = [super init];
	if (self != nil)
    {
        leaderboardController = nil;
        userNameController    = nil;
	}
	return self;
}

- (void)dealloc
{

    [super dealloc];
}


#pragma mark--------
#pragma mark --- Leaderboard Methods ---
#pragma mark--------

-(void)showLeaderBoardView
{
    if (leaderboardController)
    {
        [leaderboardController.view removeFromSuperview];
        [leaderboardController release];
        leaderboardController = nil;
    }
    [[CCDirector sharedDirector] pause];
    leaderboardController = [[LeaderBoardViewController alloc] initWithNibName:@"LeaderBoardViewController" bundle:nil];
    NSLog(@"%@",leaderboardController);
    [[[(Cocos2DSimpleGameAppDelegate*)[[UIApplication sharedApplication] delegate] getRootViewController] view] addSubview:leaderboardController.view];
    
}



-(void)removeLeaderBoardView
{
    if (leaderboardController)
    {
        [leaderboardController.view removeFromSuperview];
        [leaderboardController release];
        leaderboardController = nil;
    }
    [[CCDirector sharedDirector] resume];
}

-(void)showUserNameView
{
    if (userNameController)
    {
        [userNameController.view removeFromSuperview];
        [userNameController release];
        userNameController = nil;
    }
    [[CCDirector sharedDirector] pause];
    userNameController = [[UserNameController alloc] initWithNibName:@"UserNameController" bundle:nil];
    [[[(Cocos2DSimpleGameAppDelegate*)[[UIApplication sharedApplication] delegate] getRootViewController] view] addSubview:userNameController.view];
}

-(void)removeUserNameView
{
    if (userNameController)
    {
        [userNameController.view removeFromSuperview];
        [userNameController release];
        userNameController = nil;
    }
    [[CCDirector sharedDirector] resume];
    [[AppWarpHelper sharedAppWarpHelper] connectToWarp];
    
    if ([[CCDirector sharedDirector] runningScene])
    {
        [[CCDirector sharedDirector] replaceScene: [HelloWorldScene node]];
    }
    else
    {
        [[CCDirector sharedDirector] runWithScene: [HelloWorldScene node]];
    }
    
}


@end
