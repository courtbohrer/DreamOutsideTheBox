//
//  VideosViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 1/6/16.
//  Copyright © 2016 Courtney Bohrer. All rights reserved.
//

#import "VideosViewController.h"

@interface VideosViewController (){
    NSMutableArray *vidNames;
    NSMutableArray *vidLinks;
}

@end

@implementation VideosViewController

@synthesize vidTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    vidTableView.delegate=self;
    vidTableView.dataSource=self;
    
    //load the curriculum
    vidNames = [[NSMutableArray alloc] init];
    vidLinks = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Videos"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                [vidNames addObject:[object valueForKey:@"Name"]];
                [vidLinks addObject:[object objectForKey:@"Link"]];
            }
            [vidTableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [vidNames count];
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
    
    cell.textLabel.text = [vidNames objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *link = [vidLinks objectAtIndex:indexPath.row];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: link]];
    
    [[YTVimeoExtractor sharedExtractor]fetchVideoWithVimeoURL:link withReferer:nil completionHandler:^(YTVimeoVideo * _Nullable video, NSError * _Nullable error) {
        
        if (video) {
            
            //self.titleLabel.text = [NSString stringWithFormat:@"Video Title: %@",video.title];
            NSDictionary *streamURLs = video.streamURLs;
            //Will get the highest available quality.
            NSString *url = streamURLs[@(YTVimeoVideoQualityHD1080)] ?: streamURLs[@(YTVimeoVideoQualityHD720)] ?: streamURLs [@(YTVimeoVideoQualityMedium480)]?: streamURLs[@(YTVimeoVideoQualityMedium360)]?:streamURLs[@(YTVimeoVideoQualityLow270)];
            
            NSURL *movieURL = [NSURL URLWithString:url];
            MPMoviePlayerViewController *moviePlayerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:movieURL];
            
            [self presentMoviePlayerViewControllerAnimated:moviePlayerViewController];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]init];
            alertView.title = error.localizedDescription;
            alertView.message = error.localizedFailureReason;
            [alertView addButtonWithTitle:@"OK"];
            alertView.delegate = self;
            [alertView show];
            
        }
        
    }];
    
}



- (IBAction)didTouchCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
