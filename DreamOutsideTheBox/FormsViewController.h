//
//  FormsViewController.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "StandardTableViewCell.h"

@interface FormsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *formsTableView;

@end
