//
//  TurnBasedRoomListener.h
//  AppWarp_Project
//
//  Created by shephertz technologies on 24/07/13.
//  Copyright (c) 2013 ShephertzTechnology PVT LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TurnBasedRoomListener <NSObject>
@required

/**
 * Invoked when a room is created. Lobby subscribers will receive this.
 * @param event
 */
-(void)onSendMoveDone:(Byte) result;
    


@end
