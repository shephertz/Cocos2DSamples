//
//  UserNameController.m
//  Cocos2DSimpleGame
//
//  Created by Rajeev on 25/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "UserNameController.h"
#import "AppWarpHelper.h"
#import "Cocos2DSimpleGameAppDelegate.h"
#import "NFStoryBoardManager.h"

@interface UserNameController ()

@end

@implementation UserNameController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) || !nibNameOrNil)
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    else 
    {
        self = [super initWithNibName:[NSString stringWithFormat:@"%@_iPhone",nibNameOrNil] bundle:nibBundleOrNil];
    }
    
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
    userNameTextField_SignUp.delegate=self;
    [userNameTextField_SignUp setReturnKeyType:UIReturnKeyDone];
    
    passwordTextField_SignUp.delegate=self;
    [passwordTextField_SignUp setReturnKeyType:UIReturnKeyDone];
    
    emailTextField_SignUp.delegate=self;
    [emailTextField_SignUp setReturnKeyType:UIReturnKeyDone];
    
    userNameTextField.delegate=self;
    [userNameTextField setReturnKeyType:UIReturnKeyDone];
    
    passwordTextField.delegate=self;
    [passwordTextField setReturnKeyType:UIReturnKeyDone];
    
    playerNameTextField.delegate=self;
    [playerNameTextField setReturnKeyType:UIReturnKeyDone];
    
    CGRect winSize = [[UIScreen mainScreen] bounds];
    CGRect firstViewRect = firstView.frame;
    CGRect signUpViewRect = signUpView.frame;
    CGRect guestViewRect = guestView.frame;
    [firstView setFrame:CGRectMake((winSize.size.height-firstViewRect.size.width)/2,(winSize.size.width-firstViewRect.size.height)/2,  firstViewRect.size.width, firstViewRect.size.height)];
    [signUpView setFrame:CGRectMake((winSize.size.height-signUpViewRect.size.width)/2, (winSize.size.width-signUpViewRect.size.height)/2, signUpViewRect.size.width, signUpViewRect.size.height)];
    [guestView setFrame:CGRectMake((winSize.size.height-guestViewRect.size.width)/2,(winSize.size.width-guestViewRect.size.height)/2,  guestViewRect.size.width, guestViewRect.size.height)];

}

-(void)showAcitvityIndicator
{
    indicatorView.hidden = NO;
    [activityIndicatorView startAnimating];
}

-(void)removeAcitvityIndicator
{
    [activityIndicatorView stopAnimating];
    [indicatorView removeFromSuperview];
}


#pragma mark ----
#pragma mark ---Button Actions---
#pragma mark ----


-(IBAction)backButtonAction:(id)sender
{
    signUpView.hidden = YES;
    firstView.hidden  = NO;
}


-(IBAction)submitButtonAction:(id)sender
{
    int userNameLentgh = [[[userNameTextField_SignUp.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] length];
    int pswLentgh = [[[passwordTextField_SignUp.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] length];
    int emailLentgh = [[[emailTextField_SignUp.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] length];
    
    if (userNameLentgh && pswLentgh && emailLentgh)
    {
        if ([self emailValidation:emailTextField_SignUp.text])
        {
            [[AppWarpHelper sharedAppWarpHelper] setUserName:userNameTextField_SignUp.text];
            [[AppWarpHelper sharedAppWarpHelper] setPassword:passwordTextField_SignUp.text];
            [[AppWarpHelper sharedAppWarpHelper] setEmailId:emailTextField_SignUp.text];
            [[AppWarpHelper sharedAppWarpHelper] setAlreadyRegistered:NO];
            
            if ([[AppWarpHelper sharedAppWarpHelper] registerUser])
            {
                [(Cocos2DSimpleGameAppDelegate*)[[UIApplication sharedApplication] delegate] removeEnterUserNameScreen];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"Error:"
                                      message: @"User With this name already Exists!"
                                      delegate: nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }

        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Error:"
                                  message: @"Please enter a valid email address!"
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error:"
                              message: @"Any one of the fields can not be left empty!"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}

- (BOOL)emailValidation: (NSString *)emailToValidate
{
    NSString *regexForEmailAddress = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexForEmailAddress];
    return [emailValidation evaluateWithObject:emailToValidate];
}


-(IBAction)logInButtonAction:(id)sender
{
    int userNameLentgh = [[[userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] length];
    int pswLentgh = [[[passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] length];
    
    if (userNameLentgh && pswLentgh)
    {
        // Process the login request
        [[AppWarpHelper sharedAppWarpHelper] setUserName:userNameTextField.text];
        [[AppWarpHelper sharedAppWarpHelper] setPassword:passwordTextField.text];
        [[AppWarpHelper sharedAppWarpHelper] setAlreadyRegistered:YES];
        
        if ([[AppWarpHelper sharedAppWarpHelper] signInUser])
        {
            [(Cocos2DSimpleGameAppDelegate*)[[UIApplication sharedApplication] delegate] removeEnterUserNameScreen];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Error:"
                                  message: @"Please check ur user name or password!"
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else if(!userNameLentgh && !pswLentgh)
    {
        //Ask for UserName and Password
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error:"
                              message: @"Please enter ur user name and password!"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if(!userNameLentgh)
    {
        //Ask for UserName
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error:"
                              message: @"Please enter ur user name!"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {
        //Ask for Password
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error:"
                              message: @"Please enter ur password!"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(IBAction)signUpButtonAction:(id)sender
{
    firstView.hidden = YES;
    signUpView.hidden = NO;
}



-(IBAction)facebookLogInButtonAction:(id)sender
{
    firstView.hidden = YES;
    signUpView.hidden = YES;
    guestView.hidden = NO;
}

-(IBAction)startGameButtonAction:(id)sender
{
    int playerNameLentgh = [[[playerNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] length];

    
    if (playerNameLentgh )
    {
        // Process the login request
        [[AppWarpHelper sharedAppWarpHelper] setUserName:playerNameTextField.text];
        [[NFStoryBoardManager sharedNFStoryBoardManager] showGameLoadingIndicator];
        //[(Cocos2DSimpleGameAppDelegate*)[[UIApplication sharedApplication] delegate] removeEnterUserNameScreen];
        
    }
    else
    {
        //Ask for UserName and Password
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error:"
                              message: @"Please enter ur name!"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}

#pragma mark ----
#pragma mark ---TextField Delegates Methods---
#pragma mark ----
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        
        // Be sure to test for equality using the "isEqualToString" message
        
        [textField resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        
        return NO;
    }
    
    // For any other character return TRUE so that the text gets added to the view
    
    return YES;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [[AppWarpHelper sharedAppWarpHelper] setUserName:textField.text];
//	[textField resignFirstResponder];
//    [(Cocos2DSimpleGameAppDelegate*)[[UIApplication sharedApplication] delegate] removeEnterUserNameScreen];
//	return YES;
//}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotate
{
    return NO;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation==UIInterfaceOrientationMaskLandscape);
//}

@end
