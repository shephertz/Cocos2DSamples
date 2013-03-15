//
//  UserNameController.h
//  Cocos2DSimpleGame
//
//  Created by Rajeev on 25/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNameController : UIViewController<UITextFieldDelegate>
{
    /*****
     * Sign up View related insatnces
     */
    IBOutlet UIView         *signUpView;
    IBOutlet UITextField    *userNameTextField_SignUp;
    IBOutlet UITextField    *passwordTextField_SignUp;
    IBOutlet UITextField    *emailTextField_SignUp;
    IBOutlet UIButton       *submitButton;
    IBOutlet UIButton       *backButton;
    
    
    /*****
     * First View related insatnces
     */
    IBOutlet UIView         *firstView;
    IBOutlet UITextField    *userNameTextField;
    IBOutlet UITextField    *passwordTextField;
    IBOutlet UIButton       *logInButton;
    IBOutlet UIButton       *facebookLogInButton;
    IBOutlet UIButton       *signUpButton;
    
    /*****
     * Guest View related insatnces
     */
    IBOutlet UIView         *guestView;
    IBOutlet UITextField    *playerNameTextField;
    IBOutlet UIButton       *startButton;
}

-(IBAction)submitButtonAction:(id)sender;
-(BOOL)emailValidation:(NSString *)emailToValidate;
-(IBAction)logInButtonAction:(id)sender;
-(IBAction)signUpButtonAction:(id)sender;
-(IBAction)facebookLogInButtonAction:(id)sender;
-(IBAction)startGameButtonAction:(id)sender;
@end
