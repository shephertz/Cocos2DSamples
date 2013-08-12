//
//  PWSettingsViewController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 24/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWSettingsViewController.h"
#import "PWGameController.h"
#import "PWFacebookHelper.h"
#import "SimpleAudioEngine.h"
@interface PWSettingsViewController ()

@end

@implementation PWSettingsViewController
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [[UISwitch appearance] setOnTintColor:[UIColor colorWithRed:158.0/255 green:84.0/255 blue:24.0/255 alpha:1.0]];
    [[UISwitch appearance] setTintColor:[UIColor colorWithRed:232.0/255 green:232.0/255 blue:111.0/255 alpha:1.000]];
    //[[UISwitch appearance] setThumbTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.000]];
    
        
    vibrationButton = [[UISwitch alloc] initWithFrame:CGRectMake(653, 321 , 0, 0)];
    [vibrationButton addTarget:self action:@selector(vibrationButtonAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:vibrationButton];
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        if (IS_IPHONE5)
        {
            self.view.frame = CGRectMake(0, 0, 568, 320);
            titleLabel.center = CGPointMake(titleLabel.center.x+30, titleLabel.center.y);
            
            notificationButton.center = CGPointMake(notificationButton.center.x+60, notificationButton.center.y);
            vibrationButton.center = CGPointMake(notificationButton.center.x, vibrationLabel.center.y);
            volumeControl.center = CGPointMake(volumeControl.center.x+45, volumeControl.center.y);
            statusImage.center = CGPointMake(notificationButton.center.x, statusImage.center.y);
            
            notificationLabel.center = CGPointMake(notificationLabel.center.x+20, notificationLabel.center.y);
            vibrationLabel.center = CGPointMake(vibrationLabel.center.x+20, vibrationLabel.center.y);
            soundLabel.center = CGPointMake(soundLabel.center.x+20, soundLabel.center.y);
            statusLabel.center = CGPointMake(statusLabel.center.x+20, statusLabel.center.y);
            
            logOutButton.center = CGPointMake(logOutButton.center.x+45, logOutButton.center.y);
        }
        else
        {
           vibrationButton.center = CGPointMake(318, 150);
        }
    }
    else
    {
        
    }

    volumeControl.maximumValue=1.0f;
    volumeControl.minimumValue=0.0f;
    
    volumeControl.value=[[[PWGameController sharedInstance] dataManager] volume];
    notificationButton.on = [[[PWGameController sharedInstance] dataManager] isNotificationOn];
    vibrationButton.on = [[[PWGameController sharedInstance] dataManager] isVibrationOn];
    
    if ([PWFacebookHelper sharedInstance].loggedInSession.isOpen)
    {
        [statusImage setImage:[UIImage imageNamed:@"Button-online.png"]];
    }
    else
    {
        [statusImage setImage:[UIImage imageNamed:@"Button-offline.png"]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setVolume:(id)sender
{
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:volumeControl.value];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:volumeControl.value];
    [[[PWGameController sharedInstance] dataManager] setVolume:volumeControl.value];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:volumeControl.value] forKey:VOLUME];
}

-(IBAction)notificationButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:SWITCH_CLICKED];

    [[[PWGameController sharedInstance] dataManager] setIsNotificationOn:notificationButton.on];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:notificationButton.on] forKey:NOTIFICATION];
    
    if (notificationButton.on)
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    else
    {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
}

-(void)vibrationButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:SWITCH_CLICKED];

    [[[PWGameController sharedInstance] dataManager] setIsVibrationOn:vibrationButton.on];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:vibrationButton.on] forKey:VIBRATION];
}

-(IBAction)backButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:BACK_BUTTON_CLICKED];
    if (previousScreenCode==kGameLayer)
    {
        [[[PWGameController sharedInstance] dataManager] removeNewAlphabetFromSessionIfNotSubmitted];
    }
    [[[PWGameController sharedInstance] dataManager] saveSettings];
    [[PWGameController sharedInstance] switchToLayerWithCode:previousScreenCode];
}

-(IBAction)logoutButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    [[PWFacebookHelper sharedInstance] setDelegate:self];
    [[PWFacebookHelper sharedInstance] loginToFacebook];
}

-(void)userDidLoggedOut
{
    [[[PWGameController sharedInstance] dataManager] cleanLocalData];
    [[PWGameController sharedInstance] dataManager].gamesArray = nil;
    [[PWGameController sharedInstance] switchToLayerWithCode:kHomeLayer];
}

-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [super dealloc];
}
@end
