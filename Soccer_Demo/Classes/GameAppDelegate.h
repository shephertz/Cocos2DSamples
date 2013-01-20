

#import <UIKit/UIKit.h>

@class RootViewController;

@interface GameAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
