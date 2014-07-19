//  Created by Richard Topchiy on 31/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ZoomSegue.h"
#import "MiniMapViewController.h"

@implementation ZoomSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    MiniMapViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    
    //destinationViewController.scrollView.contentSize =
    
    // Transformation start scale
    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    // Store original centre point of the destination view
    CGPoint originalCenter = destinationViewController.view.center;
    // Set center to start point of the button
    destinationViewController.view.center = self.originatingPoint;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         destinationViewController.view.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         
                         [destinationViewController.view removeFromSuperview];
                         [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
                         
                     }];
}

@end