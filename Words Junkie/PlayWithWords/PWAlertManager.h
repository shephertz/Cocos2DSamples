//
//  PWAlertManager.h
//  PlayWithWords
//
//  Created by shephertz technologies on 07/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWAlertManager : NSObject<UIAlertViewDelegate>
{
    id alertLayer;
    UIAlertView *alertView;
    BOOL isSingleButtonAlert;
    BOOL isAlertDisplayed;
}

@property(nonatomic,assign) AlertType alertType;


-(void)showTurnAlertWithAlertInfo:(NSDictionary*)alertInfo;
-(void)showTwoButtonAlertWithInfo:(NSDictionary*)alertInfo;
-(void)showOneButtonAlertWithInfo:(NSDictionary*)alertInfo;

-(void)dismissAlert;
@end
