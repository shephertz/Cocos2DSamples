//
//  FNGameOverLayer.m
//  Fight Ninja
//
//  Created by shephertz technologies on 19/03/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import "FNGameOverLayer.h"
#import "FNGameLogicLayer.h"
#import "AppWarpHelper.h"
#import "NFStoryBoardManager.h"

@implementation FNGameOverLayer
@synthesize label = _label;
@synthesize users;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	FNGameOverLayer *layer = [FNGameOverLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor:ccc4(255,255,255,255)] ))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
		int titleFontSize=0,normalFontSize=0;
        NSString *gameOverSceneBg;
        
        float childLayerWidth,childLayerHeight;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            titleFontSize = 40;
            normalFontSize = 28;
            childLayerWidth = 400;
            childLayerHeight= 300;
            
            if (CC_CONTENT_SCALE_FACTOR()==2)
            {
                gameOverSceneBg = @"MenuBg_iPadRetina.png";
            }
            else
            {
                gameOverSceneBg = @"MenuBg.png";
            }
            
        }
        else
        {
            titleFontSize = 26;
            normalFontSize = 20;
            if (CC_CONTENT_SCALE_FACTOR()==2)
            {
                gameOverSceneBg = @"MenuBg.png";
            }
            else
            {
                gameOverSceneBg = @"MenuBg_iPhone.png";
            }
            childLayerWidth = 250;
            childLayerHeight= 250;
        }
        
        CCSprite *bgSprite = [CCSprite spriteWithFile:gameOverSceneBg];
        [bgSprite setPosition:ccp(winSize.width/2, winSize.height/2)];
        [self addChild:bgSprite];
        
        CCLayerColor *childLayer = [CCLayerColor layerWithColor:ccc4(0,0,0,255) width:childLayerWidth height:childLayerHeight];
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
    //[[CCDirector sharedDirector] replaceScene: [HelloWorldScene node]];
    [[NFStoryBoardManager sharedNFStoryBoardManager] showUserNameView];
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
    
	[[CCDirector sharedDirector] replaceScene:[FNGameLogicLayer scene]];
	
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    [_label release];
	_label = nil;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
