//
//  PWDataManager.m
//  PlayWithWords
//
//  Created by shephertz technologies on 07/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWDataManager.h"
#import "PWGameLogicLayer.h"
#import "PWFacebookHelper.h"
#import "PWGameController.h"
#import "CDWordList.h"
#import "SimpleAudioEngine.h"
#import "PWAlertManager.h"

@implementation PWDataManager

@synthesize player1Dict,player2Dict,deviceToken,recentWord;
@synthesize myScore,opponentScore,gameDataDict,sessionInfo,lockedWordList,player1,player2,doc_Id,friendsList,player2_name,gamesArray,index,alphabet,myPlayerId,isNotificationOn,isVibrationOn,volume,wordList,boardSize,sendPush,delegate;

-(id)init
{
    if (self=[super init])
    {
        gameDataDict = nil;
        sessionInfo = nil;
        lockedWordList = nil;
        player2 = nil;
        player1 = nil;
        friendsList = nil;
        player2_name =nil;
        gamesArray = nil;
        alphabet = nil;
        index = nil;
        self.deviceToken = nil;
        self.recentWord = nil;
        sendPush = NO;
        sessionTokenNumber = 0;
        self.delegate = nil;
    }
    return self;
}


-(void)dealloc
{
    if (self.delegate)
    {
        self.delegate = nil;
    }
    if (recentWord)
    {
        self.recentWord = nil;
    }
    if (deviceToken)
    {
        self.deviceToken = nil;
    }
    if (gameDataDict)
    {
        self.gameDataDict = nil;
    }
    
    if (sessionInfo)
    {
        
        self.sessionInfo = nil;
    }
    
    if (lockedWordList)
    {
        
        self.lockedWordList = nil;
    }
    
    if (player1)
    {
        self.player1 = nil;
    }
    
    if (player2)
    {
        self.player2 = nil;
    }
    
    if (player2_name)
    {
        self.player2_name = nil;
    }
    
    if (player2Dict)
    {
        self.player2Dict = nil;
    }
    
    if (player1Dict)
    {
        self.player1Dict = nil;
    }
    
    if (doc_Id)
    {
        self.doc_Id = nil;
    }
    
    if (friendsList)
    {
        self.friendsList = nil;
    }
    
    if (gamesArray)
    {
        self.gamesArray = nil;
    }
    
    if (index)
    {
        self.index = nil;
    }
    
    if (alphabet)
    {
        self.alphabet = nil;
    }
    if (wordList)
    {
        [wordList release];
        wordList=nil;
    }
    [super dealloc];
}

-(void)loadDictionary
{
    wordList = [[CDWordList alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"word_list" ofType:@"txt"]];
}
-(void)setUpInitialSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:VOLUME])
    {
        volume = [[userDefaults objectForKey:VOLUME] floatValue];
        isNotificationOn = [[userDefaults objectForKey:NOTIFICATION] boolValue];
        isVibrationOn    = [[userDefaults objectForKey:VIBRATION] boolValue];
    }
    else
    {
        volume = 100;
        isNotificationOn = YES;
        isVibrationOn    = YES;
        
        [userDefaults setObject:[NSNumber numberWithFloat:volume] forKey:VOLUME];
        [userDefaults setObject:[NSNumber numberWithBool:isNotificationOn] forKey:NOTIFICATION];
        [userDefaults setObject:[NSNumber numberWithBool:isVibrationOn] forKey:VIBRATION];
    }
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:volume];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:volume];
    [self loadSounds];
}

-(void)loadSounds
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:MENU_ITEM_CLICKED];
    [[SimpleAudioEngine sharedEngine] preloadEffect:MENU_ANIMATION];
    [[SimpleAudioEngine sharedEngine] preloadEffect:CHARACTER_PLACED];
    [[SimpleAudioEngine sharedEngine] preloadEffect:MOVE_CONFIRM];
    [[SimpleAudioEngine sharedEngine] preloadEffect:BACK_BUTTON_CLICKED];
    [[SimpleAudioEngine sharedEngine] preloadEffect:RECALL_BUTTON];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SWITCH_CLICKED];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:CLOCK_TICKING];
    [[SimpleAudioEngine sharedEngine] preloadEffect:MENU_ITEMS_CLICKED];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SNAPSHOT_CLICKED];
}

-(void)saveSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setObject:[NSNumber numberWithFloat:volume] forKey:VOLUME];
    [userDefaults setObject:[NSNumber numberWithBool:isNotificationOn] forKey:NOTIFICATION];
    [userDefaults setObject:[NSNumber numberWithBool:isVibrationOn] forKey:VIBRATION];
}

-(void)addAlphabet:(NSString*)newAlphabet atIndex:(NSString*)newIndex
{
    if (gameDataDict)
    {
        [gameDataDict setObject:newAlphabet forKey:newIndex];
    }
    else
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:newAlphabet,newIndex, nil];
        self.gameDataDict = dict;
        [dict release];
    }
    self.alphabet = newAlphabet;
    self.index = newIndex;
}

-(void)removeNewAlphabetFromSessionIfNotSubmitted
{
    NSLog(@"gameDataDict=%@",gameDataDict);
    if (self.index)
    {
        [gameDataDict removeObjectForKey:self.index];
        self.index = nil;
        self.alphabet = nil;
    }
    NSLog(@"gameDataDict=%@",gameDataDict);
}


-(void)saveSessionLocally
{
    PWGameLogicLayer *gameLayer = [PWGameLogicLayer sharedInstance];
    if (sessionInfo)
    {
        [self.player1Dict setObject:[NSNumber numberWithInt:myScore] forKey:MY_SCORE];
        [self.player2Dict setObject:[NSNumber numberWithInt:opponentScore] forKey:MY_SCORE];
        
        [self.player1Dict setObject:[NSNumber numberWithInt:gameLayer.turnIndicator] forKey:TURN];
        [self.player2Dict setObject:[NSNumber numberWithInt:((gameLayer.turnIndicator==kPlayerOneTurn)?kPlayerTwoTurn:kPlayerOneTurn)] forKey:TURN];

        [sessionInfo setObject:player1Dict forKey:[NSString stringWithFormat:@"%@",player1]];
        [sessionInfo setObject:player2Dict forKey:[NSString stringWithFormat:@"%@",player2]];
        [sessionInfo setObject:[NSNumber numberWithInt:gameLayer.currentGameMode] forKey:GAME_MODE];
        [sessionInfo setObject:[NSNumber numberWithInt:gameLayer.gameState] forKey:GAME_STATE];
        
        if (index)
        {
            [sessionInfo setObject:index forKey:NEW_INDEX];
            [sessionInfo setObject:alphabet forKey:NEW_ALPHABET];
        }
        if (gameDataDict)
        {
            [sessionInfo setObject:gameDataDict forKey:GAME_DATA];
        }
        if (lockedWordList)
        {
            [sessionInfo setObject:lockedWordList forKey:LOCKED_WORD_LIST];
        }
        NSLog(@"sessionInfo=%@",sessionInfo);
        [self writeSessionToTheFile];
    }
    else
    {
        sessionInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:myScore],MY_SCORE,
                       [NSNumber numberWithInt:opponentScore],OPPONENT_SCORE,
                       [NSNumber numberWithInt:kPlayerOneTurn],TURN,
                       [NSNumber numberWithInt:kPlacementMode],GAME_MODE,
                       [NSNumber numberWithInt:kGameRunning],GAME_STATE,nil];
        
        [player1Dict setObject:[NSNumber numberWithInt:myScore] forKey:MY_SCORE];
        [player2Dict setObject:[NSNumber numberWithInt:opponentScore] forKey:MY_SCORE];
        
        [player1Dict setObject:[NSNumber numberWithInt:gameLayer.turnIndicator] forKey:TURN];
        [player2Dict setObject:[NSNumber numberWithInt:((gameLayer.turnIndicator==kPlayerOneTurn)?kPlayerTwoTurn:kPlayerOneTurn)] forKey:TURN];
        
        [sessionInfo setObject:player1Dict forKey:player1];
        [sessionInfo setObject:player2Dict forKey:player2];
        
        if (gameDataDict)
        {
            [sessionInfo setObject:gameDataDict forKey:GAME_DATA];
        }
        if (lockedWordList)
        {
            [sessionInfo setObject:lockedWordList forKey:LOCKED_WORD_LIST];
        }
        if (index)
        {
            [sessionInfo setObject:index forKey:NEW_INDEX];
            [sessionInfo setObject:alphabet forKey:NEW_ALPHABET];
        }
        [self writeSessionToTheFile];
    }
    
    if (index)
    {
        self.index = nil;
    }
    if (alphabet)
    {
        self.alphabet = nil;
    }
    
}


-(int)getTimeLeftForTheRunningGame
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = GAMEDATA_FOLDER_PATH;
    int timeLeft;
    NSMutableDictionary *timerDict=nil;
    NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@", folderPath,TIMER_INFO_PLIST];
    if ([fileManager fileExistsAtPath:filePath])
	{
        timerDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        if ([timerDict objectForKey:doc_Id])
        {
            timeLeft = [[timerDict objectForKey:doc_Id] intValue];
        }
        else
        {
            timeLeft = TIMER_VALUE;
        }
        [timerDict release];
    }
    else
    {
        timeLeft = TIMER_VALUE;
    }
    return timeLeft;
}

-(void)updateTimeLeftForTheRunningGame:(int)timeLeft
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = GAMEDATA_FOLDER_PATH;
    NSMutableDictionary *timerDict=nil;
    
    if(![fileManager fileExistsAtPath:folderPath] )
	{
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
    NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@", folderPath,TIMER_INFO_PLIST];
    if ([fileManager fileExistsAtPath:filePath])
	{
        timerDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [timerDict setObject:[NSNumber numberWithInt:timeLeft] forKey:doc_Id];
    }
    else
    {
        timerDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:30],doc_Id, nil];
    }
    [timerDict writeToFile:filePath atomically:YES];
    [timerDict release];
}

-(void)writeSessionToTheFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = GAMEDATA_FOLDER_PATH;
    
    if(![fileManager fileExistsAtPath:folderPath] )
	{
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
    NSMutableDictionary *gameDict=nil;
    NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@", folderPath,SESSION_INFO_PLIST];
    if ([fileManager fileExistsAtPath:filePath])
	{
        gameDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    
    if (gameDict)
    {
        if ([[sessionInfo objectForKey:GAME_STATE] intValue]==kGameOver)
        {
            if ([gameDict objectForKey:FINISHED_GAMES])
            {
                [[gameDict objectForKey:FINISHED_GAMES] setObject:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil] forKey:doc_Id];
                
                if ([gameDict objectForKey:RUNNING_GAMES])
                {
                    [[gameDict objectForKey:RUNNING_GAMES] removeObjectForKey:doc_Id];//removing games from running game dict
                }
            }
            else
            {
                NSMutableDictionary *finishedGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
                [gameDict setObject:finishedGames forKey:FINISHED_GAMES];
                [finishedGames release];
            }
        
        }
        else
        {
            if ([gameDict objectForKey:RUNNING_GAMES])
            {
                [[gameDict objectForKey:RUNNING_GAMES] setObject:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil] forKey:doc_Id];
                
            }
            else
            {
                NSMutableDictionary *runningGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
                [gameDict setObject:runningGames forKey:RUNNING_GAMES];
                [runningGames release];
            }
        }
    
    }
    else
    {
        gameDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        if ([[sessionInfo objectForKey:GAME_STATE] intValue]==kGameOver)
        {
            NSMutableDictionary *finishedGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
            [gameDict setObject:finishedGames forKey:FINISHED_GAMES];
            [finishedGames release];
        }
        else
        {
            NSMutableDictionary *runningGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
            [gameDict setObject:runningGames forKey:RUNNING_GAMES];
            [runningGames release];
        }
    }
    
    [gameDict writeToFile:filePath atomically:YES];
    
    [gameDict release];
}

-(void)cleanLocalData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = GAMEDATA_FOLDER_PATH;
    
    if(![fileManager fileExistsAtPath:folderPath] )
	{
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
    NSMutableDictionary *gameDict=nil;
    NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@", folderPath,SESSION_INFO_PLIST];
    if ([fileManager fileExistsAtPath:filePath])
	{
        gameDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [gameDict removeAllObjects];
//        if ([gameDict objectForKey:FINISHED_GAMES])
//        {
//            [[gameDict objectForKey:FINISHED_GAMES] removeAllObjects];
//        }
//        
//        if ([gameDict objectForKey:RUNNING_GAMES])
//        {
//            [[gameDict objectForKey:RUNNING_GAMES] removeAllObjects];
//        }
    }
    [gameDict writeToFile:filePath atomically:YES];
}

-(void)startNewGameSessionLocally
{
    //NSMutableDictionary *runningGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
    
    NSMutableDictionary *gameDict=nil;
    /***
     * Local folder & file existence check
     */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = GAMEDATA_FOLDER_PATH;
    
    if(![fileManager fileExistsAtPath:folderPath] )
	{
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
    NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@", folderPath,SESSION_INFO_PLIST];
    if ([fileManager fileExistsAtPath:filePath])
	{//File exists
        gameDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath]; // Got the main dict
        
        if ([gameDict objectForKey:player1]) //login user data check
        {
            if ([[gameDict objectForKey:player1] objectForKey:RUNNING_GAMES]) //Running games data check
            {
                [[[gameDict objectForKey:player1] objectForKey:RUNNING_GAMES] setObject:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil] forKey:doc_Id]; // Saving newly created data 
            }
            else
            {// There is no running games
                
                NSMutableDictionary *runningGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
                [[gameDict objectForKey:player1] setObject:runningGames forKey:RUNNING_GAMES]; // Saving newly created data 
            }
        }
        else
        { // First time user
            NSMutableDictionary *runningGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
            NSMutableDictionary *currentUserDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:runningGames,RUNNING_GAMES,nil];
            [gameDict setObject:currentUserDict forKey:player1]; // Saving newly created data
        }
    }
    else
    { // File does not exists
        NSMutableDictionary *runningGames = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:sessionInfo,SESSION_DICT,doc_Id,DOC_ID,nil],doc_Id,nil];
        NSMutableDictionary *currentUserDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:runningGames,RUNNING_GAMES,nil];
        gameDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:currentUserDict,player1,nil]; // Got the main dict
    }
    
    [gameDict writeToFile:filePath atomically:YES];
}


-(NSMutableDictionary*)readSessionFromTheFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [[NSString alloc] initWithFormat:@"%@/%@", GAMEDATA_FOLDER_PATH,SESSION_INFO_PLIST];
    NSMutableDictionary *localGamesInfo = nil;
    if ([fileManager fileExistsAtPath:filePath])
	{
        localGamesInfo = [[[NSMutableDictionary alloc] initWithContentsOfFile:filePath] autorelease];
    }
    return localGamesInfo;
}

-(void)setUpInitialData
{
    NSString *userId = [[PWFacebookHelper sharedInstance] userId];
    
    self.gameDataDict = [sessionInfo objectForKey:GAME_DATA];
    self.lockedWordList = [sessionInfo objectForKey:LOCKED_WORD_LIST];
    
    
    if ([userId isEqualToString:[sessionInfo objectForKey:PLAYER1]])
    {
        self.player2 = [NSString stringWithFormat:@"%@",[sessionInfo objectForKey:PLAYER2]];
    }
    else
    {
        self.player2 = [NSString stringWithFormat:@"%@",[sessionInfo objectForKey:PLAYER1]];
    }
    //NSLog(@"userId=%@...palyer2=%@",userId,player2);
    //NSLog(@"session=%@",sessionInfo);
    self.player1Dict = [sessionInfo objectForKey:userId];
    self.player2Dict = [sessionInfo objectForKey:player2];
    //NSLog(@"player2Dict=%@",player2Dict);
    myScore = [[player1Dict objectForKey:MY_SCORE] intValue];
    sessionTokenNumber = [[sessionInfo objectForKey:@"sessionToken"] intValue];
    opponentScore = [[player2Dict objectForKey:MY_SCORE] intValue];
    self.player2_name = [player2Dict objectForKey:PLAYER_NAME];
}



-(void)lockThisWord:(NSString*)word
{
    self.recentWord = word;
    if (lockedWordList)
    {
        [lockedWordList addObject:word];
    }
    else
    {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:word, nil];
        self.lockedWordList = arr;
        [arr release];
    }
}

#pragma mark-
#pragma mark- ---Updating Sessions---
#pragma mark-

-(void)writeSessionToTheServer
{
    NSAutoreleasePool *threadPool = [[NSAutoreleasePool alloc] init];
    [sessionInfo setObject:[NSNumber numberWithInt:(++sessionTokenNumber)] forKey:@"sessionToken"];
    int globalSessionToken=-1;
    int i =0;
    do
    {
        NSAutoreleasePool *loopPool = [[NSAutoreleasePool alloc] init];
        NSLog(@"%s..i=%d",__FUNCTION__,++i);
        [self updateGameSessionOnSever];
        globalSessionToken = [self getGlobalSessionToken];
        [loopPool release];
            
    }while (globalSessionToken < sessionTokenNumber && i<=10);
    
    if (delegate && [delegate respondsToSelector:@selector(removeSubmittingScreen)])
    {
        [delegate performSelectorOnMainThread:@selector(removeSubmittingScreen) withObject:nil waitUntilDone:NO];
    }
    if (sendPush)
    {
        [self notifyOpponentForRecentMove:recentWord];
        self.recentWord=nil;
        sendPush = NO;
    }
    [threadPool release];
}


-(void)updateGameSessionOnSever
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    StorageService *storageService = [servicAPI buildStorageService];
    @try
    {
        Storage *storage = [storageService updateDocumentByDocId:DOC_NAME collectionName:COLLECTION_NAME docId:doc_Id newJsonDoc:[sessionInfo JSONRepresentation]];
        [storage release];
    }
    @catch (App42Exception *exception)
    {      
    }
    @finally
    {
        [storageService release];
        [servicAPI release];
    }
}



#pragma mark-
#pragma mark- ---Fetching Data---
#pragma mark-

-(int)getGlobalSessionToken
{
    
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    
    StorageService *storageService = [servicAPI buildStorageService];
    int globalSessionToken=-1;
    @try
    {
        Storage *storage = [storageService findDocumentById:DOC_NAME collectionName:COLLECTION_NAME docId:doc_Id];
        NSMutableDictionary *gamesInfoDict = (NSMutableDictionary *)[[self getDictionaryFromJSON:[[[storage jsonDocArray] objectAtIndex:0] jsonDoc]] retain];
        globalSessionToken = [[gamesInfoDict objectForKey:@"sessionToken"] intValue];
        [gamesInfoDict release];
        [storage release];
    }
    @catch (App42Exception *exception)
    {
        globalSessionToken=-1;
    }
    @finally
    {
        [storageService release];
        [servicAPI release];
        return globalSessionToken;
    }
}



-(BOOL)readSessionFromTheServer
{
    BOOL isSuccess = NO;
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    
    StorageService *storageService = [servicAPI buildStorageService];
    
    @try
    {
        
        Storage *storage = [storageService findDocumentById:DOC_NAME collectionName:COLLECTION_NAME docId:doc_Id];
        
        NSMutableDictionary *gamesInfoDict = (NSMutableDictionary *)[[self getDictionaryFromJSON:[[[storage jsonDocArray] objectAtIndex:0] jsonDoc]] retain];
        int globalSessionToken = [[gamesInfoDict objectForKey:@"sessionToken"] intValue];
        if (globalSessionToken>=sessionTokenNumber)
        {
            self.doc_Id = [[[storage jsonDocArray] objectAtIndex:0] docId];
            [self setSessionInfo:gamesInfoDict];
            sessionTokenNumber = globalSessionToken;
            isSuccess = YES;
        }
        [gamesInfoDict release];
        [storage release];
    }
    @catch (App42Exception *exception)
    {
        self.doc_Id = nil;
        [self setSessionInfo:nil];
    }
    @finally
    {
        [storageService release];
        [servicAPI release];
        return isSuccess;
    }
}


-(void)getAllGames
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    StorageService *storageService = [servicAPI buildStorageService];
    Storage *storage;
    @try
    {
        PWFacebookHelper *fbHelper = [PWFacebookHelper sharedInstance];
        fbHelper.userInfoDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookUserInfo"];
        if (fbHelper.userInfoDict)
        {
            fbHelper.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
            fbHelper.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
            [self setPlayer1:[NSString stringWithFormat:@"%@",fbHelper.userId]];
        }
        Query *query1_1 = [QueryBuilder buildQueryWithKey:PLAYER1 value:player1 andOperator:APP42_OP_EQUALS];
        Query *query1_2 = [QueryBuilder buildQueryWithKey:PLAYER2 value:player1 andOperator:APP42_OP_EQUALS];
        Query *query1_3 = [QueryBuilder combineQuery:query1_1 withQuery:query1_2 usingOperator:APP42_OP_OR];
        storage = [storageService findDocumentsByQuery:query1_3 dbName:DOC_NAME collectionName:COLLECTION_NAME];
        self.gamesArray = [storage jsonDocArray];
    }
    @catch (App42Exception *exception)
    {
        self.gamesArray=nil;
        NSLog(@"exception=%@",exception.reason);
    }
    @finally
    {
        [storageService release];
        [servicAPI release];
    }
}

-(NSArray*)checkForRandomPlayer
{
    NSArray *idArray = nil;
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    
    StorageService *storageService = [servicAPI buildStorageService];
    
    @try
    {
        Storage *storage = [storageService findAllDocuments:DOC_NAME collectionName:RANDOM_STACK];
        idArray = [[storage jsonDocArray] retain];
        
    }
    @catch (App42Exception *exception)
    {
        idArray = nil;
    }
    @finally
    {
        
        [storageService release];
        [servicAPI release];
        return idArray;
    }
}


#pragma mark-
#pragma mark- ---Creating New Session---
#pragma mark-

-(void)createNewGameSession
{
    myScore = 0;
    opponentScore = 0;
    self.player1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:myScore],MY_SCORE,[[PWFacebookHelper sharedInstance] userName],PLAYER_NAME,[NSNumber numberWithInt:kPlayerOneTurn],TURN,[NSNumber numberWithInt:1],SKIPP_CHANCE_LEFT, nil];
    
    
    self.player2Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:opponentScore],MY_SCORE,self.player2_name,PLAYER_NAME,[NSNumber numberWithInt:kPlayerTwoTurn],TURN,[NSNumber numberWithInt:1],SKIPP_CHANCE_LEFT, nil];
    
    sessionInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",player1],PLAYER1,
                   [NSString stringWithFormat:@"%@",player2],PLAYER2,
                   [NSNumber numberWithInt:kPlacementMode],GAME_MODE,
                   [NSNumber numberWithInt:kGameRunning],GAME_STATE,
                   [NSNumber numberWithInt:kNormalMode],GAME_TYPE,
                   NSStringFromCGSize(CGSizeMake(NUMBER_OF_ROWS, NUMBER_OF_COLUMNS)),GAME_BOARD_SIZE,
                   player1Dict,[NSString stringWithFormat:@"%@",player1],
                   player2Dict,[NSString stringWithFormat:@"%@",player2],
                   nil];
    
    [self performSelectorInBackground:@selector(startNewGameSessionOntheServer) withObject:nil];
}

-(void)startNewGameSessionOntheServer
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    StorageService *storageService = [servicAPI buildStorageService];
    @try
    {
        Storage *storage = [storageService insertJSONDocument:DOC_NAME collectionName:COLLECTION_NAME json:[sessionInfo JSONRepresentation]];
        self.doc_Id = [[[storage jsonDocArray] objectAtIndex:0] docId];
    }
    @catch (App42Exception *exception)
    { }
    @finally
    {
        [storageService release];
        [servicAPI release];
    }
}


-(void)removeDocWithRequestId:(NSString*)requestId
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    
    StorageService *storageService = [servicAPI buildStorageService];
    
    @try
    {
        [storageService deleteDocumentById:DOC_NAME collectionName:RANDOM_STACK docId:requestId];
    }
    @catch (App42Exception *exception)
    {
        
    }
    @finally
    {
        [storageService release];
        [servicAPI release];
    }

}
-(void)addRequestToRandomStack
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:player1,@"uid",[[PWFacebookHelper sharedInstance] userName],@"name", nil];
    NSDictionary *randomStack = [NSDictionary dictionaryWithObjectsAndKeys:userInfo,RANDOM_STACK, nil];
    
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    
    StorageService *storageService = [servicAPI buildStorageService];
    
    @try
    {
        Storage *storage = [storageService insertJSONDocument:DOC_NAME collectionName:RANDOM_STACK json:[randomStack JSONRepresentation]];
        [storage release];
        // self.doc_Id = [[[storage jsonDocArray] objectAtIndex:0] docId];
    }
    @catch (App42Exception *exception)
    {
        
    }
    @finally
    {
        [storageService release];
        [servicAPI release];
    }

}

-(void)removeDocWithDocId:(NSString*)docid
{
        
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    
    StorageService *storageService = [servicAPI buildStorageService];
    
    @try
    {
        App42Response *response = [storageService deleteDocumentById:DOC_NAME collectionName:COLLECTION_NAME docId:docid];
        NSLog(@"response=%@",response);
    }
    @catch (App42Exception *exception)
    {
        
    }
    @finally
    {
        [storageService release];
        [servicAPI release];
    }
}


-(NSDictionary*)getDictionaryFromJSON:(NSString*)jsonString
{
    SBJSON *jsonParser = [[SBJSON alloc] init];
    NSDictionary *resDictionary = [jsonParser objectWithString:jsonString error:nil];
    [jsonParser release];
    return resDictionary;
}

-(id)getObjectFromJSON:(NSString*)jsonString
{
    SBJSON *jsonParser = [[SBJSON alloc] init];
    id object = [jsonParser objectWithString:jsonString error:nil];
    [jsonParser release];
    return object;
}

#pragma mark-
#pragma mark-- Score Management --
#pragma mark-

-(void)saveScore
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    ScoreBoardService *scoreboardService = [servicAPI buildScoreBoardService];
    @try
    {
        NSString *userName = [NSString stringWithFormat:@"%@zz%@",[[PWFacebookHelper sharedInstance] userName],player1];
        [scoreboardService saveUserScore:GAME_NAME gameUserName:userName gameScore:myScore];
    }
    
    @catch (App42Exception *exception)
    {
        
    }
    @finally
    {
        [scoreboardService release];
        [servicAPI release];
    }
}

-(NSMutableArray*)getScores
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    ScoreBoardService *scoreboardService = [servicAPI buildScoreBoardService];
    NSMutableArray *scoreList =nil;
    @try
    {
        Game *game=[scoreboardService getTopNRankers:GAME_NAME max:MAX_NUMBER_OF_RECORDS_DISPLAYED_IN_LB];
        scoreList = game.scoreList;
    }
    
    @catch (App42Exception *exception)
    {    }
    @finally
    {
        [scoreboardService release];
        [servicAPI release];
        return scoreList;
    }
}

-(NSMutableArray*)getTodaysScores
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    ScoreBoardService *scoreboardService = [servicAPI buildScoreBoardService];
    NSMutableArray *scoreList = nil;
    @try
    {
        Game *game=[scoreboardService getTopNRankers:GAME_NAME startDate:[NSDate dateWithTimeIntervalSinceNow:-3600*24] endDate:[NSDate dateWithTimeIntervalSinceNow:0] max:MAX_NUMBER_OF_RECORDS_DISPLAYED_IN_LB];
        scoreList = game.scoreList;
        
    }
    
    @catch (App42Exception *exception)
    {
        
    }
    @finally
    {
        [scoreboardService release];
        [servicAPI release];
        return scoreList;
    }
    
}

-(NSMutableArray*)getFriendsScores
{
    ServiceAPI *servicAPI = [[ServiceAPI alloc] init];
    servicAPI.apiKey = APP42_APP_KEY;
    servicAPI.secretKey = APP42_SECRET_KEY;
    ScoreBoardService *scoreboardService = [servicAPI buildScoreBoardService];
    NSMutableArray *scoreList=nil;
    @try
    {
        NSLog(@"friendsList=%@",friendsList);
        NSArray *arr = [self getFriendsId:friendsList];
        NSLog(@"arr=%@",arr);
        Game *game=[scoreboardService getTopRankersByGroup:GAME_NAME group:arr];
        scoreList = game.scoreList;
    }
    @catch (App42Exception *exception)
    {    }
    @finally
    {
        [scoreboardService release];
        [servicAPI release];
        return scoreList;
    }
}

-(NSArray*)getFriendsId:(NSArray*)friends
{
    NSMutableArray *fbIDArray = [[NSMutableArray alloc] initWithCapacity:0];
    int count = [friends count];
    for (int i=0; i<count; i++)
    {
        NSString *name = [[[[friends objectAtIndex:i] objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0];
        
        [fbIDArray addObject:[NSString stringWithFormat:@"%@zz%@",name,[[friends objectAtIndex:i] objectForKey:@"uid"]]];
    }
    
    [fbIDArray addObject:[NSString stringWithFormat:@"%@zz%@",[[PWFacebookHelper sharedInstance] userName],player1]];
    return fbIDArray;
}


-(void)resetGameData
{
    self.doc_Id = nil;
    self.sessionInfo = nil;
    self.gameDataDict = nil;
    self.lockedWordList = nil;
}
#pragma mark-
#pragma mark-- Push Notification --
#pragma mark-

-(void)registerUserForPushNotificationToApp42Cloud
{
    if (!self.deviceToken)
    {
        return;
    }
    ServiceAPI *serviceObj = [[ServiceAPI alloc]init];
    serviceObj.apiKey = APP42_APP_KEY;
    serviceObj.secretKey = APP42_SECRET_KEY;
    PushNotificationService *pushObj = [serviceObj buildPushService];
    
    @try
    {
        PushNotification *pushNotification =[pushObj registerDeviceToken:self.deviceToken withUser:player1];
        [pushNotification release];
    }
    @catch (App42Exception *exception)
    {
        NSLog(@"%@",exception.reason);
    }
    @finally
    {
        [serviceObj release];
        [pushObj release];
    }
}

-(void)notifyOpponentForRecentMove:(NSString*)word
{
    ServiceAPI *serviceObj = [[ServiceAPI alloc]init];
    serviceObj.apiKey = APP42_APP_KEY;
    serviceObj.secretKey = APP42_SECRET_KEY;
    PushNotificationService *pushObj = [serviceObj buildPushService];
    int score = word.length;
    score *=score;
    @try
    {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        NSString *message;
        if ([[[PWGameController sharedInstance] alertManager] alertType]==kValidWordAlert)
        {
            message = [NSString stringWithFormat:@"%@ made %@ for %d points.It's your turn now!",[[PWFacebookHelper sharedInstance] userName],[word uppercaseString],score];
        }
        else if ([[[PWGameController sharedInstance] alertManager] alertType]==kInvalidWordAlert)
        {
            message = [NSString stringWithFormat:@"It's your turn against %@!",[[PWFacebookHelper sharedInstance] userName]];
        }
        else if([[[PWGameController sharedInstance] alertManager] alertType]==kQuitGameAlert)
        {
            message = [NSString stringWithFormat:@"%@ has quit the game. You won!",[[PWFacebookHelper sharedInstance] userName]];
        }
        else if([[[PWGameController sharedInstance] alertManager] alertType]==kGameOverAlert)
        {
            NSString *winnerID =[sessionInfo objectForKey:WINNER_ID];
            NSString *resultString;
            if ([winnerID isEqualToString:player1])
            {
                NSString *playerName = [[[[PWFacebookHelper sharedInstance] userName] componentsSeparatedByString:@" "] objectAtIndex:0];
                resultString = [NSString stringWithFormat:@"%@ Won!",playerName];
            }
            else if (winnerID.length==0)
            {
                resultString = @"It's a Tie!";
            }
            else
            {
                resultString = @"You Won!";
            }
            message = [NSString stringWithFormat:@"No more tiles left. %@",resultString];
        }
        else
        {
            message = [NSString stringWithFormat:@"%@ has passed the turn.It's your turn now!",[[PWFacebookHelper sharedInstance] userName]];
        }
        [dictionary setObject:message forKey:@"alert"];
        [dictionary setObject:@"default" forKey:@"sound"];
        [dictionary setObject:@"1" forKey:@"badge"];
        
        PushNotification *pushNotification = [pushObj sendPushMessageToUser:player2 withMessageDictionary:dictionary];
        [pushNotification release];
        NSLog(@"player2=%@",player2);
        
    }
    @catch (App42Exception *exception)
    {
        NSLog(@"%@",exception.reason);
    }
    @finally
    {
        [serviceObj release];
        [pushObj release];
    }
}



@end
