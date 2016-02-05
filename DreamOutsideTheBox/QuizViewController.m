//
//  QuizViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController (){
    NSMutableArray *quizNames;
}

@end

@implementation QuizViewController

@synthesize quizTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    quizTableView.delegate=self;
    quizTableView.dataSource=self;
    
    quizNames = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Quiz"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                [quizNames addObject:[object valueForKey:@"Name"]];
            }
            [quizTableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// table delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [quizNames count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [quizNames objectAtIndex:indexPath.row];
    
    return cell;
}


//TODO: implement

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}



- (IBAction)didTouchCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)didTouchCreateQuizButton:(id)sender {
    CreateQuizViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateQuizVC"];
    [self presentModalViewController:controller animated:YES];
}
@end
