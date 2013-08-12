/*****************************************************************
 *  PWMenuLayer.m
 *  PlayWithWords
 *  Created by shephertz technologies on 03/05/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/


#import "PWMenuLayer.h"
#import "PWGameLogicLayer.h"
#import "PWAlertManager.h"
#import "PWHudLayer.h"
#import "PWGameController.h"
#import "PWCharacter.h"
#import "SimpleAudioEngine.h"
#define Y_OFFSET 10

@implementation PWMenuLayer
@synthesize isButtonEnabled,menuButton;

#pragma mark--
#pragma mark-- Initialization Methods
#pragma mark--

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
    if (self=[super initWithColor:color width:w height:h])
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            scaleFactor = 0.5f;
            [self layoutMenuLayerForIPhone];
        }
        else
        {
            scaleFactor = 1.0f;
            [self layoutMenuLayerForIPad];
        }
        [self setTouchEnabled:YES];
        
        isButtonEnabled = NO;
    }
    return self;
}

-(void)layoutMenuLayerForIPad
{
    CGSize s = self.contentSize;
    
    /** ---Play Button--- **/
    CCLabelTTF *playButtonTitle = [CCLabelTTF labelWithString:@"Play" fontName:GLOBAL_FONT fontSize:28];
    [playButtonTitle setColor:ccBLACK];
    playButton = [CCMenuItemImage itemWithNormalImage:@"Button_bg_normal.png" selectedImage:@"Button_bg_highlight.png" target:self selector:@selector(playClicked:)];
    CGSize playButtonSize = playButton.contentSize;
    playButtonTitle.position = ccp(playButtonSize.width/2, playButtonSize.height/2.2);
    [playButton addChild:playButtonTitle];
    playButton.position = ccp(playButtonSize.width/1.5, s.height/2.3);
    
    /** ---Recall Button--- **/
    CCLabelTTF *recallButtonTitle = [CCLabelTTF labelWithString:@"Recall" fontName:GLOBAL_FONT fontSize:28];
    [recallButtonTitle setColor:ccBLACK];
    recallButton = [CCMenuItemImage itemWithNormalImage:@"Button_bg_normal.png" selectedImage:@"Button_bg_highlight.png" target:self selector:@selector(recallButtonClicked:)];
    CGSize recallButtonSize = recallButton.contentSize;
    recallButtonTitle.position = ccp(recallButtonSize.width/2, recallButtonSize.height/2.2);
    [recallButton addChild:recallButtonTitle];
    recallButton.position = ccp((playButton.position.x+playButtonSize.width/2 + recallButtonSize.width/1.7), s.height/2.3);
    
    /** ---Menu Button--- **/
    menuButton = [CCMenuItemImage itemWithNormalImage:@"Menu-button.png" selectedImage:@"Menu-button.png" target:[PWGameLogicLayer sharedInstance] selector:@selector(menuButtonAction:)];
    menuButton.tag = MENU_BUTTON_TAG;
    menuButton.position = ccp(s.width-menuButton.contentSize.width/2, s.height*2.2+menuButton.contentSize.height/2);
    
    /** ---Quit Button--- **/
    CCLabelTTF *quitButtonTitle = [CCLabelTTF labelWithString:@"Quit" fontName:GLOBAL_FONT fontSize:28];
    [quitButtonTitle setColor:ccBLACK];
    quitButton = [CCMenuItemImage itemWithNormalImage:@"Button_bg_normal.png" selectedImage:@"Button_bg_highlight.png" target:self selector:@selector(quitButtonClicked:)];
    CGSize quitButtonSize = quitButton.contentSize;
    quitButtonTitle.position = ccp(quitButtonSize.width/2, quitButtonSize.height/2.2);
    [quitButton addChild:quitButtonTitle];
    quitButton.position = ccp(s.width-quitButton.contentSize.width/1.5, s.height/2.3);

    
    /** ---Pass Button--- **/
    CCLabelTTF *passButtonTitle = [CCLabelTTF labelWithString:@"Pass" fontName:GLOBAL_FONT fontSize:28];
    [passButtonTitle setColor:ccBLACK];
    passButton = [CCMenuItemImage itemWithNormalImage:@"Button_bg_normal.png" selectedImage:@"Button_bg_highlight.png" target:self selector:@selector(passButtonClicked:)];
    CGSize passButtonSize = passButton.contentSize;
    passButtonTitle.position = ccp(passButtonSize.width/2, passButtonSize.height/2.2);
    [passButton addChild:passButtonTitle];
    passButton.position = ccp(quitButton.position.x-(quitButtonSize.width/2+passButtonSize.width/1.7), s.height/2.3);
    
    
    CCMenu *toolMenu = [CCMenu menuWithItems:playButton,recallButton,passButton,menuButton,quitButton, nil];
    toolMenu.position = CGPointZero;
    [self addChild:toolMenu z:10];
    
    [self setButtonsEnabled:NO];
    
    if ([[PWGameLogicLayer sharedInstance] turnIndicator]==kPlayerTwoTurn || [[PWGameLogicLayer sharedInstance] gameState]==kGameOver)
    {
        [self setPassButtonEnabled:NO];
    }
    else
    {
        [self setPlayButtonEnabled:YES];
    }
}


-(void)layoutMenuLayerForIPhone
{
    CGSize s = self.contentSize;
    
    int x_pos_offset =4;
    CCSprite *menuBg = [CCSprite spriteWithFile:@"Button-box.png"];
    menuBg.position = ccp(s.width-menuBg.contentSize.width/2, s.height/2);
    [self addChild:menuBg];
    
    playButton = [CCMenuItemImage itemWithNormalImage:@"Play-button-iPhone.png" selectedImage:@"Play-button-iPhone.png" target:self selector:@selector(playClicked:)];
    playButton.position = ccp(menuBg.position.x+x_pos_offset, 6.2*s.height/8);
    
    recallButton = [CCMenuItemImage itemWithNormalImage:@"Undo.png" selectedImage:@"Undo.png" target:self selector:@selector(recallButtonClicked:)];
    recallButton.position = ccp(menuBg.position.x+x_pos_offset, 4.8*s.height/8);
    
    
    passButton = [CCMenuItemImage itemWithNormalImage:@"Pass-button-iPhone.png" selectedImage:@"Pass-button-iPhone.png" target:self selector:@selector(passButtonClicked:)];
    passButton.position = ccp(menuBg.position.x+x_pos_offset, 3.3*s.height/8);
    
    /** ---Quit Button--- **/
    quitButton = [CCMenuItemImage itemWithNormalImage:@"Quit-button-iPhone.png" selectedImage:@"Quit-button-iPhone.png" target:self selector:@selector(quitButtonClicked:)];
    quitButton.position = ccp(menuBg.position.x+x_pos_offset, 1.8*s.height/8);

    
    menuButton = [CCMenuItemImage itemWithNormalImage:@"Menu-button.png" selectedImage:@"Menu-button.png" target:[PWGameLogicLayer sharedInstance] selector:@selector(menuButtonAction:)];
    menuButton.tag = MENU_BUTTON_TAG;
    menuButton.position = ccp(s.width-menuButton.contentSize.width/2, 8);
    
    CCMenu *toolMenu = [CCMenu menuWithItems:playButton,recallButton,passButton,quitButton,menuButton, nil];
    toolMenu.position = CGPointZero;
    [self addChild:toolMenu z:10];
    
    [self setButtonsEnabled:NO];
    
    if ([[PWGameLogicLayer sharedInstance] turnIndicator]==kPlayerTwoTurn)
    {
        [self setPassButtonEnabled:NO];
    }
    else
    {
        [self setPlayButtonEnabled:YES];
    }
}

-(void)setPlayButtonEnabled:(BOOL)isEnabled
{
    [playButton setIsEnabled:isEnabled];
    if (isEnabled)
    {
        [playButton setOpacity:255];
    }
    else
    {
        [playButton setOpacity:150];
    }
}
-(void)setRecallButtonEnabled:(BOOL)isEnabled
{
    [recallButton setIsEnabled:isEnabled];
    if (isEnabled)
    {
        [recallButton setOpacity:255];
    }
    else
    {
        [recallButton setOpacity:150];
    }
}

-(void)setButtonsEnabled:(BOOL)isEnabled
{
    [playButton setIsEnabled:isEnabled];

    [recallButton setIsEnabled:isEnabled];
    [self setPassButtonEnabled:!isEnabled];
    
    if (isEnabled)
    {
        [playButton setOpacity:255];
        [recallButton setOpacity:255];
    }
    else
    {
        [playButton setOpacity:150];
        [recallButton setOpacity:150];
    }
}

-(void)setPassButtonEnabled:(BOOL)isEnabled
{
    [passButton setIsEnabled:isEnabled];
    [quitButton setIsEnabled:isEnabled];
    if (isEnabled)
    {
        [passButton setOpacity:255];
        [quitButton setOpacity:255];
    }
    else
    {
        [passButton setOpacity:150];
        [quitButton setOpacity:150];
    }
}

-(CGPoint)getPlayButtonPosition
{
    return playButton.position;
}

-(void)playClicked:(id)sender
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    PWGameLogicLayer *gameLayer = [PWGameLogicLayer sharedInstance];
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    
    if (gameLayer.turnIndicator==kPlayerTwoTurn)
    {
        return;
    }
    
    int skipChanceLeftForOpponent = [[[dataManager player2Dict] objectForKey:SKIPP_CHANCE_LEFT] intValue];
    if (!skipChanceLeftForOpponent)
    {
        [[dataManager player2Dict] setObject:[NSNumber numberWithInt:skipChanceLeftForOpponent+1] forKey:SKIPP_CHANCE_LEFT];
    }
    
    CurrentGameMode gameMode = [gameLayer currentGameMode];
    
    if (gameMode==kPlacementMode)
    {
        if (!gameLayer.selectedChar)
        {
            NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Place a character!",ALERT_MESSAGE, nil];
            [[PWGameController sharedInstance].alertManager showTurnAlertWithAlertInfo:alertInfo];
            return;
        }
        [gameLayer placeTheChar];
        [sender setString:@"Play"];
        gameMode = kSearchMode;
        [gameLayer setCurrentGameMode:gameMode];
    }
    else
    {
        if (![[PWGameController sharedInstance] tutorialStatus])
        {
            [[[PWGameController sharedInstance] tutorialManager] setTutorialElementsVisible:NO];
        }
        if (![gameLayer isWordSelected])
        {
            NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Select a word!",ALERT_MESSAGE, nil];
            [[PWGameController sharedInstance].alertManager showTurnAlertWithAlertInfo:alertInfo];
            return;
        }
        
        if (![gameLayer isValidWordSelection])
        {
            NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Not a valid selection!",ALERT_MESSAGE, nil];
            [[PWGameController sharedInstance].alertManager showTurnAlertWithAlertInfo:alertInfo];
            return;
        }
        NSString *word = [[gameLayer constructWordFromTheSelectedNodes] retain];
        BOOL isDictoinaryWord = [gameLayer isDictionaryWord:word];
        BOOL isLockedWord = [gameLayer isLockedWord:word];
        
        
        
        if (isDictoinaryWord && !isLockedWord)
        {//Valid Word
            dataManager.recentWord = word;
            NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,[NSString stringWithFormat:@"Play %@ for %d points!",[word uppercaseString],word.length*word.length],ALERT_MESSAGE,@"Cancel",ALERT_CANCEL_BUTTON_TEXT,@"OK",ALERT_OK_BUTTON_TEXT, nil];
            [PWGameController sharedInstance].alertManager.alertType = kValidWordAlert;
            [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];
        }
        else
        {//Invalid Word
            NSString *title;
            if (!isDictoinaryWord)
            {
                title = @"Not a word";
            }
            else
            {
                title = @"Duplicate word";

            }
            NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:title,ALERT_TITLE,[NSString stringWithFormat:@"Play %@ for 0 points!",[word uppercaseString]],ALERT_MESSAGE,@"Cancel",ALERT_CANCEL_BUTTON_TEXT,@"OK",ALERT_OK_BUTTON_TEXT, nil];
            [PWGameController sharedInstance].alertManager.alertType = kInvalidWordAlert;
            [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];

        }
        
        [gameLayer resetSelectionParameters];
        [word release];
    
    }
}


-(void)recallButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:RECALL_BUTTON];

    PWGameLogicLayer *gamelayer = [PWGameLogicLayer sharedInstance];
    PWDataManager *dataManager = [[PWGameController sharedInstance] dataManager];
    
    
    
    if (gamelayer.selectedChar)
    {
        [gamelayer.selectedChar startNotPlaceableIndicatorAnimation:NO];
        [[gamelayer getScrollLayer] removeChild:gamelayer.selectedChar cleanup:YES];
        gamelayer.selectedChar = nil;
    }
    else
    {
        [dataManager.gameDataDict removeObjectForKey:dataManager.index];
        int tag = [gamelayer getCharTagForIndex:CGPointFromString(dataManager.index)];
        [[gamelayer getScrollLayer] removeChild:[[gamelayer getScrollLayer] getChildByTag:tag] cleanup:YES];
    }
    
    [gamelayer resetSelectionParameters];
    gamelayer.currentGameMode = kPlacementMode;
    [self setButtonsEnabled:NO];
    dataManager.index = nil;
    dataManager.alphabet = nil;
}

-(void)passButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];

    PWGameLogicLayer *gameLayer = [PWGameLogicLayer sharedInstance];
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    if (gameLayer.turnIndicator==kPlayerTwoTurn)
    {
        return;
    }
    BOOL isGameOver = NO;
    int skipChanceLeftForMe = [[[dataManager player1Dict] objectForKey:SKIPP_CHANCE_LEFT] intValue];
    if (!skipChanceLeftForMe)
    {
        isGameOver = YES;
    }
    
    if (isGameOver)
    {
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"You will loose if you pass this turn!",ALERT_MESSAGE,@"Cancel",ALERT_CANCEL_BUTTON_TEXT,@"Continue",ALERT_OK_BUTTON_TEXT, nil];
        [PWGameController sharedInstance].alertManager.alertType = kPassTurnAlert;
        [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];
    }
    else
    {
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Are you sure you want to pass your turn?",ALERT_MESSAGE,@"No",ALERT_CANCEL_BUTTON_TEXT,@"Yes",ALERT_OK_BUTTON_TEXT, nil];
        [PWGameController sharedInstance].alertManager.alertType = kPassTurnAlert;
        [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];
    }

}

/*
-(void)passButtonClicked1:(id)sender
{
    PWGameLogicLayer *gameLayer = [PWGameLogicLayer sharedInstance];
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    if (gameLayer.turnIndicator==kPlayerTwoTurn)
    {
        return;
    }
    BOOL isGameOver;
    int skipChanceLeftForMe = [[dataManager player1Dict] objectForKey:SKIPP_CHANCE_LEFT];
    if (!skipChanceLeftForMe)
    {
        isGameOver = YES;
    }
    else
    {
        [[dataManager player1Dict] setObject:[NSNumber numberWithBool:skipChanceLeftForMe-1] forKey:SKIPP_CHANCE_LEFT];
    }
    CurrentGameMode gameMode = [gameLayer currentGameMode];
    
    NSString *word = [[gameLayer constructWordFromTheSelectedNodes] retain];
    
    if (!isGameOver)
        isGameOver = [gameLayer isGameOverNormally];
    
    if (word && [gameLayer isDictionaryWord:word] && ![gameLayer isLockedWord:word])
    {
        [dataManager lockThisWord:word];
        Turn turnIndicator = [gameLayer turnIndicator];
        
        if (turnIndicator == kPlayerOneTurn)
        {
            if (!isGameOver)
            {
                NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Player 2 Turn!",ALERT_MESSAGE, nil];
                [gameLayer.alertManager showTurnAlertWithAlertInfo:alertInfo];
            }
            
            turnIndicator = kPlayerTwoTurn;
            [gameLayer.hudLayer updateMyScore:word.length];
        }
        else
        {
            if (!isGameOver)
            {
                NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Your Turn!",ALERT_MESSAGE, nil];
                [gameLayer.alertManager showTurnAlertWithAlertInfo:alertInfo];
            }
            turnIndicator = kPlayerOneTurn;
            [gameLayer.hudLayer updateOpponentScore:word.length];
        }
        [gameLayer setTurnIndicator:turnIndicator];
        [gameLayer.hudLayer updateTurnInfoLabel];
    }
    else
    {
        Turn turnIndicator = [gameLayer turnIndicator];
        if (turnIndicator == kPlayerOneTurn)
        {
            if (!isGameOver)
            {
                NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Player 2 Turn!",ALERT_MESSAGE, nil];
                [gameLayer.alertManager showTurnAlertWithAlertInfo:alertInfo];
            }
           
            turnIndicator = kPlayerTwoTurn;
        }
        else
        {
            if (!isGameOver)
            {
                NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Your Turn!",ALERT_MESSAGE, nil];
                [gameLayer.alertManager showTurnAlertWithAlertInfo:alertInfo];
            }
            
            turnIndicator = kPlayerOneTurn;
        }
        [gameLayer setTurnIndicator:turnIndicator];
        [gameLayer.hudLayer updateTurnInfoLabel];
    }
    
    [self setButtonsEnabled:NO];
    [self setPassButtonEnabled:NO];
    gameMode = kPlacementMode;
    [gameLayer resetSelectionParameters];
    [word release];
    
    [gameLayer setCurrentGameMode:gameMode];
    
    if (isGameOver)
    {
        [gameLayer setGameState:kGameOver];
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Game Over!",ALERT_MESSAGE, nil];
        [gameLayer.alertManager showTurnAlertWithAlertInfo:alertInfo];
        [dataManager.sessionInfo setObject:[self getWinnerID] forKey:WINNER_ID];
        [dataManager performSelectorInBackground:@selector(saveScore) withObject:nil];
    }
    [dataManager saveSessionLocally];
    [dataManager writeSessionToTheServer];
}
*/
-(NSString *)getWinnerID
{
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    if ([dataManager myScore]>[dataManager opponentScore])
    {
        return [dataManager player1];
    }
    else if ([dataManager myScore]==[dataManager opponentScore])
    {
        return @"";
    }
    else
    {
        return [dataManager player2];
    }
}

-(void)quitButtonClicked:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    PWGameLogicLayer *gameLayer = [PWGameLogicLayer sharedInstance];

    if (gameLayer.turnIndicator==kPlayerTwoTurn)
    {
        return;
    }
    
    NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Are you sure you want to quit this game?",ALERT_MESSAGE,@"No",ALERT_CANCEL_BUTTON_TEXT,@"Yes",ALERT_OK_BUTTON_TEXT, nil];
    [PWGameController sharedInstance].alertManager.alertType = kQuitGameAlert;
    [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];
    
}


-(void)dealloc
{
    [super dealloc];
}

@end
