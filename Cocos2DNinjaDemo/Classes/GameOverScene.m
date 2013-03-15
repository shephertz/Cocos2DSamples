//
//  GameOverScene.m
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 2/10/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "GameOverScene.h"
#import "HelloWorldScene.h"
#import "AppWarpHelper.h"
#import "NFStoryBoardManager.h"
@implementation GameOverScene
@synthesize layer = _layer;


- (id)init 
{

	if ((self = [super init])) 
    {
		self.layer = [GameOverLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {
	[_layer release];
	_layer = nil;
	[super dealloc];
}

@end

@implementation GameOverLayer
@synthesize label = _label;
@synthesize users;
-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] ))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
		int titleFontSize=0,normalFontSize=0;
        NSString *gameOverSceneBg;
        
        float childLayerWidth,childLayerHeight;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            titleFontSize = 40/CC_CONTENT_SCALE_FACTOR();
            normalFontSize = 28/CC_CONTENT_SCALE_FACTOR();
            gameOverSceneBg = @"MenuBg.png";
            childLayerWidth = 400;
            childLayerHeight= 300;
        }
        else
        {
            titleFontSize = 22/CC_CONTENT_SCALE_FACTOR();
            normalFontSize = 16/CC_CONTENT_SCALE_FACTOR();
            gameOverSceneBg = @"MenuBg_iPhone.png";
            childLayerWidth = 250;
            childLayerHeight= 250;
        }
        
        CCSprite *bgSprite = [CCSprite spriteWithFile:gameOverSceneBg];
        [bgSprite setPosition:ccp(winSize.width/2, winSize.height/2)];
        [self addChild:bgSprite];
        
        CCColorLayer *childLayer = [CCColorLayer layerWithColor:ccc4(0,0,0,255) width:childLayerWidth height:childLayerHeight];
        childLayer.position = ccp((winSize.width-childLayerWidth)/2, (winSize.height-childLayerHeight)/2);
		
        
        
        CGSize childLayerSize = childLayer.contentSize;
        
		self.label = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Marker Felt" fontSize:titleFontSize];
		_label.color = ccWHITE;
		_label.position = ccp(childLayerSize.width/2, 6.5*childLayerSize.height/8);
		[childLayer addChild:_label];
        
        CCLabelTTF *scoreTitle = [CCLabelTTF labelWithString:@"Score:" fontName:@"Marker Felt" fontSize:normalFontSize];
        scoreTitle.position = ccp(3.5*childLayerSize.width/8,4.5*childLayerSize.height/8);
        scoreTitle.color = ccc3(60,90,133);
        [childLayer addChild:scoreTitle z:100];
        
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[AppWarpHelper sharedAppWarpHelper] score]] fontName:@"Marker Felt" fontSize:normalFontSize];
        scoreLabel.position = ccp(5*childLayerSize.width/8,4.5*childLayerSize.height/8);
        scoreLabel.color = ccc3(60,90,133);
        [childLayer addChild:scoreLabel z:100];
        
        
        
        CCLabelTTF *leaderboardLabel = [CCLabelTTF labelWithString:@"Leaderboard" fontName:@"Marker Felt" fontSize:normalFontSize];
        CCMenuItemLabel *leaderboardMenuItem = [CCMenuItemLabel itemWithLabel:leaderboardLabel target:self selector:@selector(leaderboardButtonAction)];
        leaderboardMenuItem.position = ccp(childLayerSize.width/2,3*childLayerSize.height/8);
        
        CCLabelTTF *backToGameLabel = [CCLabelTTF labelWithString:@"Back To Game" fontName:@"Marker Felt" fontSize:normalFontSize];
        CCMenuItemLabel *backToGameMenuItem = [CCMenuItemLabel itemWithLabel:backToGameLabel target:self selector:@selector(backToGameButtonAction)];
        backToGameMenuItem.position = ccp(childLayerSize.width/2,1.5*childLayerSize.height/8);
        
        CCMenu *menu = [CCMenu menuWithItems:leaderboardMenuItem,backToGameMenuItem, nil];
        menu.position = CGPointZero;
        [childLayer addChild:menu];
        
		[self addChild:childLayer];
	}	
	return self;
}

-(void)leaderboardButtonAction
{
    [[NFStoryBoardManager sharedNFStoryBoardManager] showLeaderBoardView];
}

-(void)backToGameButtonAction
{
    [[CCDirector sharedDirector] replaceScene: [HelloWorldScene node]];
}


-(void)showOnlineUsers:(NSMutableArray*)userNames
{
    NSLog(@"%s",__FUNCTION__);
    self.users = userNames;
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    int count = [userNames count];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    for (int i=0; i<count; i++)
    {
        CCLabelTTF *label = [CCLabelTTF labelWithString:[userNames objectAtIndex:i] fontName:@"Arial" fontSize:20];
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(enemySelected:)];
        item.tag = i;
        [array addObject:item];
        item.position = ccp(winSize.width/2, winSize.height/2);
    }
    
    CCMenu *menu = [CCMenu menuWithItems:[array objectAtIndex:0],nil];
    menu.position = CGPointZero;
    [self addChild:menu];
    [array release];
}

-(void)enemySelected:(id)sender
{
    
}


- (void)gameOverDone
{

	[[CCDirector sharedDirector] replaceScene:[[[HelloWorldScene alloc] init] autorelease]];
	
}

- (void)dealloc {
	[_label release];
	_label = nil;
	[super dealloc];
}

@end
