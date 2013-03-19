//
//  FNPlayer.h
//  Fight Ninja
//
//  Created by shephertz technologies on 19/03/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface FNPlayer : CCSprite<CCTouchOneByOneDelegate>
{
    
    CGPoint prevTouchPoint;
    BOOL isEnemy;
}
@property BOOL isEnemy;

@end
