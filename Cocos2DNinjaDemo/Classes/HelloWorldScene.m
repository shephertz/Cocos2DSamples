//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"
#import "AppWarpHelper.h"
#import "GameConstants.h"


@implementation HelloWorldScene
@synthesize layer = _layer;

- (id)init
{

    if ((self = [super init]))
    {
        self.layer = [HelloWorld node];
        [self addChild:_layer];
    }
	
	return self;
}

- (void)dealloc
{
    self.layer = nil;
    [super dealloc];
}

@end


// HelloWorld implementation
@implementation HelloWorld

-(void)spriteMoveFinished:(id)sender
{

	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
	
	if (sprite.tag == 1)
    { // target
		[_targets removeObject:sprite];
		
		//GameOverScene *gameOverScene = [GameOverScene node];
		//[gameOverScene.layer.label setString:@"You Lose :["];
		//[[CCDirector sharedDirector] replaceScene:gameOverScene];
		
	}
    else if (sprite.tag == 2)
    { // projectile
		[_projectiles removeObject:sprite];
	}
	
}

-(void)updateEnemyStatus:(NSDictionary*)dataDict
{
    
    CGPoint pos = CGPointFromString([dataDict objectForKey:PLAYER_POSITION]);
    enemy.position = ccp(enemy.position.x,pos.y);
    
    int count = dataDict.count;
    
    if (count<=2)
    {
        return;
    }
    enemy.opacity = 255;
    isEnemyAdded = YES;
	CCSprite *target = [CCSprite spriteWithFile:@"Target.png" rect:CGRectMake(0, 0, 27, 40)]; 
	
	// Determine where to spawn the target along the Y axis
	//CGSize winSize = [[CCDirector sharedDirector] winSize];

	target.position =enemy.position ;
	[self addChild:target];
	
	
	float actualDuration = [[dataDict objectForKey:MOVEMENT_DURATION] floatValue];
	CGPoint destination = CGPointFromString([dataDict objectForKey:PROJECTILE_DESTINATION]);
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration position:destination];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	// Add to targets array
	target.tag = 1;
	[_targets addObject:target];
	
}

-(void)gameLogic:(ccTime)dt
{
	//[self addTarget];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(255,255,255,255)] ))
    {
        score=0;
        isEnemyAdded = NO;
        [[AppWarpHelper sharedAppWarpHelper] setScore:score];
        timeLeft = GAME_OVER_TIME;
        previousUpdatedTime = (int)GAME_OVER_TIME;
		// Enable touch events
		self.isTouchEnabled = YES;
		
		// Initialize arrays
		_targets = [[NSMutableArray alloc] init];
		_projectiles = [[NSMutableArray alloc] init];
		
		// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		// Add the player to the middle of the screen along the y-axis, 
		// and as close to the left side edge as we can get
		// Remember that position is based on the anchor point, and by default the anchor
		// point is the middle of the object.
		player = [Player spriteWithFile:@"Player.png" rect:CGRectMake(0, 0, 27, 40)];
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
        enemy.isEnemy = NO;
		[self addChild:player];
        
        enemy = [Player spriteWithFile:@"Player.png" rect:CGRectMake(0, 0, 27, 40)];
		enemy.position = ccp(winSize.width-enemy.contentSize.width/2, winSize.height/2);
        enemy.isEnemy = YES;
		[self addChild:enemy];
        
        if (!isEnemyAdded)
        {
            enemy.opacity = 100.0f;
        }
		
		// Call game logic about every second
		//[self schedule:@selector(gameLogic:) interval:1.0];
		[self schedule:@selector(update:)];
		
		// Start up the background music
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
        
        CCLabelTTF *scoreTitle = [CCLabelTTF labelWithString:@"Score:" fontName:@"Helvetica-Bold" fontSize:20];
        CGSize scoreTitleSize = scoreTitle.contentSize;
        scoreTitle.position = ccp(winSize.width-scoreTitleSize.width-scoreTitleSize.width/4,winSize.height-scoreTitleSize.height/2);
        scoreTitle.color = ccc3(60,90,133);
        [self addChild:scoreTitle z:100];
        
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",score] fontName:@"Helvetica-Bold" fontSize:20];
        scoreLabel.position = ccp(winSize.width-3*scoreTitleSize.width/8,winSize.height-scoreTitleSize.height/2);
        scoreLabel.color = ccc3(60,90,133);
        [self addChild:scoreLabel z:100];
        
        CCLabelTTF *timeTitle = [CCLabelTTF labelWithString:@"Time Left:" fontName:@"Helvetica-Bold" fontSize:20];
        timeTitle.position = ccp(7*timeTitle.contentSize.width/12,winSize.height-scoreTitleSize.height/2);
        timeTitle.color = ccc3(60,90,133);
        [self addChild:timeTitle z:100];
        
        timeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",previousUpdatedTime] fontName:@"Helvetica-Bold" fontSize:20];
        timeLabel.position = ccp(timeTitle.contentSize.width+5*timeLabel.contentSize.width/4,winSize.height-scoreTitleSize.height/2);
        timeLabel.color = ccc3(60,90,133);
        [self addChild:timeLabel z:100];
        
        
		
	}
	return self;
}

- (void)update:(ccTime)dt
{
    if (!isEnemyAdded)
    {
        return;
    }
    timeLeft -= dt;
    
	NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    if ([_projectiles count])
    {
        
    
        for (CCSprite *projectile in _projectiles)
        {
            CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2), 
                                               projectile.position.y - (projectile.contentSize.height/2), 
                                               projectile.contentSize.width, 
                                               projectile.contentSize.height);

            NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
            for (CCSprite *target in _targets)
            {
                CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2), 
                                               target.position.y - (target.contentSize.height/2), 
                                               target.contentSize.width, 
                                               target.contentSize.height);
        
                if (CGRectIntersectsRect(projectileRect, targetRect))
                {
                    [targetsToDelete addObject:target];				
                }
                else if (![targetsToDelete containsObject:target]&&CGRectIntersectsRect(player.boundingBox, targetRect))
                {
                    [targetsToDelete addObject:target];
                    score--;
                    [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
                }
                
            }
            
            if (![projectilesToDelete containsObject:projectile]&&CGRectIntersectsRect(projectileRect, enemy.boundingBox))
            {
                [projectilesToDelete addObject:projectile];
                score++;
                [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
            }

            
            for (CCSprite *target in targetsToDelete)
            {
                [_targets removeObject:target];
                [self removeChild:target cleanup:YES];									
                _projectilesDestroyed++;

            }
            
            if (![projectilesToDelete containsObject:projectile]&&targetsToDelete.count > 0)
            {
                [projectilesToDelete addObject:projectile];
            }
            [targetsToDelete release];
            
            
        }
        for (CCSprite *projectile in projectilesToDelete)
        {
            [_projectiles removeObject:projectile];
            [self removeChild:projectile cleanup:YES];
        }
        [projectilesToDelete release];
    }
    else
    {
        NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        for (CCSprite *target in _targets)
        {
            CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2),
                                           target.position.y - (target.contentSize.height/2),
                                           target.contentSize.width,
                                           target.contentSize.height);
            
            if (![targetsToDelete containsObject:target]&&CGRectIntersectsRect(player.boundingBox, targetRect))
            {
                [targetsToDelete addObject:target];
                score--;
                [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
            }
            
        }
        for (CCSprite *target in targetsToDelete)
        {
            [_targets removeObject:target];
            [self removeChild:target cleanup:YES];
            _projectilesDestroyed++;
        }
    }
    //NSLog(@"timeLeft:--%f",timeLeft);
    if (previousUpdatedTime>((int)timeLeft))
    {
        previousUpdatedTime = (int)timeLeft;
        //NSLog(@"previousUpdatedTime:--%d",previousUpdatedTime);
        [timeLabel setString:[NSString stringWithFormat:@"%d",previousUpdatedTime]];
        
        if (previousUpdatedTime<=0)
        {
            [[AppWarpHelper sharedAppWarpHelper] disconnectWarp];
            [[AppWarpHelper sharedAppWarpHelper] setScore:score];
            //[[AppWarpHelper sharedAppWarpHelper] saveScore];
            [[AppWarpHelper sharedAppWarpHelper] performSelectorInBackground:@selector(saveScore) withObject:nil];
            // Run the GameOverScene
            [[CCDirector sharedDirector] replaceScene:[GameOverScene node]];
        }
    }
	
}



- (void)pauseGame
{
   // NSLog(@"Paused!");
}



- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isEnemyAdded)
    {
        return;
    }
	// Choose one of the touches to work with
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	
	// Set up initial location of projectile
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	CCSprite *projectile = [CCSprite spriteWithFile:@"Projectile.png" rect:CGRectMake(0, 0, 20, 20)];
	projectile.position = player.position;//ccp(20, winSize.height/2);
	
	// Determine offset of location to projectile
	int offX = location.x - projectile.position.x;
	int offY = location.y - projectile.position.y;
	
	// Bail out if we are shooting down or backwards
	if (offX <= 0) return;
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];

	// Play a sound!
	[[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
	
	// Determine where we wish to shoot the projectile to
	int realX = winSize.width + (projectile.contentSize.width/2);
	float ratio = (float) offY / (float) offX;
	int realY = (realX * ratio) + projectile.position.y;
	CGPoint realDest = ccp(realX, realY);
	
	// Determine the length of how far we're shooting
	int offRealX = realX - projectile.position.x;
	int offRealY = realY - projectile.position.y;
	float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
	float velocity = 480/1; // 480pixels/1sec
	float realMoveDuration = length/velocity;
	
    CGPoint destination = CGPointMake(winSize.width-realDest.x, realDest.y);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[[AppWarpHelper sharedAppWarpHelper] userName],USER_NAME,NSStringFromCGPoint(player.position),PLAYER_POSITION,NSStringFromCGPoint(destination),PROJECTILE_DESTINATION,[NSString stringWithFormat:@"%f",realMoveDuration],MOVEMENT_DURATION, nil];
    
    [self updatePlayerDataToServerWithDataDict:dict];
    
	// Move projectile to actual endpoint
	[projectile runAction:[CCSequence actions:
						   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
						   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
						   nil]];
	
	// Add to projectiles array
	projectile.tag = 2;
	[_projectiles addObject:projectile];
	
}

-(void)updatePlayerDataToServerWithDataDict:(NSDictionary*)dataDict
{
    if(!dataDict)
		return;
	
	NSError *error = nil;
	//converting the content to plist supported binary format.
	NSData *convertedData = [NSPropertyListSerialization dataWithPropertyList:dataDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
	
	if(error || ! convertedData)
	{
		NSLog(@"DataConversion Failed.ErrorDescription: %@",[error description]);
		return;
	}
    [[AppWarpHelper sharedAppWarpHelper] setCustomDataWithData:convertedData];
    
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_targets release];
	_targets = nil;
	[_projectiles release];
	_projectiles = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
