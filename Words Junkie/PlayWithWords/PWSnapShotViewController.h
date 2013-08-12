//
//  PWSnapShotViewController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 04/06/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWSnapShotViewController : UIViewController
{
    IBOutlet UIView      *bgView;
    IBOutlet UIImageView *snapShot;
    IBOutlet UIButton    *okButton;
    IBOutlet UIButton    *shareButton;
    IBOutlet UILabel     *snapshotTitle;
    IBOutlet UIImageView *snapshotTitleBg;
    ScreenCode previousScreenCode;
    
}
@property(nonatomic,assign) ScreenCode previousScreenCode;


-(void)setScreenShotImage:(UIImage*)screenShot;
-(IBAction)okButtonSction:(id)sender;
-(IBAction)shareButtonSction:(id)sender;
@end
