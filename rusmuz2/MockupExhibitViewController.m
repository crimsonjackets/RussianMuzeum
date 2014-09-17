//
//  ExhibitViewController.m
//  rusmuz2
//
//  Created by Richard Topchiy on 10/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "MockupExhibitViewController.h"

@interface MockupExhibitViewController ()

@end

@implementation MockupExhibitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.label.text = self.labelText;
}



@end
