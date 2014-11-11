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
#import <MediaPlayer/MediaPlayer.h>

#define PREVIEW_HEIGHT 146


@interface ExhibitViewController ()


@property (nonatomic, strong) NSMutableArray *previewsViews;
@property (nonatomic, strong) NSMutableArray *previewsCopies;

@property (nonatomic, strong) NSMutableArray *blocksViews;

@property (nonatomic, strong) NSArray *picturesInfo;
@property (nonatomic, strong) NSMutableArray *picturesViews;

@property (nonatomic, strong) NSArray *exhibitsStorage;

@property (nonatomic) LFGlassView *blurView;

@property NSUInteger pageCount;
@property NSUInteger currentPage;
@property (nonatomic) CGFloat contentOffsetNormalized;
@property (nonatomic) BOOL userInteractionEnabled;

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
 
    self.previewScrollView.exhibitTappedDelegate = self;
    self.blocksScrollView.exhibitTappedDelegate = self;
    
    [self setUserInteractionEnabled:YES];

    [self lazyLoadPreviews];

    _blocksScrollView.numberOfBlocks = _pageCount;

    [self lazyLoadPictures];
    
    NSLog(@"RoomNumber IS:  %@", self.roomNumber);
    NSLog(@"QR is: %@", self.exhibitQRCode);
    NSLog(@"CONTENTSIZE %f", self.previewScrollView.contentSize.width);
}

- (void)lazyLoadPreviews {
    NSInteger pageCount = _pageCount;
    _previewsViews = [[NSMutableArray alloc] init];


    
    for (NSInteger i = 0; i < pageCount * 2; ++i) {

        [_previewsViews addObject:[NSNull null]];
        [_previewsCopies addObject:[NSNull null]];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    
    CGSize contentSize;
    CGSize size = CGSizeMake(screenWidth * pageCount, PREVIEW_HEIGHT);
    self.previewScrollView.contentSize = size;
    
    NSLog(@"Contentsize REijo: %f", contentSize.width);
    NSLog(@"Contentsize REijo: %f", contentSize.height);

    //[self loadVisiblePreviews];
    [self loadAllPreviews];
}

- (void)loadAllPreviews {
    for (NSInteger i=0; i<=_pageCount; i++) {
        [self loadPreviewScreen:i];
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

    //[self loadVisiblePictures];
    [self loadAllPictures];
}

- (void)loadAllPictures {
    for (NSInteger i=0; i<=_pageCount; i++) {
        [self loadPicture:i];
    }
}


#pragma mark - CoreData fetching
- (NSArray *)getExhibits {
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exhibit"];
    request.fetchBatchSize = 5;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room.number == %@", self.roomNumber];
    request.predicate = predicate;
    NSError *error = nil;
    
    NSArray *fetchedExhibits = [context executeFetchRequest:request error:&error];
    
    _pageCount = fetchedExhibits.count;

    return fetchedExhibits;
}


#pragma mark - Scrolling Engine

/*
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == _previewScrollView) {

            [self loadVisiblePreviews];
        
        

    } else if (scrollView == self.pictureScrollView) {

            
                    [self loadVisiblePictures];

    }
}
 
 
*/

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == _previewScrollView) {
        NSLog(@"PreviewScrollVeiw ENDED ANIMATION");
    } else if (scrollView == _pictureScrollView) {
        NSLog(@"PICTURE SCR VIEW ENDED ANIMATION");
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
/*
    if (scrollView == self.previewScrollView) {
        static NSInteger previousPage = 0;
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (previousPage != page) {

            CGPoint offset = scrollView.contentOffset;
            offset.x = scrollView.frame.size.width * page;

            [self.pictureScrollView setContentOffset:offset animated:YES];
            previousPage = page;
            
        }
        
    } else if (scrollView == self.blocksScrollView) {
        
        return;
        
    } else if (scrollView == self.pictureScrollView) {

        static NSInteger previousPage = 0;
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (previousPage != page) {

            CGPoint offset = scrollView.contentOffset;
            offset.x = scrollView.frame.size.width * page;
            
            [self.previewScrollView setContentOffset:offset animated:YES];
            [_blocksScrollView setSelectedViewNumber:page];
            previousPage = page;

        }
        
        [_blocksScrollView scrollToContentOffsetNormalized:self.contentOffsetNormalized animated:NO];
    }
  */

    if (scrollView == self.pictureScrollView) {
        
        static NSInteger previousPage = 0;
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (previousPage != page) {
            
            CGPoint offset = scrollView.contentOffset;
            offset.x = scrollView.frame.size.width * page;
            
            //[self.previewScrollView setContentOffset:offset animated:YES];
            [_blocksScrollView setSelectedViewNumber:page];
            _currentPage = page;
            previousPage = page;
        }
        [_previewScrollView setContentOffset:self.pictureScrollView.contentOffset animated:NO];
        [_blocksScrollView scrollToContentOffsetNormalized:self.contentOffsetNormalized animated:NO];
    }
}

- (CGFloat)contentOffsetNormalized {
    CGFloat offsetX = _pictureScrollView.contentOffset.x;
    CGFloat contentWidth = _pictureScrollView.contentSize.width;
    CGFloat normalized = offsetX / contentWidth;
            NSLog(@"ContentOffset Normalized: %f", normalized);
    return normalized;
}

- (void)loadVisiblePreviews {
    CGFloat pageWidth = _previewScrollView.frame.size.width;
    
    //BUG FIXED: multiplying by 2 due to the quantity of images visible
    NSInteger page = (NSInteger)floor((_previewScrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    NSLog(@"CUREENT PAGE PREVIEWS: %ld", (long)page);
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 2;
    NSInteger lastPage = page + 2;
    
    NSLog(@"first page: %ld", (long)firstPage);
    NSLog(@"last page: %ld", (long)lastPage);
    
    
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        //[self purgePreview:i];
    }
    
	// Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        //[self loadPage:i fromArray:storageArray toViewArray:viewArray andScrollView:scrollView];
        [self loadPreviewScreen:i];
    
    
 }
    
	// Purge anything after the last page
    for (NSInteger i=lastPage; i<_pageCount; i++) {
        //[self purgePreview:i];
    }
}


- (void)loadPreviewScreen:(NSInteger)screen {
    if (screen < 0 || screen >= _pageCount) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    NSInteger previous = screen - 1;
    NSInteger next = screen + 1;
    
    //[self loadPreview:previous];
    //[self loadPreview:next];
    
    if (!(previous < 0 || previous >= _pageCount)) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat totalWidth = screen * screenWidth;
        
        
        ExhibitPreview *exhibitPreview =  [_previewsViews objectAtIndex:previous];
        //            ExhibitPreview *exhibitPreviewCopy =  [_previewsCopies objectAtIndex:previous];
        
        if ((NSNull*)exhibitPreview == [NSNull null]) {
            Exhibit *exhibit = [_exhibitsStorage objectAtIndex:previous];
            ExhibitPreview *exhibitPreview = [[ExhibitPreview alloc] initWithExhibit:exhibit];
            
                    NSURL *url = [NSURL URLWithString:@"http://spbfoto.spb.ru/foto/data/media/1/rusmus.jpg"];
            [exhibitPreview setImageWithURL:url];
            
            NSLog(@"Exhibit named: is previewd: %@", exhibit.name);
            
            NSString *number = [NSString stringWithFormat:@"%ld", (long)previous + 1];
            exhibitPreview.number.text = number;
            
            exhibitPreview.tag = previous;
            
            CGRect frame = exhibitPreview.frame;
            frame.origin.x = totalWidth;
            exhibitPreview.frame = frame;
            [_previewsViews replaceObjectAtIndex:previous withObject:exhibitPreview];
            
            [_previewScrollView addSubview:exhibitPreview];
            
            UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            recognizer.delegate = self;
            recognizer.cancelsTouchesInView = NO;
            [exhibitPreview addGestureRecognizer:recognizer];
            
        } else if (exhibitPreview.frame.origin.x != totalWidth) {
            ExhibitPreview *copiedPreview = [exhibitPreview copy];
            
            NSURL *url = [NSURL URLWithString:@"http://spbfoto.spb.ru/foto/data/media/1/rusmus.jpg"];
            [copiedPreview setImageWithURL:url];
            
            CGRect frame = exhibitPreview.frame;
            frame.origin.x = totalWidth;
            copiedPreview.frame = frame;
            
            [_previewScrollView addSubview:copiedPreview];
            
            copiedPreview.tag = previous;
            
            UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            recognizer.delegate = self;
            recognizer.cancelsTouchesInView = NO;
            [copiedPreview addGestureRecognizer:recognizer];
        }
        
    }


    
    if (!(next < 0 || next >= _pageCount)) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat totalWidth = screen * screenWidth + screenWidth/2;
        
        ExhibitPreview *exhibitPreview = [_previewsViews objectAtIndex:next];
        if ((NSNull*)exhibitPreview == [NSNull null]) {
            
            Exhibit *exhibit = [_exhibitsStorage objectAtIndex:next];
            
            ExhibitPreview *exhibitPreview = [[ExhibitPreview alloc] initWithExhibit:exhibit];
            
            NSURL *url = [NSURL URLWithString:@"http://spbfoto.spb.ru/foto/data/media/1/rusmus.jpg"];
            [exhibitPreview setImageWithURL:url];
            
            NSLog(@"Exhibit named: is previewd: %@", exhibit.name);
            
            NSString *number = [NSString stringWithFormat:@"%ld", (long)next + 1];
            exhibitPreview.number.text = number;
            
            exhibitPreview.tag = next;
            
            
            CGRect frame = exhibitPreview.frame;
            frame.origin.x = totalWidth;
            exhibitPreview.frame = frame;
            [_previewsViews replaceObjectAtIndex:next withObject:exhibitPreview];
            
            [_previewScrollView addSubview:exhibitPreview];
            
            UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            recognizer.delegate = self;
            recognizer.cancelsTouchesInView = NO;
            [exhibitPreview addGestureRecognizer:recognizer];
            
        } else if (exhibitPreview.frame.origin.x != totalWidth) {
            ExhibitPreview *copiedPreview = [exhibitPreview copy];
            
            NSURL *url = [NSURL URLWithString:@"http://spbfoto.spb.ru/foto/data/media/1/rusmus.jpg"];
            [copiedPreview setImageWithURL:url];
            
            CGRect frame = exhibitPreview.frame;
            frame.origin.x = totalWidth;
            copiedPreview.frame = frame;
            
            [_previewScrollView addSubview:copiedPreview];
            
            copiedPreview.tag = next;
            
            UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            recognizer.delegate = self;
            recognizer.cancelsTouchesInView = NO;
            [copiedPreview addGestureRecognizer:recognizer];
        }
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
    for (NSInteger i=lastPage; i<_pageCount; i++) {
        [self purgePicture:i];
    }
    
}
/*
- (void)loadPicture:(NSInteger)page  {
    if (page < 0 || page >= _pageCount) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    UIView *pageView = [_picturesViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        Exhibit *exhibit = [_exhibitsStorage objectAtIndex:page];
        
        UIImage *image = [UIImage imageWithData:exhibit.picture scale:2];
        
        //ExhibitImageView *newExhibitImageView = [[ExhibitImageView alloc] initWithImage:image];
        
        ExhibitImageView *newExhibitImageView = [[ExhibitImageView alloc] initWithFrame:_pictureScrollView.bounds];
        //newExhibitImageView.image = image;

        newExhibitImageView.image = image;
        NSString *number = [NSString stringWithFormat:@"%ld", (long)page + 1];
        //newExhibitImageView.number.text = number;
        newExhibitImageView.title.text = exhibit.name;
        newExhibitImageView.author.text = exhibit.author;
        //newExhibitImageView.info.text = exhibit.info;
        newExhibitImageView.videoButton.tag = page + 1;
        newExhibitImageView.userInteractionEnabled = YES;
        [newExhibitImageView.videoButton addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        
        CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat totalWidth = page * screenWidth;
        frame.origin.x = totalWidth;
        newExhibitImageView.frame = frame;

        [_pictureScrollView addSubview:newExhibitImageView];

        [_picturesViews replaceObjectAtIndex:page withObject:newExhibitImageView];
    }
}
 */


- (void)loadPicture:(NSInteger)page  {
    if (page < 0 || page >= _pageCount) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    UIView *pageView = [_picturesViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        Exhibit *exhibit = [_exhibitsStorage objectAtIndex:page];
        
        //ExhibitImageView *newExhibitImageView = [[ExhibitImageView alloc] initWithImage:image];
        
        ExhibitImageView *newExhibitImageView = [[ExhibitImageView alloc] initWithFrame:_pictureScrollView.bounds];

        
        NSURL *url = [NSURL URLWithString:exhibit.photoURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholderImage"];
        newExhibitImageView.exhibitTappedDelegate = self;
        
/*
        __weak ExhibitImageView *weakExhibitImageView = newExhibitImageView;
        
        [newExhibitImageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            weakExhibitImageView.image = image;
            [weakExhibitImageView setNeedsLayout];
            [weakExhibitImageView setContentMode:UIViewContentModeScaleAspectFill];
        } failure:nil];

        */
       [newExhibitImageView setImageWithURL:url];

        newExhibitImageView.number = page;
        newExhibitImageView.title.text = exhibit.name;
        newExhibitImageView.author.text = exhibit.author;
        //newExhibitImageView.info.text = exhibit.info;
        
 
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
               CGRect frame = CGRectMake(0, 0, screenWidth, screenRect.size.height);
        CGFloat totalWidth = page * screenWidth;
        frame.origin.x = totalWidth;
        newExhibitImageView.frame = frame;
        
        [_pictureScrollView addSubview:newExhibitImageView];
        
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


#pragma mark Navigating the Exhibit Views

- (void)exhibitSelected:(NSInteger)exhibitNumber {
    NSLog(@"EXHIBIT SELECTED: %ld", (long)exhibitNumber);
    [_blocksScrollView setSelectedViewNumber:exhibitNumber];
    
    CGFloat contentOffsetNormalized = (CGFloat)exhibitNumber / (CGFloat)_pageCount;
    //[_blocksScrollView scrollToContentOffsetNormalized:contentOffsetNormalized animated:YES];
    
    //[_previewScrollView scrollToPage:exhib≈≈itNumber];
    [_pictureScrollView scrollToPage:exhibitNumber];
}


- (void)exhibitInfoButtonPressed:(UIButton *)button {
    NSLog(@"Exhibit info button pressed %ld", (long)button.tag);
//    [self showDismissButton];

    [self letsTry];
}

- (void)letsTry {
    Exhibit *exhibit = _exhibitsStorage[_currentPage];
    ExhibitInfoView *view = [[ExhibitInfoView alloc] initWithFrame:self.view.bounds];
    view.title = exhibit.name;
    view.author = exhibit.author;
    view.info = exhibit.info;
    
    [self.view addSubview:view];
    [view animateIn];
    [self showDismissButton];
}


- (void)showDismissButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(dismissInfoPage:)
     forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage imageNamed:@"closeIcon"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGRect frame = CGRectMake(screenWidth - 50, -10, 0, 0);
    frame.size = image.size;
    button.frame = frame;
    button.alpha = 0.0f;
    [self.view addSubview:button];
    
    frame.origin.y = 50;
    
    [UIView animateWithDuration:0.3f animations:^{
        button.alpha = 1.0f;
        button.frame = frame;
    }];
    
    
    
}

- (void)dismissInfoPage:(UIButton *)button {
    CGRect frame = button.frame;
    frame.origin.y = -10;
    [UIView animateWithDuration:0.3f animations:^{
        button.alpha = 0.0f;
        button.frame = frame;
        _blurView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [button removeFromSuperview];
        [_blurView removeFromSuperview];
    }];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    ExhibitPreview *view = (ExhibitPreview *)recognizer.view;
    NSInteger number = view.tag;
//    [self.exhibitTappedDelegate exhibitSelected:number];
    [self exhibitSelected:number];

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

- (void)sponsorButtonPressed {
    FloorSelectorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SponsorViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
@end
