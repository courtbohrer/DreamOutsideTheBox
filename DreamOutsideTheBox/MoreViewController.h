//
//  MoreViewController.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface MoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)didTouchLoginButton:(id)sender;
- (IBAction)didTouchCOGButton:(id)sender;
- (IBAction)didTouchWebsiteButton:(id)sender;
- (IBAction)didTouchGiveButton:(id)sender;
- (IBAction)didTouchFBButton:(id)sender;
- (IBAction)didTouchInstagramButton:(id)sender;


@end
