//
//  Player.m
//  Cocos2DSimpleGame
//
//  Created by Rajeev on 23/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "GameConstants.h"
#import "AppWarpHelper.h"
#import "HelloWorldScene.h"
@implementation Player
@synthesize isEnemy;

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(0,0, s.width, s.height);
}
- (id)init
{
	if ( (self=[super init]))
	{
    }
	
	return self;
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] openGLView]];
    CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	
	spoint = [self convertToNodeSpace:spoint];
	return CGRectContainsPoint(self.rect, spoint);
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	//NSLog(@"%s",__FUNCTION__);
	if(!isEnemy && [self containsTouchLocation:touch])
	{
        CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] openGLView]];
        CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
        
        prevTouchPoint = [self convertToNodeSpace:spoint];
		return YES;
		
	}
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"%s",__FUNCTION__);

    CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] openGLView]];
    CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	
	spoint = [self convertToNodeSpace:spoint];
    
    self.position = CGPointMake(self.position.x, self.position.y+spoint.y-prevTouchPoint.y);
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[[AppWarpHelper sharedAppWarpHelper] userName],USER_NAME,NSStringFromCGPoint(self.position),PLAYER_POSITION,nil];
    
    [[(HelloWorldScene*)[[CCDirector sharedDirector] runningScene] layer] updatePlayerDataToServerWithDataDict:dict];

    //NSLog(@"position=%@",NSStringFromCGPoint(self.position));
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"%s",__FUNCTION__);

}

@end
