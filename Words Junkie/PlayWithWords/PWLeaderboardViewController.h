//
//  PWLeaderboardViewController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 17/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWFacebookHelper.h"
@interface PWLeaderboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PWFacebookHelperDelegate>
{
    IBOutlet UITableView *leaderboardTableView;

    IBOutlet UIButton *backButton;
    NSMutableArray *scoreList;

    IBOutlet UIView *indicatorView;
    IBOutlet UIActivityIndicatorView *activityIndicatorView;
    
    IBOutlet UIButton *todayButton;
    IBOutlet UIButton *globalButton;
    IBOutlet UIButton *friendsButton;
    IBOutlet UIButton *allTimeButton;
    
    int colorChanger;
    
    IBOutlet UILabel *messageLabel;
    IBOutlet UILabel *nameTitleLabel;
    IBOutlet UILabel *rankTitleLabel;
    IBOutlet UILabel *scoreTitleLabel;
    
    int rowHeight;
    
    ScreenCode previousScreenCode;
    
}
@property(nonatomic,assign) ScreenCode previousScreenCode;

-(void)showAcitvityIndicator;
-(void)removeAcitvityIndicator;
-(void)getScore;

-(IBAction)todayButtonClicked:(id)sender;
-(IBAction)globalButtonClicked:(id)sender;
-(IBAction)friendsButtonClicked:(id)sender;
-(IBAction)allTimeButtonClicked:(id)sender;
-(IBAction)backButtonClicked:(id)sender;
-(void)getTodaysScores;
-(void)getFriendsScores;
@end
