

// Import the interfaces
#import "GamePlayScene.h"
#import "SimpleAudioEngine.h"
#import "GlobalContext.h"
#import <AppWarp_iOS_SDK/AppWarp_iOS_SDK.h>
#import "NotificationListener.h"

@implementation GamePlayScene
@synthesize layer = _layer;

- (id)init {

    if ((self = [super init])) {
        self.layer = [GamePlay node];
        [self addChild:_layer z:1];
    }
	
	return self;
}

- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}

@end


// GamePlay implementation
@implementation GamePlay

-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    
    if (sprite.tag == 2) { // projectile
        [_projectiles removeObject:sprite];
    }
    
    [self removeChild:sprite cleanup:YES];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(0,139,0,255)] )) {

		// Enable touch events
		self.isTouchEnabled = YES;
		
		// Initialize arrays
		_projectiles = [[NSMutableArray alloc] init];
		
		// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		// Add the player to the middle of the screen along the y-axis, 
		// and as close to the left side edge as we can get
		// Remember that position is based on the anchor point, and by default the anchor
		// point is the middle of the object.
		CCSprite *player = [CCSprite spriteWithFile:@"Player.png" rect:CGRectMake(0, 0, 40, 40)];
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
		[self addChild:player];
		
        CCSprite *oppPlayer = [CCSprite spriteWithFile:@"Player.png" rect:CGRectMake(0, 0, 40, 40)];
        oppPlayer.position = ccp(winSize.width-oppPlayer.contentSize.width/2, winSize.height/2);
        [self addChild:oppPlayer];
		
        NotificationListener *notificationListener = [[NotificationListener alloc]initWithGame:self];
        [[WarpClient getInstance] addNotificationListener:notificationListener];
		
	}
	return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	// Choose one of the touches to work with
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    [self moveProjectileFrom:ccp(20, winSize.height/2) To:location];
    
    
    //
    // Build and Send a json packet to everyone in the room updating
    // them about your touch event.
    //
    NSMutableDictionary* jsonPacket = [NSMutableDictionary dictionary];
    [jsonPacket setObject:[[GlobalContext sharedInstance] username] forKey:@"sender"];
    [jsonPacket setObject:[NSNumber numberWithInt:location.x] forKey:@"xPos"];
    [jsonPacket setObject:[NSNumber numberWithInt:location.y] forKey:@"yPos"];
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonPacket options:0 error:&error];
    
    [[WarpClient getInstance]sendUpdatePeers:data];
}

-(void)handleRemoteTouchAtX:(int)xPos AtY:(int)yPos {
    //
    // Move the remote projectile w.r.t the opponent's sprite.
    // Its a mirror image along the Y-axis
    //
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    [self moveProjectileFrom:ccp(winSize.width - 20, winSize.height/2) To:ccp(winSize.width - xPos - 20, yPos)];
}

- (void) moveProjectileFrom:(CGPoint)src To:(CGPoint)dest
{
    CCSprite *projectile = [CCSprite spriteWithFile:@"Projectile.png" rect:CGRectMake(0, 0, 20, 20)];
	projectile.position = src;
    
    int offRealX = dest.x - src.x;
	int offRealY = dest.y - src.y;
    
	float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
	float velocity = 240/1; // 480pixels/1sec
    
	float realMoveDuration = length/velocity;
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];
    
    [projectile runAction:[CCSequence actions:
                           [CCMoveTo actionWithDuration:realMoveDuration position:dest],
                           [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                           nil]];
    
    // Add to projectiles array
	projectile.tag = 2;
	[_projectiles addObject:projectile];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_projectiles release];
	_projectiles = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
