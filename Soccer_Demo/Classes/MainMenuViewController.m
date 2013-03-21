//
//  MainMenuViewController.m
//  Cocos2DSimpleGame
//
//  Created by Dhruv Chopra on 1/17/13.
//
//

#import "MainMenuViewController.h"
#import "GlobalContext.h"
#import "NotificationListener.h"

@implementation MainMenuViewController
@synthesize username = _username;
@synthesize error = _error;
@synthesize rootViewController = _rootViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationLandscapeLeft;
}

// Tell the system It should autorotate
- (BOOL) shouldAutorotate {
    return NO;
}

// Tell the system which initial orientation we want to have
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (IBAction)joinClicked:(id)sender {
    [_username resignFirstResponder];
    [WarpClient initWarp:[GlobalContext API_KEY] secretKey:[GlobalContext SECRET_KEY]];
    
    [[WarpClient getInstance] addConnectionRequestListener: self];
    [[WarpClient getInstance] connect];
    RoomListener *roomListener = [[RoomListener alloc] init];
    [[WarpClient getInstance] addRoomRequestListener:roomListener];
    [[GlobalContext sharedInstance] setUsername:_username.text];
}

- (void) startGame
{
    if (_rootViewController == nil) {
        self.rootViewController = [[[RootViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    }
    [self.navigationController pushViewController:_rootViewController animated:YES];
}

- (void)dealloc
{
    [_rootViewController release];
    _rootViewController = nil;
    [_username release];
    [_error release];
    [super dealloc];
}

-(void)onConnectDone:(ConnectEvent*) event{
    if (event.result==0) {
         NSLog(@"Connection established");        
        [[WarpClient getInstance]joinZone:[[GlobalContext sharedInstance] username]];
    }
    else {
         NSLog(@"Connection Failed"); 
        _error.text = @"Connection Failed!";
    }
}

-(void)onJoinZoneDone:(ConnectEvent*) event{
    if (event.result==0) {        
        NSLog(@"Join Zone done");
        [[WarpClient getInstance]joinRoom:[GlobalContext ROOM_ID]];
        [[WarpClient getInstance]subscribeRoom:[GlobalContext ROOM_ID]];
        [self startGame];
    }
    else {
        _error.text = @"Join Zone Failed!";
    }
}


-(void)onDisconnectDone:(ConnectEvent*) event{
    NSLog(@"connection failed");
}

- (void)viewDidUnload {
    [self setUsername:nil];
    [self setError:nil];
    [super viewDidUnload];
}
@end
