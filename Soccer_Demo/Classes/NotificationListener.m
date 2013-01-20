//
//  NotificationListener.m
//  Cocos2DSimpleGame
//
//  Created by Dhruv Chopra on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotificationListener.h"
#import "GlobalContext.h"

@implementation NotificationListener

@synthesize gameView;

-(id)initWithGame:(GamePlay *)game{
    self.gameView = game;
    return self;
}


-(void)onRoomCreated:(RoomData*)roomEvent{
    
}
-(void)onRoomDestroyed:(RoomData*)roomEvent{
    
}
-(void)onUserLeftRoom:(RoomData*)roomData username:(NSString*)username{
    
}
-(void)onUserJoinedRoom:(RoomData*)roomData username:(NSString*)username{
    
}
-(void)onUserLeftLobby:(LobbyData*)lobbyData username:(NSString*)username{
    
}
-(void)onUserJoinedLobby:(LobbyData*)lobbyData username:(NSString*)username{
    
}
-(void)onChatReceived:(ChatEvent*)chatEvent{

}


//
// decode the NSData into JSON to get
// sender, xPos and yPos and invoke the callback 
// on the gameView reference 
// 
//

-(void)onUpdatePeersReceived:(UpdateEvent*)updateEvent{

    NSLog(@"onUpdate peers received");
    NSError* error = nil;
    
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:updateEvent.update
                          options:kNilOptions 
                          error:&error];
    
    
    int xLoc = [[json objectForKey:@"xPos"]intValue];
    int yLoc = [[json objectForKey:@"yPos"]intValue];
    NSString* sender = [json objectForKey:@"sender"];
    
    
    if(![sender isEqualToString:[[GlobalContext sharedInstance] username]]){
        [gameView handleRemoteTouchAtX:xLoc AtY:yLoc];
    }
    NSLog(@"notification received = %@,%i,%i",sender,xLoc,yLoc);
    
    
}

@end

@implementation RoomListener

-(void)onSubscribeRoomDone:(RoomEvent*)roomEvent{
    
    if (roomEvent.result == SUCCESS) {
        NSLog(@"Subscribed");
    }
    else {
        NSLog(@"subscribed failed");
    }
}
-(void)onUnSubscribeRoomDone:(RoomEvent*)roomEvent{
    if (roomEvent.result == SUCCESS) {
        NSLog(@"Room Unsubscribed");
    }
    else {
        NSLog(@"Room Unsubscribed failed");
    }
}
-(void)onJoinRoomDone:(RoomEvent*)roomEvent{
    if (roomEvent.result == SUCCESS) {
        NSLog(@"Room Joined");
    }
    else {
        NSLog(@"Room Join failed");
    }
    
}
-(void)onLeaveRoomDone:(RoomEvent*)roomEvent{
    if (roomEvent.result == SUCCESS) {
        NSLog(@"Room Left");
    }
    else {
        NSLog(@"Room Left failed");
    }
}
-(void)onGetLiveRoomInfoDone:(LiveRoomInfoEvent*)event{    
    
}
-(void)onSetCustomRoomDataDone:(LiveRoomInfoEvent*)event{
    NSLog(@"event joined users = %@",event.joinedUsers);
    NSLog(@"event custom data = %@",event.customData);
}

@end
