//  Created by Richard Topchiy on 31/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ZoomSegue.h"
#import "MiniMapViewController.h"
#include "InteractiveMapViewController.h"

@implementation ZoomSegue

- (void)perform {
    InteractiveMapViewController *sourceViewController = self.sourceViewController;
    MiniMapViewController *destinationViewController = self.destinationViewController;
    
    UIView *sourceView = ((UIViewController *)self.sourceViewController).view;
    UIView *destinationView = [((UIViewController *)self.destinationViewController).view snapshotViewAfterScreenUpdates:YES];
    
    destinationView.frame = CGRectMake(0, 0, 1, 1);
    destinationView.center = self.originatingPoint;
    
    [sourceView addSubview:destinationView];
    
    [UIView animateWithDuration:1
                     animations:^{
                         destinationView.frame = sourceView.frame;
                         
                     }
                     completion:^(BOOL finished) {
                         [destinationView removeFromSuperview];
                         [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
                     }];
    
}


- (CGRect)zoomedRect {
    1
}

@end