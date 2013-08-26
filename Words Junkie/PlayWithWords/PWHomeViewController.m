//
//  PWHomeViewController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 13/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWHomeViewController.h"
#import "PWGameController.h"
#import "SimpleAudioEngine.h"
@interface PWHomeViewController ()

@end

@implementation PWHomeViewController

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
    if (runningGamesArray)
    {
        [runningGamesArray release];
        runningGamesArray = nil;
    }
    if (finishedGamesArray)
    {
        [finishedGamesArray release];
        finishedGamesArray = nil;
    }
    if (finishedGamesDict)
    {
        [finishedGamesDict release];
        finishedGamesDict = nil;
    }
    [super dealloc];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[PWFacebookHelper sharedInstance] setDelegate:self];
    finishedGamesArray = nil;
    runningGamesArray = nil;
    CGRect tableViewFrame;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        if (IS_IPHONE5)
        {
            self.view.frame = CGRectMake(0, 0, 568, 320);
            tableViewFrame = CGRectMake(20, 58, 350, 206);
            separator.frame = CGRectMake(separator.frame.origin.x, separator.frame.origin.y, 345, 3);
            titleLabel.center = CGPointMake(titleLabel.center.x+30, titleLabel.center.y);
            indicatorView.center = CGPointMake(indicatorView.center.x+30, indicatorView.center.y);
            
            newGameButton.center = CGPointMake(newGameButton.center.x+70, newGameButton.center.y);
            leaderboardButton.center = CGPointMake(leaderboardButton.center.x+70, leaderboardButton.center.y);
            settingsButton.center = CGPointMake(settingsButton.center.x+70, settingsButton.center.y);
            helpButton.center = CGPointMake(helpButton.center.x+70, helpButton.center.y);
            loginButton.center = CGPointMake(loginButton.center.x+70, loginButton.center.y);
        }
        else
        {
            tableViewFrame = CGRectMake(20, 58, 290, 206);
        }
    }
    else
    {
        tableViewFrame = CGRectMake(42, 120, 618, 510);
    }
    //CGSize size = self.view.frame.size;
    
    gamesListView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
	[gamesListView setDataSource:self];
    [gamesListView setDelegate:self];
	[gamesListView setBackgroundColor:[UIColor clearColor]];
	[gamesListView setShowsVerticalScrollIndicator:NO];
	[gamesListView setBackgroundView:nil];
    [gamesListView setSeparatorColor:[UIColor clearColor]];
	[self.view addSubview:gamesListView];
	[gamesListView release];
    
    
    if (!FBSession.activeSession.isOpen)
    {
        [self showLoginView];
    }
    else
    {
        [self showAcitvityIndicator];
        [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.001f];        
        [[[PWGameController sharedInstance] dataManager] performSelectorInBackground:@selector(registerUserForPushNotificationToApp42Cloud) withObject:nil];
    }
}


-(void)showAcitvityIndicator
{
    [activityIndicatorView startAnimating];
}

-(void)removeAcitvityIndicator
{
    [activityIndicatorView stopAnimating];
    [indicatorView removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

-(IBAction)leaderboardButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    [[PWGameController sharedInstance] setPreviousScreenCode:kHomeLayer];
    [[PWGameController sharedInstance] switchToLayerWithCode:kLeaderboard];
}


-(IBAction)settingsButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    [[PWGameController sharedInstance] setPreviousScreenCode:kHomeLayer];
    [[PWGameController sharedInstance] switchToLayerWithCode:kSettingsView];
}

-(IBAction)helpButtonAction:(id)sender
{
    if (isLoggingViewOnTop)
    {
        return;
    }
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    [[PWGameController sharedInstance] setPreviousScreenCode:kHomeLayer];
    [[PWGameController sharedInstance] switchToLayerWithCode:kHelpView];
}


-(IBAction)newGameButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [[PWGameController sharedInstance] switchToLayerWithCode:kNewGameView];
    //[[PWFacebookHelper sharedInstance] setDelegate:self];
    //[[PWFacebookHelper sharedInstance] getFriendsPlayingThisGame];
}

-(IBAction)logInButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [[PWFacebookHelper sharedInstance] setDelegate:self];
    [[PWFacebookHelper sharedInstance] loginToFacebook];
}

-(void)updateLoginButtonUI
{
    
    if ([[PWFacebookHelper sharedInstance] loggedInSession].isOpen)
    {
        // valid account UI is shown whenever the session is open
        [loginButton setTitle:@"Log out" forState:UIControlStateNormal];
        
    }
    else
    {
        // login-needed account UI is shown whenever the session is closed
        [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    }
}

-(IBAction)activeGamesButtonAction:(id)sender
{
    if ([sender isSelected])
    {
        return;
    }
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [activeGamesButton setSelected:YES];
    [finishedGamesButton setSelected:NO];
    selectedTab = [sender tag];
    [gamesListView reloadData];
}

-(IBAction)finishedGamesButtonAction:(id)sender
{
    if ([sender isSelected])
    {
        return;
    }
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [activeGamesButton setSelected:NO];
    [finishedGamesButton setSelected:YES];
    selectedTab = [sender tag];
    [gamesListView reloadData];
}

#pragma mark-
#pragma mark-- Facebook delegate methods --
#pragma mark-

-(void)friendListRetrieved:(NSArray*)freindsList
{
    
    NSLog(@"Friends=%@",freindsList);
    [[[PWGameController sharedInstance] dataManager] setFriendsList:freindsList];
    [[PWGameController sharedInstance] switchToLayerWithCode:kFriendsListView];
    
}

-(void)userDidLoggedOut
{
    [[PWGameController sharedInstance] dataManager].gamesArray = nil;
    [gamesListView reloadData];
    [self showLoginView];
}

-(void)showLoginView
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGRect bgFrame,buttonFrame;
    CGPoint bgCenter,buttonCenter;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        if (IS_IPHONE5)
        {
            bgFrame = CGRectMake(0, 0, 366, 250);
            buttonFrame = CGRectMake(0, 0, 172, 29);
        }
        else
        {
            bgFrame = CGRectMake(0, 0, 310, 250);
            buttonFrame = CGRectMake(0, 0, 172, 29);
        }
        bgCenter = CGPointMake(size.width/3+5, size.height/2-10);
        buttonCenter = CGPointMake(size.width/3+2, size.height/2-10);
    }
    else
    {
        bgFrame = CGRectNull;
        buttonFrame = CGRectMake(0, 0, 344, 58);
        bgCenter = CGPointMake(size.width/3+10, size.height/2-20);
        buttonCenter = CGPointMake(size.width/3+4, size.height/2-20);
    }
    
    loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    loginView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    [self.view addSubview:loginView];
    [loginView release];
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_Bg.png"]];
    if (!CGRectIsNull(bgFrame))
    {
        [bgView setFrame:bgFrame];
    }
    
    [bgView setCenter:bgCenter];
    [loginView addSubview:bgView];
    [bgView release];
    
    loginFBButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginFBButton addTarget:self action:@selector(logInWithFacebook) forControlEvents:UIControlEventTouchDown];
    [loginFBButton setImage:[UIImage imageNamed:@"Login_facebook.png"] forState:UIControlStateNormal];
    [loginFBButton setFrame:buttonFrame];
    [loginFBButton setCenter:buttonCenter];
    [loginView addSubview:loginFBButton];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self action:@selector(helpButtonAction:) forControlEvents:UIControlEventTouchDown];
    [infoButton setImage:[UIImage imageNamed:@"Help-icon.png"] forState:UIControlStateNormal];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        [infoButton setFrame:CGRectMake(10, size.height-46, 47, 36)];
    }
    else
    {
        [infoButton setFrame:CGRectMake(20, size.height-56, 47, 36)];
    }
    
    [loginView addSubview:infoButton];
    
}


-(void)logInWithFacebook
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    [self showLoggingIn];
    [[PWFacebookHelper sharedInstance] setDelegate:self];
    BOOL isOpen = [[PWFacebookHelper sharedInstance] openSessionWithAllowLoginUI:YES];
    NSLog(@"isSessionOpen=%d",isOpen);
}

-(void)showLoggingIn
{
    loginFBButton.hidden = YES;
    isLoggingViewOnTop = YES;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setCenter:CGPointMake(loginFBButton.center.x, loginFBButton.center.y-15)];
    [loginView addSubview:activityIndicator];
    [activityIndicator release];
    [activityIndicator startAnimating];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    label.text = @"Logging in ...";
    label.tag = 12;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:GLOBAL_FONT size:20];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    [label setCenter:CGPointMake(loginFBButton.center.x, loginFBButton.center.y+15)];
    [loginView addSubview:label];
    
    loginFBButton.hidden = YES;
}

-(void)removeLoginView
{
    isLoggingViewOnTop = NO;
    if (loginView)
    {
        [activityIndicator stopAnimating];
        [loginView removeFromSuperview];
        activityIndicator = nil;
        loginView = nil;
    }
}


-(void)userDidLoggedIn
{
    [gamesListView reloadData];
    [self removeLoginView];
    [self showAcitvityIndicator];
    [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.001f];
    [[[PWGameController sharedInstance] dataManager] registerUserForPushNotificationToApp42Cloud];
}

-(void)fbDidNotLogin:(BOOL)cancelled
{
    UILabel *label = (UILabel*)[loginView viewWithTag:12];
    [label removeFromSuperview];
    loginFBButton.hidden = NO;
    [activityIndicator stopAnimating];
}
-(void)reloadTableView
{
    [[[PWGameController sharedInstance] dataManager] getAllGames];
    [self getFinishedGames];
    [gamesListView reloadData];
    [self removeAcitvityIndicator];
}

-(void)getFinishedGames
{
    if (runningGamesArray)
    {
        [runningGamesArray release];
        runningGamesArray=nil;
    }
    if (finishedGamesArray)
    {
        [finishedGamesArray release];
        finishedGamesArray=nil;
    }

    
    for (id object in [[[PWGameController sharedInstance] dataManager] gamesArray])
    {
        NSDictionary *gamesInfoDict = [[[[PWGameController sharedInstance] dataManager] getDictionaryFromJSON:[object jsonDoc]] retain];
        
        if ([[gamesInfoDict objectForKey:GAME_STATE] intValue]==kGameOver)
        {
            if (finishedGamesArray)
            {
                [finishedGamesArray addObject:object];
            }
            else
            {
                finishedGamesArray = [[NSMutableArray alloc] initWithObjects:object,nil];
            }
        }
        else
        {
            if (runningGamesArray)
            {
                [runningGamesArray addObject:object];
            }
            else
            {
                runningGamesArray = [[NSMutableArray alloc] initWithObjects:object,nil];
            }
        }
    }
    [self getLocallyStiredFinishedGames];
//    NSLog(@"gamesArray=%@",[[[PWGameController sharedInstance] dataManager] gamesArray]);
//    NSLog(@"runningGamesArray=%@",runningGamesArray);
//    NSLog(@"finishedGamesArray=%@",finishedGamesArray);
}

-(void)getLocallyStiredFinishedGames
{
    PWDataManager *dataManager =[[PWGameController sharedInstance] dataManager];
    finishedGamesDict = [[[dataManager readSessionFromTheFile] objectForKey:FINISHED_GAMES] retain];
    //NSLog(@"finishedGamesDict=%@",finishedGamesDict);
    if (!finishedGamesDict)
    {
        finishedGamesDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    if (!finishedGamesArray)
    {
        finishedGamesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    for (id object in finishedGamesArray)
    {
        NSMutableDictionary *gamesInfoDict = (NSMutableDictionary *)[[dataManager getDictionaryFromJSON:[object jsonDoc]] retain];
        
        [finishedGamesDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:gamesInfoDict,SESSION_DICT,[object docId],DOC_ID,nil] forKey:[object docId]];
    }
    //NSLog(@"finishedGamesDict=%@",finishedGamesDict);
    [finishedGamesArray removeAllObjects];
    NSArray *keys = [finishedGamesDict allKeys];
    for (NSString *key in keys)
    {
        [finishedGamesArray addObject:[finishedGamesDict objectForKey:key]];
    }
    //NSLog(@"finishedGamesArray=%@",finishedGamesArray);
    //[finishedGamesDict release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int count=0; 
    if (selectedTab==0)
    {
        count = [runningGamesArray count];
    }
    else
    {
        count = [finishedGamesArray count];
    }
    NSLog(@"count=%d",count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;


        int fontSize1,fontSize2;
        CGRect frame,imageFrame;
        float labelWidth1,labelWidth2,labelWidth3;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            fontSize1 = 12;
            fontSize2 = 10;
            if (IS_IPHONE5)
            {
                frame = CGRectMake(0, 0, 350, cellHeight);
                
                labelWidth1 = 80;
                labelWidth2 = 76;
                labelWidth3 = 72;
            }
            else
            {
                frame = CGRectMake(0, 0, 290, cellHeight);
                imageFrame = CGRectMake(0, 0, 350, cellHeight);
                labelWidth1 = 60;
                labelWidth2 = 64;
                labelWidth3 = 56;
            }
            imageFrame = CGRectMake(2,(cellHeight-42)/2, 42, 42);
        }
        else
        {
            fontSize1 = 20;
            fontSize2 = 16;
            frame = CGRectMake(0, 0, 618, cellHeight);
            imageFrame = CGRectMake(5, 2, cellHeight-4, cellHeight-4);
            labelWidth1 = 132;
            labelWidth2 = 135;
            labelWidth3 = 125;
        }

        UIImageView *imageView =[[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:@"ActiveGames_Pannel.png"];
        imageView.tag = 10;
        [cell.contentView addSubview:imageView];


        UIColor *color = [UIColor colorWithRed:40.0f/255.0f green:42.0f/255.0f blue:30.0f/255.0f alpha:1.0f];
        //CGSize winSize = imageView.frame.size;
        
        //float cellHeight = winSize.height;
        //NSLog(@"cellHeight=%f",cellHeight);

        //NSLog(@"gamesInfoDict=%@",gamesInfoDict);
        float x_pos = 2;
        UIImageView *player2ImageView = [[UIImageView alloc] initWithFrame:imageFrame];
        player2ImageView.tag = 1;
        [imageView addSubview:player2ImageView];
        [player2ImageView release];

        x_pos += player2ImageView.frame.size.width;
        UILabel *player2Name = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, 2, labelWidth1, cellHeight)];
        [player2Name setBackgroundColor:[UIColor clearColor]];
        player2Name.tag = 2;
        player2Name.numberOfLines = 0;
        player2Name.textAlignment = UITextAlignmentCenter;
        player2Name.textColor = color;
        [player2Name setFont:[UIFont fontWithName:GLOBAL_FONT size:fontSize1]];
        [imageView addSubview:player2Name];
        [player2Name release];

        x_pos += labelWidth1;
        UILabel *player2ScoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, cellHeight/8, labelWidth2, cellHeight/2-cellHeight/9)];
        [player2ScoreTitle setBackgroundColor:[UIColor clearColor]];
        player2ScoreTitle.numberOfLines = 0;
        player2ScoreTitle.tag = 3;
        player2ScoreTitle.textAlignment = UITextAlignmentCenter;
        player2ScoreTitle.textColor = color;
        [player2ScoreTitle setFont:[UIFont fontWithName:GLOBAL_FONT size:fontSize2]];
        [imageView addSubview:player2ScoreTitle];
        [player2ScoreTitle release];

        UILabel *player2Score = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, cellHeight/2, labelWidth2, cellHeight/2-cellHeight/9)];
        [player2Score setBackgroundColor:[UIColor clearColor]];
        player2Score.numberOfLines = 0;
        player2Score.tag = 4;
        player2Score.textAlignment = UITextAlignmentCenter;
        player2Score.textColor = color;
        [player2Score setFont:[UIFont fontWithName:GLOBAL_FONT size:fontSize2]];
        [imageView addSubview:player2Score];
        [player2Score release];


        x_pos += labelWidth2;

        UILabel *middleLine = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, cellHeight/4, 2, cellHeight/2)];
        [middleLine setBackgroundColor:color];
        [imageView addSubview:middleLine];
        [middleLine release];
        
        x_pos += 2;
        UILabel *player1ScoreTitle = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, cellHeight/9, labelWidth2, cellHeight/2-cellHeight/9)];
        player1ScoreTitle.text = @"Your Score:";
        [player1ScoreTitle setBackgroundColor:[UIColor clearColor]];
        player1ScoreTitle.numberOfLines = 0;
        player1ScoreTitle.tag = 5;
        player1ScoreTitle.textAlignment = UITextAlignmentCenter;
        player1ScoreTitle.textColor = color;
        [player1ScoreTitle setFont:[UIFont fontWithName:GLOBAL_FONT size:fontSize2]];
        [imageView addSubview:player1ScoreTitle];
        [player1ScoreTitle release];

        UILabel *player1Score = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, cellHeight/2, labelWidth2, cellHeight/2-cellHeight/9)];
        [player1Score setBackgroundColor:[UIColor clearColor]];
        player1Score.numberOfLines = 0;
        player1Score.tag = 6;
        player1Score.textAlignment = UITextAlignmentCenter;
        player1Score.textColor = color;
        [player1Score setFont:[UIFont fontWithName:GLOBAL_FONT size:fontSize2]];
        [imageView addSubview:player1Score];
        [player1Score release];

        x_pos += labelWidth2;



        UILabel *waitingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, 2, labelWidth3, cellHeight)];
        waitingTimeLabel.tag = 7;
        [waitingTimeLabel setBackgroundColor:[UIColor clearColor]];
        waitingTimeLabel.numberOfLines = 0;
        waitingTimeLabel.textAlignment = UITextAlignmentCenter;
        waitingTimeLabel.textColor = color;
        [waitingTimeLabel setFont:[UIFont fontWithName:GLOBAL_FONT size:fontSize1]];
        [imageView addSubview:waitingTimeLabel];
        [waitingTimeLabel release];

        [imageView release];

    }
    
    NSDictionary *gamesInfoDict ;
    if (selectedTab==0)
    {
        gamesInfoDict = [[[[PWGameController sharedInstance] dataManager] getDictionaryFromJSON:[[runningGamesArray objectAtIndex:indexPath.row] jsonDoc]] retain];
    }
    else
    {
        gamesInfoDict = [[[finishedGamesArray objectAtIndex:indexPath.row] objectForKey:SESSION_DICT] retain];
    }
    //NSLog(@"finishedGamesArray=%@",finishedGamesArray);
    NSString *player1 = [[[PWGameController sharedInstance] dataManager] player1];
    NSString *player2;
    if ([player1 isEqualToString:[gamesInfoDict objectForKey:PLAYER1]])
    {
        player2 = [NSString stringWithFormat:@"%@",[gamesInfoDict objectForKey:PLAYER2]];
    }
    else
    {
        player2 = [NSString stringWithFormat:@"%@",[gamesInfoDict objectForKey:PLAYER1]];
    }
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:10];
    
    [self loadProfileImageForId:player2 onImageView:(UIImageView *)[imageView viewWithTag:1]];
    
    [(UILabel *)[imageView viewWithTag:2] setText:[[gamesInfoDict objectForKey:player2] objectForKey:PLAYER_NAME]];
    NSString *player2FirstName = [[[[gamesInfoDict objectForKey:player2] objectForKey:PLAYER_NAME] componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString *title = [NSString stringWithFormat:@"%@'s Score:",player2FirstName];
    [(UILabel *)[imageView viewWithTag:3] setText:title];
    
    [(UILabel *)[imageView viewWithTag:4] setText:[NSString stringWithFormat:@"%d",[[[gamesInfoDict objectForKey:player2] objectForKey:MY_SCORE] intValue]]];
    [(UILabel *)[imageView viewWithTag:6] setText:[NSString stringWithFormat:@"%d",[[[gamesInfoDict objectForKey:player1] objectForKey:MY_SCORE] intValue]]];
    
    NSString *turn;
    int turnIndicator = [[[gamesInfoDict objectForKey:player1] objectForKey:TURN] intValue];
    int gameState = [[gamesInfoDict objectForKey:GAME_STATE] intValue];
    
    if (gameState==kGameOver)
    {
        turn = @"Game Over";
    }
    else if (turnIndicator==1)
    {
        turn = @"Your Move";
    }
    else
    {
        turn = [NSString stringWithFormat:@"%@'s Move",[[[[gamesInfoDict objectForKey:player2] objectForKey:PLAYER_NAME] componentsSeparatedByString:@" "] objectAtIndex:0]];
    }

    [(UILabel *)[imageView viewWithTag:7] setText:turn];
    [gamesInfoDict release];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //int rowHeight;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        cellHeight = 60;
    }
    else
    {
        cellHeight = 84;
    }
    return cellHeight;
}


- (void)loadProfileImageForId:(NSString*)facebookID onImageView:(UIImageView*)profileImg
{
	//NSLog(@"%s",__FUNCTION__);
	
	profileImg.image = [UIImage imageNamed:@"Male_Image.png"];
	
	NSFileManager *filemanager = [NSFileManager defaultManager];
	
	NSString *imagePath = [NSString stringWithFormat:@"%@/%@.png",FACEBOOKPROFILEIMAGES_FOLDER_PATH,facebookID];
	NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:FACEBOOKREFRESHED];
	int numberOfDaysPassed=0;
	
	if (date)
	{
		NSTimeInterval interval = -1*[date timeIntervalSinceNow];
		numberOfDaysPassed = interval/(3660*24);
		//NSLog(@"NSTimeInterval=%lf.....numberOfDaysPassed=%d",interval,numberOfDaysPassed);
	}
	
	if (numberOfDaysPassed>=10 || ![filemanager fileExistsAtPath:imagePath])
	{
		UIActivityIndicatorView *activityIndicator_l = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[activityIndicator_l setCenter:CGPointMake(profileImg.center.x-3, profileImg.center.y-2)];
		[profileImg addSubview:activityIndicator_l];
		[activityIndicator_l release];
		[activityIndicator_l startAnimating];
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:profileImg,@"imageView",facebookID,@"ID",activityIndicator_l,@"activityIndicator",nil];
		[[PWFacebookHelper sharedInstance] downloadFacebookImage:dict];
	}
	else
	{
		[profileImg setImage:[UIImage imageWithContentsOfFile:imagePath]];
	}
}



 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
     // Return NO if you do not want the specified item to be editable.
     if (selectedTab==0)
     {
         return NO;

     }
     else
     {
         return YES;
  
     }
 }  
 

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete)
     {
         
         if (selectedTab)
         {
             PWDataManager *dataManager =[[PWGameController sharedInstance] dataManager];
             if ([finishedGamesDict objectForKey:[[finishedGamesArray objectAtIndex:indexPath.row] objectForKey:DOC_ID]])
             {
                 NSMutableDictionary *gamesDict = [[dataManager readSessionFromTheFile] retain];
                // NSLog(@"finishedGamesDict=%@",finishedGamesDict);
                 [finishedGamesDict removeObjectForKey:[[finishedGamesArray objectAtIndex:indexPath.row] objectForKey:DOC_ID]];
                 //NSLog(@"finishedGamesDict=%@",finishedGamesDict);
                 if (gamesDict)
                 {
                     [gamesDict setObject:finishedGamesDict forKey:FINISHED_GAMES];
                     NSFileManager *fileManager = [NSFileManager defaultManager];
                     
                     NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@", GAMEDATA_FOLDER_PATH,SESSION_INFO_PLIST];
                     if ([fileManager fileExistsAtPath:filePath])
                     {
                         [gamesDict writeToFile:filePath atomically:YES];
                     }
                 }

             }
             
            [dataManager performSelectorInBackground:@selector(removeDocWithDocId:) withObject:[[finishedGamesArray objectAtIndex:indexPath.row] objectForKey:DOC_ID]];
            
             [finishedGamesArray removeObjectAtIndex:indexPath.row];
             // Delete the row from the data source
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert)
     {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
 }
 

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    NSMutableDictionary *gamesInfoDict;
    PWDataManager *dataManager = [[PWGameController sharedInstance] dataManager];
    if (selectedTab)
    {
        gamesInfoDict = (NSMutableDictionary *)[[[finishedGamesArray objectAtIndex:indexPath.row] objectForKey:SESSION_DICT] retain];
        [dataManager setDoc_Id:[[finishedGamesArray objectAtIndex:indexPath.row] objectForKey:DOC_ID]];
    }
    else
    {
        gamesInfoDict = (NSMutableDictionary *)[[dataManager getDictionaryFromJSON:[[runningGamesArray objectAtIndex:indexPath.row] jsonDoc]] retain];
        [dataManager setDoc_Id:[[runningGamesArray objectAtIndex:indexPath.row] docId]];
    }
    
    
    
    [dataManager setSessionInfo:gamesInfoDict];
    [dataManager setUpInitialData];
    [[PWGameController sharedInstance] switchToLayerWithCode:kGameLayer];
    [gamesInfoDict release];
    gamesInfoDict=nil;
}


@end
