//
//  PWGameController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 08/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWGameController.h"
#import "PWGameLogicLayer.h"
#import "Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h"
#import "AppDelegate.h"
#import "PWDataManager.h"
#import "PWHomeViewController.h"
#import "PWLeaderboardViewController.h"
#import "PWFriendsListViewController.h"
#import "PWSettingsViewController.h"
#import "PWNewGameViewController.h"
#import "PWSnapShotViewController.h"
#import "PWHelpViewController.h"
#import "Reachability.h"
#import "PWAlertManager.h"


static PWGameController *gameController;

@implementation PWGameController
@synthesize dataManager,previousScreenCode,currentScreenCode,networkStatus,alertManager,tutorialStatus,nextTutorialStep,tutorialManager;

+(PWGameController *)sharedInstance
{
    if (!gameController)
    {
        gameController = [[PWGameController alloc] init];
    }
    return gameController;
}

-(id)init
{
    if (self=[super init])
    {
        gameScene = [CCScene node];
        dataManager = [[PWDataManager alloc] init];
        currentController = nil;
        PWAlertManager *alertManager_temp = [[PWAlertManager alloc] init];
        self.alertManager = alertManager_temp;
        [alertManager_temp release];
        tutorialManager = nil;
        //[dataManager readSessionFromTheFile];
    }
    return self;
}

-(void)startReachabilityCheck
{
    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];

    //Change the host name here to change the server your monitoring
	hostReach = [[Reachability reachabilityForInternetConnection] retain];
	[hostReach startNotifier];
    [self notifyUserWithReachability: hostReach];
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
    
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self notifyUserWithReachability: curReach];
}

- (void) notifyUserWithReachability: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    networkStatus = netStatus;
    if (netStatus==NotReachable)
    {
       NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Network Required",ALERT_TITLE,@"Words Junkie requires an active internet connection to play. Please check your network connections and try again.",ALERT_MESSAGE,@"OK",ALERT_CANCEL_BUTTON_TEXT, nil];
        alertManager.alertType = kNoNetwork;
        [alertManager showOneButtonAlertWithInfo:alertInfo];
    }
}


-(void)switchToLayerWithCode:(ScreenCode)code
{
    currentScreenCode = code;
    switch (code)
    {
        case kHomeLayer:
        {
            [self removeUpperView];
            PWHomeViewController *homeController = [[PWHomeViewController alloc] initWithNibName:@"PWHomeViewController" bundle:nil];
            AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
            [app.navController.view addSubview:homeController.view];
            currentController = homeController;
            //[self performSelector:@selector(cleanGameScene) withObject:self afterDelay:0.1];
            
        }
            break;
        
        case kGameLayer:
        {
            [gameScene removeAllChildrenWithCleanup:YES];
            //[[CCDirector sharedDirector] replaceScene:[PWGameLogicLayer scene]];
            [gameScene addChild:[PWGameLogicLayer sharedInstance]];
            [[PWGameLogicLayer sharedInstance] layoutGameLayer];
            [self performSelector:@selector(removeUpperView) withObject:nil afterDelay:0.01];
            [[PWGameLogicLayer sharedInstance] performSelector:@selector(startGame) withObject:nil afterDelay:0.1];
        }
            break;
            
        case kFriendsListView:
        {
            [self removeUpperView];

            [gameScene removeAllChildrenWithCleanup:YES];
            PWFriendsListViewController *friendsViewController = [[PWFriendsListViewController alloc] initWithNibName:@"PWFriendsListViewController" bundle:nil];
            friendsViewController.previousScreenCode = previousScreenCode;
            //friendsViewController.friendsList = [dataManager friendsList];
            
            AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
            [app.navController.view addSubview:friendsViewController.view];
            currentController = friendsViewController;
        }
            break;
            
        case kLeaderboard:
        {
            [self removeUpperView];        
            PWLeaderboardViewController *leaderboardController = [[PWLeaderboardViewController alloc] initWithNibName:@"PWLeaderboardViewController" bundle:nil];
            leaderboardController.previousScreenCode = previousScreenCode;
            AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
            [app.navController.view addSubview:leaderboardController.view];
            currentController = leaderboardController;
            

        }
            break;
            
        case kSettingsView:
        {
            [self removeUpperView];
            PWSettingsViewController *settingViewController = [[PWSettingsViewController alloc] initWithNibName:@"PWSettingsViewController" bundle:nil];
            settingViewController.previousScreenCode = previousScreenCode;
            AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
            [app.navController.view addSubview:settingViewController.view];
            currentController = settingViewController;
            
        }
          break;
            
        case kHelpView:
        {
            [self removeUpperView];
            PWHelpViewController *helpViewController = [[PWHelpViewController alloc] initWithNibName:@"PWHelpViewController" bundle:nil];
            helpViewController.previousScreenCode = previousScreenCode;
            AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
            [app.navController.view addSubview:helpViewController.view];
            currentController = helpViewController;
            
        }
            break;
            
        case kSnapShotView:
        {
            PWSnapShotViewController *snapShotViewController = [[PWSnapShotViewController alloc] initWithNibName:@"PWSnapShotViewController" bundle:nil];
            AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
            [app.navController.view addSubview:snapShotViewController.view];
            [snapShotViewController setScreenShotImage:[[PWGameLogicLayer sharedInstance] getScreenShot]];
            currentController = snapShotViewController;
        }
            break;
            
        case kNewGameView:
        {
            [self removeUpperView];
            PWNewGameViewController *newGameViewController = [[PWNewGameViewController alloc] initWithNibName:@"PWNewGameViewController" bundle:nil];
            AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
            [app.navController.view addSubview:newGameViewController.view];
            currentController = newGameViewController;
        }

        default:
            break;
    }
}


-(void)refreshUpperView
{
    if ([PWGameLogicLayer getGameLogicLayer] &&  currentScreenCode==kGameLayer)
    {
        NSLog(@"3..%s",__FUNCTION__);
        [[PWGameLogicLayer getGameLogicLayer] refresh];
    }
    else if(currentController && currentScreenCode==kHomeLayer)
    {
        [currentController showAcitvityIndicator];
        [currentController performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.001f];
    }
}

-(void)cleanGameScene
{
    [[PWGameLogicLayer sharedInstance] removeGameObjects];
    [[PWGameLogicLayer sharedInstance] removeAllChildrenWithCleanup:YES];
    [[PWGameLogicLayer sharedInstance] removeFromParentAndCleanup:YES];
    [[CCDirector sharedDirector] purgeCachedData];
    [gameScene removeAllChildrenWithCleanup:YES];
}
//-(void)cleanGameScene
//{
//    if ([[CCDirector sharedDirector] runningScene]!=gameScene)
//    {
//        
//        [[PWGameLogicLayer sharedInstance] removeGameObjects];
//        [[PWGameLogicLayer sharedInstance] removeAllChildrenWithCleanup:YES];
//        
//        [[CCDirector sharedDirector] purgeCachedData];
//        [[CCDirector sharedDirector] replaceScene:gameScene];
//    }
//    [gameScene removeAllChildrenWithCleanup:YES];
//}

-(void)removeUpperView
{
    if (currentController)
    {
        [[currentController view] removeFromSuperview];
        [currentController release];
        currentController = nil;
    }
}

-(void)runGameScene
{
    [[CCDirector sharedDirector] replaceScene:gameScene];
}
-(CCScene*)getGameScene
{
    return gameScene;
}

-(void)releaseTutorialManager
{
    [[PWGameLogicLayer sharedInstance] setCoverLayerVisible:YES];
    [tutorialManager removeTutorialElements];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:tutorialStatus]  forKey:TUTORIAL_STATUS];
     [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:nextTutorialStep]  forKey:NEXT_TUTORIAL_STEP];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (dataManager)
    {
        [dataManager release];
        dataManager = nil;
    }
    if (alertManager)
    {
        self.alertManager = nil;
    }
    [super dealloc];
}

@end
