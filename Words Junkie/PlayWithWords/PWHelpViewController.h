//
//  PWHelpViewController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 05/06/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWHelpViewController : UIViewController
{
    
    IBOutlet UIButton *backButton;
    IBOutlet UILabel  *titleLabel;
    ScreenCode previousScreenCode;
    IBOutlet UIWebView *helpView;
    
}
@property(nonatomic,assign) ScreenCode previousScreenCode;


-(IBAction)backButtonAction:(id)sender;

@end
