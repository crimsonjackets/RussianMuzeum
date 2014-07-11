//
//  MiniMapViewController.m
//  rusmuz2
//
//  Created by Richard Topchiy on 03/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//


#import "MiniMapViewController.h"
#import "AppDelegate.h"
#import "ExhibitViewController.h"

@interface MiniMapViewController ()
@property (nonatomic, strong) MTImageMapView *imageView;
@property (nonatomic, strong) NSString *roomNumber;
@property (nonatomic, strong) UIView *containerView;


- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;
- (void)exhibitButtonPressed:(UIButton *)button;

@end

@implementation MiniMapViewController

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f + 30.0f;
    } else {
        //contentsFrame.origin.y = 30.0f;
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
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
    [self centerScrollViewContents];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize containerSize = CGSizeMake(640.0f, 640.0f);
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize}];
    [self.scrollView addSubview:self.containerView];
    
    
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    NSMutableArray *exhibits = [[NSMutableArray alloc] init];
    
    const CGFloat sideOfTheSquare = 20.0f;
    
    for (int i = 0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"%d", i];
        CGFloat horizontal = ( arc4random() % 640);
        CGFloat vertical = ( arc4random() % 640);
        CGFloat width = horizontal + sideOfTheSquare;
        CGFloat heighth = vertical + sideOfTheSquare;
        

        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(exhibitButtonPressed:)
         
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:name forState:UIControlStateNormal];
        button.frame = CGRectMake(horizontal, vertical, 160.0f, 40.0f);
        button.tag = i;
        [self.containerView addSubview:button];
        
        NSLog(@"%ld", (long)button.tag);
        [exhibits addObject:[NSString stringWithFormat:@"%d", i]];
        
    }
    
    for (NSString *str in coordinates) {
        NSLog(@"%@", str);
    }

    
//
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = containerSize;
    
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

    self.scrollView.zoomScale = minScale;
    // 6
    [self centerScrollViewContents];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

-(void)exhibitButtonPressed:(UIButton *)button {
    NSLog(@"%ld", (long)button.tag);
    [self performSegueWithIdentifier:@"showExhibit" sender:button];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showExhibit"])
    {
        // Get reference to the destination view controller
        ExhibitViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        UIButton  *button = (UIButton *)sender;
        NSString *text = [NSString stringWithFormat:@"%ld", (long)button.tag];
        vc.labelText = text;
//        vc.label.text = text;
        
        NSLog(@"Segue works %@", text);
    }
}


@end
