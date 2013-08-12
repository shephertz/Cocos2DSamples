//
//  PWGameController.h
//  PlayWithWords
//
//  Created by shephertz technologies on 08/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PWDataManager.h"
#import "PWAlertManager.h"
#import "PWTutorialManager.h"
@class Reachability;

@interface PWGameController : NSObject
{
    ScreenCode currentScreenCode;
    CCScene *gameScene;
    id currentController;
    ScreenCode previousScreenCode;
    
    Reachability* hostReach;
    int networkStatus;
    PWAlertManager *alertManager;
    
    TutorialStep nextTutorialStep;
    BOOL tutorialStatus;
    PWTutorialManager *tutorialManager;
}
@property (nonatomic, retain) PWAlertManager    *alertManager;
@property (nonatomic, assign) PWDataManager     *dataManager;
@property (nonatomic, assign) ScreenCode  previousScreenCode;
@property (nonatomic, assign) ScreenCode  currentScreenCode;
@property (nonatomic, assign) int networkStatus;
@property (nonatomic, assign) BOOL tutorialStatus;
@property (nonatomic, assign) TutorialStep nextTutorialStep;
@property (nonatomic, assign) PWTutorialManager *tutorialManager;

+(PWGameController *)sharedInstance;

-(void)switchToLayerWithCode:(ScreenCode)code;
-(void)runGameScene;
-(void)removeUpperView;
-(void)startReachabilityCheck;
-(void)refreshUpperView;
-(CCScene*)getGameScene;
-(void)cleanGameScene;
-(void)releaseTutorialManager;
@end
