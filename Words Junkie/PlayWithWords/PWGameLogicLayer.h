
/*****************************************************************
 *  PWGameLogicLayer.h
 *  PlayWithWords
 *  Created by shephertz technologies on 18/04/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayerPanZoom.h"
#import "PWFacebookHelper.h"

@class PWCharacter;
@class PWHudLayer;
@class PWMenuLayer;
@class PWDrawLine;

//@class CDWordList;

@interface PWGameLogicLayer : CCLayerColor<CCLayerPanZoomClickDelegate,PWFacebookHelperDelegate>
{
    CCLayerColor *characterMenuLayer;
    CCLayerColor *coverLayer;
    
    PWCharacter     *selectedChar;
    PWHudLayer      *hudLayer;
    PWMenuLayer     *menuLayer;
    
    CCDrawNode      *selectionLine;
    NSMutableArray  *selectedPointsArray;
    NSMutableArray  *selectedIndicesArray;
    
    CurrentGameMode currentGameMode;
    SelectionType   selectionType;
    Turn            turnIndicator;
    GameState       gameState;
    
    BOOL            isCharacterSelected;
    float           rowWidth,rowHeight;
    CGPoint         startPoint;
    CGPoint         lastPlacedCharIndex;
    
    //CDWordList *wordList;
    CCSprite *menuScreen;
    CCMenuItemImage *closeItem;
    CCMenuItemImage *fbItem;
    CCMenuItemSprite *moreButton;
    CCLayerPanZoom *_panZoomLayer;
    float scaleFactor;
    UIImage *screenShot;
    int timeLeft;
    int refreshTimer;
    int numberOfRows;
    int numberOfColumns;
    
    UIActivityIndicatorView *indicatorView;
}

@property (nonatomic, retain) PWCharacter       *selectedChar;
@property (nonatomic, assign) PWHudLayer        *hudLayer;
@property (nonatomic, assign) PWMenuLayer       *menuLayer;


@property (nonatomic, assign) CurrentGameMode   currentGameMode;
@property (nonatomic, assign) GameState         gameState;
@property (nonatomic, assign) Turn              turnIndicator;
@property (nonatomic, assign) BOOL              isCharacterSelected;

@property (nonatomic, assign) int               timeLeft;
@property (nonatomic, assign) float             rowHeight;
@property (nonatomic, assign) float             rowWidth;
@property (nonatomic, assign) int               numberOfRows;
@property (nonatomic, assign) int               numberOfColumns;

//returns a CCScene that contains the PWGameLogicLayer as the only child
+(CCScene *) scene;
+(PWGameLogicLayer *)sharedInstance;
+(PWGameLogicLayer *)getGameLogicLayer;
-(void)startGame;
-(void)refresh;
-(void)refreshGame:(ccTime)delta;


-(void)createWordBoard;
-(void)getSelectedCharFromCharacterMenuWithLetter:(NSString*)letter withPositionINdex:(int)pos_index;
-(void)createCharacterMenuForIPhone;
-(void)showMenuScreen:(BOOL)isShow withAnimation:(BOOL)isAnimate;
-(CGPoint)getIndexForThePosition:(CGPoint)point;
-(CGPoint)getCorrectCharPositionForTheIndex:(CGPoint)index;
-(void)reorderSelectedChar;
-(void)placeTheChar;
-(void)placeCharacterAtCorrectPlaceOnEndTouchPoint:(CGPoint)touchPoint;
-(int)getCharTagForIndex:(CGPoint)index;
-(BOOL)validSelectionCheck:(CGPoint)index;
-(NSString*)constructWordFromTheSelectedNodes;
-(void)drawSelectedNodes:(CGPoint)spoint;
-(void)resetSelectionParameters;
-(void)resizeTheCharacterToTileSize;

-(BOOL) isDictionaryWord:(NSString*) word;
-(BOOL)isLockedWord:(NSString*) word;

-(BOOL)isWordSelected;

-(void)changeTheBgOfCharacter:(CCSprite*)character withBg:(NSString*)bgImage;
-(BOOL)isValidWordSelection;
-(BOOL)isBeyondTheBoundary:(CGPoint)index;

-(void)menuButtonAction:(id)sender;
-(void)settingsButtonAction:(id)sender;
-(void)helpButtonAction:(id)sender;
-(void)leaderboardButtonAction:(id)sender;
-(void)snapshotButtonAction:(id)sender;
-(CCLayerPanZoom*)getScrollLayer;
-(void)enableScrolling:(BOOL)isScollingEnabled;
-(void)createBgLayerForIPad;
-(void)createBgLayerForIPhone;
-(void)createScrollLayer;
-(UIImage*)getScreenShot;
-(void)shareSnapshot;
-(void)menuScreenAnimationDone;
-(void)layoutGameLayer;
-(void)continueWithThisValidWord;
-(void)continueWithThisInvalidWord;
-(void)passTheMove;
-(void)quitFromTheRunningGame;
-(void)takeSnapShot;
-(void)enableFBItemInMenu:(BOOL)isEnabled;
-(void)checkRelationWithPlayerTwo;
-(BOOL)isGameOverNormally;
-(void)createCoverLayer;
-(void)setCoverLayerVisible:(BOOL)isVisible;
-(void)removeGameObjects;
-(void)createSubmittingScreen;
-(void)removeSubmittingScreen;
-(void)setCoverLayerMessageVisible:(BOOL)isVisible;

@end
