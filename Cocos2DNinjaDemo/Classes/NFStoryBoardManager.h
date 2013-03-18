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
@interface NFStoryBoardManager : NSObject
{
    LeaderBoardViewController *leaderboardController;
    UserNameController        *userNameController;
}

+(NFStoryBoardManager *)sharedNFStoryBoardManager;


-(void)showLeaderBoardView;
-(void)removeLeaderBoardView;
-(void)showUserNameView;
-(void)removeUserNameView;
-(void)showGameLoadingIndicator;
-(void)removeGameLoadingIndicator;
@end
