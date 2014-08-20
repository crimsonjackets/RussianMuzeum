//
//  StartViewController.m
//  RussianMuseum
//
//  Created by admin on 13.08.14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"
#import "Exhibit.h"

@interface StartViewController ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    self.imageView.image = [self getRandomExhibitImage];
    
}


- (UIImage *)getRandomExhibitImage {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    request.predicate = nil;
    NSError *error = nil;
    
    NSArray *fetchedExhibits = [context executeFetchRequest:request error:&error];
    Exhibit *exhibit = fetchedExhibits[arc4random_uniform([fetchedExhibits count])];
    UIImage *picture = [UIImage imageWithData:exhibit.picture scale:2];
    return  picture;
}

@end
