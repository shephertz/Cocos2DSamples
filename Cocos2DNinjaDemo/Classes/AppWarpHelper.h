//
//  AppWarpHelper.h
//  Cocos2DSimpleGame
//
//  Created by Rajeev on 25/01/13.
//
//

#import <Foundation/Foundation.h>
#import "Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h"

@interface AppWarpHelper : NSObject
{
    ServiceAPI *serviceAPIObject;
}
@property(nonatomic,retain) id delegate;
@property (nonatomic,retain) NSString *roomId;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *emailId;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *enemyName;
@property (nonatomic,assign) BOOL     alreadyRegistered;
@property (nonatomic,assign) int      score;

+(AppWarpHelper *)sharedAppWarpHelper;
-(void)initializeAppWarp;
-(void)setCustomDataWithData:(NSData*)data;
-(void)receivedEnemyStatusData:(NSData*)data;
-(void)getAllUsers;
-(BOOL)registerUser;
-(BOOL)signInUser;
-(void)saveScore;
-(NSMutableArray*)getScores;
@end
