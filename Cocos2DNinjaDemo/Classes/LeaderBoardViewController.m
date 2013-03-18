//
//  LeaderBoardViewController.m
//  Cocos2DSimpleGame
//
//  Created by shephertz technologies on 14/03/13.
//
//

#import "LeaderBoardViewController.h"
#import "NFStoryBoardManager.h"
#import "AppWarpHelper.h"

@interface LeaderBoardViewController ()

@end

@implementation LeaderBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) || !nibNameOrNil)
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    else 
    {
        self = [super initWithNibName:[NSString stringWithFormat:@"%@_iPhone",nibNameOrNil] bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize viewSize = self.view.frame.size;
    // Do any additional setup after loading the view from its nib.
    scoreList=nil;
    
    userRecordsTableView.backgroundColor = [UIColor clearColor];
    userRecordsTableView.frame = CGRectMake(0, 0, viewSize.height, viewSize.height);
    
    //
    // Create a header view. Wrap it in a container to allow us to position
    // it better.
    //
    UIView *containerView =[[[UIView alloc] initWithFrame:CGRectMake(0, 0, userRecordsTableView.frame.size.width, 60)] autorelease];
    UILabel *headerLabel  =[[[UILabel alloc] initWithFrame:CGRectMake(0, 10, userRecordsTableView.frame.size.width, 40)] autorelease];
    headerLabel.text = NSLocalizedString(@"Leaderboard", @"");
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor blackColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.textAlignment = UITextAlignmentCenter;
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    [containerView addSubview:headerLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 59, userRecordsTableView.frame.size.width, 1)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [containerView addSubview:lineLabel];
    [lineLabel release];
    
    userRecordsTableView.tableHeaderView = containerView;
    
    
    userRecordsTableView.dataSource = self;
    userRecordsTableView.delegate   = self;
    
    [self showAcitvityIndicator];
    [self performSelectorInBackground:@selector(getScore) withObject:nil];
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

-(void)getScore
{
    scoreList=[[AppWarpHelper sharedAppWarpHelper] getScores];
    [userRecordsTableView reloadData];
    [self removeAcitvityIndicator];
}

#pragma mark-------------
#pragma mark ---Button Actions---
#pragma mark-------------

-(IBAction)backButtonAction:(id)sender
{
    [[NFStoryBoardManager sharedNFStoryBoardManager] removeLeaderBoardView];
}




#pragma mark-------------
#pragma mark ---UITableViewDatasource Methods---
#pragma mark-------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	return @"Leaderboard";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows =0;
    if (scoreList)
    {
        numberOfRows =[scoreList count]+1;
    }
	return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserRecord";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        CGSize viewSize = self.view.frame.size;
        float labelWidth = viewSize.width/3;
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 30)];
        rankLabel.backgroundColor = [UIColor clearColor];
        rankLabel.tag =1;
        rankLabel.textAlignment = UITextAlignmentCenter;
        [rankLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:rankLabel];
        [rankLabel release];
        
        UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 0, 1, tableView.rowHeight)];
        lineLabel1.backgroundColor = [UIColor blackColor];
        [cell addSubview:lineLabel1];
        [lineLabel1 release];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 0, labelWidth, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.tag =2;
        nameLabel.textAlignment = UITextAlignmentCenter;
        [nameLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:nameLabel];
        [nameLabel release];
        
        UILabel *lineLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(2*labelWidth, 0, 1, tableView.rowHeight)];
        lineLabel2.backgroundColor = [UIColor blackColor];
        [cell addSubview:lineLabel2];
        [lineLabel2 release];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*labelWidth, 0, labelWidth, 30)];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.tag =3;
        scoreLabel.textAlignment = UITextAlignmentCenter;
        [scoreLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:scoreLabel];
        [scoreLabel release];
    }
    
    if (indexPath.row==0)
    {
        UILabel *rankLabel=(UILabel *)[cell viewWithTag:1];
        [rankLabel setText:@"Rank"];
        
        
        UILabel *nameLabel=(UILabel *)[cell viewWithTag:2];
        [nameLabel setText:@"Name"];
        //[nameLabel setTextColor:[UIColor purpleColor]];
        
        UILabel *scoreLabel =(UILabel *)[cell viewWithTag:3];
        [scoreLabel setText:@"Score"];
        //[scoreLabel setTextColor:[UIColor purpleColor]];
    }
    else
    {
        Score *l_score = [scoreList objectAtIndex:indexPath.row-1];
        [(UILabel *)[cell viewWithTag:1] setText:[NSString stringWithFormat:@"%d",indexPath.row]];
        [(UILabel *)[cell viewWithTag:2] setText:l_score.userName];
        [(UILabel *)[cell viewWithTag:3] setText:[NSString stringWithFormat:@"%0.0f",l_score.value]];
    }
	
    return cell;
}

#pragma mark-------------
#pragma mark ---UITableViewDelegate Methods---
#pragma mark-------------


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



#pragma mark--------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
//- (NSUInteger) supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationLandscapeLeft;
//}
//
//- (BOOL) shouldAutorotate
//{
//    return YES;
//}

@end
