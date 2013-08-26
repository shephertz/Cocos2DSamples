//
//  ConnectionListener.m
//  Cocos2DSimpleGame
//
//  Created by Rajeev on 23/01/13.
//
//

#import "ConnectionListener.h"
#import "FNGameOverLayer.h"
@implementation ConnectionListener
@synthesize helper;

-(id)initWithHelper:(id)l_helper
{
    self.helper = l_helper;
    return self;
}

-(void)onConnectDone:(ConnectEvent*) event
{
    NSLog(@"%s...name=%@",__FUNCTION__,[helper userName]);
    if (event.result==SUCCESS)
    {
        NSLog(@"connection success");
        //[[WarpClient getInstance] joinRoom:[[AppWarpHelper sharedAppWarpHelper] roomId]];
        [[WarpClient getInstance] joinRoomInRangeBetweenMinUsers:0 andMaxUsers:1 maxPrefered:YES];
    }
    else if (event.result==SUCCESS_RECOVERED)
    {
        NSLog(@"connection recovered");
        [[AppWarpHelper sharedAppWarpHelper] unScheduleRecover];
    }
    else if (event.result==CONNECTION_ERROR_RECOVERABLE)
    {
        NSLog(@"recoverable connection error");
        [[AppWarpHelper sharedAppWarpHelper] scheduleRecover];
        
    }
    else if (event.result==BAD_REQUEST)
    {
        
        NSLog(@"Bad request");
    }
    else
    {
        NSLog(@"Disconnected");
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Connection Error:",@"title",@"Please check ur internet connection!",@"message", nil];
        [[AppWarpHelper sharedAppWarpHelper] onConnectionFailure:dict];
    }
}



-(void)onJoinZoneDone:(ConnectEvent*) event
{
    if (event.result==0)
    {
        NSLog(@"Join Zone done");
        
        //[[WarpClient getInstance] joinRoom:[[AppWarpHelper sharedAppWarpHelper] roomId]];
    }
    else
    {
        NSLog(@"Join Zone failed");
    }

}


-(void)onAuthenticationDone:(ConnectEvent*) event
{
    if(event.result == SUCCESS)
    {
        NSLog(@"I am authenticated");
    }
}

-(void)onDisconnectDone:(ConnectEvent*) event{
    NSLog(@"On Disconnect invoked");
}

-(void)onGetMatchedRoomsDone:(MatchedRoomsEvent *)event
{
    
}

#pragma mark ------
#pragma mark ZoneListener Protocol methods


-(void)onCreateRoomDone:(RoomEvent*)roomEvent{
    RoomData *roomData = roomEvent.roomData;
    NSLog(@"roomEvent result = %i",roomEvent.result);
    NSLog(@"room id = %@",roomData.roomId);
    [[AppWarpHelper sharedAppWarpHelper] setRoomId:roomData.roomId];
    [[WarpClient getInstance] joinRoom:roomData.roomId];
    //[[WarpClient getInstance]getAllRooms];
}

-(void)onDeleteRoomDone:(RoomEvent*)roomEvent{
    if (roomEvent.result == SUCCESS) {
    }
    else {
    }
}

-(void)onGetAllRoomsDone:(AllRoomsEvent*)event{
    if (event.result == SUCCESS) {
        //[[WarpClient getInstance]getOnlineUsers];
    }
    else {
    }
}
-(void)onGetOnlineUsersDone:(AllUsersEvent*)event{
    if (event.result == SUCCESS)
    {
        NSLog(@"usernames = %@",event.userNames);
//        int userCount = [event.userNames count];
//        [[AppWarpHelper sharedAppWarpHelper] setNumberOfPlayers:userCount];
//        if (userCount==2)
//        {
//            
//        }
    }
    else 
    {
        
    }
    
}
-(void)onGetLiveUserInfoDone:(LiveUserInfoEvent*)event{
    NSLog(@"onGetLiveUserInfo called");
    if (event.result == SUCCESS)
    {
        //[[WarpClient getInstance]setCustomUserData:event.name customData:usernameTextField.text];
    }
    else {
    }
    
}
-(void)onSetCustomUserDataDone:(LiveUserInfoEvent*)event{
    if (event.result == SUCCESS) {
    }
    else {
    }
}




@end
