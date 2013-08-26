
/*****************************************************************
 *  PWCharacter.m
 *  PlayWithWords
 *  Created by shephertz technologies on 18/04/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/


#import "PWCharacter.h"
#import "PWGameLogicLayer.h"
#import "PWGameController.h"

@implementation PWCharacter
@synthesize isMovable,alphabet,pos_index,isPlaced;

#pragma mark--
#pragma mark-- Initialization Methods
#pragma mark--

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
    if (self=[super initWithColor:color width:w height:h])
    {
        //
        [self setTouchEnabled:YES];
        isPlaced = NO;
    }
    return self;
}

-(void)dealloc
{
    if (self.alphabet)
    {
        self.alphabet = nil;
    }
    [super dealloc];
}


- (CGRect)rect
{
	CGSize s = [self contentSize];
	return CGRectMake(0,0, s.width, s.height);
}

#pragma mark -
#pragma mark -Animations
#pragma mark -

-(void)startNotPlaceableIndicatorAnimation:(BOOL)isAnimate
{
    if (isAnimate)
    {
        CGSize s = [self contentSize];
        CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(255,0,0,255) width:s.width+8 height:s.height+8];
		[self addChild: layer z:-1 tag:1001];
        layer.position = ccp(-4, -4);
		[layer runAction: [CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.5f],[CCFadeOut actionWithDuration:0.5f], nil]] ];
    }
    else
    {
        CCLayerColor *layer = (CCLayerColor*)[self getChildByTag:1001];
        if (layer)
        {
            [layer stopAllActions];
            [layer removeFromParentAndCleanup:YES];
        }
        
    }

}

-(void)illuminateChar:(BOOL)isIlluminate
{
    return;
    if (isIlluminate)
    {
        CGSize s = [self contentSize];
        CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(255,255,255,255) width:s.width+8 height:s.height+8];
		[self addChild: layer z:-1 tag:1000];
        layer.position = ccp(-4, -4);
		[layer runAction: [CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.5f],[CCFadeOut actionWithDuration:0.5f], nil]] ];
    }
    else
    {
        CCLayerColor *layer = (CCLayerColor*)[self getChildByTag:1000];
        if (layer)
        {
            [layer stopAllActions];
            [layer removeFromParentAndCleanup:YES];
        }
        
    }
}


-(void)animateTheChar:(BOOL)shouldAnimate
{
    if (shouldAnimate)
    {
        self.scale = 1.5f;
        self.anchorPoint = ccp(0.5f, 1.0f);
        id action_move_forward = [CCRotateBy actionWithDuration:0.5f angle:60];
        id action_move_backward = [CCRotateBy actionWithDuration:0.5f angle:-60];
        id action_move_forward_reverse = [action_move_forward reverse];
        id action_move_backward_reverse = [action_move_backward reverse];
        id action_Sequence = [CCSequence actions:action_move_forward,action_move_forward_reverse,action_move_backward,action_move_backward_reverse, nil];
        id action_repeat = [CCRepeatForever actionWithAction:action_Sequence];
        [self runAction:action_repeat];
    }
    else
    {
        self.scale = 1.0f;
        [self stopAllActions];
        self.rotation = 0;
        self.anchorPoint = ccp(0.0f, 0.0f);
 
    }
}


#pragma mark -
#pragma mark -Touch_events
#pragma mark -

- (void)onEnter
{
    if (!isMovable)
    {
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:(id)self priority:0 swallowsTouches:NO];
    }
	
	[super onEnter];
}


- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
    CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	
	spoint = [self convertToNodeSpace:spoint];
	return CGRectContainsPoint(self.rect, spoint);
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    PWGameLogicLayer *gameLayer = [PWGameLogicLayer sharedInstance];
    
	if(self.visible && ([gameLayer selectedChar]==NULL || isMovable) && [self containsTouchLocation:touch] && gameLayer.currentGameMode==kPlacementMode && !isPlaced && gameLayer.turnIndicator==kPlayerOneTurn)
	{
        [gameLayer enableScrolling:NO];
        [self startNotPlaceableIndicatorAnimation:NO];
        gameLayer.selectedChar = self;
        [gameLayer resizeTheCharacterToTileSize];
        [self changeTextureWithImage:@"Tile_Placed.png"];
        
        CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
        CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
        prevTouchPoint = [self convertToNodeSpace:spoint];
        
        if (!isMovable)
        {
            [[[PWGameController sharedInstance] tutorialManager] setTutorialElementsVisible:NO];
            [gameLayer getSelectedCharFromCharacterMenuWithLetter:alphabet withPositionINdex:pos_index];
        }
        self.isMovable = YES;
        [self animateTheChar:YES];
        gameLayer.isCharacterSelected = YES;
        return YES;
	}
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
    CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	spoint = [self convertToNodeSpace:spoint];
    
    self.position = CGPointMake(self.position.x+spoint.x-prevTouchPoint.x, self.position.y+spoint.y-prevTouchPoint.y);
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
    CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	spoint = [self convertToNodeSpace:spoint];
    
    [self animateTheChar:NO];
}

-(void)changeTextureWithImage:(NSString*)imageName
{
    float rowWidth,rowHeight;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        rowWidth = TILE_WIDTH_IPHONE;
        rowHeight = TILE_HEIGHT_IPHONE;
    }
    else
    {
        rowWidth = TILE_WIDTH;
        rowHeight = TILE_HEIGHT;
    }
    
    CCSprite *characterBg = (CCSprite*)[self getChildByTag:9];
    [characterBg setTexture:[[CCTextureCache sharedTextureCache] addImage:imageName]];
    [characterBg setTextureRect:CGRectMake(0, 0, rowWidth, rowHeight)];
    [characterBg setPosition:ccp(rowWidth/2, rowHeight/2)];
}

-(void)setSelected:(BOOL)isSelected
{
    NSString *imageName;
    if (isSelected)
    {
        imageName = @"Tile_Selected.png";
    }
    else
    {
        imageName = @"Tile_Placed.png";
    }
    CCSprite *characterBg = (CCSprite*)[self getChildByTag:9];
    [characterBg setTexture:[[CCTextureCache sharedTextureCache] addImage:imageName]];
}

@end
