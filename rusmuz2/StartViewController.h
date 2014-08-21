//
//  StartViewController.h
//  RussianMuseum
//
//  Created by admin on 13.08.14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "AppDelegate.h"
#import "NavigationButton.h"
#import <UIKit/UIKit.h>
#import "Exhibit.h"
#import "Room.h"
#import <CoreData/CoreData.h>

@interface StartViewController : UIViewController <NavigationButtonDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet NavigationButton *navigationButton;

@end
