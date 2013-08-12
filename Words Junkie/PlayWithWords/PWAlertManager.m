//
//  PWAlertManager.m
//  PlayWithWords
//
//  Created by shephertz technologies on 07/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWAlertManager.h"
#import "PWAlertLayer.h"
#import "PWGameLogicLayer.h"
#import "PWGameController.h"

@implementation PWAlertManager
@synthesize alertType;

-(void)showTurnAlertWithAlertInfo:(NSDictionary*)alertInfo
{
    
    isSingleButtonAlert= NO; 
    if (isAlertDisplayed && [[PWGameLogicLayer sharedInstance] timeLeft]<=0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        alertView = nil;
    }
    
   alertView = [[UIAlertView alloc]
                              initWithTitle:[alertInfo objectForKey:ALERT_TITLE]
                              message:[alertInfo objectForKey:ALERT_MESSAGE]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}

-(void)showTwoButtonAlertWithInfo:(NSDictionary*)alertInfo
{
    
    isSingleButtonAlert= NO;
    if (isAlertDisplayed && [[PWGameLogicLayer sharedInstance] timeLeft]<=0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        alertView = nil;
        isAlertDisplayed =NO;
    }
    alertView = [[UIAlertView alloc]
                              initWithTitle:[alertInfo objectForKey:ALERT_TITLE]
                              message:[alertInfo objectForKey:ALERT_MESSAGE]
                              delegate:self
                              cancelButtonTitle:[alertInfo objectForKey:ALERT_CANCEL_BUTTON_TEXT]
                              otherButtonTitles:[alertInfo objectForKey:ALERT_OK_BUTTON_TEXT], nil];
    [alertView show];
    [alertView release];
    isAlertDisplayed =YES;
}

-(void)showOneButtonAlertWithInfo:(NSDictionary*)alertInfo
{
    
    isSingleButtonAlert= YES;
    if (isAlertDisplayed && [[PWGameLogicLayer sharedInstance] timeLeft]<=0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        alertView = nil;
        isAlertDisplayed =NO;
    }
    alertView = [[UIAlertView alloc]
                              initWithTitle:[alertInfo objectForKey:ALERT_TITLE]
                              message:[alertInfo objectForKey:ALERT_MESSAGE]
                              delegate:self
                              cancelButtonTitle:[alertInfo objectForKey:ALERT_CANCEL_BUTTON_TEXT]
                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    isAlertDisplayed =YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isAlertDisplayed =NO;
	if (buttonIndex == 0)
    {//Cancel button pressed
		NSLog(@"user pressed Cancel");
        if (alertType==kNoNetwork)
        {
            exit(1);
        }
        else if (alertType==kPassTurnAlert && isSingleButtonAlert)
        {
            [[PWGameLogicLayer sharedInstance] passTheMove];
        }
	}
	else
    {//Ok Button pressed
		NSLog(@"user pressed OK");
        if (alertType==kInvalidWordAlert)
        {
            [[PWGameLogicLayer sharedInstance] continueWithThisInvalidWord];
        }
        else if (alertType==kValidWordAlert)
        {
            [[PWGameLogicLayer sharedInstance] continueWithThisValidWord];
        }
        else if (alertType==kPassTurnAlert)
        {
            [[PWGameLogicLayer sharedInstance] passTheMove];
        }
        else if (alertType==kGameOverAlert)
        {
            [[PWGameLogicLayer sharedInstance] performSelector:@selector(takeSnapShot) withObject:nil afterDelay:0.1];
        }
        else if (alertType==kQuitGameAlert)
        {
            [[PWGameLogicLayer sharedInstance] quitFromTheRunningGame];
        }
        else if (alertType==kNoNetwork)
        {
            exit(1);
        }
	}
}


-(void)dismissAlert
{
    [[PWGameLogicLayer sharedInstance] removeChild:alertLayer cleanup:YES];
}

@end
