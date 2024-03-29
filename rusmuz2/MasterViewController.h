//
//  MasterViewController.h
//  rusmuz2
//
//  Created by Richard Topchiy on 27/06/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "Exhibit.h"
#import "Room.h"
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property  NSInteger *roomNumber;

@end
