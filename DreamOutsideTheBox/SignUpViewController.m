//
//  SignUpViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController (){
    NSArray *schoolData;
    NSArray *positionData;
}

@end

@implementation SignUpViewController

@synthesize passwordField, emailField, usernameField, retypePasswordField, schoolPicker, positionPicker, schoolField, positionField, phoneNumberField;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set keyboard type
    //phoneNumberField.keyboardType = UIKeyboardTypePhonePad;
    phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
    
    // set up pickers
    
    schoolData = @[@"Still loading!"];
    positionData = @[@"Still loading!"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"GeneralInfo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                if ([[object objectForKey:@"Name"] isEqualToString:@"Schools"]) {
                    NSArray *arr = [object objectForKey:@"Data"];
                    schoolData = arr;
                    [schoolPicker reloadAllComponents];
                } else if ([[object objectForKey:@"Name"] isEqualToString:@"Positions"]){
                    positionData = [object objectForKey:@"Data"];
                    [positionPicker reloadAllComponents];
                }
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
       }
    }];
    

    schoolPicker.dataSource = self;
    schoolPicker.delegate = self;
    schoolPicker.hidden = true;
    positionPicker.dataSource = self;
    positionPicker.delegate = self;
    positionPicker.hidden = true;
    
    // TODO: make sure they are all here
    usernameField.delegate = self;
    passwordField.delegate = self;
    retypePasswordField.delegate = self;
    emailField.delegate = self;
    schoolField.delegate = self;
    positionField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)signUpButton:(id)sender {
    [self checkForTheExistingUsersAndSignup];
}

-(void)checkForTheExistingUsersAndSignup {
    
    NSString *usernameString = [usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passwordString = [passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *retypePasswordString = [retypePasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *emailString = [emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([usernameString length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No username entered" message:@"Please enter a username." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
        [usernameField becomeFirstResponder];
    } else if ([emailString length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No email entered" message:@"Please enter an email address." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
        [emailField becomeFirstResponder];
    } else if ([passwordString length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No password entered" message:@"Please enter a password." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
        [passwordField becomeFirstResponder];
    } else if ([retypePasswordString length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Retype password" message:@"Please retype password." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
        [passwordField becomeFirstResponder];
    } else if (![passwordString isEqualToString:retypePasswordString]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"Your passwords do not match. Please try again." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
        [passwordField becomeFirstResponder];
    } else if ([schoolField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No school selected." message:@"Please select a school." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
    } else if ([positionField.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No position selected." message:@"Please select a position." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
    } else if(! [ValidateEmail isValidEmailAddress:emailString]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email" message:@"Please enter valid email." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
        [emailField becomeFirstResponder];
    } else {

    PFQuery *query= [PFUser query]; //query for users
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             NSArray *UserArrayObjects = objects;
             BOOL userExist = NO;
             for (PFObject *userObject in UserArrayObjects)
             {
                 if([usernameString isEqualToString:[userObject objectForKey:@"username"]]  || [emailString isEqualToString:[userObject objectForKey:@"email"]]  )
                 {
                     userExist = YES;
                     break;
                 }
             }
             if(!userExist)
             {
                 [self signupNewUser];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup failed" message:@"That username or email already exists." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
                 [alert show];
             }
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup failed" message:@"It looks like we are having trouble connecting to our network." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
             [alert show];
         }
     }];

    }

}

- (void)signupNewUser{
    
    NSString *usernameString = [usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passwordString = [passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *retypePasswordString = [retypePasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *emailString = [emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    PFUser *user ;
    user = [PFUser user];
    user.username = usernameString;
    user.password = passwordString;
    user.email = emailString;
    [user setObject:schoolField.text forKey:@"School"];
    [user setObject:positionField.text forKey:@"Position"];
    
    //Signup in background
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (!error)
         {
             [self dismissViewControllerAnimated:true completion:nil];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup Failed" message:@"Sorry about that. We suggest checking your network and trying again." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
             [alert show];
         }
     }];
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:schoolPicker]) {
        return [schoolData count];
    } else if ([pickerView isEqual:positionPicker]){
        return [positionData count];
    }
    
    //should not be reached
    return 0;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:schoolPicker]) {
        return schoolData[row];
    } else if ([pickerView isEqual:positionPicker]){
        return positionData[row];
    }
    
    //should not be reached
    return nil;
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:schoolPicker]) {
        schoolField.text = schoolData[row];
        schoolPicker.hidden = true;
        [schoolField resignFirstResponder];
    } else if ([pickerView isEqual:positionPicker]){
        positionField.text = positionData[row];
        positionPicker.hidden = true;
        [positionField resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:schoolField]) {
        schoolPicker.hidden = false;
        positionPicker.hidden = true;
        [self.view endEditing:true];
    } else if ([textField isEqual:positionField]){
        schoolPicker.hidden = true;
        positionPicker.hidden = false;
        [self.view endEditing:true];
    } else{
        schoolPicker.hidden = true;
        positionPicker.hidden = true;
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

    
@end
