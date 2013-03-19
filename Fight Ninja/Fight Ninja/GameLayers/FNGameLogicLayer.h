//
//  FNGameLogicLayer.h
//  Fight Ninja
//
//  Created by shephertz technologies on 19/03/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "FNPlayer.h"

@interface FNGameLogicLayer : CCLayerColor
{
    
    NSMutableArray *_targets;
	NSMutableArray *_projectiles;
	int _projectilesDestroyed;
    FNPlayer *player;
    FNPlayer *enemy;
    int score;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *timeLabel;
    float timeLeft;
    int previousUpdatedTime;
    BOOL isEnemyAdded;
}


// returns a CCScene that contains the FNGameLogicLayer as the only child
+(CCScene *) scene;



-(void)pauseGame;
-(void)updateEnemyStatus:(NSDictionary*)dataDict;

@end
