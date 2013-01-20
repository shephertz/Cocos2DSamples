//
//  GlobalContext.h
//  Cocos2DSimpleGame
//
//  Created by Dhruv Chopra on 1/20/13.
//  Singleton for storing the username
//

#import <Foundation/Foundation.h>

@interface GlobalContext : NSObject

+ (GlobalContext*)sharedInstance;

@property (copy, nonatomic) NSMutableString *username;
+(NSString*) API_KEY;
+(NSString*) SECRET_KEY;
+(NSString*) ROOM_ID;
@end
