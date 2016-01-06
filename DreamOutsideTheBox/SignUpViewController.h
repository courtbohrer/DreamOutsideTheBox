//
//  SignUpViewController.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ValidateEmail.h"

@interface SignUpViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

// text fields
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordField;
@property (weak, nonatomic) IBOutlet UITextField *schoolField;
@property (weak, nonatomic) IBOutlet UITextField *positionField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@property (weak, nonatomic) IBOutlet UIPickerView *schoolPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *positionPicker;

// button outlets
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

// button actions
- (IBAction)signUpButton:(id)sender;
- (IBAction)didTouchCloseButton:(id)sender;


@end
