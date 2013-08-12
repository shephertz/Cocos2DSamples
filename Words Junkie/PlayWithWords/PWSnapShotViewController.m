//
//  PWSnapShotViewController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 04/06/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWSnapShotViewController.h"
#import "PWGameController.h"
#import "PWGameLogicLayer.h"
#import "SimpleAudioEngine.h"

@interface PWSnapShotViewController ()

@end

@implementation PWSnapShotViewController
@synthesize previousScreenCode;

- (id)initWithNibName:(NSString *)nibNameOrNilBase bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibNameOrNil;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        nibNameOrNil = [NSString stringWithFormat:@"%@_iPhone",nibNameOrNilBase];
    }
    else
    {
        nibNameOrNil = [NSString stringWithFormat:@"%@_iPad",nibNameOrNilBase];
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (IS_IPHONE5)
    {
        self.view.frame = CGRectMake(0, 0, 568, 320);
        bgView.frame = CGRectMake(0, 0, 568, 320);
        snapShot.frame = CGRectMake(snapShot.frame.origin.x+4, snapShot.frame.origin.y, 317, snapShot.frame.size.height);
        snapshotTitle.center = CGPointMake(snapshotTitle.center.x+20, snapshotTitle.center.y);
        snapshotTitleBg.center = snapshotTitle.center;
        shareButton.center = CGPointMake(shareButton.center.x+40, shareButton.center.y);
        okButton.center = CGPointMake(okButton.center.x+40, okButton.center.y);
    }

}

-(void)setScreenShotImage:(UIImage*)screenShot
{
    snapShot.image = screenShot;
}

-(IBAction)okButtonSction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    [[PWGameController sharedInstance] removeUpperView];
}

-(IBAction)shareButtonSction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:MENU_ITEM_CLICKED];
    [[PWGameController sharedInstance] removeUpperView];
    [[PWGameLogicLayer sharedInstance] shareSnapshot];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
