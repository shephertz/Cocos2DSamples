//
//  PWHelpViewController.m
//  PlayWithWords
//
//  Created by shephertz technologies on 05/06/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "PWHelpViewController.h"
#import "PWGameController.h"
#import "SimpleAudioEngine.h"

@interface PWHelpViewController ()

@end

@implementation PWHelpViewController
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE5)
    {
        self.view.frame = CGRectMake(0, 0, 568, 320);
        titleLabel.center = CGPointMake(titleLabel.center.x+30, titleLabel.center.y);
        helpView.frame = CGRectMake(helpView.frame.origin.x+20, helpView.frame.origin.y,helpView.frame.size.width+50,helpView.frame.size.height);
    }
    

    [self draftHelpText];
    [helpView setOpaque:NO];
    [helpView setBackgroundColor:[UIColor clearColor]];
    
    
    
}

-(void)draftHelpText
{
    
    NSString *htmlFile;// = [[NSBundle mainBundle] pathForResource:@"Help" ofType:@"html" inDirectory:nil];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
        htmlFile = [[NSBundle mainBundle] pathForResource:@"Help_iPhone" ofType:@"html" inDirectory:nil];
    }
    else
    {
        htmlFile = [[NSBundle mainBundle] pathForResource:@"Help" ofType:@"html" inDirectory:nil];
    }
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [helpView loadHTMLString:htmlString baseURL:nil];
}



-(IBAction)backButtonAction:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:BACK_BUTTON_CLICKED];

    if (previousScreenCode==kGameLayer)
    {
        [[[PWGameController sharedInstance] dataManager] removeNewAlphabetFromSessionIfNotSubmitted];
    }
    [[PWGameController sharedInstance] switchToLayerWithCode:previousScreenCode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [super dealloc];
}

@end
