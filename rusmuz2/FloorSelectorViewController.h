//
//  FloorSelectorViewController.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 27/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NavigationButton.h"
#import "InteractiveMapViewController.h"
#import "StartViewController.h"
#import "SponsorViewController.h"

@interface FloorSelectorViewController : UIViewController <NavigationButtonDelegate>

@property (strong, nonatomic) IBOutlet NavigationButton *navigationButton;

- (IBAction)button1Floor:(id)sender;
- (IBAction)button2Floor:(id)sender;

@end
