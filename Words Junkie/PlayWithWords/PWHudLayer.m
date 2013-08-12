/*****************************************************************
 *  PWHudLayer.m
 *  PlayWithWords
 *  Created by shephertz technologies on 03/05/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import "PWHudLayer.h"
#import "PWGameLogicLayer.h"
#import "PWGameController.h"
#import "SimpleAudioEngine.h"

@implementation PWHudLayer
@synthesize isBackButtonEnabled;
#pragma mark--
#pragma mark-- Initialization Methods
#pragma mark--

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
    if (self=[super initWithColor:color width:w height:h])
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            scleFactor = 0.5f;
            [self createHudLayoutForIPhone];
        }
        else
        {
            scleFactor = 1.0f;
            [self createHudLayoutForIPad];
        }
        [self setTouchEnabled:YES];
        if ([[PWGameLogicLayer sharedInstance] turnIndicator]==kPlayerOneTurn && [[PWGameController sharedInstance] tutorialStatus])
        {
            [self setTimerVisible:YES];
        }
        else
        {
            [self setTimerVisible:NO];
        }
        isBackButtonEnabled = YES;
    }
    return self;
}

-(void)createHudLayoutForIPad
{
    CGSize layerSize = [self contentSize];
    
    CCMenuItemImage *backButton = [CCMenuItemImage itemWithNormalImage:@"Backbutton.png" selectedImage:@"Back_P.png" target:self selector:@selector(backButtonClicked:)];
    float x_pos = layerSize.width/22;
    backButton.position = ccp(x_pos, layerSize.height/2);
    
    
    x_pos = backButton.contentSize.width;
    myScoreTitle = [CCLabelTTF labelWithString:@"Your Score :" fontName:GLOBAL_FONT fontSize:30];
    x_pos = x_pos+backButton.contentSize.width/1.8+myScoreTitle.contentSize.width/2;
    [myScoreTitle setPosition:ccp(x_pos, layerSize.height/2)];
    [myScoreTitle setColor:ccBLACK];
    [self addChild:myScoreTitle];
    
    myScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[PWGameController sharedInstance] dataManager] myScore]] fontName:GLOBAL_FONT fontSize:30];
    [myScoreLabel setPosition:ccp((myScoreTitle.position.x+myScoreTitle.contentSize.width/1.8f+myScoreLabel.contentSize.width/2), layerSize.height/2)];
    [myScoreLabel setColor:ccBLACK];
    [self addChild:myScoreLabel];
    
    CCMenuItemImage *refreshButton = [CCMenuItemImage itemWithNormalImage:@"Refresh.png" selectedImage:@"Refresh_p.png" target:self selector:@selector(refreshButtonClicked:)];
    x_pos = layerSize.width-layerSize.width/22;
    refreshButton.position = ccp(x_pos, layerSize.height/2);
    
    CCMenu *hudMenu = [CCMenu menuWithItems:backButton, nil];
    hudMenu.position = CGPointZero;
    [self addChild:hudMenu];
    
    NSString *player2Name = [[[[[PWGameController sharedInstance] dataManager] player2_name] componentsSeparatedByString:@" "] objectAtIndex:0];
    opponentScoreTitle = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@'s Score :",player2Name] fontName:GLOBAL_FONT fontSize:30];
    [opponentScoreTitle setColor:ccBLACK];
    [self addChild:opponentScoreTitle];
    
    oppenentScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[PWGameController sharedInstance] dataManager] opponentScore]] fontName:GLOBAL_FONT fontSize:30];
    x_pos = layerSize.width-(oppenentScoreLabel.contentSize.width/1.5);
    [oppenentScoreLabel setPosition:ccp(x_pos,layerSize.height/2)];
    [oppenentScoreLabel setColor:ccBLACK];
    [self addChild:oppenentScoreLabel];
    
    [opponentScoreTitle setPosition:ccp((oppenentScoreLabel.position.x-oppenentScoreLabel.contentSize.width/1.8f-opponentScoreTitle.contentSize.width/2), layerSize.height/2)];
    
    turnInfoLabel = [CCLabelTTF labelWithString:@"Your Turn!" fontName:GLOBAL_FONT fontSize:30];
    [turnInfoLabel setPosition:ccp(layerSize.width/2,layerSize.height/2)];
    [turnInfoLabel setColor:ccBLACK];
    [self addChild:turnInfoLabel];
    
    timerLabelTitle = [CCLabelTTF labelWithString:@"Time : " fontName:GLOBAL_FONT fontSize:30];
    [timerLabelTitle setColor:ccBLACK];
   // [self addChild:timerLabelTitle];
    
    timerBg = [CCSprite spriteWithFile:@"Watch.png"];
    [timerBg setPosition:ccp(layerSize.width-(timerBg.contentSize.width/1.5),-timerBg.contentSize.height/1.5)];
    [self addChild:timerBg z:1];
    
    timerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[PWGameLogicLayer sharedInstance] timeLeft]] fontName:GLOBAL_FONT fontSize:30];
    [timerLabel setPosition:timerBg.position];
    [timerLabel setColor:ccWHITE];
    [self addChild:timerLabel z:2];
}



-(void)createHudLayoutForIPhone
{
    CGSize layerSize = [self contentSize];
    int fontSize = 18;
    CCMenuItemImage *backButton = [CCMenuItemImage itemWithNormalImage:@"back-button-new.png" selectedImage:@"back-button-new.png" target:self selector:@selector(backButtonClicked:)];
    
    float x_pos = layerSize.width/22;
    backButton.position = ccp(x_pos, -layerSize.height*9.3);
    
    myScoreTitle = [CCLabelTTF labelWithString:@"Your Score :" fontName:GLOBAL_FONT fontSize:fontSize];
    [myScoreTitle setPosition:ccp(myScoreTitle.contentSize.width/1.7, layerSize.height/2)];
    [myScoreTitle setColor:ccBLACK];
    [self addChild:myScoreTitle];
    
    
    myScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[PWGameController sharedInstance] dataManager] myScore]] fontName:GLOBAL_FONT fontSize:fontSize];
    [myScoreLabel setPosition:ccp((myScoreTitle.position.x+myScoreTitle.contentSize.width/1.8f+myScoreLabel.contentSize.width/2), layerSize.height/2)];
    [myScoreLabel setColor:ccBLACK];
    [self addChild:myScoreLabel];
    
    
    CCMenuItemImage *refreshButton = [CCMenuItemImage itemWithNormalImage:@"Refresh.png" selectedImage:@"Refresh_p.png" target:self selector:@selector(refreshButtonClicked:)];
    refreshButton.scale = 0.65f;
    x_pos = layerSize.width-layerSize.width/22;
    refreshButton.position = ccp(x_pos, layerSize.height/2);
    
    CCMenu *hudMenu = [CCMenu menuWithItems:backButton,nil];
    hudMenu.position = CGPointZero;
    [self addChild:hudMenu];
    
    NSString *player2Name = [[[[[PWGameController sharedInstance] dataManager] player2_name] componentsSeparatedByString:@" "] objectAtIndex:0];
    opponentScoreTitle = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@'s Score :",player2Name] fontName:GLOBAL_FONT fontSize:fontSize];
    [opponentScoreTitle setColor:ccBLACK];
    [self addChild:opponentScoreTitle];
    
    oppenentScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[PWGameController sharedInstance] dataManager] opponentScore]] fontName:GLOBAL_FONT fontSize:fontSize];
    x_pos = layerSize.width-(oppenentScoreLabel.contentSize.width/2+5);
    [oppenentScoreLabel setPosition:ccp(x_pos,layerSize.height/2)];
    [oppenentScoreLabel setColor:ccBLACK];
    [self addChild:oppenentScoreLabel];
    
    [opponentScoreTitle setPosition:ccp((oppenentScoreLabel.position.x-oppenentScoreLabel.contentSize.width/1.8f-opponentScoreTitle.contentSize.width/2), layerSize.height/2)];
    
    turnInfoLabel = [CCLabelTTF labelWithString:@"Your Turn!" fontName:GLOBAL_FONT fontSize:fontSize];
    [turnInfoLabel setPosition:ccp(layerSize.width/2,layerSize.height/2)];
    [turnInfoLabel setColor:ccBLACK];
    [self addChild:turnInfoLabel];
    
    
    timerLabelTitle = [CCLabelTTF labelWithString:@"Time : " fontName:GLOBAL_FONT fontSize:fontSize];
    [timerLabelTitle setColor:ccBLACK];
    //[self addChild:timerLabelTitle];
    
    timerBg = [CCSprite spriteWithFile:@"Watch.png"];
    [timerBg setPosition:ccp((timerBg.contentSize.width/1.5),-timerBg.contentSize.height/1.5)];
    [self addChild:timerBg];
    
    timerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" %d",[[PWGameLogicLayer sharedInstance] timeLeft]] fontName:GLOBAL_FONT fontSize:fontSize];
    [timerLabel setPosition:timerBg.position];
    [timerLabel setColor:ccWHITE];
    [self addChild:timerLabel];
    
    [timerLabelTitle setPosition:ccp(timerLabelTitle.contentSize.width/1.8,-layerSize.height/1.7)];
}


-(void)updateMyScore:(int)score
{
    int myScore =[[[PWGameController sharedInstance] dataManager] myScore];
    myScore += score*score;
    [[[PWGameController sharedInstance] dataManager] setMyScore:myScore];
    NSString *scoreString = [NSString stringWithFormat:@"%d",myScore];
    [myScoreLabel setString:scoreString];
    CGSize layerSize = [self contentSize];
    [myScoreLabel setPosition:ccp(myScoreTitle.position.x+myScoreTitle.contentSize.width/1.8f+myScoreLabel.contentSize.width/2, layerSize.height/2)];
    
}

-(void)updateOpponentScore:(int)score
{
    int opponentScore =[[[PWGameController sharedInstance] dataManager] opponentScore];
    opponentScore += score*score;
    [[[PWGameController sharedInstance] dataManager] setOpponentScore:opponentScore];
    
    float width = oppenentScoreLabel.contentSize.width;
    
    NSString *scoreString = [NSString stringWithFormat:@"%d",opponentScore];
    [oppenentScoreLabel setString:scoreString];
    CGSize layerSize = [self contentSize];
    
    float diff = width-oppenentScoreLabel.contentSize.width;
    oppenentScoreLabel.position = ccp(oppenentScoreLabel.position.x+diff/2, oppenentScoreLabel.position.y);
        
    [opponentScoreTitle setPosition:ccp(oppenentScoreLabel.position.x-oppenentScoreLabel.contentSize.width/1.8f-opponentScoreTitle.contentSize.width/2, layerSize.height/2)];
}

-(void)refreshOpponentScore:(int)score
{
    [[[PWGameController sharedInstance] dataManager] setOpponentScore:score];
    
    float width = oppenentScoreLabel.contentSize.width;
    
    NSString *scoreString = [NSString stringWithFormat:@"%d",score];
    [oppenentScoreLabel setString:scoreString];
    CGSize layerSize = [self contentSize];
    
    float diff = width-oppenentScoreLabel.contentSize.width;
    oppenentScoreLabel.position = ccp(oppenentScoreLabel.position.x+diff/2, oppenentScoreLabel.position.y);
    [opponentScoreTitle setPosition:ccp(oppenentScoreLabel.position.x-oppenentScoreLabel.contentSize.width/1.8f-opponentScoreTitle.contentSize.width/2, layerSize.height/2)];
}

-(void)refreshMyScore:(int)myScore
{
    [[[PWGameController sharedInstance] dataManager] setMyScore:myScore];
    NSString *scoreString = [NSString stringWithFormat:@"%d",myScore];
    [myScoreLabel setString:scoreString];
    CGSize layerSize = [self contentSize];
    [myScoreLabel setPosition:ccp(myScoreTitle.position.x+myScoreTitle.contentSize.width/1.8f*scleFactor+myScoreLabel.contentSize.width/2*scleFactor, layerSize.height/2)];

}

-(void)updateTimer:(int)timeLeft
{
    [timerLabel setString:[NSString stringWithFormat:@" %d",timeLeft]];
}

-(void)setTimerVisible:(BOOL)isVisible
{
    [timerLabel setVisible:isVisible];
    [timerBg setVisible:isVisible];
}


-(void)updateTurnInfoLabel
{
    PWDataManager *dataManager = [[PWGameController sharedInstance] dataManager];
    if ([[PWGameLogicLayer sharedInstance] gameState]==kGameOver)
    {
        NSString *winnerID =[[dataManager sessionInfo] objectForKey:WINNER_ID];
        if ([winnerID isEqualToString:dataManager.player1])
        {
            [turnInfoLabel setString:@"You Won!"];
        }
        else if (winnerID.length==0)
        {
            [turnInfoLabel setString:@"Tie!"];
        }
        else
        {
            NSString *playerName = [[dataManager.player2_name componentsSeparatedByString:@" "] objectAtIndex:0];
            [turnInfoLabel setString:[NSString stringWithFormat:@"%@ Won!",playerName]];
        }
    }
    else if ([[PWGameLogicLayer sharedInstance] turnIndicator]==kPlayerOneTurn)
    {
        [turnInfoLabel setString:@"Your Turn!"];
    }
    else
    {
        NSString *playerName = [[dataManager.player2_name componentsSeparatedByString:@" "] objectAtIndex:0];
        [turnInfoLabel setString:[NSString stringWithFormat:@"%@'s Turn!",playerName]];
    }
}

-(void)backButtonClicked:(id)sender
{
    if (!isBackButtonEnabled)
    {
        return;
    }
    [[[PWGameController sharedInstance] dataManager] setDelegate:nil];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:BACK_BUTTON_CLICKED];
    PWDataManager *dataManager=[[PWGameController sharedInstance] dataManager];
    [dataManager updateTimeLeftForTheRunningGame:[[PWGameLogicLayer sharedInstance] timeLeft]];
    [[PWGameLogicLayer sharedInstance] unschedule:@selector(refreshGame:)];
    [[PWGameController sharedInstance] switchToLayerWithCode:kHomeLayer];
    [dataManager resetGameData];
    [[PWGameController sharedInstance] cleanGameScene];
}

-(void)refreshButtonClicked:(id)sender
{
    //[[[PWGameController sharedInstance] dataManager] notifyOpponentForRecentMove:@"Hi"];
    //[[PWGameLogicLayer sharedInstance] refresh];
}

-(void)dealloc
{
    [super dealloc];
}

@end
