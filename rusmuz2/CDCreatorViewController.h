//
//  CDCreatorViewController.h
//  rusmuz2
//
//  Created by Richard Topchiy on 01/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "Exhibit.h"
#import "Room.h"
#import <CoreData/CoreData.h>

@interface CDCreatorViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)createOneRoom:(id)sender;
- (IBAction)createExhibits:(id)sender;
- (IBAction)fetchTheRoom:(id)sender;

@end
