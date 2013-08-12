
/*****************************************************************
 *  PWMenuLayer.h
 *  PlayWithWords
 *  Created by shephertz technologies on 03/05/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PWMenuLayer : CCLayerColor
{
    BOOL isButtonEnabled;
    CCMenuItemLabel *playButton;
    CCMenuItemLabel *recallButton;
    CCMenuItemLabel *passButton;
    CCMenuItemImage *menuButton;
    CCMenuItemImage *quitButton;
    float scaleFactor;
}

@property(nonatomic,assign) BOOL isButtonEnabled;
@property(nonatomic,readonly) CCMenuItemImage *menuButton;

-(void)playClicked:(id)sender;
-(void)recallButtonClicked:(id)sender;
-(void)passButtonClicked:(id)sender;
-(void)quitButtonClicked:(id)sender;
-(void)setButtonsEnabled:(BOOL)isEnabled;
-(void)setPassButtonEnabled:(BOOL)isEnabled;
-(void)layoutMenuLayerForIPad;
-(void)layoutMenuLayerForIPhone;
-(NSString *)getWinnerID;
-(void)setPlayButtonEnabled:(BOOL)isEnabled;
-(void)setRecallButtonEnabled:(BOOL)isEnabled;
-(CGPoint)getPlayButtonPosition;
@end
