//
//  RoomListener.m
//  AppWarp_Project
//
//  Created by Shephertz Technology on 06/08/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "RoomListener.h"

@implementation RoomListener

@synthesize helper;

-(id)initWithHelper:(id)l_helper
{
    self.helper = l_helper;
    return self;
}

-(void)onSubscribeRoomDone:(RoomEvent*)roomEvent{
    
    if (roomEvent.result == SUCCESS) {
        //[[WarpClient getInstance]setCustomRoomData:roomEvent.roomData.roomId roomData:@"custom room data set"];
    }
    else {
    }
}
-(void)onUnSubscribeRoomDone:(RoomEvent*)roomEvent{
    if (roomEvent.result == SUCCESS)
    {
        
    }
    else
    {
        
    }
}
-(void)onJoinRoomDone:(RoomEvent*)roomEvent
{
   NSLog(@".onJoinRoomDone..on Join room listener called");
    
    if (roomEvent.result == SUCCESS)
    {
        RoomData *roomData = roomEvent.roomData;
        [[WarpClient getInstance]subscribeRoom:roomData.roomId];
        [[AppWarpHelper sharedAppWarpHelper] getAllUsers];
    }
    else {
    }
    
}
-(void)onLeaveRoomDone:(RoomEvent*)roomEvent{
    if (roomEvent.result == SUCCESS) {
        //[[WarpClient getInstance]unsubscribeRoom:roomEvent.roomData.roomId];
    }
    else {
    }
}
-(void)onGetLiveRoomInfoDone:(LiveRoomInfoEvent*)event{
    NSString *joinedUsers = @"";
    NSLog(@"joined users array = %@",event.joinedUsers);
    
    for (int i=0; i<[event.joinedUsers count]; i++)
    {
        joinedUsers = [joinedUsers stringByAppendingString:[event.joinedUsers objectAtIndex:i]];
    }
    
    
    
}
-(void)onSetCustomRoomDataDone:(LiveRoomInfoEvent*)event{
    NSLog(@"event joined users = %@",event.joinedUsers);
    NSLog(@"event custom data = %@",event.customData);

}

@end
