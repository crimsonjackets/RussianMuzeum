//
//  QRViewController.m
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitViewController.h"
#import "AppDelegate.h"

@interface ExhibitViewController ()

@property (nonatomic, strong) NSArray *previewsStorage;
@property (nonatomic, strong) NSMutableArray *previewsViews;

@property (nonatomic, strong) NSArray *blocksStorage;
@property (nonatomic, strong) NSMutableArray *blocksViews;

@property (nonatomic, strong) NSArray *picturesStorage;
@property (nonatomic, strong) NSArray *picturesInfo;
@property (nonatomic, strong) NSMutableArray *picturesViews;

@end

@implementation ExhibitViewController



- (void)viewDidLoad
{
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    self.previewScrollView.delegate = self;
    self.blocksScrollView.delegate = self;
    self.pictureScrollView.delegate = self;
    //[self addImages];
    [self lazyLoadPreviews];
    [self lazyLoadBlocks];
    [self lazyLoadPictures];
    
    NSLog(@"CONTENTSIZE %f", self.previewScrollView.contentSize.width);
}

- (void)lazyLoadPictures {
    self.picturesStorage = [self getPictures];
    
    NSInteger pageCount = self.picturesStorage.count;
    self.picturesViews = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.picturesViews addObject:[NSNull null]];
    }
    
    CGSize contentSize;
    for (UIImage *image in self.picturesStorage) {
        contentSize.width = contentSize.width + image.size.width;
        contentSize.height = image.size.height;
    }
    
    self.pictureScrollView.contentSize = contentSize;
    
    NSLog(@"Contentsize REijo: %f", contentSize.width);
    NSLog(@"Contentsize REijo: %f", contentSize.height);
    [self loadVisiblePagesInScrollView:self.pictureScrollView];
}



- (void)lazyLoadBlocks {
    self.blocksStorage = [self getBlocks];
    
    NSInteger pageCount = self.blocksStorage.count;
    self.blocksViews = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.blocksViews addObject:[NSNull null]];
    }
    
    CGSize contentSize;
    for (UIImage *image in self.blocksStorage) {
        contentSize.width = contentSize.width + image.size.width;
        contentSize.height = image.size.height;
    }
    
    self.blocksScrollView.contentSize = contentSize;
    
    NSLog(@"Contentsize REijo: %f", contentSize.width);
    NSLog(@"Contentsize REijo: %f", contentSize.height);
    [self loadVisiblePagesInScrollView:self.blocksScrollView];
}


- (void)lazyLoadPreviews {
//    self.previewsStorage = [self getPreviews];
    self.previewsStorage = [self getPictures];
    NSInteger pageCount = self.previewsStorage.count;
    self.previewsViews = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.previewsViews addObject:[NSNull null]];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;

    
    CGSize contentSize;
//    for (UIImage *image in self.previewsStorage) {
//        contentSize.width = contentSize.width + image.size.width;
//        contentSize.height = image.size.height;
//    }
    CGSize size = CGSizeMake((screenWidth/2) * self.previewsStorage.count, 150);
    self.previewScrollView.contentSize = size;
    
    NSLog(@"Contentsize REijo: %f", contentSize.width);
    NSLog(@"Contentsize REijo: %f", contentSize.height);
    [self loadVisiblePagesInScrollView:self.previewScrollView];
}

#pragma mark - CoreData fetching
- (NSArray *)getPreviews {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<100; i++) {
        [array addObject:[UIImage imageNamed:@"pic1.png"]];
        [array addObject:[UIImage imageNamed:@"pic3.png"]];
    }
    return (NSArray *)array;
}

- (NSArray *)getBlocks {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<100; i++) {
        [array addObject:[UIImage imageNamed:@"block.png"]];
    }
    return (NSArray *)array;
}

- (NSArray *)getPictures {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *infoArray = [[NSMutableArray alloc] init];
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    request.predicate = nil;
    NSError *error = nil;
    
    NSArray *fetchedExhibits = [context executeFetchRequest:request error:&error];
    
    for (Exhibit *exhibit in fetchedExhibits) {
        [array addObject:[UIImage imageWithData:exhibit.picture scale:2]];
        [infoArray addObject:exhibit.info];
    }
    self.picturesInfo = (NSArray *)infoArray;
    return (NSArray *)array;
}


#pragma mark - Scrolling Engine

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadVisiblePagesInScrollView:scrollView];
    NSLog(@"DID scroll: %f", scrollView.contentSize.height);
}

- (void)loadVisiblePagesInScrollView:(UIScrollView *)scrollView {
    //Checking the scrollView:
    NSInteger visiblePages;
    NSMutableArray *viewArray;
    NSArray *storageArray;
    if (scrollView == self.previewScrollView) {
        visiblePages = 2;
        viewArray = self.previewsViews;
        storageArray = self.previewsStorage;
    } else if (scrollView == self.blocksScrollView) {
        visiblePages = 13;
        viewArray = self.blocksViews;
        storageArray = self.blocksStorage;
    } else if (scrollView == self.pictureScrollView) {
        visiblePages = 1;
        viewArray = self.picturesViews;
        storageArray = self.picturesStorage;
    }
    
    // First, determine which page is currently visible
    CGFloat pageWidth = scrollView.frame.size.width;

    
    //BUG FIXED: multiplying by 2 due to the quantity of images visible
    NSInteger page = visiblePages * (NSInteger)floor((scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    NSLog(@"CUREENT PAGE: %ld", (long)page);
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1 - visiblePages;
    NSInteger lastPage = page + 1 + visiblePages;
    
    NSLog(@"first page: %ld", (long)firstPage);
        NSLog(@"last page: %ld", (long)lastPage);
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i inArray:storageArray fromViewArray:viewArray];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i fromArray:storageArray toViewArray:viewArray andScrollView:scrollView];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage; i<self.previewsStorage.count; i++) {
        [self purgePage:i inArray:storageArray fromViewArray:viewArray];
    }
}

- (void)loadPage:(NSInteger)page fromArray:(NSArray *)array toViewArray:(NSMutableArray *)viewArray andScrollView:(UIScrollView *)scrollView {
    if (page < 0 || page >= array.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // 1
    UIView *pageView = [viewArray objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        // 2
        UIImage *image = [array objectAtIndex:page];
        
        CGRect frame;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        if (scrollView == self.previewScrollView) {

            frame = CGRectMake(0.0f, 0.0f, screenWidth/2, 211);
        } else {
            frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        }
        
        
        
        CGFloat totalWidth = 0.0f;
        
//        for (int i = 1; i <= page; i++) {
//            UIImage *img = [array objectAtIndex:i];
//            totalWidth += img.size.width;
//        }
        if (scrollView == self.previewScrollView) {
            totalWidth = (page) * (screenWidth/2);
        } else {
            for (int i = 1; i <= page; i++) {
                UIImage *img = [array objectAtIndex:i];
                totalWidth += img.size.width;
            }
        }

        
        frame.origin.x = totalWidth;
        
        // 3
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:image];
        if (scrollView == self.pictureScrollView) {
            UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
            
            [descriptionLabel setTextColor:[UIColor whiteColor]];
            [descriptionLabel setBackgroundColor:[UIColor clearColor]];
            [descriptionLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 17.0f]];
            descriptionLabel.numberOfLines = 0;
            descriptionLabel.textAlignment = NSTextAlignmentCenter;
            [descriptionLabel setText:self.picturesInfo[page]];
            [newPageView addSubview:descriptionLabel];
        }
        if (scrollView == self.previewScrollView) {
            newPageView.contentMode = UIViewContentModeScaleAspectFill;
        } else {
            newPageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        newPageView.frame = frame;
        [scrollView addSubview:newPageView];
        // 4
        [viewArray replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page inArray:(NSArray *)array fromViewArray:(NSMutableArray *)viewArray {
    if (page < 0 || page >= array.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [viewArray objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [viewArray replaceObjectAtIndex:page withObject:[NSNull null]];
    }
    
}

@end
