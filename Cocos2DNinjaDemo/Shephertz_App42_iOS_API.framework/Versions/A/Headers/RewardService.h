//
//  RewardService.h
//  App42_iOS_SERVICE_APIs
//
//  Created by Shephertz Technology on 21/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RewardResponseBuilder.h"
@class Reward;

/**
 * Define a Reward e.g. Sword, Energy etc. Is needed for Reward Points
 *
 * The Game service allows Game, User, Score and ScoreBoard Management on the
 * Cloud. The service allows Game Developer to create a Game and then do in Game
 * Scoring using the Score service. It also allows to maintain a Scoreboard
 * across game sessions using the ScoreBoard service. One can query for average
 * or highest score for user for a Game and highest and average score across
 * users for a Game. It also gives ranking of the user against other users for a
 * particular game. The Reward and RewardPoints allows the Game Developer to
 * assign rewards to a user and redeem the rewards. E.g. One can give Swords or
 * Energy etc. The services Game, Score, ScoreBoard, Reward, RewardPoints can be
 * used in Conjunction for complete Game Scoring and Reward Management.
 *
 * @see Game, RewardPoint, Score, ScoreBoard
 */
@interface RewardService : NSObject{
    
    NSString *apiKey;
    NSString *secretKey;
}
@property (nonatomic, retain) NSString *apiKey;
@property (nonatomic, retain) NSString *secretKey;
/**
 * Creates Reward. Reward can be Sword, Energy etc. When Reward Points have
 * to be added the Reward name created using this method has to be
 * specified.
 *
 * @param rewardName
 *            - The reward that has to be created
 * @param rewardDescription
 *            - The description of the reward to be created
 *
 * @return Reward object containing the reward that has been created
 * 
 */
-(Reward*)createReward:(NSString*)rewardName rewardDescription:(NSString*)rewardDescription;
/**
 * Fetches the count of all the Rewards
 *
 * @return App42Response objects containing count of all the rewards of the
 *         App
 *
 */
-(App42Response*)getAllRewardsCount;
/**
 * Fetches all the Rewards
 *
 * @return List of Reward objects containing all the rewards of the App
 *
 */
-(NSArray*)getAllRewards;
/**
 * Fetches all the Rewards by paging.
 *
 * @param max
 *            - Maximum number of records to be fetched
 * @param offset
 *            - From where the records are to be fetched
 *
 * @return List of Reward objects containing all the rewards of the App
 *
 */
-(NSArray*)getAllRewards:(int)max offset:(int)offset;
/**
 * Retrieves the reward for the specified name
 *
 * @param rewardName
 *            - Name of the reward that has to be fetched
 *
 * @return Reward object containing the reward based on the rewardName
 *
 */
-(Reward*)getRewardByName:(NSString*)rewardName;
/**
 * Adds the reward points to an users account. Reward Points can be earned
 * by the user which can be redeemed later.
 *
 * @param gameName
 *            - Name of the game for which reward points have to be added
 * @param gameUserName
 *            - The user for whom reward points have to be added
 * @param rewardName
 *            - The rewards for which reward points have to be added
 * @param rewardPoints
 *            - The points that have to be added
 *
 * @return Reward object containing the reward points that has been added
 *
 */
-(Reward*)earnRewards:(NSString*)gameName gameUserName:(NSString*)gameUserName rewardName:(NSString*)rewardName rewardPoints:(double)rewardsPoints;
/**
 * Deducts the reward points from the earned rewards by a user.
 *
 * @param gameName
 *            - Name of the game for which reward points have to be deducted
 * @param gameUserName
 *            - The user for whom reward points have to be deducted
 * @param rewardName
 *            - The rewards for which reward points have to be deducted
 * @param rewardPoints
 *            - The points that have to be deducted
 *
 * @return Reward object containing the reward points that has been deducted
 *
 */
-(Reward*)redeemRewards:(NSString*)gameName gameUserName:(NSString*)gameUserName rewardName:(NSString*)rewardName rewardPoints:(double)rewardsPoints;
/**
 * Fetches the reward points for a particular user
 *
 * @param gameName
 *            - Name of the game for which reward points have to be fetched
 * @param userName
 *            - The user for whom reward points have to be fetched
 *
 * @return Reward object containing the reward points for the specified user
 *
 * @throws App42Exception
 *
 */
-(Reward*)getGameRewardPointsForUser:(NSString*)gameName userName:(NSString*)userName;

@end
