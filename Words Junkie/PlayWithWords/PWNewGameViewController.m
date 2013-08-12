//
//  PWNewGameViewController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 27/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWNewGameViewController.h"
#import "PWGameController.h"
#import "PWGameLogicLayer.h"
#import "PWAlertManager.h"
#import "SimpleAudioEngine.h"

@interface PWNewGameViewController ()

@end

@implementation PWNewGameViewController
@synthesize previousScreenCode;

- (id)initWithNibName:(NSString *)nibNameOrNilBase bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibNameOrNil;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        nibNameOrNil = [NSString stringWithFormat:@"%@_iPhone",nibNameOrNilBase];
    }
    else
    {
        nibNameOrNil = [NSString stringWithFormat:@"%@_iPad",nibNameOrNilBase];
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE5)
    {
        self.view.frame = CGRectMake(0, 0, 568, 320);
        titleLabel.center = CGPointMake(titleLabel.center.x+30, titleLabel.center.y);
        selectFriendsButton.center = CGPointMake(selectFriendsButton.center.x+40, selectFriendsButton.center.y);
        randomPlayerButton.center = CGPointMake(randomPlayerButton.center.x+40, randomPlayerButton.center.y);
    }

}

-(void)findingOpponentView
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    findingOpponentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winSize.width, winSize.height)];
    findingOpponentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:findingOpponentView];
    [findingOpponentView release];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winSize.width, winSize.height)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    [findingOpponentView addSubview:bgView];
    [bgView release];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setCenter:findingOpponentView.center];
    activityIndicator.tag = 10;
    [findingOpponentView addSubview:activityIndicator];
    [activityIndicator release];
    [activityIndicator startAnimating];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, winSize.width/2, 60)];
    label.text = @"Finding random opponent ...";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:GLOBAL_FONT size:20];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    [label setCenter:CGPointMake(findingOpponentView.center.x, findingOpponentView.center.y+20)];
    [findingOpponentView addSubview:label];

}

-(void)removeFindingOpponentView
{
    if (findingOpponentView)
    {
        UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[findingOpponentView viewWithTag:10];
        [activityIndicator stopAnimating];
        [findingOpponentView removeFromSuperview];
        findingOpponentView = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:BACK_BUTTON_CLICKED];

    [[PWGameController sharedInstance] switchToLayerWithCode:kHomeLayer];
}

-(IBAction)selectFreindsButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    [[PWGameController sharedInstance] setPreviousScreenCode:kNewGameView];
    [[PWGameController sharedInstance] switchToLayerWithCode:kFriendsListView];
    //[[PWFacebookHelper sharedInstance] setDelegate:self];
    //[[PWFacebookHelper sharedInstance] getFriendsPlayingThisGame];
    
}
-(IBAction)randomPlayerButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [self findingOpponentView];
    [self performSelector:@selector(checkForRandomPlayer) withObject:nil afterDelay:0.1];
}

-(void)checkForRandomPlayer
{
    PWDataManager *dataManager = [[PWGameController sharedInstance] dataManager];
    NSArray *idArray = [[[PWGameController sharedInstance] dataManager] checkForRandomPlayer];
    
    if (idArray && idArray.count)
    {
        int randomIndex = arc4random()%idArray.count;
        NSDictionary *userInfoDict = [[dataManager getDictionaryFromJSON:[[idArray objectAtIndex:randomIndex] jsonDoc]] retain];
        //NSLog(@"[[idArray objectAtIndex:randomIndex] docId]=%@",[[idArray objectAtIndex:randomIndex] docId]);
        //NSLog(@"userInfoDict=%@",userInfoDict);
        if ([[[userInfoDict objectForKey:RANDOM_STACK] objectForKey:@"uid"] isEqualToString:dataManager.player1])
        {
            [self removeFindingOpponentView];
            // do nothing if the id of the requeting user and id in the stack is same.
            NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"We will notify you when we find an opponent!",ALERT_MESSAGE, nil];
            [[PWGameController sharedInstance].alertManager showTurnAlertWithAlertInfo:alertInfo];
        }
        else
        {
            dataManager.player2 = [[userInfoDict objectForKey:RANDOM_STACK] objectForKey:@"uid"];
            dataManager.player2_name = [[userInfoDict objectForKey:RANDOM_STACK] objectForKey:@"name"];
            [dataManager createNewGameSession];
            [[PWGameController sharedInstance] switchToLayerWithCode:kGameLayer];
            [dataManager removeDocWithRequestId:[[idArray objectAtIndex:randomIndex] docId]];
            [self removeFindingOpponentView];
        }
        
        [userInfoDict release];
        userInfoDict=nil;
        [idArray release];
        idArray=nil;
        
    }
    else
    {
        [self removeFindingOpponentView];
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"We will notify you when we find an opponent!",ALERT_MESSAGE, nil];
        [[PWGameController sharedInstance].alertManager showTurnAlertWithAlertInfo:alertInfo];
        [dataManager performSelectorInBackground:@selector(addRequestToRandomStack) withObject:nil];
    }
    
}



#pragma mark-
#pragma mark-- Facebook delegate methods --
#pragma mark-

-(void)friendListRetrieved:(NSArray*)freindsList
{
    
    NSLog(@"Friends=%@",freindsList);
    [[[PWGameController sharedInstance] dataManager] setFriendsList:freindsList];
    [[PWGameController sharedInstance] setPreviousScreenCode:kNewGameView];
    [[PWGameController sharedInstance] switchToLayerWithCode:kFriendsListView];
    
}

@end
