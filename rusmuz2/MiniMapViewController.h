//
//  MiniMapViewController.h
//  rusmuz2
//
//  Created by Richard Topchiy on 03/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTImageMapView.h"

@interface MiniMapViewController : UIViewController <UIScrollViewDelegate, MTImageMapDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *roomNumbers;

@end
