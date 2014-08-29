//
//  FloorSelectorViewController.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 27/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "FloorSelectorViewController.h"
#import "InteractiveMapViewController.h"

@interface FloorSelectorViewController ()

@end

@implementation FloorSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
@end
