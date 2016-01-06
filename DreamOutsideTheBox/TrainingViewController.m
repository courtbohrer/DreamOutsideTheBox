//
//  TrainingViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "TrainingViewController.h"

@interface TrainingViewController ()

@end

@implementation TrainingViewController

@synthesize topLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void) viewDidAppear:(BOOL)animated{
    if (![PFUser currentUser]) {
        topLabel.text = @"Welcome! Please login to view the rest of our content!";
    } else if (![[PFUser currentUser] valueForKey:@"verified"]) {
        NSString *name = [[PFUser currentUser] valueForKey:@"username"];
        topLabel.text = [NSString stringWithFormat:@"Hi there %@! \nWelcome to our app and thank you for volunteering your time. \nFor the security of our Dreamers, you need to complete one of our training quizzes before you can access the rest of our content.", name];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
    } else {
        NSString *name = [[PFUser currentUser] valueForKey:@"username"];
        topLabel.text = [NSString stringWithFormat:@"Welcome back %@!", name];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
