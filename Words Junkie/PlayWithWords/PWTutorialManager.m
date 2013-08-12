//
//  PWTutorialManager.m
//  PlayWithWords
//
//  Created by shephertz technologies on 13/06/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWTutorialManager.h"
#import "PWGameLogicLayer.h"
#import "PWMenuLayer.h"
@implementation PWTutorialManager
-(id)init
{
    if (self=[super init])
    {
        
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}


-(void)showTutorialStep:(TutorialStep)step
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    switch (step)
    {
        case kDragNDrop:
            
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            {
                [self showMessagePromptWithMessage:@"Drag a character from the rack and drop any where on the board" atPosition:CGPointMake(winSize.width/3.0, 2.5*winSize.height/4) withFlipY:NO];
                [self showIndicatorAtPoint:ccp(winSize.width/8,CHARACTER_MENU_HEIGHT_IPHONE*2.0f) andDirection:kDownward];

            }
            else
            {
                [self showMessagePromptWithMessage:@"Drag a character from the rack and drop any where on the board" atPosition:CGPointMake(winSize.width/3.5, winSize.height/2) withFlipY:NO];
                [self showIndicatorAtPoint:ccp(CHARACTER_MENU_HEIGHT_IPAD,CHARACTER_MENU_HEIGHT_IPAD*3.0f) andDirection:kDownward];

            }
            break;
        case kSelectCharcater:
        {
            PWGameLogicLayer *gameLayer = [PWGameLogicLayer sharedInstance];
            CGPoint index = CGPointFromString([[NSUserDefaults standardUserDefaults] objectForKey:TUTORIAL_CHAR_INDEX]);
            CGPoint pos = [[PWGameLogicLayer sharedInstance] getCorrectCharPositionForTheIndex:CGPointMake(index.x, index.y+1)];
            float rowWidth = [[PWGameLogicLayer sharedInstance] rowWidth];
            float rowHeight = [[PWGameLogicLayer sharedInstance] rowHeight];
            BOOL isFlip = NO;
            if (index.y<[gameLayer numberOfColumns]/2 && index.x >= [gameLayer numberOfRows]/2)
            {
                isFlip = YES;
            }
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            {
                
                [self showMessagePromptWithMessage:@"Tap on the character to select and form a word...Longer the word, the more points you get!" atPosition:CGPointMake(winSize.width/3.0, winSize.height/2) withFlipY:isFlip];

                [self showIndicatorAtPoint:ccp(pos.x+rowWidth,pos.y+rowHeight/2) andDirection:kLeftWard];
            }
            else
            {
                
                [self showMessagePromptWithMessage:@"Tap on the character to select and form a word...Longer the word, the more points you get!" atPosition:CGPointMake(winSize.width/3.5, winSize.height/2) withFlipY:isFlip];

                [self showIndicatorAtPoint:ccp(pos.x+rowWidth,pos.y+rowHeight/2) andDirection:kLeftWard];
            }
        }
            break;
        case kClickOnPlay:
        {
            
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            {
                [self showMessagePromptWithMessage:@"Tap on Play to submit your word!" atPosition:CGPointMake(winSize.width/3.0, winSize.height/1.8) withFlipY:YES];
                [self showIndicatorAtPoint:ccp(13.5*winSize.width/16,13*winSize.height/16) andDirection:kRightWard];
            }
            else
            {
                [self showMessagePromptWithMessage:@"Tap on Play to submit your word!" atPosition:CGPointMake(winSize.width/3.5, winSize.height/2) withFlipY:YES];
                CGPoint pos = [[[PWGameLogicLayer sharedInstance] menuLayer] getPlayButtonPosition];

                [self showIndicatorAtPoint:ccp(pos.x,pos.y+1.3*winSize.height/16) andDirection:kDownward];
            }
        }
            break;
        case kCompleted:
        {
            [self showMessagePromptWithMessage:@"Fantastic, you are ready to play now!" atPosition:CGPointMake(winSize.width/2, winSize.height/2) withFlipY:YES];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:step] forKey:NEXT_TUTORIAL_STEP];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:TUTORIAL_STATUS];            
        }
            break;
        default:
            break;
    }
}

-(void)setTutorialElementsVisible:(BOOL)isVisible
{
    [self removeTutorialElements];
}

-(void)removeTutorialElements
{
    [mrJunkie removeFromParentAndCleanup:YES];
    [messageBg removeAllChildrenWithCleanup:YES];
    [messageBg removeFromParentAndCleanup:YES];
    [arrowSprite removeFromParentAndCleanup:YES];
    messageBg = nil;
    arrowSprite = nil;
    mrJunkie=nil;
}

-(void)showMessagePromptWithMessage:(NSString*)message atPosition:(CGPoint)pos withFlipY:(BOOL)isFlip
{
    if (!messageBg)
    {
        [self createMessagePromptWithMessage:message atPosition:pos withFlipY:isFlip];
    }
    else
    {
        CCLabelTTF *messageLabel = (CCLabelTTF*)[messageBg getChildByTag:10];
        messageBg.position = pos;
        [messageLabel setString:message];
    }
}

-(void)createMessagePromptWithMessage:(NSString*)message atPosition:(CGPoint)pos withFlipY:(BOOL)isFlip
{    
    float y_pos=0.5f;
    if (isFlip)
    {
        y_pos=-0.6f;
    }
    messageBg = [CCSprite spriteWithFile:@"TutorialBubble.png"] ;
    CGSize size = messageBg.contentSize;
    messageBg.flipY = isFlip;
    messageBg.position = ccp(pos.x,pos.y-size.height*y_pos);
    [[PWGameLogicLayer sharedInstance] addChild:messageBg z:SELECTED_ALPHABET+2];
    
    
    mrJunkie = [CCSprite spriteWithFile:@"MrJunkieStanding.png"] ;
    mrJunkie.position = ccp(pos.x-size.width/2-mrJunkie.contentSize.width/2,pos.y);
    [[PWGameLogicLayer sharedInstance] addChild:mrJunkie z:SELECTED_ALPHABET+2];
    
    
    int fontSize;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        fontSize =14;
    }
    else
    {
        fontSize =24;
    }
    
    CCLabelTTF *messageLabel = [CCLabelTTF labelWithString:message fontName:GLOBAL_FONT fontSize:fontSize dimensions:CGSizeMake(14*size.width/16, 15*size.height/16) hAlignment:kCCTextAlignmentCenter vAlignment:kCCVerticalTextAlignmentCenter];
    messageLabel.position = ccp(8.5*size.width/16,size.height/2);
    messageLabel.tag = 10;
    messageLabel.color = ccBLACK;
    [messageBg addChild:messageLabel];
}

-(void)showIndicatorAtPoint:(CGPoint)point andDirection:(TutorialArrowDirection)direction
{
    if (!arrowSprite)
    {
        [self createClickPointIndicatorAtPostion:point];
    }
    
    //[arrowSprite stopAllActions];
    
    float x_var,y_var;
    if (direction==kUpward)
    {
        arrowSprite.rotation = 180;
        x_var = 0;
        y_var = 10;
    }
    else if (direction==kDownward)
    {
        //arrowSprite.rotation = -90;
        x_var = 0;
        y_var = 10;
    }
    else if (direction==kLeftWard)
    {
        arrowSprite.rotation = 90;
        x_var = 10;
        y_var = 0;
    }
    else
    {
        arrowSprite.rotation = -90;
        x_var = 10;
        y_var = 0;
    }
    
    id action_move = [CCMoveBy actionWithDuration:0.5f position:CGPointMake(x_var, y_var)];
    id action_reverse = [action_move reverse];
    id action_sequence = [CCSequence actions:action_move,action_reverse, nil];
    [arrowSprite runAction:[CCRepeatForever actionWithAction:action_sequence]];
}

-(void)createClickPointIndicatorAtPostion:(CGPoint)pos
{
    arrowSprite = [CCSprite spriteWithFile:@"TutorialArrow.png"];
    arrowSprite.position = pos;
    [[PWGameLogicLayer sharedInstance] addChild:arrowSprite z:SELECTED_ALPHABET+3];
}


@end
