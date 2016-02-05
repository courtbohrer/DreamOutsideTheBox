//
//  CreateQuizViewController.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 1/16/16.
//  Copyright © 2016 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateQuizViewController : UIViewController

// question field outlets
@property (weak, nonatomic) IBOutlet UITextView *questionField;
@property (weak, nonatomic) IBOutlet UITextView *firstAnswerField;
@property (weak, nonatomic) IBOutlet UITextView *secondAnswerField;
@property (weak, nonatomic) IBOutlet UITextView *thirdAnswerField;
@property (weak, nonatomic) IBOutlet UITextView *fourthAnswerField;

//privacy button outlets
@property (weak, nonatomic) IBOutlet UIButton *anybodyButton;
@property (weak, nonatomic) IBOutlet UIButton *shipButton;
@property (weak, nonatomic) IBOutlet UIButton *staffButton;
@property (weak, nonatomic) IBOutlet UIButton *VBButton;
@property (weak, nonatomic) IBOutlet UIButton *DBButton;

//privacy button actions
- (IBAction)didTouchAnybodyButton:(id)sender;
- (IBAction)didTouchShipButton:(id)sender;
- (IBAction)didTouchStaffButton:(id)sender;
- (IBAction)didTouchVBButton:(id)sender;
- (IBAction)didTouchDBButton:(id)sender;

// save
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)didTouchSaveButton:(id)sender;

//close
- (IBAction)didTouchCloseButton:(id)sender;

@end
