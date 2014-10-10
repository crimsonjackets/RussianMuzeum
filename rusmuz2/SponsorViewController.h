//
//  SponsorViewController.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 09/10/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NavigationButton.h"
#import "FloorSelectorViewController.h"
#import "StartViewController.h"

@interface SponsorViewController : UIViewController <NavigationButtonDelegate>

@property (strong, nonatomic) IBOutlet NavigationButton *navigationButton;

@end
