//
//  PWTutorialManager.h
//  PlayWithWords
//
//  Created by shephertz technologies on 13/06/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface PWTutorialManager : NSObject
{
    CCSprite *messageBg;
    CCSprite *arrowSprite;
    CCSprite *mrJunkie;
}
-(void)showTutorialStep:(TutorialStep)step;
-(void)showMessagePromptWithMessage:(NSString*)message atPosition:(CGPoint)pos withFlipY:(BOOL)isFlip;
-(void)createMessagePromptWithMessage:(NSString*)message atPosition:(CGPoint)pos withFlipY:(BOOL)isFlip;
-(void)createClickPointIndicatorAtPostion:(CGPoint)pos;
-(void)showIndicatorAtPoint:(CGPoint)point andDirection:(TutorialArrowDirection)direction;
-(void)setTutorialElementsVisible:(BOOL)isVisible;
-(void)removeTutorialElements;
@end
