
/*****************************************************************
 *  IntroLayer.m
 *  PlayWithWords
 *  Created by shephertz technologies on 18/04/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

// Import the interfaces
#import "IntroLayer.h"
#import "PWGameLogicLayer.h"
#import "PWGameController.h"
#import "PWFacebookHelper.h"
#pragma mark - IntroLayer

// IntroLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the IntroLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
//	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[[[PWGameController sharedInstance] getGameScene] addChild: layer];
	
	// return the scene
	return [[PWGameController sharedInstance] getGameScene];
}

// 
-(id) init
{
	if( (self=[super init]))
    {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
//    [[CCDirector sharedDirector] replaceScene:[PWGameLogicLayer scene]];
//    [[PWGameLogicLayer sharedInstance] startGame];
    
    [[PWGameController sharedInstance] switchToLayerWithCode:kHomeLayer];
    //[[PWGameController sharedInstance] runGameScene];
	
}

-(NSString*)getUTCTimeFormattedStamp
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss a.SSS'Z'"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    NSLog(@"dateString=%@",dateString);
    NSLog(@"dateString_1=%@",[self changeformate_string24hr:dateString]);
    
    return dateString;
    
}

-(NSString *)changeformate_string24hr:(NSString *)date
{
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [df setTimeZone:timeZone];
    //[df setTimeZone:[NSTimeZone systemTimeZone]];
    
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss a.SSS'Z'"];
    
    NSDate* wakeTime = [df dateFromString:date];
    
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    
    return [df stringFromDate:wakeTime];
    
}
@end
