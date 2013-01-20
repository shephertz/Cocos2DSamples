
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// GamePlay Layer
@interface GamePlay : CCColorLayer
{
	NSMutableArray *_projectiles;
	int _projectilesDestroyed;
}

//
// Callback from the NotificationListener class when we
// receive an update from the other player.
//
-(void)handleRemoteTouchAtX:(int)xPos AtY:(int)yPos;
    
@end

@interface GamePlayScene : CCScene
{
    GamePlay *_layer;
}
@property (nonatomic, retain) GamePlay *layer;
@end

