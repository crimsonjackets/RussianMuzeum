//
//  ExhibitsScrollView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 25/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "PictureScrollView.h"

@implementation PictureScrollView

- (void)scrollToPage:(NSInteger)page {
    CGPoint contentOffset = CGPointZero;
    contentOffset.x = page * self.frame.size.width;
    [self setContentOffset:contentOffset animated:YES];
}


@end
