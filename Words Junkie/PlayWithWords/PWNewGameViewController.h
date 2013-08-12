//
//  PWNewGameViewController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 27/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWFacebookHelper.h"
@interface PWNewGameViewController : UIViewController<PWFacebookHelperDelegate>
{
    IBOutlet UIButton *selectFriendsButton;
    IBOutlet UIButton *randomPlayerButton;
    IBOutlet UIButton *backButton;
    IBOutlet UILabel  *titleLabel;
    ScreenCode previousScreenCode;
    UIView *findingOpponentView;
}
@property(nonatomic,assign) ScreenCode previousScreenCode;

-(IBAction)backButtonAction:(id)sender;
-(IBAction)selectFreindsButtonAction:(id)sender;
-(IBAction)randomPlayerButtonAction:(id)sender;
@end
