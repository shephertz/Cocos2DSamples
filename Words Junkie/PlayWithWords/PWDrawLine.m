//
//  PWDrawLine.m
//  PlayWithWords
//
//  Created by shephertz technologies on 19/04/13.
//  Copyright 2013 shephertz technologies. All rights reserved.
//

#import "PWDrawLine.h"


@implementation PWDrawLine

@synthesize pointsArray;

-(id)init
{
    if (self=[super init])
    {
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        self.pointsArray = array;
        [array release];
    }
    return self;
}
-(id)initWithStartPoint:(CGPoint)l_startPoint andEndPoint:(CGPoint)l_endPoint
{
    if (self=[super init])
    {
        startPoint  = l_startPoint;
        endPoint    = l_endPoint;
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        self.pointsArray = array;
        [array release];
    }
    return self;
}

-(void)draw
{
    if (pointsArray.count>=2)
    {
        glLineWidth( 4.0f );
        ccDrawColor4B(255,0,0,255);
        startPoint = CGPointFromString([pointsArray objectAtIndex:0]);
        endPoint = CGPointFromString([pointsArray objectAtIndex:1]);
        ccDrawLine( startPoint, endPoint );
    }
}


-(void)dealloc
{
    [super dealloc];
}

@end
