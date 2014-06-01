//
//  InteractiveMapViewController.h
//  rusmuz
//
//  Created by Richard Topchiy on 30/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTImageMapView.h"

@interface InteractiveMapViewController : UIViewController <UIScrollViewDelegate, MTImageMapDelegate>


@property (strong, nonatomic) IBOutlet UISegmentedControl *floorSelector;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *stateNames;

@end
