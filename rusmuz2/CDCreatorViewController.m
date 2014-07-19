//
//  CDCreatorViewController.m
//  rusmuz2
//
//  Created by Richard Topchiy on 01/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "CDCreatorViewController.h"
#import "AppDelegate.h"

@interface CDCreatorViewController ()

@end

@implementation CDCreatorViewController

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
    
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createOneRoom:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
    Room *room1 = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    room1.number = [NSNumber numberWithInt:78];
    NSLog(@"Room with number %@ created", room1.number);
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (IBAction)createExhibits:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    Room *room = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    request.predicate = nil;
    request.fetchLimit = 1;
    NSError *error = nil;
    
    NSArray *fetchedRoom = [self.managedObjectContext executeFetchRequest:request error:&error];
    room = fetchedRoom[0];
    for (int i=0; i<10; i++) {
        Exhibit *ex = [NSEntityDescription insertNewObjectForEntityForName:@"Exhibit" inManagedObjectContext:context];
        ex.room = room;
        ex.name =[NSString stringWithFormat:@"%d", i];
        NSLog(@"Exhibit %@ created.",ex.name);
    }
    
    
    NSError *error1 = nil;
    if (![context save:&error1]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}

- (IBAction)fetchTheRoom:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    Room *room = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    request.predicate = nil;
    request.fetchLimit = 1;
    NSError *error = nil;
    
    NSArray *fetchedRoom = [context executeFetchRequest:request error:&error];
    room = fetchedRoom[0];

    NSLog(@"Room is: %@", room);
}

- (IBAction)fetchAllExhibits:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    request.predicate = nil;
    NSError *error = nil;
    
    NSArray *fetchedExhibits = [context executeFetchRequest:request error:&error];
    
    for (Exhibit *exhibit in fetchedExhibits) {
        NSLog(@"Exhibit %@ has been found", exhibit.name);
    }

}

- (IBAction)countCheck:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    
    NSError *error = nil;
    
    // if there's no object fetched, return nil
    if ([context countForFetchRequest:request error:&error] == 0) {
        NSLog(@"!!!WARN: NO Object Matches.");
    } else {
        NSLog(@"COunt IS %lu", (unsigned long)[context countForFetchRequest:request error:&error]);
    }
}
@end
