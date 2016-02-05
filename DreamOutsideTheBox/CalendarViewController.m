//
//  CalendarViewController.m
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController (){
    NSMutableDictionary *_eventsByDate;
    NSDate *_dateSelected;
}

@end

@implementation CalendarViewController

@synthesize eventName, desc, startAndEndTime, mapView, link, eventDetail;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    [self populateEvents];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    eventDetail.hidden = YES;
    
    
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

// calendar delegate methods

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Test if the dayView is from another month than the page
    // Use only in month mode for indicate the day of the previous or next month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        //dayView.circleView.backgroundColor = [UIColor colorWithRed:145 green:94 blue:49 alpha:.8];
        dayView.circleView.backgroundColor = [UIColor colorWithRed:0 green:170 blue:182 alpha:.8];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor brownColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor brownColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    // Your method to test if a date have an event for example
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    // Use to indicate the selected date
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
    
    // me
    
    if ([self haveEventForDay:_dateSelected]) {
        NSString *key = [[self dateFormatter] stringFromDate:_dateSelected];
        if ([_eventsByDate[key] count] > 1) {
            //figure this out
            NSLog(@"THIS IS WHAT IS HAPPENING");
        } else {
            //show event details
            eventDetail.hidden = false;
            
            PFObject *event = [_eventsByDate[key] objectAtIndex:0];
            eventName.text = [event objectForKey:@"Name"];
            desc.text = [event objectForKey:@"Description"];
            
            
            
        }
    } else {
        eventDetail.hidden = true;
    }
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)populateEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSString *mySchool = [[PFUser currentUser] objectForKey:@"School"];
            for (PFObject *object in objects) {
                if ([[object objectForKey:@"School"] isEqualToString:@"all"] || [[object objectForKey:@"School"] isEqualToString:mySchool]) {
                    // add to eventsByDate
                    NSDate *startDate = [object objectForKey:@"StartDate"];
                    NSString *key = [[self dateFormatter] stringFromDate:startDate];
                    if(!_eventsByDate[key]){
                        _eventsByDate[key] = [NSMutableArray new];
                    }
            
                    [_eventsByDate[key] addObject:object];
                }
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
