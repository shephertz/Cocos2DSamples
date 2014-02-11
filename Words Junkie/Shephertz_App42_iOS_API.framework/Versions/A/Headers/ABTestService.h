//
//  ABTestService.h
//  PAE_iOS_SDK
//
//  Created by Rajeev Ranjan on 17/10/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@class ABTest;
@interface ABTestService : App42Service

- (id) init __attribute__((unavailable));
/**
 * This is a constructor that takes
 *
 * @param apiKey
 * @param secretKey
 * @param baseURL
 *
 */
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;

/**
 * Goal Achieved for given test case variant.
 * @param testName
 * @param variantName
 * @return
 * @throws App42Exception
 */
-(ABTest*)goalAchievedForTest:(NSString*)testName withVariant:(NSString*)variantName;

/**
 * Executes given TestCase and returns variant profile from server
 * @param testName
 * @return
 * @throws App42Exception
 */
-(ABTest*)execute:(NSString*) testName;

/**
 * Executes given Data Driven TestCase and returns variant profile from server
 * @param testName
 * @return
 * @throws App42Exception
 */
-(ABTest*)executeDataDriven:(NSString*) testName;

-(BOOL)isActive:(NSString*) testName;


@end
