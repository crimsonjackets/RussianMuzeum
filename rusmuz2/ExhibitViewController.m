//
//  QRViewController.m
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitViewController.h"
#import "ZBarSDK.h"



@interface ExhibitViewController ()
@property (nonatomic, strong) NSArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property CGSize contentSize;
@end

@implementation ExhibitViewController

- (void)addImages
{
    UIImage *pic1 = [UIImage imageNamed:@"pic1.png"];
    UIImage *pic2 = [UIImage imageNamed:@"pic2.png"];
    UIImage *pic3 = [UIImage imageNamed:@"pic3.png"];
    
    UIImageView *one = [[UIImageView alloc] initWithImage:pic1];
    UIImageView *two = [[UIImageView alloc] initWithImage:pic2];
    UIImageView *three = [[UIImageView alloc] initWithImage:pic3];
    
    one.frame = CGRectMake(0, 0, pic1.size.width, pic1.size.height);
    two.frame = CGRectMake(pic1.size.width, 0, pic2.size.width, pic2.size.height);
    three.frame = CGRectMake(pic1.size.width + pic2.size.width, 0, pic3.size.width, pic3.size.height);
    
    
    CGSize contentSize = CGSizeMake(pic1.size.width + pic2.size.width + pic3.size.width, pic1.size.height);
        NSLog(@"Contentsize ME: %f", contentSize.width);
        NSLog(@"Contentsize ME: %f", contentSize.height);
    [self.imageScrollView setContentSize:contentSize];
    [self.imageScrollView addSubview:one];
    [self.imageScrollView addSubview:two];
    [self.imageScrollView addSubview:three];
}

- (void)viewDidLoad
{
    DatabaseManager *databaseManager = [DatabaseManager sharedInstance];
    
    if ([databaseManager.exhibits objectForKey:_textQRCode] != nil) {
        _textviewQRCode.text = [databaseManager.exhibits objectForKey:_textQRCode];
    }
    
    self.imageScrollView.delegate = self;
    //[self addImages];
    [self lazyLoadImagesToScrollView:self.imageScrollView];
    
    NSLog(@"CONTENTSIZE %f", self.imageScrollView.contentSize.width);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadVisiblePagesInScrollView:scrollView];
    NSLog(@"DID scroll");
}

- (void)lazyLoadImagesToScrollView:(UIScrollView *)scrollView {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        [array addObject:[UIImage imageNamed:@"pic1.png"]];
        [array addObject:[UIImage imageNamed:@"pic3.png"]];
    }
    self.pageImages = (NSArray *)array;
    
    //    self.pageImages = [NSArray arrayWithObjects:
    //                       [UIImage imageNamed:@"pic1.png"],
    //                       [UIImage imageNamed:@"pic2.png"],
    //                       [UIImage imageNamed:@"pic3.png"],
    //                       [UIImage imageNamed:@"pic2.png"],
    //                       nil];
    NSInteger pageCount = self.pageImages.count;
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    for (UIImage *image in self.pageImages) {
        self.contentSize = CGSizeMake(self.contentSize.width + image.size.width, image.size.height);
    }
    
    self.imageScrollView.contentSize = CGSizeMake(0.0f, 0.0f);
    self.imageScrollView.contentSize = self.contentSize;
    
    NSLog(@"Contentsize REijo: %f", self.contentSize.width);
    NSLog(@"Contentsize REijo: %f", self.contentSize.height);
    [self loadVisiblePagesInScrollView:scrollView];
}

- (void)loadVisiblePagesInScrollView:(UIScrollView *)scrollView {
    //Checking the scrollView:
    NSInteger visiblePages;
    NSMutableArray *viewArray;
    NSArray *imageArray;
    if (scrollView == self.imageScrollView) {
        visiblePages = 2;
        viewArray = self.pageViews;
        imageArray = self.pageImages;
    }
    
    // First, determine which page is currently visible
    CGFloat pageWidth = scrollView.frame.size.width;

    
    //BUG FIXED: multiplying by 2 due to the quantity of images visible
    NSInteger page = visiblePages * (NSInteger)floor((scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    NSLog(@"CUREENT PAGE: %ld", (long)page);
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 3;
    NSInteger lastPage = page + 3;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i inArray:imageArray fromViewArray:viewArray];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i fromArray:imageArray toViewArray:viewArray];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage; i<self.pageImages.count; i++) {
        [self purgePage:i inArray:imageArray fromViewArray:viewArray];
    }
}

- (void)loadPage:(NSInteger)page fromArray:(NSArray *)array toViewArray:(NSMutableArray *)viewArray {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // 1
    UIView *pageView = [viewArray objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        // 2
        UIImage *image = [array objectAtIndex:page];
        
        CGRect frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        
        CGFloat totalWidth = 0.0f;
        
        for (int i = 1; i <= page; i++) {
            UIImage *img = [array objectAtIndex:i];
            totalWidth += img.size.width;
        }

        
        frame.origin.x = totalWidth;
        
        // 3
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:image];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.imageScrollView addSubview:newPageView];
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
