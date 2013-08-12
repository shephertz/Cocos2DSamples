//
//  PWFriendsListViewController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 17/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWFriendsListViewController.h"
#import "PWGameLogicLayer.h"
#import "PWGameController.h"
#import "SimpleAudioEngine.h"
@interface PWFriendsListViewController ()

@end

@implementation PWFriendsListViewController
@synthesize friendsList,previousScreenCode;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        if (IS_IPHONE5)
        {
            //tableViewFrame = CGRectMake(20, 58, 350, 206);
            titleLabel.center = CGPointMake(titleLabel.center.x+30, titleLabel.center.y);
            //indicatorView.center = CGPointMake(indicatorView.center.x+50, indicatorView.center.y);
            self.view.frame = CGRectMake(0, 0, 568, 320);
            [friendListTableView setFrame:CGRectMake(friendListTableView.frame.origin.x+20, friendListTableView.frame.origin.y, 288, friendListTableView.frame.size.height)];
            indicatorView.center = CGPointMake(indicatorView.center.x+50, indicatorView.center.y);
        }
        else
        {
            titleLabel.center = CGPointMake(titleLabel.center.x+50, titleLabel.center.y);
            //tableViewFrame = CGRectMake(20, 58, 290, 206);
            titleLabel.center = CGPointMake(titleLabel.center.x-50, titleLabel.center.y);
        }
    }
    else
    {
        //tableViewFrame = CGRectMake(42, 120, 618, 510);
    }

    [self showAcitvityIndicator];
    [[PWFacebookHelper sharedInstance] setDelegate:self];
    [[PWFacebookHelper sharedInstance] getFriendsPlayingThisGame];
    //CGSize size = self.view.frame.size;
    colorChanger = 1;
	[friendListTableView setDataSource:self];
    [friendListTableView setDelegate:self];
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

-(void)dealloc
{
    if (self.friendsList)
    {
        self.friendsList = nil;
    }
    [super dealloc];
}


#pragma mark-
#pragma mark-- Facebook delegate methods --
#pragma mark-

-(void)friendListRetrieved:(NSArray*)freindsList
{
    
    NSLog(@"Friends=%@",freindsList);
    [[[PWGameController sharedInstance] dataManager] setFriendsList:freindsList];
    self.friendsList = freindsList;
    [friendListTableView reloadData];
    [self removeAcitvityIndicator];
}


#pragma mark - Button Actions

-(IBAction)backButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:BACK_BUTTON_CLICKED];

    [self removeAcitvityIndicator];
    [[PWFacebookHelper sharedInstance] setDelegate:nil];
    [[PWGameController sharedInstance] switchToLayerWithCode:previousScreenCode];
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
    int count = 0;
    if (friendsList)
    {
        count = [friendsList count];
    }
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
        
        
        
        CGSize viewSize = friendListTableView.frame.size;
        float labelWidth = viewSize.width/3;
        
        float x_pos = 5;
        float y_pos = 10;
        int fontSize = 22;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            x_pos = 2;
            y_pos = 3;
            fontSize = 14;
        }
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, rowHeight)];
        if (colorChanger>0)
        {
            bgView.backgroundColor = [UIColor colorWithRed:184.0f/255.0f green:143.0f/255.0f blue:19.0f/255.0f alpha:1.0f];
        }
        else
        {
            bgView.backgroundColor = [UIColor colorWithRed:183.0f/255.0f green:106.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
        }
        colorChanger *=-1;
        
        [cell addSubview:bgView];
        [bgView release];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x_pos, 1, rowHeight-2, rowHeight-2)];
        imageView.tag = 1;
        [cell addSubview:imageView];
        [imageView release];
        
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            x_pos +=imageView.frame.size.width*1.3f;
        }
        else
        {
            x_pos +=imageView.frame.size.width*1.5f;
        }
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, y_pos, labelWidth, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.tag =2;
        nameLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:fontSize];
        nameLabel.textAlignment = UITextAlignmentLeft;
        [nameLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:nameLabel];
        [nameLabel release];
        
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            if (IS_IPHONE5)
            {
                x_pos +=labelWidth*1.8f;
            }
            else
            {
                x_pos +=labelWidth*1.65f;
            }
            
        }
        else
        {
            x_pos +=labelWidth*1.8f;
        }
        UILabel *plusLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_pos, y_pos, labelWidth, 30)];
        plusLabel.backgroundColor = [UIColor clearColor];
        plusLabel.tag =3;
        plusLabel.text = @"+";
        plusLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:fontSize];
        plusLabel.textAlignment = UITextAlignmentCenter;
        [plusLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:plusLabel];
        [plusLabel release];
                
    }
    
    NSString *facebookID = [[friendsList objectAtIndex:indexPath.row] objectForKey:@"uid"];
    [self loadProfileImageForId:facebookID onImageView:(UIImageView *)[cell viewWithTag:1]];
    [(UILabel *)[cell viewWithTag:2] setText:[[friendsList objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    
    
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

- (void)loadProfileImageForId:(NSString*)facebookID onImageView:(UIImageView *)profileImg
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



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    //NSLog(@"friendsList=%@, %@",friendsList,[friendsList objectAtIndex:indexPath.row]);
    [[PWGameController sharedInstance] dataManager].player2 = [NSString stringWithFormat:@"%@",[[friendsList objectAtIndex:indexPath.row] objectForKey:@"uid"]];
    [[PWGameController sharedInstance] dataManager].player2_name = [[friendsList objectAtIndex:indexPath.row] objectForKey:@"name"];
    [[[PWGameController sharedInstance] dataManager] createNewGameSession];
    [[PWGameController sharedInstance] switchToLayerWithCode:kGameLayer];
}


@end
