/*****************************************************************
 *  PWAlertLayer.m
 *  PlayWithWords
 *  Created by shephertz technologies on 03/05/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import "PWAlertLayer.h"


@implementation PWAlertLayer

#pragma mark--
#pragma mark-- Initialization Methods
#pragma mark--

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
    if (self=[super initWithColor:color width:w height:h])
    {

    }
    return self;
}

-(void)showNormalAlertWithInfo:(NSDictionary*)alertInfoDict
{
    CGSize layerSize = self.contentSize;
    
    NSString *title = [alertInfoDict objectForKey:ALERT_TITLE];
    CGPoint messagePos; 
    if (title)
    {
        CCLabelTTF *alertTitle = [CCLabelTTF labelWithString:title fontName:GLOBAL_FONT fontSize:30];
        [alertTitle setPosition:ccp(layerSize.width/2, layerSize.height/1.5)];
        [alertTitle setColor:ccBLACK];
        [self addChild:alertTitle];
        messagePos = ccp(layerSize.width/2, layerSize.height/3);
    }
    else
        messagePos = ccp(layerSize.width/2, layerSize.height/2);
    
    CCLabelTTF *alertMessage = [CCLabelTTF labelWithString:[alertInfoDict objectForKey:ALERT_MESSAGE] fontName:GLOBAL_FONT fontSize:30 dimensions:CGSizeMake(layerSize.width, layerSize.height) hAlignment:kCCTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap];
    [alertMessage setPosition:messagePos];
    [alertMessage setVerticalAlignment:kCCVerticalTextAlignmentCenter];
    [alertMessage setColor:ccBLACK];
    [self addChild:alertMessage];
}


-(void)dealloc
{
    [super dealloc];
}
@end
