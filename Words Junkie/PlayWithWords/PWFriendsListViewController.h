//
//  PWFriendsListViewController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 17/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWFacebookHelper.h"

@interface PWFriendsListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PWFacebookHelperDelegate>
{
    IBOutlet UITableView *friendListTableView;
    int colorChanger;
    int rowHeight;
    IBOutlet UILabel *titleLabel;
    ScreenCode previousScreenCode;
    
    IBOutlet UIView *indicatorView;
    IBOutlet UIActivityIndicatorView *activityIndicatorView;

    
}
@property(nonatomic,assign) ScreenCode previousScreenCode;
@property(nonatomic,retain) NSArray *friendsList;

-(void)showAcitvityIndicator;
-(void)removeAcitvityIndicator;

@end
