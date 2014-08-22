//
//  StartViewController.m
//  RussianMuseum
//
//  Created by admin on 13.08.14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "StartViewController.h"




@interface StartViewController ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationButton.buttonKind = startVC;
    self.navigationButton.delegate = self;
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSLog(@"View didload");
    [self showExhibit:[self getRandomExhibit]];

}


- (Exhibit *)getRandomExhibit {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    request.predicate = nil;
    NSError *error = nil;
    
    NSArray *fetchedExhibits = [context executeFetchRequest:request error:&error];
    Exhibit *exhibit = fetchedExhibits[arc4random_uniform([fetchedExhibits count])];

//    UIImage *picture = [UIImage imageWithData:exhibit.picture scale:2];
    return  exhibit;
}

- (void)showExhibit:(Exhibit *)exhibit {
    
    self.imageView.image = [UIImage imageWithData:exhibit.picture scale:2];
    self.titleLabel.text = exhibit.name;
    self.authorLabel.text = exhibit.author;
    
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
    InteractiveMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InteractiveMapViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
