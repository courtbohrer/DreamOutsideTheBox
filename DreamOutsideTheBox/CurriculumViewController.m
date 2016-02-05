//
//  CurriculumViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "CurriculumViewController.h"

@interface CurriculumViewController (){
    NSMutableArray *curNames;
    NSMutableArray *curPDFs;
    NSMutableArray *curImages;
    UIActivityIndicatorView *loadingSpinner;
}
@end

@implementation CurriculumViewController

@synthesize curTableView, webView, closeButton;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    curTableView.delegate=self;
    curTableView.dataSource=self;
    
    curNames = [[NSMutableArray alloc] init];
    curPDFs = [[NSMutableArray alloc] init];
    curImages = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Curriculum"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            int index = 0;
            for (PFObject *object in objects) {
                [curNames addObject:[object valueForKey:@"Name"]];
                [curPDFs addObject:[[object objectForKey:@"PDF"] url]];
                [curImages addObject:[UIImage imageNamed:@"DOTB-02.png"]];
                
                PFFile *imgFile = [object objectForKey:@"Image"];
                if (imgFile != [NSNull null]) {
                    [imgFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        UIImage *curImage = [UIImage imageWithData:imageData];
                        [curImages setObject:curImage atIndexedSubscript:index];
                        [curTableView reloadData];
                    }];
                }
                index++;
            }
            [curTableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    webView.hidden = true;
    closeButton.hidden = true;
}

-(void) viewWillAppear:(BOOL)animated{
    //disables the Calendar, Curriculum and Forms when user is not verified
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

-(void) viewDidAppear:(BOOL)animated{
    //load the curriculum
    
}

// table delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [curNames count];
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
    
    cell.label.text = [curNames objectAtIndex:indexPath.row];
    cell.img.image = [curImages objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    PFFile *PDF = [curPDFs objectAtIndex:indexPath.row];
    //NSString *urlString = [PDF url];
    
    NSURL *url = [NSURL URLWithString:PDF];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    self.webView.hidden = false;
    closeButton.hidden = false;
    loadingSpinner = [[UIActivityIndicatorView alloc] init];
    [loadingSpinner startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //self.webView.hidden = false;
    //closeButton.hidden = false;
    [loadingSpinner  stopAnimating];
    loadingSpinner.hidden=YES;
}


- (IBAction)didTouchCloseButton:(id)sender {
    webView.hidden = true;
    closeButton.hidden = true;
    
}
@end
