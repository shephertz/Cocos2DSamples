//
//  PWBackgroundLayer.m
//  PlayWithWords
//
//  Created by shephertz technologies on 27/05/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import "PWBackgroundLayer.h"


@implementation PWBackgroundLayer
// Helper class method that creates a Scene with the PWGameLogicLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
    
	// 'layer' is an autorelease object.
	PWBackgroundLayer *layer = [PWBackgroundLayer node];
	
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
	if( (self=[super init]) )
    {
		[self setTouchEnabled:YES];
	}
	return self;
}

@end
