//
//  PWSettingsViewController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 24/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWFacebookHelper.h"

@interface PWSettingsViewController : UIViewController<PWFacebookHelperDelegate>
{
    IBOutlet UISlider *volumeControl;
    IBOutlet UISwitch *notificationButton;
    UISwitch *vibrationButton;
    IBOutlet UIImageView *statusImage;
    IBOutlet UIButton *logOutButton;
    
    IBOutlet UILabel *notificationLabel;
    IBOutlet UILabel *vibrationLabel;
    IBOutlet UILabel *soundLabel;
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *titleLabel;
    ScreenCode previousScreenCode;
    
}
@property(nonatomic,assign) ScreenCode previousScreenCode;


-(IBAction)setVolume:(id)sender;
-(IBAction)notificationButtonAction:(id)sender;
-(void)vibrationButtonAction:(id)sender;
-(IBAction)backButtonAction:(id)sender;
-(IBAction)logoutButtonAction:(id)sender;

@end
