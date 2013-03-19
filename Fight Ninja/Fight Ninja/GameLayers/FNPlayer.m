//
//  FNPlayer.m
//  Fight Ninja
//
//  Created by shephertz technologies on 19/03/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import "FNPlayer.h"
#import "AppWarpHelper.h"
#import "GameConstants.h"
#import "FNGameLogicLayer.h"
#import "NFStoryBoardManager.h"
@implementation FNPlayer
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
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
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
	//NSLog(@"%s",__FUNCTION__);
	if(!isEnemy && [self containsTouchLocation:touch])
	{
        CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
        CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
        
        prevTouchPoint = [self convertToNodeSpace:spoint];
		return YES;
		
	}
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"%s",__FUNCTION__);
    
    CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
    CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	
	spoint = [self convertToNodeSpace:spoint];
    
    self.position = CGPointMake(self.position.x, self.position.y+spoint.y-prevTouchPoint.y);
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[[AppWarpHelper sharedAppWarpHelper] userName],USER_NAME,NSStringFromCGPoint(self.position),PLAYER_POSITION,nil];
    
    [[NFStoryBoardManager sharedNFStoryBoardManager] updatePlayerDataToServerWithDataDict:dict];
    
    //NSLog(@"position=%@",NSStringFromCGPoint(self.position));
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"%s",__FUNCTION__);
    
}


@end
