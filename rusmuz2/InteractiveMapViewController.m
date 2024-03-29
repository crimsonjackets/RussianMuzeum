//
//  InteractiveMapViewController.m
//  MTMapCheck
//
//  Created by Richard Topchiy on 30/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "InteractiveMapViewController.h"

#import "MTImageMapView/MTImageMapView.h"


@interface InteractiveMapViewController ()
@property (nonatomic, strong) MTImageMapView *imageView;
@property (nonatomic, strong) NSString *roomNumber;
@property CGPoint touchedPoint;
@end

@implementation InteractiveMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.navigationButton.buttonKind = mapVC;
    self.navigationButton.delegate = self;
    

    
    if ([self.currentFloor isEqualToNumber:@1]) {
    [self reloadMapWithImageNamed:@"floor1.png" CoordinatesNamed:@"testCoord" andRoomNumbersNamed:@"testNumbers"];
    }
    
    if ([self.currentFloor isEqualToNumber:@2]) {
    [self reloadMapWithImageNamed:@"floor2.png" CoordinatesNamed:@"testCoord" andRoomNumbersNamed:@"testNumbers"];
    }
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        //      contentsFrame.origin.y = +300.0f;
        
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer *)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    NSLog(@"ZOOMSCALE %f", self.scrollView.zoomScale);
    
    [self centerScrollViewContents];
}

- (void)changeFloor:(int)number {
    //number == 1 - first floor
    //number == 2 - second floor
    //number == 3 - Benua
    if (number == 3){
        NSLog(@"Change map to Benua");
        return;
    }
    CGFloat zoomScale = self.scrollView.zoomScale;
    CGPoint contentOffset = self.scrollView.contentOffset;
    
    if (number == 1) {
        [self.imageView removeFromSuperview];
        [self reloadMapWithImageNamed:@"floor1.png" CoordinatesNamed:@"testCoord" andRoomNumbersNamed:@"testNumbers"];
        _currentFloor = @1;
        NSLog(@"Current floor number is %@", _currentFloor);
    } else {
        [self.imageView removeFromSuperview];
        [self reloadMapWithImageNamed:@"floor2.png" CoordinatesNamed:@"testCoord" andRoomNumbersNamed:@"testNumbers"];
        _currentFloor = @2;
        NSLog(@"Current floor number is %@", _currentFloor);
    }
    self.navigationButton.currentFloor  = _currentFloor;
    self.scrollView.zoomScale = zoomScale;
    self.scrollView.contentOffset = contentOffset;
}


- (void)reloadMapWithImageNamed: (NSString *)imageName CoordinatesNamed: (NSString *)coordinatesName andRoomNumbersNamed: (NSString *)roomNumbersName
{
    self.roomNumbers = \
    [NSArray arrayWithContentsOfFile:
     [[NSBundle mainBundle]
      pathForResource:roomNumbersName
      ofType:@"plist"]];
    
    
    // 1
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView = [[MTImageMapView alloc] initWithImage:image];
//    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    
    //MTImageView Code
    [self.imageView setDelegate:self];
    [self.scrollView addSubview:self.imageView];
    [self.scrollView sendSubviewToBack:self.imageView];
    
    NSArray *coordinates = \
    [NSArray arrayWithContentsOfFile:
     [[NSBundle mainBundle]
      pathForResource:coordinatesName
      ofType:@"plist"]];
    
    [_imageView
     setMapping:coordinates
     doneBlock:^(MTImageMapView *imageMapView) {
         NSLog(@"Areas are all mapped");
     }];
    
    
    // 2
    CGFloat height = self.imageView.frame.size.height;
    CGSize contentSize = CGSizeMake(self.imageView.frame.size.width, height);
    
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.contentSize = contentSize;
    

    
    // 3
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    // 4
    CGRect scrollViewFrame =  self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    
    // 5
    self.scrollView.maximumZoomScale = 1.0f;
    
    //Adjust this thing to taste
    //self.scrollView.zoomScale = 0.125f;
    self.scrollView.zoomScale = minScale;
    // 6
    [self centerScrollViewContents];

}

-(void)imageMapView:(MTImageMapView *)inImageMapView
   didSelectMapArea:(NSUInteger)inIndexSelected
{

    self.roomNumber = [_roomNumbers objectAtIndex:inIndexSelected];

    ExhibitViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ExhibitViewController"];
    vc.roomNumber = (NSNumber *)self.roomNumber;
    [self presentViewController:vc animated:YES completion:nil];
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
    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FloorSelectorViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)changeFloorButtonPressed:(UIButton*)sender {
    [self changeFloor:sender.tag];
    NSLog(@"Change Floor button pressed, ViewController");
}

- (void)sponsorButtonPressed {
    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
