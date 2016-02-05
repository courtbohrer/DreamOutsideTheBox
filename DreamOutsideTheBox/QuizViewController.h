//
//  QuizViewController.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CreateQuizViewController.h"

@interface QuizViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)didTouchCloseButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *quizTableView;
@property (weak, nonatomic) IBOutlet UIButton *createQuizButton;

- (IBAction)didTouchCreateQuizButton:(id)sender;

@end
