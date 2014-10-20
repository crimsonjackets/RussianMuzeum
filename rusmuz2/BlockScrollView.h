//
//  BlockScrollView.h
//  RussianMuseum
//
//  Created by Richard Topchiy on 11/10/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockView.h"

#import "ExhibitTappedDelegate.h"

@interface BlockScrollView : UIScrollView

@property (nonatomic) NSInteger numberOfBlocks;
@property (nonatomic) NSInteger selectedViewNumber;

@property (nonatomic, assign) id <ExhibitTappedDelegate> exhibitTappedDelegate;

- (void)scrollToContentOffsetNormalized:(CGFloat)contentOffsetNormalized animated:(BOOL)animated;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;

@end
