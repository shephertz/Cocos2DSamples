
/*****************************************************************
 *  AppDelegate.h
 *  PlayWithWords
 *  Created by shephertz technologies on 18/04/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import <UIKit/UIKit.h>
#import "cocos2d.h"


// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
