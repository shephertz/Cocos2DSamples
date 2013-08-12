//
//  PWDrawLine.h
//  PlayWithWords
//
//  Created by shephertz technologies on 19/04/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PWDrawLine : CCSprite
{
    CGPoint startPoint;
    CGPoint endPoint;
    NSMutableArray *pointsArray;
    
}
@property(nonatomic,retain) NSMutableArray *pointsArray;

-(id)initWithStartPoint:(CGPoint)l_startPoint andEndPoint:(CGPoint)l_endPoint;

@end
