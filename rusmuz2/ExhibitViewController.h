//
//  QRViewController.h
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Exhibit.h"
#import "Room.h"

#import "PreviewScrollView.h"
#import "BlockScrollView.h"
#import "PictureScrollView.h"

#import "ExhibitTappedDelegate.h"

#import "ExhibitPreview.h"


#import "StartViewController.h"
#import "InteractiveMapViewController.h"
#import "SponsorViewController.h"

@interface ExhibitViewController : UIViewController <UIScrollViewDelegate, ExhibitTappedDelegate, NavigationButtonDelegate>

@property (strong, nonatomic) IBOutlet NavigationButton *navigationButton;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet PreviewScrollView *previewScrollView;
@property (strong, nonatomic) IBOutlet BlockScrollView *blocksScrollView;
@property (strong, nonatomic) IBOutlet PictureScrollView *pictureScrollView;

@property (strong, nonatomic) NSString *exhibitQRCode;
@property (strong, nonatomic) NSNumber *roomNumber;


@end
