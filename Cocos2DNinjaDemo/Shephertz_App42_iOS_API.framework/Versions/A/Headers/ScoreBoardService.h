//
//  ScoreBoardService.h
//  App42_iOS_SERVICE_APIs
//
//  Created by Shephertz Technology on 21/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameResponseBuilder.h"
@class Game;
/**
 * ScoreBoard allows storing, retrieving, querying and ranking scores for users
 * and Games across Game Session. The Game service allows Game, User, Score and
 * ScoreBoard Management on the Cloud. The service allows Game Developer to
 * create a Game and then do in Game Scoring using the Score service. It also
 * allows to maintain a Scoreboard across game sessions using the ScoreBoard
 * service. One can query for average or highest score for user for a Game and
 * highest and average score across users for a Game. It also gives ranking of
 * the user against other users for a particular game. The Reward and
 * RewardPoints allows the Game Developer to assign rewards to a user and redeem
 * the rewards. E.g. One can give Swords or Energy etc. The services Game,
 * Score, ScoreBoard, Reward, RewardPoints can be used in Conjunction for
 * complete Game Scoring and Reward Management.
 *
 * @see Game, RewardPoint, RewardPoint, Score
 *
 */
@interface ScoreBoardService : NSObject{
    
    NSString *apiKey;
    NSString *secretKey;
}
@property (nonatomic, retain) NSString *apiKey;
@property (nonatomic, retain) NSString *secretKey;
/**
 * Saves the User score for a game
 *
 * @param gameName
 *            - Name of the game for which score has to be saved
 * @param gameUserName
 *            - The user for which score has to be saved
 * @param gameScore
 *            - The sore that has to be saved
 *
 * @return the saved score for a game
 * 
 */
-(Game*)saveUserScore:(NSString*)gameName gameUserName:(NSString*)gameUserName gameScore:(double)gameScore;
/**
 * Retrieves the scores for a game for the specified name
 *
 * @param gameName
 *            - Name of the game for which score has to be fetched
 * @param userName
 *            - The user for which score has to be fetched
 *
 * @return the game score for the specified user
 *
 */
-(Game*)getScoresByUser:(NSString*)gameName gameUserName:(NSString*)gameUserName;
/**
 * Retrieves the highest game score for the specified user
 *
 * @param gameName
 *            - Name of the game for which highest score has to be fetched
 * @param userName
 *            - The user for which highest score has to be fetched
 *
 * @return the highest game score for the specified user
 *
 */
-(Game*)getHighestScoreByUser:(NSString*)gameName gameUserName:(NSString*)gameUserName;
/**
 * Retrieves the lowest game score for the specified user
 *
 * @param gameName
 *            - Name of the game for which lowest score has to be fetched
 * @param userName
 *            - The user for which lowest score has to be fetched
 *
 * @return the lowest game score for the specified user
 *
 */
-(Game*)getLowestScoreByUser:(NSString*)gameName gameUserName:(NSString*)gameUserName;
/**
 * Retrieves the Top Rankings for the specified game
 *
 * @param gameName
 *            - Name of the game for which ranks have to be fetched
 *
 * @return the Top rankings for a game
 *
 */
-(Game*)getTopRankings:(NSString*)gameName;
/**
 * Retrieves the average game score for the specified user
 *
 * @param gameName
 *            - Name of the game for which average score has to be fetched
 * @param userName
 *            - The user for which average score has to be fetched
 *
 * @return the average game score for the specified user
 *
*/
-(Game*)getAverageScoreByUser:(NSString*)gameName userName:(NSString*)userName;
/**
 * Retrieves the Top Rankings for the specified game
 *
 * @param gameName
 *            - Name of the game for which ranks have to be fetched
 * @param max
 *            - Maximum number of records to be fetched
 *
 * @return the Top rankings for a game
 *
 */
-(Game*)getTopNRankings:(NSString*)gameName max:(int)max;

/**
 * Retrieves the Top N Rankers/Scorers for the specified game
 *
 * @param gameName
 *            - Name of the game for which ranks have to be fetched
 * @param max
 *            - Maximum number of records to be fetched
 *
 * @return the Top rankers for a game
 *
 */
-(Game*)getTopNRankers:(NSString*)gameName max:(int)max;

/**
 * Retrieves the Top N Rankers/Scorers for the specified game within the
 * given group
 * @param gameName
 *            - Name of the game for which ranks have to be fetched
 * @param group
 *            - array of usernames in the group
 *
 * @return the Top rankers for a game
 *
 */
-(Game*)getTopRankersByGroup:(NSString*)gameName group:(NSArray*)group;

/**
 * Retrieves the Top N Rankings for the specified game within the
 * given group
 * @param gameName
 *            - Name of the game for which ranks have to be fetched
 * @param group
 *            - array of usernames in the group
 *
 * @return the Top rankers for a game
 *
 */
-(Game*)getTopRankingsByGroup:(NSString*)gameName group:(NSArray*)group;

/**
 * Retrieves the last score made by the user in all games
 *
 * @param userName
 *            - Name of the user for which the last score has to be fetched
 *
 * @return the Top rankers for a game
 *
 */
-(Game*)getLastGameScore:(NSString*)userName;

/**
 * Retrieves the User Ranking for the specified game
 *
 * @param gameName
 *            - Name of the game for which ranks have to be fetched
 * @param userName
 *            - Name of the user for which ranks have to be fetched
 *
 * @return the rank of the User
 *
 */
-(Game*)getUserRanking:(NSString*)gameName userName:(NSString*)userName;
@end
