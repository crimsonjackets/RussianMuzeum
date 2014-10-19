//
//  PreviewScrollView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 19/10/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "PreviewScrollView.h"
#import "ExhibitPreview.h"

@implementation PreviewScrollView

- (void)scrollToPage:(NSInteger)page {
    CGPoint contentOffset = CGPointZero;
    contentOffset.x = page * self.frame.size.width;
    [self setContentOffset:contentOffset animated:NO];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    ExhibitPreview *view = (ExhibitPreview *)recognizer.view;
    NSInteger number = view.tag;
    [self.exhibitTappedDelegate exhibitSelected:number];
    NSLog(@"aaaaaaa");
}

@end
