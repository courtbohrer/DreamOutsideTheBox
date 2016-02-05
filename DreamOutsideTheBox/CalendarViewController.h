//
//  CalendarViewController.h
//  DreamOutsideTheBox
//
//  Created by Courtney Bohrer on 12/21/15.
//  Copyright © 2015 Courtney Bohrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <JTCalendar/JTCalendar.h>
#import <MapKit/MapKit.h>

@interface CalendarViewController : UIViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

// event detail elements
@property (weak, nonatomic) IBOutlet UIView *eventDetail;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *startAndEndTime;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *link;


@end
