/*****************************************************************
 *  PWCharacter.h
 *  PlayWithWords
 *  Created by shephertz technologies on 18/04/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PWCharacter : CCLayerColor
{
    CGPoint prevTouchPoint;
    int pos_index;
}
@property(nonatomic,assign) BOOL isMovable;
@property(nonatomic,assign) BOOL isPlaced;
@property(nonatomic,retain) NSString *alphabet;
@property(nonatomic,assign) int pos_index;

-(void)startNotPlaceableIndicatorAnimation:(BOOL)isAnimate;
-(void)illuminateChar:(BOOL)isIlluminate;
-(void)animateTheChar:(BOOL)shouldAnimate;
-(void)changeTextureWithImage:(NSString*)imageName;
-(void)setSelected:(BOOL)isSelected;
@end
