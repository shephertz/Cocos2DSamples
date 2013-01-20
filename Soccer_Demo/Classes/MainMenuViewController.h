//
//  MainMenuViewController.h
//  Cocos2DSimpleGame
//
//  Created by Dhruv Chopra on 1/17/13.
//
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <AppWarp_iOS_SDK/AppWarp_iOS_SDK.h>

@interface MainMenuViewController : UIViewController<ConnectionRequestListener> {
    RootViewController *_rootViewController;
}
@property (retain, nonatomic) IBOutlet UILabel *error;

@property (retain) RootViewController *rootViewController;

- (IBAction)joinClicked:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *username;

@end
