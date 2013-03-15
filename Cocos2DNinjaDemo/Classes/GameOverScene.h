//
//  GameOverScene.h
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 2/10/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "cocos2d.h"

@interface GameOverLayer : CCColorLayer {
	CCLabelTTF *_label;
    NSMutableArray *users;
}
@property(nonatomic,retain)     NSArray *users;

@property (nonatomic, retain) CCLabelTTF *label;

-(void)showOnlineUsers:(NSMutableArray*)userNames;
-(void)leaderboardButtonAction;
-(void)backToGameButtonAction;


@end

@interface GameOverScene : CCScene {
	GameOverLayer *_layer;
}

@property (nonatomic, retain) GameOverLayer *layer;

@end
