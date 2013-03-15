//
//  NFStoryBoardManager.h
//  Cocos2DSimpleGame
//
//  Created by shephertz technologies on 14/03/13.
//
//

#import <Foundation/Foundation.h>
@class LeaderBoardViewController;
@interface NFStoryBoardManager : NSObject
{
    LeaderBoardViewController *leaderboardController;
}

+(NFStoryBoardManager *)sharedNFStoryBoardManager;


-(void)showLeaderBoardView;
-(void)removeLeaderBoardView;

@end
