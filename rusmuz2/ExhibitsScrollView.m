//
//  ExhibitsScrollView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 25/07/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitsScrollView.h"

@implementation ExhibitsScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self recenterIfNecessary];
}

- (void)recenterIfNecessary
{
    CGPoint currentOffset = self.contentOffset;
    CGFloat contentWidth = self.contentSize.width;
    CGFloat centerOffsetX = (contentWidth - self.bounds.size.width) / 2.0;
    CGFloat distanceFromCenter = fabsf(currentOffset.x - centerOffsetX);
    
    
    
    //if() adjust to taste
    if (distanceFromCenter > (contentWidth / 4.0)) {
        self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
        
        //move content by the same amount to make it look still
    }
}

@end
