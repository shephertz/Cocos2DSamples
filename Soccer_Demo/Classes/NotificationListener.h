//
//  NotificationListener.h
//  Cocos2DSimpleGame
//
//  Created by Dhruv Chopra on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppWarp_iOS_SDK/AppWarp_iOS_SDK.h>
#import "GamePlayScene.h"

@interface NotificationListener : NSObject<NotifyListener>

@property (nonatomic,retain)GamePlay *gameView;

-(id)initWithGame:(GamePlay*)game;

@end

@interface RoomListener : NSObject<RoomRequestListener>

@end