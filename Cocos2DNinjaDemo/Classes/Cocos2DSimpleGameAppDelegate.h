//
//  Cocos2DSimpleGameAppDelegate.h
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 11/21/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class UserNameController;
@interface Cocos2DSimpleGameAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    UserNameController  *userNameController;
}

@property (nonatomic, retain) UIWindow *window;

-(RootViewController*)getRootViewController;
-(void)showEnterUserNameScreen;
-(void)removeEnterUserNameScreen;

@end
