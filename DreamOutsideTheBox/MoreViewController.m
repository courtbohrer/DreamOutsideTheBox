//
//  MoreViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

@synthesize loginButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    if([PFUser currentUser]){
        [loginButton setTitle:@"Log out" forState:UIControlStateNormal];
        if (![[PFUser currentUser] valueForKey:@"verified"]) {
            [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
            [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
            [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        } else {
            [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
            [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
            [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
        }
    } else {
        [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
        //[[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
    }
    
    [super viewDidAppear:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchLoginButton:(id)sender {
    if([PFUser currentUser]){
        //kind of hacky, maybe add block later
        [PFUser logOut];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bye!" message:@"We have logged you out." delegate:self cancelButtonTitle:@"Bye!" otherButtonTitles:nil];
        [alert show];
        [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
    } else {
        //no current PFUser, need to login
        LoginViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentModalViewController:controller animated:YES];
    }
}

- (IBAction)didTouchCOGButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://issuu.com/dreamoutsidethebox/docs/dotb_cog_aug2014_bleed"]];
}

- (IBAction)didTouchWebsiteButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://dreamoutsidethebox.org/"]];
}

- (IBAction)didTouchGiveButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=3E3DUD3GA898Q"]];
}

- (IBAction)didTouchFBButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/dreamoutsidethebox"]];
}

- (IBAction)didTouchInstagramButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.instagram.com/dreamoutside/"]];
}

@end
