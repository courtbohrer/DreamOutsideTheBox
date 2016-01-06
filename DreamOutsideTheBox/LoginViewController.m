//
//  LoginViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameField,passwordField, loginButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTouchLoginButton:(id)sender {
    NSString *usernameString = [usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passwordString = [passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([usernameString length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No username entered" message:@"Please enter a username." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
        
    } else if ([passwordString length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No password entered" message:@"Please enter a password." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
    } else {
        
        // both fields entered, let's party
        
        [PFUser logInWithUsernameInBackground:usernameString password:passwordString block:^(PFUser *user, NSError *error)
         {
             if (!error) {
                 [self dismissViewControllerAnimated:true completion:nil];
             } else {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed" message:@"Incorrect username or password." delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
                 [alert show];
                 
             }
         }];
        
        
    }
    
}
@end
