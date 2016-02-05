//
//  VideosViewController.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 1/6/16.
//  Copyright © 2016 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YTVimeoExtractor.h"

@interface VideosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *vidTableView;

- (IBAction)didTouchCloseButton:(id)sender;


@end
