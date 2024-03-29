//
//  SponsorViewController.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 09/10/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "SponsorViewController.h"

@interface SponsorViewController ()

@end

@implementation SponsorViewController

- (void)viewDidLoad {

    self.navigationButton.delegate = self;
}

#pragma mark - Navigation Button methods
- (void)homeButtonPressed {
    NSLog(@"Home button pressed, ViewController");
        StartViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StartViewController"];
        [self presentViewController:vc animated:YES completion:nil];
}

- (void)QRButtonPressed {
    UINavigationController *nvc = [self.storyboard instantiateViewControllerWithIdentifier:@"QRNVC"];
    //QRViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QRViewController"];
    [self presentViewController:nvc animated:YES completion:nil];
    NSLog(@"QR button pressed, ViewController");
}

- (void)mapButtonPressed {
    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FloorSelectorViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)sponsorButtonPressed {
//    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorViewController"];
//    [self presentViewController:vc animated:YES completion:nil];
}

@end
