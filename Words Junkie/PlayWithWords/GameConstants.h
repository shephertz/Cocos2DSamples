
/*****************************************************************
 *  GameConstants.h
 *  PlayWithWords
 *  Created by shephertz technologies on 18/04/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#define     APP42_APP_KEY           @"20f4bef55024ea12ac3c3ed19d7ea629b3acbbc72f72b1e958b61be521afd26c"
#define     APP42_SECRET_KEY        @"d134612494e7d6d1cfdd0a5e0cbdcb76ed9abecb4e81ce6b6da4c34e79af145b"

#define     GAME_NAME               @"Words Junkie5"
#define     MAX_NUMBER_OF_RECORDS_DISPLAYED_IN_LB 20

#define     GLOBAL_FONT             @"Marker Felt"

#define     NUMBER_OF_ROWS          10
#define     NUMBER_OF_COLUMNS       10

#define     TILE_WIDTH              50.0f
#define     TILE_HEIGHT             51.0f

#define     TILE_WIDTH_IPHONE       26.0f
#define     TILE_HEIGHT_IPHONE      20.0f

#define     TILE_X_OFFSET           24.0f
#define     TILE_Y_OFFSET           105.0f
#define     TILE_Y_OFFSET_IPHONE    70.0f


#define     CHARACTER_MENU_HEIGHT_IPAD      50
#define     CHARACTER_MENU_HEIGHT_IPHONE    34

#define     HUD_LAYER_HEIGHT_IPAD           45
#define     HUD_LAYER_HEIGHT_IPHONE         25

#define     MENU_LAYER_HEIGHT_IPAD          50
#define     MENU_LAYER_HEIGHT_IPHONE        250

#define     TIMER_VALUE                     60

/**
 * Tags used for game layer children
 */
#define     BASE_TAG_FOR_CHAR       1000
#define     MENU_BG_TAG             999
#define     MENU_BUTTON_TAG         998
#define     CLOSE_BUTTON_TAG        997

#define     CHARACTER_MENU_CHAR_BASE_TAG    970 // 970-996 Reserved for chars in character menu 
/***/



/***
 * Constants for Character Menu
 */
#define     x_offset                6
#define     x_pos_diff              39 ///CC_CONTENT_SCALE_FACTOR()


/***
 *  Z-Orders
 */

#define     CHARACTER_MENU      10
#define     HUD_LAYER           10
#define     MENU_LAYER          10
#define     MENU_BUTTON         101
#define     SELECTED_ALPHABET   10000

     

/***
 *  Game Modes
 */

typedef enum
{
	kPlacementMode =1,
	kSelectionMode,
	kSearchMode,
} CurrentGameMode;


typedef enum
{
    kEmpty = -2,
    kNone =-1,
	kHorizontal =1,
	kVertical,
} SelectionType;

typedef enum
{
    kTurnNone = 0,
	kPlayerOneTurn,
	kPlayerTwoTurn,
} Turn;

typedef enum
{
	kRegisterLayer =1,
	kHomeLayer,
    kNewGameView,
    kPlayersListLayer,
    kGameLayer,
    kGameOverLayer,
    kLeaderboard,
    kSettingsView,
    kHelpView,
    kFriendsListView,
    kSnapShotView,
} ScreenCode;

typedef enum
{
    kGameRunning =1,
	kGameOver,
} GameState;

typedef enum
{
    kNormalAlert =1,
	kValidWordAlert,
    kInvalidWordAlert,
    kPassTurnAlert,
    kGameOverAlert,
    kQuitGameAlert,
    kNoNetwork,
} AlertType;

typedef enum
{
    kNormalMode =1,
	kTimedMode,
} GameType;

typedef enum
{
    kUpward =1,
	kDownward,
    kLeftWard,
    kRightWard,
} TutorialArrowDirection;

typedef enum
{
    kDragNDrop=1,
    kSelectCharcater,
    kClickOnPlay,
    kCompleted,
} TutorialStep;
/***
 *  Alert Info Keys
 */

#define ALERT_TITLE                 @"tilte"
#define ALERT_MESSAGE               @"message"
#define ALERT_CANCEL_BUTTON_TEXT    @"cancel"
#define ALERT_OK_BUTTON_TEXT        @"ok"

/***
 *  Tutorial Keys
 */
#define NEXT_TUTORIAL_STEP          @"nextStep"
#define TUTORIAL_STATUS             @"tutorialStatus"
#define TUTORIAL_CHAR_INDEX         @"tutorialCharIndex"

/***
 *  Session Info Keys
 */
#define SESSION_DICT        @"session"
#define FINISHED_GAMES      @"finishedGames"
#define RUNNING_GAMES       @"runningGames"
#define DOC_ID              @"docId"
#define MY_SCORE            @"myScore"
#define OPPONENT_SCORE      @"opponentScore"
#define TURN                @"turn"
#define TURN_ID             @"turnId"
#define GAME_MODE           @"gameMode"
#define GAME_STATE          @"gameState"
#define GAME_TYPE           @"gameType"
#define GAME_BOARD_SIZE     @"gameBoardSize"
#define SKIPP_CHANCE_LEFT   @"skipChanceLeft"
#define GAME_DATA           @"gameData"
#define LOCKED_WORD_LIST    @"lockedWordList"
#define PLAYER1             @"player1"
#define PLAYER2             @"player2"
#define PLAYER1_NAME        @"player1_name"
#define PLAYER_NAME         @"playerName"
#define WINNER_ID           @"winnerId"
#define TIME_LEFT          @"timeLeft"

#define PLAYER2_NAME        @"player2_name"
#define NEW_INDEX           @"newIndex"
#define NEW_ALPHABET        @"newAlphabet"

#define VOLUME              @"volume"
#define NOTIFICATION        @"notification"
#define VIBRATION           @"vibration"

#define FACEBOOKREFRESHED   @"facebookPicsLastRefreshedOn"
#define FB_ID_ARRAY         @"fbIDArray"
#define IMAGEVIEW           @"imageView"
#define FB_ID               @"ID"
#define INDICATOR			@"activityIndicator"

#define  FACEBOOKPROFILEIMAGES_FOLDER_PATH	[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/FacebookProfileImages"]

/***
 *  APP42 Keys
 */
#define DOC_NAME            @"PWWDOC"
#define COLLECTION_NAME     @"PWWCollection"
#define RANDOM_STACK        @"RandomStack"


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

/****
 * Sound Files
 */
#define MENU_ITEM_CLICKED       @"all_menu_item.mp3"
#define BACK_BUTTON_CLICKED     @"back_click.mp3"
#define CHARACTER_PLACED        @"char_place.mp3"
#define MENU_ANIMATION          @"fly_menu.mp3"
#define MOVE_CONFIRM            @"move_confirm.mp3"
#define RECALL_BUTTON           @"recall_char.mp3"
#define SWITCH_CLICKED          @"switch-1.mp3"
#define CLOCK_TICKING           @"clock-ticking-1.mp3" //@"clock-ticking-4.mp3"
#define MENU_ITEMS_CLICKED      @"MenuItemsClicked.mp3"
#define SNAPSHOT_CLICKED        @"SnapshotEffect.mp3"