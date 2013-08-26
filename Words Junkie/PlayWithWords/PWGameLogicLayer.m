/*****************************************************************
 *  PWGameLogicLayer.m
 *  PlayWithWords
 *  Created by shephertz technologies on 18/04/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import "PWGameLogicLayer.h"
#import "PWCharacter.h"
#import "PWDrawLine.h"
#import "PWHudLayer.h"
#import "PWMenuLayer.h"
#import "PWGameController.h"
#import "CDWordList.h"
#import "PWSnapShotFlash.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation PWGameLogicLayer

@synthesize selectedChar,hudLayer,menuLayer,currentGameMode,isCharacterSelected,turnIndicator,gameState,timeLeft,rowHeight,rowWidth,numberOfRows,numberOfColumns;

static PWGameLogicLayer *_sharedObject;

// Helper class method that creates a Scene with the PWGameLogicLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object. 
	//CCScene *scene = [CCScene node];
	
    
	// 'layer' is an autorelease object.
	PWGameLogicLayer *layer = [PWGameLogicLayer sharedInstance];
	
	// add layer as a child to scene
	[[[PWGameController sharedInstance] getGameScene] addChild: layer];
	
	// return the scene
	return [[PWGameController sharedInstance] getGameScene];
}

+(PWGameLogicLayer *)sharedInstance
{
	if (!_sharedObject)
    {
		_sharedObject = [[PWGameLogicLayer alloc] init];
	}
	return _sharedObject;
}

+(PWGameLogicLayer *)getGameLogicLayer
{
	return _sharedObject;
}


-(void)createBgLayerForIPad
{

    CGSize s = [[CCDirector sharedDirector] winSize];
    
    CCSprite *gameBgUpper = [CCSprite spriteWithFile:@"Game_BG_upper.png"];
    float y_pos =s.height-gameBgUpper.contentSize.height/2;
    [gameBgUpper setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:gameBgUpper z:2];
    
    y_pos -= gameBgUpper.contentSize.height/2;
    CCSprite *pipe_up = [CCSprite spriteWithFile:@"Pipe.png"];
    [pipe_up setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:pipe_up z:2];
    
    CCSprite *gameBgMiddle = [CCSprite spriteWithFile:@"Game_BG_middle.png"];
    y_pos -= gameBgMiddle.contentSize.height/2;
    [gameBgMiddle setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:gameBgMiddle z:0];
    
    CCSprite *gameBgLower = [CCSprite spriteWithFile:@"Game_BG_lower.png"];
     y_pos -=gameBgMiddle.contentSize.height/2+gameBgLower.contentSize.height/2;
    [gameBgLower setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:gameBgLower z:2];
    
    y_pos +=gameBgLower.contentSize.height/2+4;
    CCSprite *pipe_lower1 = [CCSprite spriteWithFile:@"Pipe.png"];
    [pipe_lower1 setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:pipe_lower1 z:CHARACTER_MENU+1];
    
    
    CCSprite *pipe_lower2 = [CCSprite spriteWithFile:@"Pipe.png"];
    y_pos -=CHARACTER_MENU_HEIGHT_IPAD-pipe_lower2.contentSize.height/2+7;
    [pipe_lower2 setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:pipe_lower2 z:CHARACTER_MENU+1];
    
}

-(void)createBgLayerForIPhone
{
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    CCSprite *gameBgUpper = [CCSprite spriteWithFile:@"Game_BG_upper.png"];
    float y_pos =s.height-gameBgUpper.contentSize.height/2;
    [gameBgUpper setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:gameBgUpper z:2];

    y_pos -= gameBgUpper.contentSize.height/2;
    CCSprite *pipe_up = [CCSprite spriteWithFile:@"Pipe.png"];
    [pipe_up setPosition:CGPointMake(s.width/2, y_pos-pipe_up.contentSize.height/3)];
    [self addChild:pipe_up z:2];
    
    CCSprite *gameBgMiddle = [CCSprite spriteWithFile:@"Game_BG_middle.png"];
    y_pos -= gameBgMiddle.contentSize.height/2;
    [gameBgMiddle setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:gameBgMiddle z:0];
    
    
    CCSprite *gameBgLower = [CCSprite spriteWithFile:@"Game_BG_lower.png"];
    y_pos -=gameBgMiddle.contentSize.height/2-gameBgLower.contentSize.height/4;
    [gameBgLower setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:gameBgLower z:2];
    
    y_pos +=gameBgLower.contentSize.height/2+4;
    CCSprite *pipe_lower1 = [CCSprite spriteWithFile:@"Pipe.png"];
    [pipe_lower1 setPosition:CGPointMake(s.width/2, y_pos)];
    [self addChild:pipe_lower1 z:CHARACTER_MENU+1];
    
    
    CCSprite *pipe_lower2 = [CCSprite spriteWithFile:@"Pipe.png"];
    [pipe_lower2 setPosition:CGPointMake(s.width/2, pipe_lower2.contentSize.height/2)];
    [self addChild:pipe_lower2 z:CHARACTER_MENU+1];
    
}


-(void)createScrollLayer
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    [[[CCDirector sharedDirector] view] setMultipleTouchEnabled:YES];
    _panZoomLayer = [[CCLayerPanZoom node] retain];
    [self addChild: _panZoomLayer z:1];
    _panZoomLayer.delegate = self;
    _panZoomLayer.contentSize = s;
    _panZoomLayer.mode = kCCLayerPanZoomModeSheet;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        _panZoomLayer.minScale = 1.0f;
        _panZoomLayer.maxScale = 2.0f;
    }
    else
    {
        _panZoomLayer.minScale = 1.0f;
        _panZoomLayer.maxScale = 2.0f;
    }
    
    _panZoomLayer.rubberEffectRatio = 0.0f;
    _panZoomLayer.panBoundsRect = CGRectMake(0, 0, s.width, s.height);
    _panZoomLayer.position = ccp(s.width/2, s.height/2);

}

-(CCLayerPanZoom*)getScrollLayer
{
    return _panZoomLayer;
}
// on "init" you need to initialize your instance
-(id) init
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor:ccc4(150, 100, 100, 255) width:winSize.width height:winSize.height]))
    {
		[self setTouchEnabled:YES];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            scaleFactor = 0.5f;
        }
        else
        {
            scaleFactor = 1.0f;
        }
        
	}
	return self;
}


-(void)layoutGameLayer
{
    CGSize boardSize;
    if ([[PWGameController sharedInstance].dataManager.sessionInfo objectForKey:GAME_BOARD_SIZE])
    {
        boardSize = CGSizeFromString([[PWGameController sharedInstance].dataManager.sessionInfo objectForKey:GAME_BOARD_SIZE]);
    }
    else
    {
        boardSize = CGSizeMake(NUMBER_OF_ROWS, NUMBER_OF_COLUMNS);
    }
    
    numberOfRows = (int)boardSize.width;
    numberOfColumns = (int)boardSize.height;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [self createBgLayerForIPhone];
        [self createCharacterMenuForIPhone];
    }
    else
    {
        [self createBgLayerForIPad];
        [self createCharacterMenuForIPad];
    }
    [self createScrollLayer];
    [self createWordBoard];
}

-(void)startGame
{
    NSLog(@"session=%@",[PWGameController sharedInstance].dataManager.sessionInfo);
    [self initialGameSetup];
    [self createHudLayer];
    [self createMenuLayer];
    
    if ([PWGameController sharedInstance].dataManager.gameDataDict.count)
    {
        [self resumeGameFromSession];
    }
    [hudLayer updateTurnInfoLabel];
    [self createCoverLayer];
    if (turnIndicator==kPlayerTwoTurn && gameState == kGameRunning)
    {
        [self setCoverLayerVisible:YES];
    }
    else
    {
        [self setCoverLayerVisible:NO];
    }
    
    // Calls refresh game after every 1 second
    if (gameState==kGameRunning)
    {
        [self schedule:@selector(refreshGame:) interval:1.0f];
        if (![[PWGameController sharedInstance] tutorialStatus])
        {
            [[[PWGameController sharedInstance] tutorialManager] showTutorialStep:[[PWGameController sharedInstance] nextTutorialStep]];
        }
    }
    
    
    
}

-(void)initialGameSetup
{
    
    PWDataManager *dataManager = [[PWGameController sharedInstance] dataManager];
    gameState = [[dataManager.sessionInfo objectForKey:GAME_STATE] intValue];
    refreshTimer = 30;
    if (!gameState)
    {
        gameState = kGameRunning;
    }
    
    turnIndicator   = [[dataManager.player1Dict objectForKey:TURN] intValue];
    currentGameMode = [[dataManager.sessionInfo objectForKey:GAME_MODE] intValue];
    

    if (gameState == kGameRunning)
    {
        BOOL tutorialStatus = [[[NSUserDefaults standardUserDefaults] objectForKey:TUTORIAL_STATUS] intValue];
        if (!tutorialStatus && turnIndicator==kPlayerOneTurn && !dataManager.myScore)
        {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:NEXT_TUTORIAL_STEP])
            {
                [[PWGameController sharedInstance] setNextTutorialStep:[[[NSUserDefaults standardUserDefaults] objectForKey:NEXT_TUTORIAL_STEP] intValue]];
            }
            else
            {
                [[PWGameController sharedInstance] setNextTutorialStep:kDragNDrop];
            }
            [[PWGameController sharedInstance] setTutorialStatus:tutorialStatus];
            PWTutorialManager *tutorialManager = [[PWTutorialManager alloc] init];
            [[PWGameController sharedInstance] setTutorialManager:tutorialManager];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:TUTORIAL_STATUS];
            [[PWGameController sharedInstance] setTutorialStatus:1];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:kCompleted] forKey:NEXT_TUTORIAL_STEP];

        }

        timeLeft = [dataManager getTimeLeftForTheRunningGame];
    }
    else if(turnIndicator == kPlayerOneTurn)
    {
        turnIndicator = kTurnNone;
        [dataManager saveScore];
        [dataManager saveSessionLocally];
        [dataManager writeSessionToTheFile];
        [dataManager removeDocWithDocId:dataManager.doc_Id];
    }
    
    coverLayer = nil;
    screenShot = nil;
    selectionLine = nil;
    selectedIndicesArray = [[NSMutableArray alloc] initWithCapacity:0];
    selectedPointsArray  = nil;
    self.selectedChar = nil;
    selectionType = kNone;
    isCharacterSelected = NO;
    
    menuScreen = nil;
    
}

#pragma mark -
#pragma mark -- Basic Layout methods of Game layer --
#pragma mark -


-(void)showMenuScreen:(BOOL)isShow withAnimation:(BOOL)isAnimate
{
    if (!menuScreen)
    {
         [self createMenuScreen];
    }
    int flipper;
    if(isShow)
    {
        flipper = -1;
    }
    else
    {
        flipper = 1;
    }
    
    if (isAnimate)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:MENU_ANIMATION];
        [menuLayer.menuButton setIsEnabled:NO];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            id menu_move_action = [CCMoveBy actionWithDuration:0.5f position:ccp(menuLayer.contentSize.width*(-flipper), 0)];
            id callBack = [CCCallFunc actionWithTarget:self selector:@selector(menuScreenAnimationDone)];
            id menu_Ease_Action = [CCEaseIn actionWithAction:menu_move_action rate:2.5f];
            [menuLayer runAction:[CCSequence actions:menu_Ease_Action,callBack, nil]];
        }
        else
        {
            id menu_move_action = [CCMoveBy actionWithDuration:0.5f position:ccp(menuLayer.menuButton.contentSize.width*(-flipper), 0)];
            id callBack = [CCCallFunc actionWithTarget:self selector:@selector(menuScreenAnimationDone)];
            id menu_Ease_Action = [CCEaseIn actionWithAction:menu_move_action rate:2.5f];
            [menuLayer.menuButton runAction:[CCSequence actions:menu_Ease_Action,callBack, nil]];
        }
        id show_action = [CCMoveBy actionWithDuration:0.5f position:ccp(menuScreen.contentSize.width*flipper, 0)];
        [menuScreen runAction:[CCEaseIn actionWithAction:show_action rate:2.5f]];
    }
    else
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            id menu_move_action = [CCMoveBy actionWithDuration:0.5f position:ccp(menuLayer.contentSize.width*(-flipper), 0)];
            [menuLayer runAction:[CCEaseIn actionWithAction:menu_move_action rate:2.5f]];
        }
        else
        {
            id menu_move_action = [CCMoveBy actionWithDuration:0.5f position:ccp(menuLayer.menuButton.contentSize.width*(-flipper), 0)];
            [menuLayer.menuButton runAction:[CCEaseIn actionWithAction:menu_move_action rate:2.5f]];
        }
                
        menuScreen.position = ccp(menuScreen.position.x+menuScreen.contentSize.width*flipper, menuScreen.position.y);
    }
}

-(void)menuScreenAnimationDone
{
    [menuLayer.menuButton setIsEnabled:YES];
    [closeItem setIsEnabled:YES];
}

-(void)createMenuScreen
{
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    float y_pos,y_offset_iphone;
    NSString *menuScreenImage;//Setting_icon_iphone
    NSString *settingImage;
    NSString *helpImage;
    NSString *snapshotImage;
    NSString *supportImage;
    NSString *leaderboardImage;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        menuScreenImage = @"MenuScreen_iPhone.png";
        settingImage = @"Setting_icon_iphone.png";
        helpImage = @"Help_icon_iphone.png";
        snapshotImage = @"Snapshot_icon_iphone.png";
        supportImage = @"FB-icon-iPhone.png";
        leaderboardImage = @"LB_icon_iphone.png";
    }
    else
    {
        menuScreenImage = @"Menu_pannel.png";
        settingImage = @"Setting-icon.png";
        helpImage = @"Help-icon.png";
        snapshotImage = @"Snapshot-icon.png";
        supportImage = @"FB-icon.png";
        leaderboardImage = @"LB-icon.png";
    }
    menuScreen = [CCSprite spriteWithFile:menuScreenImage];
    CGSize menuScreenBgSize = menuScreen.contentSize;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        y_pos = menuScreenBgSize.height/1.4;
        y_offset_iphone = 8;
    }
    else
    {
        y_pos = menuScreenBgSize.height/1.2;
        y_offset_iphone = 14;
    }
    [menuScreen setPosition:ccp(s.width+menuScreenBgSize.width/2, y_pos)];
    menuScreen.tag = MENU_BG_TAG;
    [self addChild:menuScreen z:MENU_BUTTON];
    
    closeItem = [CCMenuItemImage itemWithNormalImage:@"close-icon.png" selectedImage:@"close-icon.png" target:self selector:@selector(menuButtonAction:)];
    closeItem.tag = CLOSE_BUTTON_TAG;
    closeItem.position = ccp(menuScreenBgSize.width/4, closeItem.contentSize.height*1.7);
    
    CCMenuItemImage *settingsItem = [CCMenuItemImage  itemWithNormalImage:settingImage selectedImage:settingImage target:self selector:@selector(settingsButtonAction:)];
    float y_offset = menuScreenBgSize.height/5;
    float x_pos = menuScreenBgSize.width/1.5;
    settingsItem.position = ccp(x_pos, y_offset);
    
    CCMenuItemImage *leaderboardItem = [CCMenuItemImage itemWithNormalImage:leaderboardImage selectedImage:leaderboardImage target:self selector:@selector(leaderboardButtonAction:)];
    y_offset += settingsItem.contentSize.height/2+leaderboardItem.contentSize.height/2+y_offset_iphone;
    leaderboardItem.position = ccp(x_pos, y_offset);
    
    CCMenuItemImage *helpItem = [CCMenuItemImage itemWithNormalImage:helpImage selectedImage:helpImage target:self selector:@selector(helpButtonAction:)];
    y_offset += leaderboardItem.contentSize.height/2+helpItem.contentSize.height/2+y_offset_iphone;
    helpItem.position = ccp(x_pos, y_offset);
    
    fbItem = [CCMenuItemImage itemWithNormalImage:supportImage selectedImage:supportImage target:self selector:@selector(fbRequestButtonAction:)];
    y_offset += helpItem.contentSize.height/2+fbItem.contentSize.height/2+y_offset_iphone;
    fbItem.position = ccp(x_pos, y_offset);
    
    CCMenuItemImage *snapshotItem = [CCMenuItemImage itemWithNormalImage:snapshotImage selectedImage:snapshotImage target:self selector:@selector(snapshotButtonAction:)];
    y_offset += fbItem.contentSize.height/2+snapshotItem.contentSize.height/2+y_offset_iphone;
    snapshotItem.position = ccp(x_pos, y_offset);
    
    CCMenu *mainMenu = [CCMenu menuWithItems:closeItem,settingsItem,leaderboardItem,helpItem,fbItem,snapshotItem, nil];
    mainMenu.position = CGPointZero;
    [menuScreen addChild:mainMenu];
    [self enableFBItemInMenu:NO];
    [self checkRelationWithPlayerTwo];
}

-(void)checkRelationWithPlayerTwo
{
    [[PWFacebookHelper sharedInstance] setDelegate:self];
    [[PWFacebookHelper sharedInstance] getRelationShipWithPlayerTwo];
}

-(void)relationShipRetrieved:(BOOL)isFriend
{
    [self enableFBItemInMenu:!isFriend];
}

-(void)enableFBItemInMenu:(BOOL)isEnabled
{
    if (fbItem)
    {
        [fbItem setIsEnabled:isEnabled];
        if (isEnabled)
        {
            [fbItem setOpacity:255];
        }
        else
        {
            [fbItem setOpacity:150];
        }
    }
}

-(void)createMenuLayer
{
    float menuLayerHeight,menuLayerWidth;
    CGSize s = [[CCDirector sharedDirector] winSize];
    CGPoint pos;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        menuLayerHeight = MENU_LAYER_HEIGHT_IPHONE;
        menuLayerWidth = 100;
        pos = ccp(s.width-menuLayerWidth, CHARACTER_MENU_HEIGHT_IPHONE*1.6);
    }
    else
    {
        menuLayerHeight = MENU_LAYER_HEIGHT_IPAD;
        menuLayerWidth = s.width;
        pos = ccp(0,0);
    }
    
    PWMenuLayer *mLayer = [PWMenuLayer layerWithColor:ccc4(255, 0, 0, 0) width:menuLayerWidth height:menuLayerHeight];
    [mLayer setPosition:pos];
    [self addChild:mLayer z:MENU_LAYER];
    self.menuLayer = mLayer;
}

-(void)createHudLayer
{
    float hudLayerHeight;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        hudLayerHeight = HUD_LAYER_HEIGHT_IPHONE;
    }
    else
    {
        hudLayerHeight = HUD_LAYER_HEIGHT_IPAD;
    }
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    PWHudLayer *hud = [PWHudLayer layerWithColor:ccc4(255, 255, 255, 0) width:s.width height:hudLayerHeight];
    [hud setPosition:ccp(0, s.height-hudLayerHeight)];
    [self addChild:hud z:HUD_LAYER];
    self.hudLayer = hud;
}

-(void)createWordBoard
{
    CGSize s = _panZoomLayer.contentSize;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        rowWidth = TILE_WIDTH_IPHONE;
        rowHeight = TILE_HEIGHT_IPHONE;
        startPoint = ccp((s.width-numberOfColumns*rowWidth)/2, s.height-TILE_Y_OFFSET_IPHONE/2-((MAX_NUMBER_ROWS_ALLOWED-numberOfRows)*rowHeight/2));
    }
    else
    {
        rowWidth = TILE_WIDTH;
        rowHeight = TILE_HEIGHT;
        startPoint = ccp((s.width-numberOfColumns*rowWidth)/2, s.height-TILE_Y_OFFSET/2-((MAX_NUMBER_ROWS_ALLOWED-numberOfRows)*rowHeight/2));
    }
    
    for (int i=0; i<numberOfRows; i++)
    {
        CGPoint refPoint = CGPointMake(startPoint.x+rowWidth/2, startPoint.y-rowHeight*numberOfRows+rowHeight/2+i*rowHeight);
        
        for (int j=0; j<numberOfColumns; j++)
        {
            
            CCSprite *tile = [CCSprite spriteWithFile:@"Tile_Normal.png"];
            [tile setPosition:CGPointMake(refPoint.x+j*rowWidth, refPoint.y)];
            [_panZoomLayer addChild:tile z:1];
            
        }
    }
}
/*
-(void)drawWordBoard
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    CCDrawNode *draw = [[CCDrawNode alloc] init];
    [self addChild:draw z:10];
    [draw release];
    int initialOffset = 24;
    rowWidth = (s.width-initialOffset)/numberOfColumns;
    rowHeight =(s.height-initialOffset)/numberOfRows;
    
    startPoint = ccp(initialOffset/2, s.height-initialOffset/2);
    
    CGPoint refPoint = CGPointMake(startPoint.x+rowWidth/2, startPoint.y-rowHeight*numberOfRows);
    
    for (int i=0; i<=numberOfRows; i++)
    {
        [draw drawSegmentFrom:ccp(refPoint.x, rowHeight*i+refPoint.y) to:ccp(refPoint.x+rowWidth*numberOfColumns, rowHeight*i+refPoint.y) radius:2 color:ccc4f(0, 0, 0, 1)];
    }

    for (int i=0; i<=numberOfColumns; i++)
    {
        [draw drawSegmentFrom:ccp(rowWidth*i+refPoint.x, refPoint.y) to:ccp(rowWidth*i+refPoint.x, refPoint.y+rowHeight*numberOfRows) radius:2 color:ccc4f(0, 0, 0, 1)];
    }
}
*/
-(void)createCharacterMenuForIPhone
{
        
    CGSize size = [[CCDirector sharedDirector] winSize];
    float x_pos = 0;
    
    NSMutableArray *alphabetsArray =[[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    int alphabetCount = [alphabetsArray count];
    int numberOfCharactersDisplayedOnce;
    
    for (int i = 0; i<alphabetCount; i++)
    {
        CCSprite *tile = [CCSprite spriteWithFile:@"Tile_Small.png"];
        CGSize tileSize = tile.contentSize;
        if (!x_pos)
        {
            if (IS_IPHONE5)
            {
                x_pos = (size.width-21.5*(tileSize.width+1))/2;
                numberOfCharactersDisplayedOnce = 15;
            }
            else
            {
                x_pos = (size.width-18.3*(tileSize.width+1))/2;
                numberOfCharactersDisplayedOnce = 13;
            }
            
        }
        
        PWCharacter *character = [PWCharacter layerWithColor:ccc4(25, 100, 50, 0) width:tileSize.width height:tileSize.height];
        character.pos_index = i;
        character.tag = CHARACTER_MENU_CHAR_BASE_TAG+i;
        character.position = ccp(x_pos,CHARACTER_MENU_HEIGHT_IPHONE/4);
        character.isMovable = NO;
        character.alphabet = [alphabetsArray objectAtIndex:i];
        
        [tile setPosition:CGPointMake(tileSize.width/2, tileSize.height/2)];
        [tile setTag:9];
        [character addChild:tile z:10];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:[alphabetsArray objectAtIndex:i] fontName:GLOBAL_FONT fontSize:30*scaleFactor];
        label.tag = 10;
        label.position = ccp(tileSize.width/2, tileSize.height/2);
        label.color = ccWHITE;
        [character addChild:label z:11];
        
        [self addChild:character z:51];
        x_pos+=tileSize.width+5;
        if (i>numberOfCharactersDisplayedOnce)
        {
            character.visible = NO;
        }
    }
    
    
    CCSprite *normalSprite = [CCSprite spriteWithFile:@"Arrow-Z.png"];
    
    
    moreButton = [CCMenuItemSprite itemWithNormalSprite:normalSprite selectedSprite:nil target:self selector:@selector(moreButtonAction:)];
    moreButton.position = ccp(size.width-moreButton.contentSize.width/2, CHARACTER_MENU_HEIGHT_IPHONE/1.5f);
    moreButton.tag = 0;
//    moreButton.color = ccRED;
//    CCLayerColor *layer=[CCLayerColor layerWithColor:ccc4(255, 0, 0, 255) width:moreButton.contentSize.width height:moreButton.contentSize.height];
//    //layer.anchorPoint = ccp(0.5f, 0.5f);
//    layer.position = ccp(moreButton.position.x-moreButton.contentSize.width/2, moreButton.position.y-moreButton.contentSize.height/2);
//    [self addChild:layer z:56];
    
    CCMenu *moreMenu = [CCMenu menuWithItems:moreButton, nil];
    moreMenu.position = CGPointZero;
    [self addChild:moreMenu z:55];
    
    [alphabetsArray release];
}

-(void)createCharacterMenuForIPad
{
        
    CGSize size = [[CCDirector sharedDirector] winSize];

    float x_pos = 0;
    
    NSMutableArray *alphabetsArray =[[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    int alphabetCount = [alphabetsArray count];
    for (int i = 0; i<alphabetCount; i++)
    {
        CCSprite *tile = [CCSprite spriteWithFile:@"Tile_Small.png"];
        CGSize tileSize = tile.contentSize;
        if (!x_pos)
        {
            x_pos = (size.width-alphabetCount*(tileSize.width+1))/2;
        }
        
        PWCharacter *character = [PWCharacter layerWithColor:ccc4(25, 100, 50, 0) width:tileSize.width height:tileSize.height];
        character.pos_index = i;
        character.tag = CHARACTER_MENU_CHAR_BASE_TAG+i;
        character.position = ccp(x_pos,MENU_LAYER_HEIGHT_IPAD);
        character.isMovable = NO;
        character.alphabet = [alphabetsArray objectAtIndex:i];
        
        [tile setPosition:CGPointMake(tileSize.width/2, tileSize.height/2)];
        [tile setTag:9];
        [character addChild:tile z:10];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:[alphabetsArray objectAtIndex:i] fontName:GLOBAL_FONT fontSize:30];
        label.tag = 10;
        label.position = ccp(tileSize.width/2, tileSize.height/2);
        label.color = ccWHITE;
        [character addChild:label z:11];
        [self addChild:character z:CHARACTER_MENU];
        x_pos+=tileSize.width+1;
        
    }
    [alphabetsArray release];
}

-(void)moreButtonAction:(id)sender
{
    //CCMenuItemSprite *moreButton = (CCMenuItemSprite *)sender;
    
    [[SimpleAudioEngine sharedEngine] playEffect:BACK_BUTTON_CLICKED];
    
    int tag = moreButton.tag;
    float x_pos=0;
    CGSize size = [[CCDirector sharedDirector] winSize];
    int numberOfcharactersTobeDisplayedOnce;
    if (IS_IPHONE5)
    {
        numberOfcharactersTobeDisplayedOnce = 15;
    }
    else
    {
        numberOfcharactersTobeDisplayedOnce = 13;
    }
    float x_pos_multiplier;
    BOOL isVisible = NO;
    if (tag)
    {
        CCSprite *normalSprite = [CCSprite spriteWithFile:@"Arrow-Z.png"];
        [sender setNormalImage:normalSprite];
        if (IS_IPHONE5)
        {
            x_pos_multiplier = 21.5;
        }
        else
            x_pos_multiplier = 18.3;
        
    }
    else
    {
        CCSprite *normalSprite = [CCSprite spriteWithFile:@"Arrow-A.png"];
        [sender setNormalImage:normalSprite];
        if (IS_IPHONE5)
        {
            x_pos_multiplier = 44.6;
        }
        else
            x_pos_multiplier = 46;
        isVisible = YES;
    }
    moreButton.tag = !tag;
    for (int i = 0; i<26; i++)
    {
        PWCharacter *character = (PWCharacter *)[self getChildByTag:CHARACTER_MENU_CHAR_BASE_TAG+i];
        
        CCSprite *tile = (CCSprite *)[character getChildByTag:9];
        CGSize tileSize = tile.contentSize;
        if (!x_pos)
        {
            x_pos = (size.width-x_pos_multiplier*(tileSize.width+1))/2;
        }
        character.position = ccp(x_pos,character.position.y);
        x_pos+=tileSize.width+5;
        if (i>numberOfcharactersTobeDisplayedOnce)
        {
            [character setVisible:isVisible];
        }
        else
        {
            //[character setVisible:!isVisible];
        }
    }
    
}


-(void)createCoverLayer
{
    coverLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 0)];
    [self addChild:coverLayer z:SELECTED_ALPHABET];
    
    CGSize size = coverLayer.contentSize;
    
    CGPoint star[] = {{startPoint.x , startPoint.y-numberOfRows*rowHeight },
                        {startPoint.x+numberOfColumns*rowWidth, startPoint.y-numberOfRows*rowHeight},
                        {startPoint.x+numberOfColumns*rowWidth,startPoint.y},{startPoint.x,startPoint.y},
                        };
    CCDrawNode *draw = [[CCDrawNode alloc] init];
    [coverLayer addChild:draw z:1];
    [draw release];
    
    [draw drawPolyWithVerts:star count:sizeof(star)/sizeof(star[0]) fillColor:ccc4f(9.0f/255.0f, 44.0f/255.0f, 2.0f/255.0f, 1.0f) borderWidth:2 borderColor:ccc4f(0,0 , 0, 1.0f)];
    NSString *msg = [NSString stringWithFormat:@"Waiting for %@'s move !",[[[PWGameController sharedInstance] dataManager] player2_name]];
    
    CCLabelTTF *messageLabel = [CCLabelTTF labelWithString:msg fontName:GLOBAL_FONT fontSize:30*scaleFactor dimensions:CGSizeMake(size.width/4, size.height/4) hAlignment:kCCTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap];
    messageLabel.position = CGPointMake(9.5*size.width/16, 10*size.height/16);
    messageLabel.tag = 10;
    //messageLabel.color = ccBLACK;
    [coverLayer addChild:messageLabel z:2];
    
    CCSprite *junkie = [CCSprite spriteWithFile:@"MrJunkie.png"];
    junkie.position = ccp(startPoint.x+junkie.contentSize.width/2,startPoint.y-numberOfRows*rowHeight+junkie.contentSize.height/2);
    [coverLayer addChild:junkie z:2];
}

-(void)setCoverLayerMessageVisible:(BOOL)isVisible
{
    CCLabelTTF *messageLabel = (CCLabelTTF *)[coverLayer getChildByTag:10];
    [messageLabel setVisible:isVisible];
}


-(void)createSubmittingScreen
{
    hudLayer.isBackButtonEnabled = NO;
    CGSize size = coverLayer.contentSize;
    CCLabelTTF *messageLabel = (CCLabelTTF *)[coverLayer getChildByTag:10];
    [messageLabel setString:@"Submitting..."];
    
    indicatorView  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView setCenter:CGPointMake(9.5*size.width/16, 5.5*size.height/16)];
    [[[CCDirector sharedDirector] view] addSubview:indicatorView];
    [indicatorView release];
    [indicatorView startAnimating];
}

-(void)removeSubmittingScreen
{
    hudLayer.isBackButtonEnabled = YES;
    [[[PWGameController sharedInstance] dataManager] setDelegate:nil];
    CCLabelTTF *messageLabel = (CCLabelTTF *)[coverLayer getChildByTag:10];
    NSString *msg = [NSString stringWithFormat:@"Waiting for %@'s move !",[[[PWGameController sharedInstance] dataManager] player2_name]];
    NSLog(@"msg=%@",msg);
    [messageLabel setString:msg];
    
    [indicatorView stopAnimating];
    
    if (![[PWGameController sharedInstance] tutorialStatus])
    {
        [self setCoverLayerVisible:NO];
        [[PWGameController sharedInstance] setNextTutorialStep:kCompleted];
        [[PWGameController sharedInstance] setTutorialStatus:1];
        [[[PWGameController sharedInstance] tutorialManager] showTutorialStep:[[PWGameController sharedInstance] nextTutorialStep]];
        [[PWGameController sharedInstance] performSelector:@selector(releaseTutorialManager) withObject:nil afterDelay:2.0];
    }
}

-(void)setCoverLayerVisible:(BOOL)isVisible
{
    if (coverLayer)
    {
        if (isVisible && _panZoomLayer.scale>1.0f)
        {
            [self layerPanZoom:_panZoomLayer clickedAtPoint:_panZoomLayer.position tapCount:2];
        }
        
        [coverLayer setVisible:isVisible];
    }
    else
    {
        [self createCoverLayer];
    }
    [self enableScrolling:!isVisible];
}

#pragma mark -
#pragma mark -- Button Actions --
#pragma mark -

-(void)menuButtonAction:(id)sender
{
    CCMenuItemImage *item = (CCMenuItemImage *)sender;
    [item setIsEnabled:NO];
    if (item.tag==MENU_BUTTON_TAG)
    {
        [self showMenuScreen:YES withAnimation:YES];
    }
    else
    {
        [self showMenuScreen:NO withAnimation:YES];
    }
}


-(void)settingsButtonAction:(id)sender
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEMS_CLICKED];
    [[[PWGameController sharedInstance] dataManager] setDelegate:nil];
    [[PWFacebookHelper sharedInstance] setDelegate:nil];
    [[PWGameController sharedInstance].dataManager updateTimeLeftForTheRunningGame:[[PWGameLogicLayer sharedInstance] timeLeft]];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    //[[PWGameController sharedInstance].dataManager saveSessionLocally];
    //[[PWGameController sharedInstance].dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
    [[PWGameController sharedInstance] setPreviousScreenCode:kGameLayer];
    [[PWGameController sharedInstance] switchToLayerWithCode:kSettingsView];
    [[PWGameController sharedInstance] cleanGameScene];
}

-(void)helpButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEMS_CLICKED];
    [[[PWGameController sharedInstance] dataManager] setDelegate:nil];
    [[PWFacebookHelper sharedInstance] setDelegate:nil];
    [[PWGameController sharedInstance].dataManager updateTimeLeftForTheRunningGame:timeLeft];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[PWGameController sharedInstance] setPreviousScreenCode:kGameLayer];
    [[PWGameController sharedInstance] switchToLayerWithCode:kHelpView];
    [[PWGameController sharedInstance] cleanGameScene];
}


-(void)leaderboardButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEMS_CLICKED];
    [[[PWGameController sharedInstance] dataManager] setDelegate:nil];
    [[PWFacebookHelper sharedInstance] setDelegate:nil];
    [[PWGameController sharedInstance].dataManager updateTimeLeftForTheRunningGame:timeLeft];

    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    //[[PWGameController sharedInstance].dataManager saveSessionLocally];
    //[[PWGameController sharedInstance].dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
    [[PWGameController sharedInstance] setPreviousScreenCode:kGameLayer];
    [[PWGameController sharedInstance] switchToLayerWithCode:kLeaderboard];
    [[PWGameController sharedInstance] cleanGameScene];
}


-(void)snapshotButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEMS_CLICKED];
    [[PWGameController sharedInstance].dataManager updateTimeLeftForTheRunningGame:timeLeft];
    //[[PWGameController sharedInstance].dataManager saveSessionLocally];
    //[[PWGameController sharedInstance].dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
	[self showMenuScreen:NO withAnimation:NO];
    [self performSelector:@selector(takeSnapShot) withObject:nil afterDelay:0.1];
}

-(void)takeSnapShot
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (screenShot)
	{
		[screenShot release];
		screenShot =nil;
	}
	screenShot = [[CCDirector sharedDirector] screenshotUIImage];
    
    if (screenShot)
	{
		PWSnapShotFlash *snapShotFlashView = [[PWSnapShotFlash alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height+20)];
        
        AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
        [app.navController.view addSubview:snapShotFlashView];
		[snapShotFlashView startFlashEffect];
		[snapShotFlashView release];
    }
    else
    {
        NSLog(@"It's not written...");
    }
	[pool release];
}

-(void)shareSnapshot
{
    [[PWFacebookHelper sharedInstance] setDelegate:self];
    [[PWFacebookHelper sharedInstance] shareSnapshot:screenShot];
}

-(void)snapshotSharedToTheWall
{
    if (screenShot)
    {
        [screenShot release];
        screenShot = nil;
    }
}

-(UIImage*)getScreenShot
{
    return screenShot;
}

-(void)fbRequestButtonAction:(id)sender
{
    [[[PWGameController sharedInstance] dataManager] setDelegate:nil];
    [[PWGameController sharedInstance].dataManager updateTimeLeftForTheRunningGame:timeLeft];
    //[[PWGameController sharedInstance].dataManager saveSessionLocally];
    //[[PWGameController sharedInstance].dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
    [[PWFacebookHelper sharedInstance] setDelegate:self];
    [[PWFacebookHelper sharedInstance] sendFriendRequest];
}




#pragma mark -
#pragma mark -- Game Scheduler --
#pragma mark -

-(void)refreshGame:(ccTime)delta
{
    
   // NSLog(@"refreshTimer=%d",refreshTimer);
    
    //NSLog(@"refreshTimer=%d",refreshTimer);
    if (turnIndicator==kPlayerTwoTurn)
    {
        if (!(--refreshTimer))
        {
           // [self refresh];
            [self performSelectorOnMainThread:@selector(refresh) withObject:nil waitUntilDone:NO];
            refreshTimer = 30;
            //[hudLayer setTimerVisible:YES];
        }
    }
    else if (turnIndicator==kPlayerOneTurn && timeLeft && [[PWGameController sharedInstance] tutorialStatus])
    {
        --timeLeft;
        [hudLayer updateTimer:timeLeft];
        if (!timeLeft)
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            //[self unschedule:@selector(refreshGame:)];
            [self passTheMoveOnTimerZero];
        }
        else if(timeLeft == 59)
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:CLOCK_TICKING loop:NO];
        }
        else if(timeLeft == 54)
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        else if(timeLeft == 30)
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:CLOCK_TICKING loop:NO];
        }
        else if(timeLeft == 24)
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        else if(timeLeft == 10)
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:CLOCK_TICKING loop:YES];
        }
    }
   
    if (gameState==kGameOver)
    {
        [self unschedule:@selector(refreshGame:)];
    }
}

#pragma mark -
#pragma mark -- Game Refresher Logic --
#pragma mark -

-(void)refresh
{
    refreshTimer = 30;
    PWDataManager *dataManager = [[PWGameController sharedInstance] dataManager];
    
    BOOL isSuccess=[[[PWGameController sharedInstance] dataManager] readSessionFromTheServer];
    if (!isSuccess)
    {
        NSLog(@"readSessionFromTheServer ..... FAILED");
        return;
    }
    NSMutableDictionary *sessionDict = [[[PWGameController sharedInstance] dataManager] sessionInfo];
    NSString *newAlphabet = [sessionDict objectForKey:NEW_ALPHABET];
    NSString *newIndex = [sessionDict objectForKey:NEW_INDEX];
    if (newAlphabet!=NULL && ![[dataManager gameDataDict] objectForKey:newIndex])
    {
        [self createCharacter:newAlphabet atIndex:newIndex];
        int latestMyScore = [[[sessionDict objectForKey:dataManager.player1] objectForKey:MY_SCORE] intValue];
        int latestOpponentScore = [[[sessionDict objectForKey:dataManager.player2] objectForKey:MY_SCORE] intValue];
        
        
        int diff = latestMyScore - dataManager.myScore;
        if (diff)
        {
            [hudLayer refreshMyScore:latestMyScore];
            dataManager.myScore = latestMyScore;
        }
        
        diff = latestOpponentScore - dataManager.opponentScore;
        if (diff)
        {
            [hudLayer refreshOpponentScore:latestOpponentScore];
            dataManager.opponentScore = latestOpponentScore;
        }
    }
    else if([[[sessionDict objectForKey:dataManager.player1] objectForKey:TURN] intValue]==turnIndicator)
    {
        return;
    }
    
    
    turnIndicator = [[[sessionDict objectForKey:dataManager.player1] objectForKey:TURN] intValue];
    
        
    if ([[sessionDict objectForKey:dataManager.player1] objectForKey:SKIPP_CHANCE_LEFT])
    {
        [dataManager.player1Dict setObject:[[sessionDict objectForKey:dataManager.player1] objectForKey:SKIPP_CHANCE_LEFT] forKey:SKIPP_CHANCE_LEFT];
    }
    
    if ([[sessionDict objectForKey:dataManager.player2] objectForKey:SKIPP_CHANCE_LEFT])
    {
        [dataManager.player2Dict setObject:[[sessionDict objectForKey:dataManager.player2] objectForKey:SKIPP_CHANCE_LEFT] forKey:SKIPP_CHANCE_LEFT];
    }
    
    
    [menuLayer setButtonsEnabled:NO];
    [menuLayer setPlayButtonEnabled:YES];
    dataManager.gameDataDict = [sessionDict objectForKey:GAME_DATA];
    dataManager.lockedWordList = [sessionDict objectForKey:LOCKED_WORD_LIST];
    currentGameMode = [[sessionDict objectForKey:GAME_MODE] intValue];
    gameState = [[sessionDict objectForKey:GAME_STATE] intValue];
    if ([sessionDict objectForKey:WINNER_ID])
    {
        [dataManager.sessionInfo setObject:[sessionDict objectForKey:WINNER_ID] forKey:WINNER_ID];
    }
    
    if (gameState == kGameRunning)
    {
        timeLeft = [dataManager getTimeLeftForTheRunningGame];
    }
    else if(turnIndicator == kPlayerOneTurn && gameState == kGameOver)
    {
        turnIndicator = kTurnNone;
        [dataManager saveScore];
        [dataManager saveSessionLocally];
        [dataManager writeSessionToTheFile];
        [dataManager removeDocWithDocId:dataManager.doc_Id];
    }

    [self setCoverLayerVisible:NO];
    
    
    if (turnIndicator==kPlayerOneTurn)
    {
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"Your Turn!",ALERT_MESSAGE, nil];
        [[PWGameController sharedInstance].alertManager showTurnAlertWithAlertInfo:alertInfo];
        [hudLayer setTimerVisible:YES];
    }
    else  if (turnIndicator==kTurnNone)
    {
        NSString *message ;
        NSString *winnerID =[sessionDict objectForKey:WINNER_ID];
        if ([winnerID isEqualToString:dataManager.player1])
        {
            message =@"You Won!";
        }
        else if (winnerID.length==0)
        {
            message =@"Tie!";
        }
        else
        {
            NSString *playerName = [[dataManager.player2_name componentsSeparatedByString:@" "] objectAtIndex:0];
            message =[NSString stringWithFormat:@"%@ Won!",playerName];
        }
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"Game Over",ALERT_TITLE,message,ALERT_MESSAGE, nil];
        [[PWGameController sharedInstance].alertManager showTurnAlertWithAlertInfo:alertInfo];
    }
    [hudLayer updateTurnInfoLabel];

}

#pragma mark -
#pragma mark -- Game Resume Logic --
#pragma mark -

-(void)resumeGameFromSession
{
    NSMutableDictionary *gameDataDict = [PWGameController sharedInstance].dataManager.gameDataDict;
    NSArray *keys = [gameDataDict allKeys];
    
    for (NSString *key in keys)
    {
        [self createCharacter:[gameDataDict objectForKey:key] atIndex:key];
    }
}

-(void)createCharacter:(NSString*)alphabet atIndex:(NSString*)indexString
{
    CGPoint index = CGPointFromString(indexString);
    
    PWCharacter *character = [PWCharacter layerWithColor:ccc4(25, 100, 50, 0) width:rowWidth height:rowHeight];
    
    character.position = [self getCorrectCharPositionForTheIndex:index];
    character.isMovable = NO;
    character.isPlaced = YES;
    character.alphabet = alphabet;
    character.tag = [self getCharTagForIndex:index];
    
    
    CCSprite *tile = [CCSprite spriteWithFile:@"Tile_Placed.png"];
    [tile setPosition:CGPointMake(rowWidth/2, rowHeight/2)];
    [tile setTag:9];
    [character addChild:tile z:1];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:alphabet fontName:GLOBAL_FONT fontSize:30*scaleFactor];
    label.tag = [self getCharTagForIndex:index];
    label.position = ccp(rowWidth/2, rowHeight/2);
    label.color = ccWHITE;
    [character addChild:label z:2];
    [_panZoomLayer addChild:character z:10];
}

#pragma mark -
#pragma mark -- Character placement methods --
#pragma mark -

-(void)getSelectedCharFromCharacterMenuWithLetter:(NSString*)letter withPositionINdex:(int)pos_index
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    float x_pos_char_offset,y_pos;
    
    float x_pos_multiplier;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        if (moreButton.tag)
        {
            if (IS_IPHONE5)
            {
                x_pos_multiplier = 44.6;
            }
            else
                x_pos_multiplier = 46;
        }
        else
        {
            if (IS_IPHONE5)
            {
                x_pos_multiplier = 21.5;
            }
            else
                x_pos_multiplier = 18.3;
        }
        x_pos_char_offset = 5;
        y_pos = CHARACTER_MENU_HEIGHT_IPHONE/4;
    }
    else
    {
        x_pos_multiplier = 26;
        x_pos_char_offset = 1;
        y_pos = MENU_LAYER_HEIGHT_IPAD;
    }
    
    CCSprite *tile = [CCSprite spriteWithFile:@"Tile_Small.png"];
    CGSize tileSize = tile.contentSize;
    PWCharacter *replacementChar = [PWCharacter layerWithColor:ccc4(25, 100, 50, 0) width:tileSize.width height:tileSize.height];
    
    float x_pos = (size.width-x_pos_multiplier*(tileSize.width+1))/2;
    
    replacementChar.position = ccp(x_pos+(tileSize.width+x_pos_char_offset)*pos_index, y_pos);
    replacementChar.pos_index= pos_index;
    replacementChar.isMovable = NO;
    replacementChar.alphabet = letter;
    replacementChar.tag = CHARACTER_MENU_CHAR_BASE_TAG+pos_index;
    
    [tile setPosition:CGPointMake(tileSize.width/2, tileSize.height/2)];
    [tile setTag:9];
    [replacementChar addChild:tile z:10];

    
    CCLabelTTF *label = [CCLabelTTF labelWithString:letter fontName:GLOBAL_FONT fontSize:30*scaleFactor];
    label.position = ccp(tileSize.width/2, tileSize.height/2);
    label.color = ccWHITE;
    label.tag = 10;
    [replacementChar addChild:label z:11];
    [self addChild:replacementChar z:51];
    
    [self reorderChild:selectedChar z:SELECTED_ALPHABET];
    
}


-(void)placeTheChar
{
    [self reorderSelectedChar];
    [[PWGameController sharedInstance].dataManager addAlphabet:selectedChar.alphabet atIndex:NSStringFromCGPoint(lastPlacedCharIndex)];
    [selectedChar setOpacity:0];
    selectedChar.isMovable  = NO;
    selectedChar.isPlaced   = YES;
    self.selectedChar = nil;
    lastPlacedCharIndex = ccp(-1, -1);
}

-(void)placeCharacterAtCorrectPlaceOnEndTouchPoint:(CGPoint)touchPoint
{
    lastPlacedCharIndex = [self getIndexForThePosition:touchPoint];
    [self enableScrolling:YES];
    [selectedChar removeFromParent];
    selectedChar.tag = [self getCharTagForIndex:lastPlacedCharIndex];
    [_panZoomLayer addChild:selectedChar];
    if ([self isBeyondTheBoundary:lastPlacedCharIndex])
    {
        [selectedChar removeFromParentAndCleanup:YES];
        selectedChar = nil;
        lastPlacedCharIndex = ccp(-1, -1);
    }
    else if ([self isCharPlaceableAtIndex:lastPlacedCharIndex])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:CHARACTER_PLACED];
        [menuLayer setButtonsEnabled:YES];
        currentGameMode = kSearchMode;
        CGPoint pos = [self getCorrectCharPositionForTheIndex:lastPlacedCharIndex];
        [selectedChar setPosition:pos];
        [self placeTheChar];
    }
    else
    {
        [menuLayer setRecallButtonEnabled:YES];
        [selectedChar startNotPlaceableIndicatorAnimation:YES];
    }
}

-(void)reorderSelectedChar
{
    //CGPoint index = [self getIndexForThePosition:selectedChar.position];
    //int z_order = index.x + index.y+10;
    [self reorderChild:selectedChar z:10];
}

-(int)getCharTagForIndex:(CGPoint)index
{
    return (BASE_TAG_FOR_CHAR+BASE_TAG_FOR_CHAR*index.x+index.y);
}

-(void)resizeTheCharacterToTileSize
{
    [selectedChar setContentSize:CGSizeMake(rowWidth, rowHeight)];
    CCLabelTTF *label = (CCLabelTTF *)[selectedChar getChildByTag:10];
    label.fontSize = 30*scaleFactor;
    //label.scale = 2;
    [label setPosition:ccp(rowWidth/2, rowHeight/2)];
}

-(void)changeTheBgOfCharacter:(CCSprite*)character withBg:(NSString*)bgImage
{
    [character setTextureRect:CGRectMake(0, 0, rowWidth, rowHeight)];
    [character setTexture:[[CCTextureCache sharedTextureCache] addImage:bgImage]];
    [character setPosition:ccp(rowWidth/2, rowHeight/2)];
}

#pragma mark -
#pragma mark -- Game management methods --
#pragma mark -

-(BOOL)isCharPlaceableAtIndex:(CGPoint)index
{
    NSString *key = NSStringFromCGPoint(index);
    if ([[PWGameController sharedInstance].dataManager.gameDataDict objectForKey:key])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


-(BOOL)isBeyondTheBoundary:(CGPoint)index
{
    int x = index.x;
    int y = index.y;
    if ((x>=0 && x<numberOfRows) && (y>=0 && y<numberOfColumns))
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)resetSelectionParameters
{
    for (NSString *index in selectedIndicesArray)
    {
        PWCharacter *character = (PWCharacter *)[_panZoomLayer getChildByTag:[self getCharTagForIndex:CGPointFromString(index)]];
        [character setSelected:NO];
    }
    [selectedIndicesArray removeAllObjects];
    if (selectedPointsArray)
    {
        [selectedPointsArray release];
        selectedPointsArray = nil;
    }
    [self removeChild:selectionLine cleanup:YES];
    selectionLine = nil;
}

-(BOOL)validSelectionCheck:(CGPoint)index
{
    BOOL isValidSelection = NO;
    if ([self isCharPlaceableAtIndex:index])
    {
        //selectionType = kEmpty;
    }
    else if (selectedIndicesArray.count==1)
    {
        CGPoint prevPoint = CGPointFromString([selectedIndicesArray objectAtIndex:0]);
        if ((prevPoint.x == index.x)&&(abs(prevPoint.y - index.y)==1))
        {
            selectionType = kHorizontal;
            isValidSelection = YES;
        }
        else if ((prevPoint.y == index.y)&&(abs(prevPoint.x - index.x)==1))
        {
            selectionType = kVertical;
            isValidSelection = YES;
        }
        else
        {
            selectionType = kNone;
        }
    }
    else if(selectionType == kHorizontal)
    {
        CGPoint prevPoint = CGPointFromString([selectedIndicesArray lastObject]);
        if ((prevPoint.x == index.x)&&(abs(prevPoint.y - index.y)==1))
        {
            isValidSelection = YES;
        }
        else
        {
            selectionType = kNone;
        }
    }
    else if(selectionType == kVertical)
    {
        CGPoint prevPoint = CGPointFromString([selectedIndicesArray lastObject]);
        if ((prevPoint.y == index.y)&&(abs(prevPoint.x - index.x)==1))
        {
            isValidSelection = YES;
        }
        else
        {
            selectionType = kNone;
        }
    }
    
    return isValidSelection;
}

-(BOOL)isWordSelected
{
    if (selectedIndicesArray.count)
    {
        return YES;
    }
    else
        return NO;
}

-(NSString*)constructWordFromTheSelectedNodes
{
    int count = selectedIndicesArray.count;
    if (count==0)
    {
        return nil;
    }
    if (count==1)
    {
        NSMutableString *word = [[[NSMutableString alloc] initWithString:@""] autorelease];
        int tag = [self getCharTagForIndex:CGPointFromString([selectedIndicesArray objectAtIndex:0])];
        PWCharacter *charSprite = (PWCharacter *)[_panZoomLayer getChildByTag:tag];
        [word appendString:charSprite.alphabet];
        return [word lowercaseString];
    }
    
    int arrayTraveller,multiplier=1;
    CGPoint firstPoint = CGPointFromString([selectedIndicesArray objectAtIndex:0]);
    CGPoint endPoint = CGPointFromString([selectedIndicesArray lastObject]);
    /***
     * Deciding the direction of the word in which player did the selection
     */
    if (selectionType == kHorizontal)
    {
        if ((endPoint.y - firstPoint.y)<0)
        {
            arrayTraveller = count-1;
            multiplier = -1;
        }
        else
            arrayTraveller = 0;
    }
    else if (selectionType == kVertical)
    {
        if ((endPoint.x - firstPoint.x)<0)
        {
            arrayTraveller = count-1;
            multiplier = -1;
        }
        else
            arrayTraveller = 0;
    }
    else
    {
        return nil;
    }
    
    /***
     *  Constructing the word
     */
    NSMutableString *word = [[[NSMutableString alloc] initWithString:@""] autorelease];
    
    for (int i=0; i<count; i++,arrayTraveller+=multiplier)
    {
        int tag = [self getCharTagForIndex:CGPointFromString([selectedIndicesArray objectAtIndex:arrayTraveller])];
        PWCharacter *charSprite = (PWCharacter *)[_panZoomLayer getChildByTag:tag];
        [word appendString:charSprite.alphabet];
    }
    
    return [word lowercaseString];
}

-(void)continueWithThisValidWord
{//Valid Word
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    [[SimpleAudioEngine sharedEngine] playEffect:MOVE_CONFIRM];

    [dataManager lockThisWord:dataManager.recentWord];
    
    if (turnIndicator == kPlayerOneTurn)
    {
        
        turnIndicator = kPlayerTwoTurn;
        [hudLayer updateMyScore:dataManager.recentWord.length];
    }
    else
    {
        turnIndicator = kPlayerOneTurn;
        [hudLayer updateOpponentScore:dataManager.recentWord.length];
    }
    timeLeft=TIMER_VALUE;
    [dataManager updateTimeLeftForTheRunningGame:timeLeft];
    currentGameMode = kPlacementMode;
    BOOL isGameOver = [self isGameOverNormally];
    
    if (isGameOver)
    {
        gameState = kGameOver;
        [dataManager.sessionInfo setObject:[menuLayer getWinnerID] forKey:WINNER_ID];
        [dataManager performSelectorInBackground:@selector(saveScore) withObject:nil];
        NSString *resultString;
        if (dataManager.myScore>dataManager.opponentScore)
        {
            resultString = @"You Won";
        }
        else if (dataManager.myScore==dataManager.opponentScore)
        {
            resultString = @"Tie";
        }
        else
        {
            resultString = @"You Lost";
        }
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"No more tiles left!",ALERT_MESSAGE,@"Ok",ALERT_CANCEL_BUTTON_TEXT,@"Snapshot",ALERT_OK_BUTTON_TEXT, nil];
        [PWGameController sharedInstance].alertManager.alertType = kGameOverAlert;
        [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];
        
        [menuLayer setButtonsEnabled:NO];
        [menuLayer setPassButtonEnabled:NO];
        [hudLayer updateTurnInfoLabel];
        [dataManager saveSessionLocally];
        dataManager.sendPush = YES;
        [dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
        
    }
    else
    {
        [self setCoverLayerVisible:YES];
        [[[PWGameController sharedInstance] dataManager] setDelegate:self];
        [self createSubmittingScreen];
        [menuLayer setButtonsEnabled:NO];
        [menuLayer setPassButtonEnabled:NO];
        [hudLayer updateTurnInfoLabel];
        [dataManager saveSessionLocally];
        self.selectedChar = nil;
        dataManager.sendPush = YES;
        [dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
    }
    [hudLayer setTimerVisible:NO];
}

-(void)continueWithThisInvalidWord
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    [[SimpleAudioEngine sharedEngine] playEffect:MOVE_CONFIRM];

    //Invalid Word
    if (turnIndicator == kPlayerOneTurn)
    {
        turnIndicator = kPlayerTwoTurn;
    }
    else
    {
        turnIndicator = kPlayerOneTurn;
    }
    
    timeLeft=TIMER_VALUE;
    [dataManager updateTimeLeftForTheRunningGame:timeLeft];
    currentGameMode = kPlacementMode;
    BOOL isGameOver = [self isGameOverNormally];
    
    if (isGameOver)
    {
        [dataManager.sessionInfo setObject:[menuLayer getWinnerID] forKey:WINNER_ID];
        [dataManager performSelectorInBackground:@selector(saveScore) withObject:nil];
        
        gameState = kGameOver;
        NSString *resultString;
        if (dataManager.myScore>dataManager.opponentScore)
        {
            resultString = @"You Won";
        }
        else if (dataManager.myScore==dataManager.opponentScore)
        {
            resultString = @"Tie";
        }
        else 
        {
            resultString = @"You Lost";
        }
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"No more tiles left!",ALERT_MESSAGE,@"Ok",ALERT_CANCEL_BUTTON_TEXT,@"Snapshot",ALERT_OK_BUTTON_TEXT, nil];
        [PWGameController sharedInstance].alertManager.alertType = kGameOverAlert;
        [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];
        [menuLayer setButtonsEnabled:NO];
        [menuLayer setPassButtonEnabled:NO];
        [hudLayer updateTurnInfoLabel];
        [dataManager saveSessionLocally];
        dataManager.sendPush = YES;
        [dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
        self.selectedChar = nil;

        
    }
    else
    {
        [self setCoverLayerVisible:YES];
        [[[PWGameController sharedInstance] dataManager] setDelegate:self];
        [self createSubmittingScreen];
        [menuLayer setButtonsEnabled:NO];
        [menuLayer setPassButtonEnabled:NO];
        [hudLayer updateTurnInfoLabel];
        [dataManager saveSessionLocally];
        dataManager.sendPush = YES;
        [dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
        self.selectedChar = nil;
    }
    [hudLayer setTimerVisible:NO];
}


-(void)passTheMoveOnTimerZero
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    if (turnIndicator==kPlayerTwoTurn)
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
        [self passTheMove];
    }
    else
    {
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,[NSString stringWithFormat:@"Move passed to %@!",dataManager.player2_name],ALERT_MESSAGE,@"OK",ALERT_CANCEL_BUTTON_TEXT, nil];
        [PWGameController sharedInstance].alertManager.alertType = kPassTurnAlert;
        [[PWGameController sharedInstance].alertManager showOneButtonAlertWithInfo:alertInfo];
    }
}

-(void)passTheMove
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    PWDataManager *dataManager=[PWGameController sharedInstance].dataManager;
    [[SimpleAudioEngine sharedEngine] playEffect:MOVE_CONFIRM];

    BOOL isGameOver = NO;
    int skipChanceLeftForMe = [[[dataManager player1Dict] objectForKey:SKIPP_CHANCE_LEFT] intValue];
    if (!skipChanceLeftForMe)
    {
        isGameOver = YES;
    }
    else
    {
        [[dataManager player1Dict] setObject:[NSNumber numberWithInt:skipChanceLeftForMe-1] forKey:SKIPP_CHANCE_LEFT];
    }
    
    if (turnIndicator == kPlayerOneTurn)
    {
        turnIndicator = kPlayerTwoTurn;
    }
    else
    {
        turnIndicator = kPlayerOneTurn;
    }
    
    timeLeft=TIMER_VALUE;
    [dataManager updateTimeLeftForTheRunningGame:timeLeft];
    currentGameMode = kPlacementMode;
    [menuLayer setButtonsEnabled:NO];
    [menuLayer setPassButtonEnabled:NO];
    [self resetSelectionParameters];
    
    
    if (self.selectedChar)
    {
        [menuLayer recallButtonClicked:nil];
    }
    
    if (isGameOver)
    {
        [self setGameState:kGameOver];
        
        [dataManager.sessionInfo setObject:dataManager.player2 forKey:WINNER_ID];
        [dataManager performSelectorInBackground:@selector(saveScore) withObject:nil];
        NSDictionary *alertInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"",ALERT_TITLE,@"You lost!",ALERT_MESSAGE,@"Ok",ALERT_CANCEL_BUTTON_TEXT,@"Snapshot",ALERT_OK_BUTTON_TEXT, nil];
        [PWGameController sharedInstance].alertManager.alertType = kGameOverAlert;
        [[PWGameController sharedInstance].alertManager showTwoButtonAlertWithInfo:alertInfo];
        [hudLayer updateTurnInfoLabel];
        [dataManager saveSessionLocally];
        dataManager.sendPush = YES;
        [dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
    }
    else
    {
        [self setCoverLayerVisible:YES];
        [[[PWGameController sharedInstance] dataManager] setDelegate:self];
        [self createSubmittingScreen];
        [hudLayer updateTurnInfoLabel];
        [dataManager saveSessionLocally];
        dataManager.sendPush = YES;
        [dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
        
    }
    [hudLayer setTimerVisible:NO];
        
}

-(void)quitFromTheRunningGame
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    gameState = kGameOver;
    if (turnIndicator == kPlayerOneTurn)
    {
        turnIndicator = kPlayerTwoTurn;
    }
    else
    {
        turnIndicator = kPlayerOneTurn;
    }
    
    
    [menuLayer setButtonsEnabled:NO];
    [menuLayer setPassButtonEnabled:NO];
    [self resetSelectionParameters];
    PWDataManager *dataManager = [PWGameController sharedInstance].dataManager;
    
    [dataManager performSelectorInBackground:@selector(saveScore) withObject:nil];
    [dataManager.sessionInfo setObject:dataManager.player2 forKey:WINNER_ID];
    NSLog(@"dataManager.player2=%@",dataManager.player2);
    NSLog(@"dataManager.sessionInfo=%@",dataManager.sessionInfo);
    [dataManager saveSessionLocally];
    dataManager.sendPush = YES;
    [dataManager performSelectorInBackground:@selector(writeSessionToTheServer) withObject:nil];
    [hudLayer setTimerVisible:NO];
    [hudLayer updateTurnInfoLabel];
    
}

-(BOOL)isGameOverNormally
{
    PWDataManager *dataManager = [PWGameController sharedInstance].dataManager;
    int count = dataManager.gameDataDict.count;
    
    if (count>= numberOfRows*numberOfColumns)
    {
        [self setGameState:kGameOver];
        return YES;
    }
    else
    {
        return NO;
    }
}


-(void)drawSelectedNodes:(CGPoint)spoint
{
    if (!selectedPointsArray)
    {
        selectedPointsArray = [[NSMutableArray alloc] initWithObjects:NSStringFromCGPoint(spoint), nil];
        
    }
    else
    {
        [selectedPointsArray addObject:NSStringFromCGPoint(spoint)];
    }
    int count = selectedPointsArray.count;
    
    
    if (selectionLine)
    {
        [self removeChild:selectionLine cleanup:YES];
        selectionLine = nil;
    }
    
    selectionLine = [[CCDrawNode alloc] init];
    [self addChild:selectionLine z:99];
    [selectionLine release];
    
    CGPoint lineStartPoint = CGPointFromString([selectedPointsArray objectAtIndex:0]);
    
    CGPoint lineEndPoint = CGPointFromString([selectedPointsArray lastObject]);
    
    if (count<2)
    {
        [selectionLine drawDot:lineStartPoint radius:6 color:ccc4f(1, 0, 0, 1)];
    }
    else
    {
        [selectionLine drawSegmentFrom:lineStartPoint to:lineEndPoint radius:4 color:ccc4f(1, 0, 0, 1)];
    }
    
}


-(void)selectTheChar:(CGPoint)index
{
    PWCharacter *character = (PWCharacter *)[_panZoomLayer getChildByTag:[self getCharTagForIndex:index]];
    [character setSelected:YES];
}


#pragma -----
#pragma mark -- Word Verification Methods --
#pragma -----



-(BOOL) isDictionaryWord:(NSString*) word
{
    return [[[PWGameController sharedInstance] dataManager].wordList isWord:word];
}

-(BOOL)isValidWordSelection
{
    //NSLog(@"[[[PWGameController sharedInstance] dataManager] index]=%@",[[[PWGameController sharedInstance] dataManager] index]);
    if ([selectedIndicesArray containsObject:[[[PWGameController sharedInstance] dataManager] index]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


-(BOOL)isLockedWord:(NSString*) word
{
    BOOL isLocked = NO;
    for (NSString *obj in [PWGameController sharedInstance].dataManager.lockedWordList)
    {
        if ([word isEqualToString:obj])
        {
            isLocked = YES;
            break;
        }
    }
    return isLocked;
}

#pragma mark -
#pragma mark -- Index Calculation Methods --
#pragma mark -

-(CGPoint)getIndexForThePosition:(CGPoint)point
{
    CGPoint index = CGPointMake(0, 0);    
    index.y = (int)((point.x - startPoint.x)/(rowWidth));
    index.x = (int)((startPoint.y - point.y)/(rowHeight));
    
    return index;
}

-(CGPoint)getCorrectCharPositionForTheIndex:(CGPoint)index
{
    CGPoint pos = CGPointMake(0, 0);
    pos.x = startPoint.x+(rowWidth)*index.y;
    pos.y = startPoint.y-((rowHeight)*(index.x+1));
    return pos;
}


#pragma mark -
#pragma mark -- Touch_events --
#pragma mark -

//touch began handles the all the objects Touch events n respective actions logic.
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent*)event
{
    //NSLog(@"%s",__FUNCTION__);
    UITouch *touch = [touches anyObject];
   	CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
	CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	spoint = [_panZoomLayer convertToNodeSpace:spoint];
    
    //NSLog(@"spoint = %@",NSStringFromCGPoint(spoint));
    CGPoint index = [self getIndexForThePosition:spoint];
    NSLog(@"index = %@",NSStringFromCGPoint(index));
    
    
    //CGPoint pos = [self getCorrectCharPositionForTheIndex:index];
    //NSLog(@"position = %@",NSStringFromCGPoint(pos));
    
}


-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"%s",__FUNCTION__);
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
   	CGPoint  point = [touch locationInView:[[CCDirector sharedDirector] view]];
	CGPoint spoint = [[CCDirector sharedDirector] convertToGL:point];
	spoint = [_panZoomLayer convertToNodeSpace:spoint];
    
    if (currentGameMode == kPlacementMode && isCharacterSelected)
    {
        [self placeCharacterAtCorrectPlaceOnEndTouchPoint:spoint];
        isCharacterSelected = NO;
    }
    else if (currentGameMode == kSearchMode)
    {
        CGPoint index = [self getIndexForThePosition:spoint];
        if (selectedIndicesArray.count<1 && ![self isCharPlaceableAtIndex:index])
        {
            [selectedIndicesArray addObject:NSStringFromCGPoint(index)];
            [self selectTheChar:index];
            if (![[PWGameController sharedInstance] tutorialStatus])
            {
                [[[PWGameController sharedInstance] tutorialManager] setTutorialElementsVisible:NO];
                [[PWGameController sharedInstance] setNextTutorialStep:kClickOnPlay];
                [[[PWGameController sharedInstance] tutorialManager] showTutorialStep:[[PWGameController sharedInstance] nextTutorialStep]];
            }
        }
        else if([self validSelectionCheck:index] && (![selectedIndicesArray containsObject:NSStringFromCGPoint(index)]))
        {
            [selectedIndicesArray addObject:NSStringFromCGPoint(index)];
            [self selectTheChar:index];
        }
        else if(![self isCharPlaceableAtIndex:index])
        {
            [self removeChild:selectionLine cleanup:YES];
            selectionLine = nil;
            [self resetSelectionParameters];
        }
        NSLog(@"selectedIndicesArray=%@",selectedIndicesArray);
    }
}

#pragma mark -
#pragma mark -- CCLayerPanZoom Delegates --
#pragma mark -

-(void)enableScrolling:(BOOL)isScollingEnabled
{
    _panZoomLayer.isScrollingEnabled = isScollingEnabled;
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender  clickedAtPoint: (CGPoint) point tapCount: (NSUInteger) tapCount
{
   // NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ clickedAtPoint: { %f, %f }", sender, point.x, point.y);
    
    if (tapCount == 2 && !coverLayer.visible)
    {
        float midScale = (sender.minScale + sender.maxScale) / 2.0;
        float newScale = (sender.scale <= midScale) ? sender.maxScale : sender.minScale;
        //NSLog(@"midScale=%f....newScale=%f",midScale,newScale);
        CGFloat deltaX = (point.x - sender.anchorPoint.x * sender.contentSize.width) * (newScale - sender.scale);
        CGFloat deltaY = (point.y - sender.anchorPoint.y * sender.contentSize.height) * (newScale - sender.scale);
        CGPoint position = ccp(sender.position.x - deltaX, sender.position.y - deltaY);
        
        [sender runAction: [CCSpawn actions:
                            [CCScaleTo actionWithDuration:0.4 scale:newScale],
                            [CCMoveTo actionWithDuration:0.4 position:position],
                            nil]];
    }
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender touchPositionUpdated: (CGPoint) newPos
{
    //NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ touchPositionUpdated: { %f, %f }", sender, newPos.x, newPos.y);
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender touchMoveBeganAtPosition: (CGPoint) aPoint
{
    //NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ touchMoveBeganAtPosition: { %f, %f }", sender, aPoint.x, aPoint.y);
}

-(void)removeGameObjects
{
    NSLog(@"%s",__FUNCTION__);
    [hudLayer removeAllChildrenWithCleanup:YES];
    [hudLayer removeFromParentAndCleanup:YES];
    hudLayer =nil;
    
    [menuLayer removeAllChildrenWithCleanup:YES];
    [menuLayer removeFromParentAndCleanup:YES];
    menuLayer = nil;
    
    [_panZoomLayer removeAllChildrenWithCleanup:YES];
    [_panZoomLayer removeFromParentAndCleanup:YES];
    
    if (_panZoomLayer)
    {
        [_panZoomLayer release];
        _panZoomLayer = nil;
    }
    
    
    if (selectedIndicesArray)
    {
        [selectedIndicesArray release];
        selectedIndicesArray=nil;
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	if (hudLayer)
    {
        self.hudLayer = nil;
    }
    
    
    if (selectedIndicesArray)
    {
        [selectedIndicesArray release];
        selectedIndicesArray=nil;
    }
	[super dealloc];
}

@end
