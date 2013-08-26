//
//  NFStoryBoardManager.m
//  Cocos2DSimpleGame
//
//  Created by shephertz technologies on 14/03/13.
//
//

#import "NFStoryBoardManager.h"
#import "LeaderBoardViewController.h"
#import "AppDelegate.h"
#import "cocos2d.h"
#import "UserNameController.h"
#import "AppWarpHelper.h"
#import "FNGameLogicLayer.h"

static NFStoryBoardManager *nFStoryBoardManager;

@implementation NFStoryBoardManager
@synthesize gameLogicLayer;

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

-(void)updatePlayerDataToServerWithDataDict:(NSDictionary*)dataDict
{
    if(!dataDict)
		return;
	
	NSError *error = nil;
	//converting the content to plist supported binary format.
	NSData *convertedData = [NSPropertyListSerialization dataWithPropertyList:dataDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
	
	if(error || ! convertedData)
	{
		NSLog(@"DataConversion Failed.ErrorDescription: %@",[error description]);
		return;
	}
    [[AppWarpHelper sharedAppWarpHelper] setCustomDataWithData:convertedData];
    
    
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
    //[[[(AppDelegate*)[[UIApplication sharedApplication] delegate] ] view] addSubview:leaderboardController.view];
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController.view addSubview:leaderboardController.view];
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
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController.view addSubview:userNameController.view];
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
    if ([[CCDirector sharedDirector] runningScene])
    {
        [[CCDirector sharedDirector] replaceScene: [FNGameLogicLayer scene]];
    }
    else
    {
        [[CCDirector sharedDirector] runWithScene: [FNGameLogicLayer scene]];
    }
    
}

-(void)showGameLoadingIndicator
{
    [userNameController showAcitvityIndicator];
    [[AppWarpHelper sharedAppWarpHelper] connectToWarp];
}

-(void)removeGameLoadingIndicator
{
    [userNameController removeAcitvityIndicator];
    [self removeUserNameView];
}


-(void)showPausedView:(NSString*)messageString
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    pauseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    pauseView.backgroundColor = [UIColor clearColor];
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController.view addSubview:pauseView];
    [pauseView release];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [pauseView addSubview:bgView];
    [bgView release];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator setCenter:pauseView.center];
    indicator.tag = 10;
    [pauseView addSubview:indicator];
    
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, pauseView.center.y+60, size.width, 100)];
    message.backgroundColor = [UIColor clearColor];
    message.textAlignment=UITextAlignmentCenter;
    message.textColor = [UIColor whiteColor];
    message.text = messageString;
    [pauseView addSubview:message];
    [message release];
    
    [indicator startAnimating];
}

-(void)removePausedView
{
    if (pauseView)
    {
        UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[pauseView viewWithTag:10];
        [indicator stopAnimating];
        [pauseView removeFromSuperview];
        pauseView=nil;
        [[CCDirector sharedDirector] resume];
    }
}

@end
