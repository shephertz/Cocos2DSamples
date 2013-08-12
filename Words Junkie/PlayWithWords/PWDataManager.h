//
//  PWDataManager.h
//  PlayWithWords
//
//  Created by shephertz technologies on 07/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h"
#define	GAMEDATA_FOLDER_PATH    [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/GameData"]
#define SESSION_INFO_PLIST      @"SessionInfo.plist"
#define TIMER_INFO_PLIST        @"TimerInfo.plist"

@class CDWordList;
@interface PWDataManager : NSObject
{
    NSMutableDictionary *gameDataDict;
    NSMutableDictionary *sessionInfo;
    NSMutableArray      *lockedWordList;
    
    NSString            *index;
    NSString            *alphabet;
    
    NSMutableDictionary *player1Dict;
    NSMutableDictionary *player2Dict;

    
    int myScore;
    int opponentScore;
    int myPlayerId;
    //int timeLeft;
    
    BOOL isNotificationOn;
    BOOL isVibrationOn;
    float volume;
    CDWordList *wordList;
    CGSize boardSize;
    BOOL sendPush;
    int sessionTokenNumber;
    
    id delegate;
}

@property(nonatomic,assign) int myScore;
@property(nonatomic,assign) int opponentScore;
@property(nonatomic,assign) int myPlayerId;
@property(nonatomic,assign) BOOL sendPush;

@property(nonatomic,assign) BOOL isNotificationOn;
@property(nonatomic,assign) BOOL isVibrationOn;
@property(nonatomic,assign) float volume;
@property(nonatomic,assign) CDWordList *wordList;
@property(nonatomic,assign) CGSize boardSize;

@property(nonatomic,retain) NSMutableDictionary *gameDataDict;
@property(nonatomic,retain) NSMutableDictionary *player1Dict;
@property(nonatomic,retain) NSMutableDictionary *player2Dict;
@property(nonatomic,retain) NSMutableDictionary *sessionInfo;
@property(nonatomic,retain) NSMutableArray      *lockedWordList;
@property(nonatomic,retain) NSString            *player1;
@property(nonatomic,retain) NSString            *player2;
@property(nonatomic,retain) NSString            *player2_name;
@property(nonatomic,retain) NSString            *doc_Id;
@property(nonatomic,retain) NSArray             *friendsList;
@property(nonatomic,retain) NSArray             *gamesArray;
@property(nonatomic,retain) NSString            *alphabet;
@property(nonatomic,retain) NSString            *index;
@property(nonatomic,retain) NSString            *deviceToken;
@property(nonatomic,retain) NSString            *recentWord;
@property(nonatomic,retain) id                  delegate;



-(void)addAlphabet:(NSString*)alphabet atIndex:(NSString*)index;
-(void)saveSessionLocally;
-(void)writeSessionToTheFile;
-(NSMutableDictionary*)readSessionFromTheFile;
-(void)lockThisWord:(NSString*)word;

-(void)createNewGameSession;
-(void)writeSessionToTheServer;
-(BOOL)readSessionFromTheServer;
-(void)getAllGames;
-(NSDictionary*)getDictionaryFromJSON:(NSString*)jsonString;
-(void)setUpInitialData;
-(void)saveScore;
-(NSMutableArray*)getScores;
-(NSMutableArray*)getTodaysScores;
-(NSMutableArray*)getFriendsScores;
-(NSArray*)getFriendsId:(NSArray*)friends;
-(void)resetGameData;
-(void)setUpInitialSettings;
-(void)saveSettings;
-(NSArray *)checkForRandomPlayer;
-(void)addRequestToRandomStack;
-(void)notifyOpponentForRecentMove:(NSString*)word;
-(void)registerUserForPushNotificationToApp42Cloud;
-(void)removeDocWithDocId:(NSString*)docid;
-(void)removeDocWithRequestId:(NSString*)requestId;
-(void)loadDictionary;
-(int)getTimeLeftForTheRunningGame;
-(void)updateTimeLeftForTheRunningGame:(int)timeLeft;
-(void)loadSounds;
-(void)cleanLocalData;
-(void)removeNewAlphabetFromSessionIfNotSubmitted;
@end
