//
//  PWLeaderboardViewController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 17/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWLeaderboardViewController.h"
#import "PWGameController.h"
#import "SimpleAudioEngine.h"

@interface PWLeaderboardViewController ()

@end

@implementation PWLeaderboardViewController
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
    if (self) {
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
    scoreList = nil;
    [friendsButton setSelected:YES];
    
    messageLabel.hidden = YES;
    leaderboardTableView.dataSource = self;
    leaderboardTableView.delegate   = self;
    colorChanger = 1;
    [self showAcitvityIndicator];
    [[PWFacebookHelper sharedInstance] setDelegate:self];
    [[PWFacebookHelper sharedInstance] getFriendsPlayingThisGame];
    //[self performSelectorInBackground:@selector(getScore) withObject:nil];
    
    if (IS_IPHONE5)
    {
        self.view.frame = CGRectMake(0, 0, 568, 320);
        [leaderboardTableView setFrame:CGRectMake(leaderboardTableView.frame.origin.x+20, leaderboardTableView.frame.origin.y, 288, leaderboardTableView.frame.size.height)];
        
        friendsButton.center = CGPointMake(friendsButton.center.x+30, friendsButton.center.y);
        globalButton.center = CGPointMake(globalButton.center.x+30, globalButton.center.y);
        
        nameTitleLabel.center = CGPointMake(nameTitleLabel.center.x+32, nameTitleLabel.center.y);
        rankTitleLabel.center = CGPointMake(rankTitleLabel.center.x+46, rankTitleLabel.center.y);
        scoreTitleLabel.center = CGPointMake(scoreTitleLabel.center.x+58, scoreTitleLabel.center.y);
        indicatorView.center = CGPointMake(indicatorView.center.x+50, indicatorView.center.y);
        
    }
    
}


-(void)getScore
{
    scoreList=[[[PWGameController sharedInstance] dataManager] getScores];
    NSLog(@"scoreList=%@",scoreList);
    if (scoreList&&[scoreList count])
    {
        messageLabel.hidden = YES;
    }
    else
    {
        messageLabel.hidden = NO;
    }
    [leaderboardTableView reloadData];
    [self removeAcitvityIndicator];
}

-(void)getTodaysScores
{
    scoreList=[[[PWGameController sharedInstance] dataManager] getTodaysScores];
    if (scoreList&&[scoreList count])
    {
        messageLabel.hidden = YES;
    }
    else
    {
        messageLabel.hidden = NO;
    }
    [leaderboardTableView reloadData];
    [self removeAcitvityIndicator];
}

-(void)getFriendsScores
{
    scoreList=[[[PWGameController sharedInstance] dataManager] getFriendsScores];
    if (scoreList&&[scoreList count])
    {
        messageLabel.hidden = YES;
    }
    else
    {
        messageLabel.hidden = NO;
    }
    [leaderboardTableView reloadData];
    [self removeAcitvityIndicator];
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
		UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[activityIndicator setCenter:CGPointMake(profileImg.center.x-3, profileImg.center.y-2)];
		[profileImg addSubview:activityIndicator];
		[activityIndicator release];
		[activityIndicator startAnimating];
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:profileImg,@"imageView",facebookID,@"ID",activityIndicator,@"activityIndicator",nil];
		[[PWFacebookHelper sharedInstance] downloadFacebookImage:dict];
	}
	else
	{
		[profileImg setImage:[UIImage imageWithContentsOfFile:imagePath]];
	}
}


#pragma mark - Button Actions

-(IBAction)todayButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [self showAcitvityIndicator];
    [self performSelectorInBackground:@selector(getTodaysScores) withObject:nil];

    
}
-(IBAction)globalButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [friendsButton setSelected:NO];
    [globalButton setSelected:YES];
    
    [self showAcitvityIndicator];
    [self performSelectorInBackground:@selector(getScore) withObject:nil];


}
-(IBAction)friendsButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [friendsButton setSelected:YES];
    [globalButton setSelected:NO];
    
    [self showAcitvityIndicator];
    [self performSelectorInBackground:@selector(getFriendsScores) withObject:nil];
}

-(IBAction)allTimeButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [self showAcitvityIndicator];
    [self performSelectorInBackground:@selector(getScore) withObject:nil];
}

-(IBAction)backButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:BACK_BUTTON_CLICKED];
    if (previousScreenCode==kGameLayer)
    {
        [[[PWGameController sharedInstance] dataManager] removeNewAlphabetFromSessionIfNotSubmitted];
    }
    [[PWGameController sharedInstance] switchToLayerWithCode:previousScreenCode];
}


#pragma mark-
#pragma mark-- Facebook delegate methods --
#pragma mark-

-(void)friendListRetrieved:(NSArray*)freindsList
{
    
    NSLog(@"Friends=%@",freindsList);
    [[[PWGameController sharedInstance] dataManager] setFriendsList:freindsList];
    [self getFriendsScores];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows =0;
    if (scoreList)
    {
        numberOfRows =[scoreList count];
    }
	return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        CGSize viewSize = leaderboardTableView.frame.size;
        float labelWidth = viewSize.width/3;
        float x_pos = 5;
        float y_pos = 15;
        
        int fontSize = 24;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            x_pos = 2;
            y_pos = 3;
            fontSize = 16;
        }
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, rowHeight)];
        
        bgView.tag=5;
        [cell addSubview:bgView];
        [bgView release];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x_pos, 2, rowHeight-4, rowHeight-4)];
        imageView.tag = 1;
        [cell addSubview:imageView];
        [imageView release];
        
        x_pos +=imageView.frame.size.width*1.5f;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, y_pos, labelWidth, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.tag =2;
        nameLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:fontSize];
        nameLabel.textAlignment = UITextAlignmentLeft;
        [nameLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:nameLabel];
        [nameLabel release];
        
        x_pos +=labelWidth;
        UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, y_pos, labelWidth, 30)];
        rankLabel.backgroundColor = [UIColor clearColor];
        rankLabel.tag =3;
        rankLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:fontSize];
        rankLabel.textAlignment = UITextAlignmentCenter;
        [rankLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:rankLabel];
        [rankLabel release];

        x_pos +=labelWidth;
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, y_pos, labelWidth, 30)];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.tag =4;
        scoreLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:fontSize];
        scoreLabel.textAlignment = UITextAlignmentLeft;
        [scoreLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:scoreLabel];
        [scoreLabel release];

    }
    
    Score *l_score = [scoreList objectAtIndex:indexPath.row];
    //NSLog(@"l_score=%@...%d....%f",l_score,indexPath.row,l_score.value);
    NSArray *strArray = [l_score.userName componentsSeparatedByString:@"zz"];
    [self loadProfileImageForId:[strArray objectAtIndex:1] onImageView:(UIImageView *)[cell viewWithTag:1]];
    [(UILabel *)[cell viewWithTag:2] setText:[strArray objectAtIndex:0]];
    [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    [(UILabel *)[cell viewWithTag:4] setText:[NSString stringWithFormat:@"%0.0f",l_score.value]];
    
    UIView *bgview = (UIView *)[cell viewWithTag:5];
    if (indexPath.row%2==0)
    {
        bgview.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:143.0f/255.0f blue:19.0f/255.0f alpha:1.0f];
    }
    else
    {
        bgview.backgroundColor = [UIColor colorWithRed:183.0f/255.0f green:106.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        rowHeight = 36;
    }
    else
    {
        rowHeight = 54;
    }
    return rowHeight;

}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
    
}



@end
