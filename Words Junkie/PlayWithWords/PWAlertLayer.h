
/*****************************************************************
 *  PWAlertLayer.h
 *  PlayWithWords
 *  Created by shephertz technologies on 03/05/13.
 *  Copyright 2013 shephertz technologies. All rights reserved.
 *****************************************************************/

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PWAlertLayer : CCLayerColor
{
    
}

-(void)showNormalAlertWithInfo:(NSDictionary*)alertInfoDict;
@end
