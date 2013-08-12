//
//  PWSnapShotFlash.m
//  PlayWithWords
//
//  Created by shephertz technologies on 04/06/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWSnapShotFlash.h"
#import "PWGameController.h"
#import "SimpleAudioEngine.h"
@implementation PWSnapShotFlash

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
		self.alpha = 0.0f;
    }
    return self;
}

- (void)startFlashEffect
{
    [[SimpleAudioEngine sharedEngine] playEffect:SNAPSHOT_CLICKED];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationRepeatAutoreverses:YES];
	[UIView setAnimationRepeatCount:1];
	self.alpha = 1.0f;
	[UIView setAnimationDidStopSelector:@selector(flashStopped)];
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
}

- (void)flashStopped
{
	self.alpha = 0.0f;
    
	[[PWGameController sharedInstance] switchToLayerWithCode:kSnapShotView];
    
	[self removeFromSuperview];
}

- (void)dealloc
{
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
