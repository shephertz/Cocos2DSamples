//
//  NFStoryBoardManager.h
//  Cocos2DSimpleGame
//
//  Created by shephertz technologies on 14/03/13.
//
//

#import <Foundation/Foundation.h>
@class LeaderBoardViewController;
@class UserNameController;
@class FNGameLogicLayer;
@interface NFStoryBoardManager : NSObject
{
    LeaderBoardViewController *leaderboardController;
    UserNameController        *userNameController;
    FNGameLogicLayer          *gameLogicLayer;
}

@property (nonatomic,assign) FNGameLogicLayer          *gameLogicLayer;

+(NFStoryBoardManager *)sharedNFStoryBoardManager;


-(void)showLeaderBoardView;
-(void)removeLeaderBoardView;
-(void)showUserNameView;
-(void)removeUserNameView;
-(void)showGameLoadingIndicator;
-(void)removeGameLoadingIndicator;
-(void)updatePlayerDataToServerWithDataDict:(NSDictionary*)dataDict;
@end
