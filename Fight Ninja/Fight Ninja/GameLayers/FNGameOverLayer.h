//
//  FNGameOverLayer.h
//  Fight Ninja
//
//  Created by shephertz technologies on 19/03/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface FNGameOverLayer : CCLayerColor
{
    
    CCLabelTTF *_label;
    NSMutableArray *users;
}

@property(nonatomic,retain)     NSArray *users;
@property (nonatomic, retain) CCLabelTTF *label;

// returns a CCScene that contains the FNGameLogicLayer as the only child
+(CCScene *) scene;

-(void)showOnlineUsers:(NSMutableArray*)userNames;
-(void)leaderboardButtonAction;
-(void)backToGameButtonAction;

@end
