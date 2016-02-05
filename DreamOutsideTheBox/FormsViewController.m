//
//  FormsViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "FormsViewController.h"

@interface FormsViewController (){
    NSMutableArray *formNames;
    NSMutableArray *formLinks;
    NSMutableArray *formImages;
}

@end

@implementation FormsViewController

@synthesize formsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    formsTableView.delegate=self;
    formsTableView.dataSource=self;
    
    formNames = [[NSMutableArray alloc] init];
    formLinks = [[NSMutableArray alloc] init];
    formImages = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Form"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            int index = 0;
            for (PFObject *object in objects) {
                [formNames addObject:[object valueForKey:@"Name"]];
                [formLinks addObject:[object objectForKey:@"Link"]];
                [formImages addObject:[UIImage imageNamed:@"DOTB-02.png"]];
                
                PFFile *imgFile = [object objectForKey:@"Image"];
                if (imgFile != [NSNull null]) {
                    [imgFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        UIImage *formImage = [UIImage imageWithData:imageData];
                        [formImages setObject:formImage atIndexedSubscript:index];
                        [formsTableView reloadData];
                    }];
                }
                index++;
            }
            [formsTableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void) viewWillAppear:(BOOL)animated{
    if (![PFUser currentUser]) {
        //[[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        self.tabBarController.selectedIndex = 4;
    } else if (![[PFUser currentUser] valueForKey:@"verified"]) {
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        self.tabBarController.selectedIndex = 4;
    } else {
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// table delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [formNames count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"StandardTableViewCell";
    
    StandardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StandardTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.label.text = [formNames objectAtIndex:indexPath.row];
    cell.img.image = [formImages objectAtIndex:indexPath.row];
    
    return cell;
}

//TODO: implement
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
