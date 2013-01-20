//
//  GlobalContext.m
//  Cocos2DSimpleGame
//
//  Created by Dhruv Chopra on 1/20/13.
//
//

#import "GlobalContext.h"

@implementation GlobalContext

NSMutableString *username;

static GlobalContext *_instance = nil;
@synthesize username = _username;

+ (GlobalContext*)sharedInstance
{
    if (_instance == nil) {
        _instance = [[super allocWithZone:NULL] init];
        
    }
    return _instance;
}

//
// Return your API Key here
//
+ (NSString*) API_KEY{
    return @"";
}

//
// Return your Secret Key here
//
+ (NSString*) SECRET_KEY{
    return @"";
}

//
// Return your Room Id here
//
+ (NSString*) ROOM_ID{
    return @"1476958417";
}

@end
