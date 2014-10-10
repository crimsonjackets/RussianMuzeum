//
//  InteractiveMapViewController.h
//  rusmuz
//
//  Created by Richard Topchiy on 30/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTImageMapView.h"

#import "NavigationButton.h"
#import "StartViewController.h"
#import "QRViewController.h"
#import "ExhibitViewController.h"
#import "SponsorViewController.h"

@interface InteractiveMapViewController : UIViewController <UIScrollViewDelegate, MTImageMapDelegate, NavigationButtonDelegate>


@property (strong, nonatomic) IBOutlet NavigationButton *navigationButton;

@property (strong, nonatomic) NSNumber *currentFloor;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (nonatomic, strong) NSArray *roomNumbers;

@end
