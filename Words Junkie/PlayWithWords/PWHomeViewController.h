//
//  PWHomeViewController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 13/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWFacebookHelper.h"

@interface PWHomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PWFacebookHelperDelegate>
{
    UITableView *gamesListView;
    NSMutableArray *runningGamesArray;
    NSMutableArray *finishedGamesArray;
    NSMutableDictionary *finishedGamesDict;
    IBOutlet UIButton *loginButton;
    UIView *loginView;
    
    IBOutlet UIView *indicatorView;
    IBOutlet UIActivityIndicatorView *activityIndicatorView;
    IBOutlet UILabel *titleLabel;
    
    UIActivityIndicatorView *activityIndicator;
    
    IBOutlet UIButton *newGameButton;
    IBOutlet UIButton *leaderboardButton;
    IBOutlet UIButton *settingsButton;
    IBOutlet UIButton *helpButton;
    IBOutlet UIButton *activeGamesButton;
    IBOutlet UIButton *finishedGamesButton;
    IBOutlet UIImageView *separator;

    UIButton *loginFBButton;
    int selectedTab;
    float cellHeight;
    BOOL isLoggingViewOnTop;
}

-(IBAction)newGameButtonAction:(id)sender;
-(IBAction)logInButtonAction:(id)sender;
-(IBAction)leaderboardButtonAction:(id)sender;
-(IBAction)activeGamesButtonAction:(id)sender;
-(IBAction)finishedGamesButtonAction:(id)sender;
-(IBAction)settingsButtonAction:(id)sender;
-(IBAction)helpButtonAction:(id)sender;

-(void)updateLoginButtonUI;
-(void)showLoginView;
-(void)logInWithFacebook;
-(void)removeLoginView;
-(void)reloadTableView;
@end
 