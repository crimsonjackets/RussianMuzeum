//
//  PreviewScrollView.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 19/10/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitTappedDelegate.h"

@interface PreviewScrollView : UIScrollView

@property (nonatomic, assign) id <ExhibitTappedDelegate> exhibitTappedDelegate;

- (void)scrollToPage:(NSInteger)page;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;

@end
