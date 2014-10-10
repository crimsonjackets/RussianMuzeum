//
//  FloorSelectorViewController.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 27/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "FloorSelectorViewController.h"


@interface FloorSelectorViewController ()

@end

@implementation FloorSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationButton.buttonKind = startVC;
    self.navigationButton.delegate = self;
}



- (IBAction)button1Floor:(id)sender {
    InteractiveMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InteractiveMapViewController"];
    vc.currentFloor = @1;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)button2Floor:(id)sender {
    InteractiveMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InteractiveMapViewController"];
    vc.currentFloor = @2;
    [self presentViewController:vc animated:YES completion:nil];
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
    //FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FloorSelectorViewController"];
    //[self presentViewController:vc animated:YES completion:nil];
}

- (void)sponsorButtonPressed {
    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
