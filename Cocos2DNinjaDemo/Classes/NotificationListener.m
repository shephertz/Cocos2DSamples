//
//  NotificationListener.m
//  AppWarp_Project
//
//  Created by Shephertz Technology on 06/08/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "NotificationListener.h"

@implementation NotificationListener

@synthesize helper;

-(id)initWithHelper:(id)l_helper
{
    self.helper = l_helper;
    return self;
}

-(void)onRoomCreated:(RoomData*)roomEvent{
    
}
-(void)onRoomDestroyed:(RoomData*)roomEvent{
    
}
-(void)onUserLeftRoom:(RoomData*)roomData username:(NSString*)username{
    
}
-(void)onUserJoinedRoom:(RoomData*)roomData username:(NSString*)username
{
   //[[AppWarpHelper sharedAppWarpHelper] getAllUsers];
}
-(void)onUserLeftLobby:(LobbyData*)lobbyData username:(NSString*)username{
    
}
-(void)onUserJoinedLobby:(LobbyData*)lobbyData username:(NSString*)username{
    
}
-(void)onChatReceived:(ChatEvent*)chatEvent{
    
    //[[WarpClient getInstance]leaveRoom:chatEvent.locId];
    //[[WarpClient getInstance]leaveLobby];
    
}

-(void)onUpdatePeersReceived:(UpdateEvent*)updateEvent
{
    [helper receivedEnemyStatusData:updateEvent.update];
}

@end
