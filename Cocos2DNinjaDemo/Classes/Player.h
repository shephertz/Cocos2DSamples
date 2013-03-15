//
//  Player.h
//  Cocos2DSimpleGame
//
//  Created by Rajeev on 23/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite<CCTargetedTouchDelegate>
{
    CGPoint prevTouchPoint;
    BOOL isEnemy;
}
@property BOOL isEnemy;
@end
