//
//  CreateQuizViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 1/16/16.
//  Copyright © 2016 Courtney Bohrer. All rights reserved.
//

#import "CreateQuizViewController.h"

@interface CreateQuizViewController (){
    NSMutableArray *privArr;
}

@end

@implementation CreateQuizViewController

@synthesize questionField, firstAnswerField, secondAnswerField, thirdAnswerField, fourthAnswerField, anybodyButton, shipButton, staffButton, VBButton, DBButton, saveButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *quiz = [[NSDictionary alloc] initWithObjectsAndKeys:@"This is the first question", @"Question", @"", @"key2", nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchAnybodyButton:(id)sender {
}

- (IBAction)didTouchShipButton:(id)sender {
}

- (IBAction)didTouchStaffButton:(id)sender {
}

- (IBAction)didTouchVBButton:(id)sender {
}

- (IBAction)didTouchDBButton:(id)sender {
}
- (IBAction)didTouchSaveButton:(id)sender {
}
- (IBAction)didTouchCloseButton:(id)sender {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Are you sure?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, keep me here"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
