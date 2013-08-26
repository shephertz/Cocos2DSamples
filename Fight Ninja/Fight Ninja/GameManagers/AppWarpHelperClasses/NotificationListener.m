//
//  NotificationListener.m
//  AppWarp_Project
//
//  Created by Shephertz Technology on 06/08/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "NotificationListener.h"
#import "cocos2d.h"
#import "NFStoryBoardManager.h"

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
-(void)onUserLeftRoom:(RoomData*)roomData username:(NSString*)username
{
    //NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Error:",@"title",@"Your enemy left the room!",@"message", nil];
    //[[AppWarpHelper sharedAppWarpHelper] onConnectionFailure:dict];
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

-(void)onUserPaused:(NSString *)userName withLocation:(NSString *)locId isLobby:(BOOL)isLobby
{
    [[CCDirector sharedDirector] pause];
    NSLog(@"%s..username=%@",__FUNCTION__,userName);
    NSLog(@"locId=%@",locId);
    NSLog(@"isLobby=%d",isLobby);
    [[NFStoryBoardManager sharedNFStoryBoardManager] showPausedView:[NSString stringWithFormat:@"Waiting for %@ response...",userName]];
}

-(void)onUserResumed:(NSString *)userName withLocation:(NSString *)locId isLobby:(BOOL)isLobby
{
    
    NSLog(@"%s..username=%@",__FUNCTION__,userName);
    NSLog(@"locId=%@",locId);
    NSLog(@"isLobby=%d",isLobby);
    [[NFStoryBoardManager sharedNFStoryBoardManager] removePausedView];
}

-(void)onUserChangeRoomProperty:(RoomData *)event username:(NSString *)username properties:(NSDictionary *)properties lockedProperties:(NSDictionary *)lockedProperties
{
    
}

-(void)onMoveCompleted:(MoveEvent *)moveEvent
{
    
}

-(void)onPrivateChatReceived:(NSString *)message fromUser:(NSString *)senderName
{
    
}

@end
