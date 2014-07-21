//
//  MiniMapViewController.h
//  rusmuz2
//
//  Created by Richard Topchiy on 03/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTImageMapView.h"
#import "Event.h"
#import "Exhibit.h"
#import "Room.h"
#import <CoreData/CoreData.h>

@interface MiniMapViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *roomNumbers;
@property (nonatomic, strong) NSString *roomNumber;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
