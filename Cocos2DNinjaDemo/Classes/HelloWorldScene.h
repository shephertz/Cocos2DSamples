
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Player.h"
// HelloWorld Layer
@interface HelloWorld : CCColorLayer
{
	NSMutableArray *_targets;
	NSMutableArray *_projectiles;
	int _projectilesDestroyed;
    Player *player;
    Player *enemy;
    int score;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *timeLabel;
    float timeLeft;
    int previousUpdatedTime;
}

-(void)updatePlayerDataToServerWithDataDict:(NSDictionary*)dataDict;
-(void)pauseGame;
-(void)updateEnemyStatus:(NSDictionary*)dataDict;
    
@end

@interface HelloWorldScene : CCScene
{
    HelloWorld *_layer;
}
@property (nonatomic, retain) HelloWorld *layer;


@end

