//
//  QRViewController.h
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ViewController.h"
#import "ExhibitsScrollView.h"
#import "Exhibit.h"
#import "Room.h"
#import <CoreData/CoreData.h>

#import "StartViewController.h"
#import "InteractiveMapViewController.h"

@interface ExhibitViewController : UIViewController <UIScrollViewDelegate, NavigationButtonDelegate>

@property (strong, nonatomic) IBOutlet NavigationButton *navigationButton;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIScrollView *previewScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *blocksScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *pictureScrollView;

@property (strong, nonatomic) NSString *exhibitQRCode;



@end
