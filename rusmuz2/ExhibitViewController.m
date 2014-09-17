//
//  QRViewController.m
//  rusmuz
//
//  Created by Richard Topchiy on 19/05/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitViewController.h"
#import "AppDelegate.h"

#import "ExhibitPreview.h"
#import "BlockView.h"
#import "ExhibitImageView.h"

#define PREVIEW_HEIGHT 146
#define BLOCK_WIDTH 28
#define BLOCK_HEIGHT 28

@interface ExhibitViewController ()

@property (nonatomic, strong) NSArray *previewsStorage;
@property (nonatomic, strong) NSMutableArray *previewsViews;

@property (nonatomic, strong) NSArray *blocksStorage;
@property (nonatomic, strong) NSMutableArray *blocksViews;

@property (nonatomic, strong) NSArray *picturesStorage;
@property (nonatomic, strong) NSArray *picturesInfo;
@property (nonatomic, strong) NSMutableArray *picturesViews;

@property (nonatomic, strong) NSArray *exhibitsStorage;
@property NSUInteger pageCount;

@end

@implementation ExhibitViewController


- (void)viewDidLoad
{
    NSLog(@"THIS STRING SHOULD APPEAR ONLY ONCE!!!");
    //Temporarily, just for debougage and design CHK
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.navigationButton.buttonKind = exhibitVC;
    self.navigationButton.delegate = self;
    
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    _exhibitsStorage = [self getExhibits];
    
    self.previewScrollView.delegate = self;
    self.blocksScrollView.delegate = self;
    self.pictureScrollView.delegate = self;
    
    //[self addImages];
    [self lazyLoadPreviews];
    [self lazyLoadBlocks];
    [self lazyLoadPictures];
    
    NSLog(@"RoomNumber IS:  %@", self.roomNumber);
    NSLog(@"QR is: %@", self.exhibitQRCode);
    NSLog(@"CONTENTSIZE %f", self.previewScrollView.contentSize.width);
}

- (void)lazyLoadPreviews {
    NSInteger pageCount = _pageCount * 2;
    self.previewsViews = [[NSMutableArray alloc] init];
    
    
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.previewsViews addObject:[NSNull null]];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    
    CGSize contentSize;
    CGSize size = CGSizeMake((screenWidth/2) * pageCount, PREVIEW_HEIGHT);
    self.previewScrollView.contentSize = size;
    
    NSLog(@"Contentsize REijo: %f", contentSize.width);
    NSLog(@"Contentsize REijo: %f", contentSize.height);
//    [self loadVisiblePagesInScrollView:self.previewScrollView];
    [self loadVisiblePreviews];
}


- (void)lazyLoadBlocks {
    //self.blocksStorage = [self getBlocks];
    
    NSInteger pageCount = _pageCount;
    self.blocksViews = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < pageCount; ++i) {
        //TODO POTENTIALLY CAN INITIALIZE HERE ALL THE BLOCKS WITHOUT LAZY LOADING
        [self.blocksViews addObject:[NSNull null]];
    }
    
    CGSize contentSize;
    contentSize.width = BLOCK_WIDTH * (_pageCount);
    contentSize.height = BLOCK_HEIGHT;
    
    self.blocksScrollView.contentSize = contentSize;
    
    NSLog(@"Contentsize REijo: %f", contentSize.width);
    NSLog(@"Contentsize REijo: %f", contentSize.height);

    for (int i = 0; i < _pageCount; i++) {
        UIView *pageView = [_blocksViews objectAtIndex:i];
        if ((NSNull*)pageView == [NSNull null]) {
            
            CGFloat totalWidth = BLOCK_WIDTH * i;
            
            BlockView *view = [[BlockView alloc] initWithImage:[UIImage imageNamed:@"block.png"]];
            
                        NSString *number = [NSString stringWithFormat:@"%ld", (long)i + 1];
            view.numberLabel.text = number;
            
            CGRect frame = CGRectMake(0, 0, BLOCK_WIDTH, BLOCK_HEIGHT);
            
            frame.origin.x = totalWidth;
            view.frame = frame;
            [self.blocksScrollView addSubview:view];
            // 4
            [_blocksViews replaceObjectAtIndex:i withObject:view];
            
            
            
        }
        
    }
}

- (void)lazyLoadPictures {
    NSInteger pageCount = _pageCount;
    self.picturesViews = [[NSMutableArray alloc] init];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGSize contentSize;
    contentSize.width = screenWidth * _pageCount;
    contentSize.height = self.pictureScrollView.frame.size.height;
    self.pictureScrollView.contentSize = contentSize;
    
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.picturesViews addObject:[NSNull null]];
    }
    

//    for (UIImage *image in self.picturesStorage) {
//        contentSize.width = contentSize.width + image.size.width;
//        //contentSize.height = image.size.height;
//
//    }
//    

    
    NSLog(@"Contentsize REijo: %f", contentSize.width);
    NSLog(@"Contentsize REijo: %f", contentSize.height);
    [self loadVisiblePictures];
}


#pragma mark - CoreData fetching
- (NSArray *)getExhibits {
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room.number == %@", self.roomNumber];
    request.predicate = predicate;
    NSError *error = nil;
    
    NSArray *fetchedExhibits = [context executeFetchRequest:request error:&error];
    
    _pageCount = fetchedExhibits.count;

    return fetchedExhibits;
}
/*
- (NSArray *)getImagesFromExhibits:(NSArray *)array {
    
}
 */
- (NSArray *)getPreviews {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        [array addObject:[UIImage imageNamed:@"pic1.png"]];
        [array addObject:[UIImage imageNamed:@"pic3.png"]];
    }
    return (NSArray *)array;
}

- (NSArray *)getBlocks {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<200; i++) {
        [array addObject:[UIImage imageNamed:@"block.png"]];
    }
    return (NSArray *)array;
}

- (NSArray *)getPictures {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *infoArray = [[NSMutableArray alloc] init];
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room.number == %@", self.roomNumber];
    request.predicate = predicate;
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
//    [self loadVisiblePagesInScrollView:scrollView];
    

    NSLog(@"DID scroll content offset: %f", scrollView.contentOffset.x);
    
    if (scrollView == self.previewScrollView) {
        static NSInteger previousPage = 0;
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (previousPage != page) {
            // Page has changed, do your thing!
            // ...
            // Finally, update previous page
            
            
            CGPoint offset = scrollView.contentOffset;
            offset.x = scrollView.frame.size.width * page;
            
            [self.pictureScrollView setContentOffset:offset animated:YES];
            previousPage = page;
            
            
            
            [self loadVisiblePreviews];
        }

    } else if (scrollView == self.blocksScrollView) {

        return;

    } else if (scrollView == self.pictureScrollView) {
        static NSInteger previousPage = 0;
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (previousPage != page) {
            // Page has changed, do your thing!
            // ...
            // Finally, update previous page
            
            
            CGPoint offset = scrollView.contentOffset;
            offset.x = scrollView.frame.size.width * page;
            
            [self.previewScrollView setContentOffset:offset animated:YES];
            previousPage = page;
            [self loadVisiblePictures];
        }


    }
    
}

- (void)loadVisiblePreviews {
    CGFloat pageWidth = _previewScrollView.frame.size.width;
    
    //BUG FIXED: multiplying by 2 due to the quantity of images visible
    NSInteger page = 2 * (NSInteger)floor((_previewScrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    NSLog(@"CUREENT PAGE: %ld", (long)page);
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 3;
    NSInteger lastPage = page + 3;
    
    NSLog(@"first page: %ld", (long)firstPage);
    NSLog(@"last page: %ld", (long)lastPage);
    
    
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePreview:i];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        //[self loadPage:i fromArray:storageArray toViewArray:viewArray andScrollView:scrollView];
        [self loadPreview:i];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage; i<self.previewsStorage.count; i++) {
        [self purgePreview:i];
    }
}

- (void)loadPreview:(NSInteger)page {
    NSLog(@"PREVIEW PAGE IS : %ld", (long)page);
    if (page < 0 || page >= _previewsViews.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // 1
    UIView *pageView = [_previewsViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        Exhibit *exhibit = [_exhibitsStorage objectAtIndex:page];
        UIImage *image = [UIImage imageWithData:exhibit.picture scale:2];
        
        ExhibitPreview *newExhibitPreview =[[ExhibitPreview alloc] initWithImage:image];
        
        NSString *number = [NSString stringWithFormat:@"%ld", (long)page + 1];
        newExhibitPreview.number.text = number;
        newExhibitPreview.author.text = exhibit.author;
        newExhibitPreview.title.text = exhibit.name;
        
        
        newExhibitPreview.contentMode = UIViewContentModeScaleAspectFill;
        newExhibitPreview.clipsToBounds = YES;
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat totalWidth = 0.0f;
        totalWidth = (page) * (screenWidth/2);
        
        CGRect frame = CGRectMake(0.0f, 0.0f, screenWidth/2, PREVIEW_HEIGHT);
        frame.origin.x = totalWidth;
        newExhibitPreview.frame = frame;
        
        [_previewScrollView addSubview:newExhibitPreview];
        [_previewsViews replaceObjectAtIndex:page withObject:newExhibitPreview];
        
        NSLog(@"TW preview: %f", totalWidth);
    }
}

- (void)purgePreview:(NSInteger)page {
    if (page < 0 || page >= _previewsViews.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [_previewsViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [_previewsViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
    
}

- (void)loadVisiblePictures {

    NSMutableArray *viewArray;
    NSArray *storageArray;
    

    viewArray = self.picturesViews;
    storageArray = self.picturesStorage;
    
    
    
    // First, determine which page is currently visible
    CGFloat pageWidth = _pictureScrollView.frame.size.width;
    
    
    //BUG FIXED: multiplying by 2 due to the quantity of images visible
    NSInteger page = (NSInteger)floor((_pictureScrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    NSLog(@"CUREENT PAGE: %ld", (long)page);
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 2;
    NSInteger lastPage = page + 2;
    
    
    NSLog(@"first page: %ld", (long)firstPage);
    NSLog(@"last page: %ld", (long)lastPage);
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePicture:i];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        //[self loadPage:i fromArray:storageArray toViewArray:viewArray andScrollView:scrollView];
        [self loadPicture:i];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage; i<self.previewsStorage.count; i++) {
        [self purgePicture:i];
    }
    
}

- (void)loadPicture:(NSInteger)page  {
    if (page < 0 || page >= _pageCount) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    UIView *pageView = [_picturesViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        Exhibit *exhibit = [_exhibitsStorage objectAtIndex:page];
        UIImage *image = [UIImage imageWithData:exhibit.picture scale:2];
        
        ExhibitImageView *newExhibitImageView = [[ExhibitImageView alloc] initWithImage:image];
        NSString *number = [NSString stringWithFormat:@"%ld", (long)page + 1];
        newExhibitImageView.number.text = number;
        newExhibitImageView.author.text = exhibit.author;
        newExhibitImageView.info.text = exhibit.info;
        
        
        
        CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat totalWidth = page * screenWidth;
        frame.origin.x = totalWidth;
        newExhibitImageView.frame = frame;

        [_pictureScrollView addSubview:newExhibitImageView];
        // 4
        [_picturesViews replaceObjectAtIndex:page withObject:newExhibitImageView];
    }
}

- (void)purgePicture:(NSInteger)page {
    if (page < 0 || page >= _picturesViews.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [_picturesViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [_picturesViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
    
}
/*
- (void)loadVisiblePagesInScrollView:(UIScrollView *)scrollView {
    //Checking the scrollView:
    NSInteger visiblePages;
    NSMutableArray *viewArray;
    NSArray *storageArray;
    
    if (scrollView == self.previewScrollView) {
        visiblePages = 2;
        viewArray = self.previewsViews;
        storageArray = self.previewsStorage;
        return;
    }
    
    else if (scrollView == self.pictureScrollView) {
        visiblePages = 1;
        viewArray = self.picturesViews;
        storageArray = self.picturesStorage;
    } else {
        return;
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
        //[self loadPage:i fromArray:storageArray toViewArray:viewArray andScrollView:scrollView];
        [self loadPage:i ToScrollView:scrollView];
    }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage; i<self.previewsStorage.count; i++) {
        [self purgePage:i inArray:storageArray fromViewArray:viewArray];
    }
}





- (void)loadPage:(NSInteger)page ToScrollView:(UIScrollView *)scrollView {
    if (page < 0 || page >= _pageCount) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    NSMutableArray *viewArray;
    if (scrollView == _previewScrollView) {
        viewArray = _previewsViews;
    } else if(scrollView == _pictureScrollView) {
        viewArray = _picturesViews;
    } else if (scrollView == _blocksScrollView) {
        viewArray = _blocksViews;
    }
    
        UIView *pageView = [viewArray objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {

        CGRect frame;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        CGFloat totalWidth = 0.0f;
        
        UIView *newPageView;
        Exhibit *exhibit = [_exhibitsStorage objectAtIndex:page];
        UIImage *image = [UIImage imageWithData:exhibit.picture scale:2];
        
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        if (scrollView == self.previewScrollView) {
            frame = CGRectMake(0.0f, 0.0f, screenWidth/2, PREVIEW_HEIGHT);
        } else if(scrollView == self.pictureScrollView) {
            //frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
            frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }

        
        if (scrollView == self.previewScrollView) {
            newPageView = [[ExhibitPreview alloc] initWithImage:image];
            newPageView.contentMode = UIViewContentModeScaleAspectFill;
            ExhibitPreview *newExhibitPreview = (ExhibitPreview *)newPageView;
            NSString *number = [NSString stringWithFormat:@"%ld", (long)page + 1];
            newExhibitPreview.number.text = number;
            newExhibitPreview.author.text = exhibit.author;
            newExhibitPreview.title.text = exhibit.name;
        } else if (scrollView == self.blocksScrollView) {

            NSLog(@"I WANT TO LOAD BLOCK!!!");
        } else if (scrollView == self.pictureScrollView){
            newPageView = [[ExhibitImageView alloc] initWithImage:image];
            ExhibitImageView *newExhibitImageView = (ExhibitImageView *)newPageView;
            NSString *number = [NSString stringWithFormat:@"%ld", (long)page + 1];
            newExhibitImageView.number.text = number;
            newExhibitImageView.author.text = exhibit.author;
            newExhibitImageView.info.text = exhibit.info;
            
            
        }

        totalWidth = (page) * screenWidth;
        
        if (scrollView == self.previewScrollView) {
            totalWidth = totalWidth/2;
            newPageView.clipsToBounds = YES;
            NSLog(@"TW preview: %f", totalWidth);
        }


        
        frame.origin.x = totalWidth;
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
*/

- (UIView *)blackViewWithFrame:(CGRect)frame {
    UIView *blackView = [[UIView alloc] initWithFrame:frame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    return blackView;
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
    InteractiveMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InteractiveMapViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
