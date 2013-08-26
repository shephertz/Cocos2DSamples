//
//  User.h
//  App42_iOS_SERVICE_API
//
//  Created by Shephertz Technology on 07/02/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42Response.h"
@class Profile;

/**
 *User class contain the member variables and allowed to be set and get.
 * 
 */


@interface User : App42Response
{
    NSString *userName;
    NSString *email;
    NSString *password;
    NSArray  *roleList;
    NSString *sessionId;
    Profile  *profile;
    BOOL isAccountLocked;
}
/*!
 *set and get the name of the User.
 */
@property(nonatomic,retain)NSString *userName;
/*!
 *set and get the sessionId of the User's session.
 */
@property(nonatomic,retain)NSString *sessionId;
/*!
 *set and get the email of the User.
 */
@property(nonatomic,retain)NSString *email;
/*!
 *set and get the password of the User.
 */
@property(nonatomic,retain)NSString *password;
/*!
 *set and get the Profile object for the User.
 */
@property(nonatomic,retain)Profile *profile;
/*!
 * set and get the User's account status.
 */
@property(nonatomic,assign)BOOL isAccountLocked;
/*!
 *set and get the the roles assigned to the User
 */
@property(nonatomic,retain)NSArray *roleList;

-(NSString*)toString;
@end
