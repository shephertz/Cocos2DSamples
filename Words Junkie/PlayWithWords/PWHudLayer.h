
/*****************************************************************
 *  PWHudLayer.h
 *  PlayWithWords
 *  Created by shephertz technologies on 03/05/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PWHudLayer : CCLayerColor
{
    CCLabelTTF *myScoreTitle;
    CCLabelTTF *myScoreLabel;
    
    CCLabelTTF *opponentScoreTitle;
    CCLabelTTF *oppenentScoreLabel;
    
    CCLabelTTF *turnInfoLabel;
    CCLabelTTF *timerLabel;
    CCLabelTTF *timerLabelTitle;
    CCSprite   *timerBg;
    CCDrawNode *draw;
    float scleFactor;
    BOOL isBackButtonEnabled;
}
@property(nonatomic,assign) BOOL isBackButtonEnabled;

-(void)createHudLayoutForIPhone;
-(void)createHudLayoutForIPad;

-(void)updateMyScore:(int)score;
-(void)updateOpponentScore:(int)score;
-(void)updateTurnInfoLabel;
-(void)backButtonClicked:(id)sender;
-(void)refreshOpponentScore:(int)score;
-(void)refreshMyScore:(int)myScore;
-(void)updateTimer:(int)timeLeft;
-(void)setTimerVisible:(BOOL)isVisible;

@end
