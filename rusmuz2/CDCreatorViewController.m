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
@end
