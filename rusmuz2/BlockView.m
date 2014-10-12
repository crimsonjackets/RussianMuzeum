//
//  BlockView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 31/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "BlockView.h"

#define DESELECTED_BLOCK_ALPHA 0.3f

@implementation BlockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.numberLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.numberLabel setTextColor:[UIColor whiteColor]];
        [self.numberLabel setBackgroundColor:[UIColor clearColor]];
        [self.numberLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 14.0f]];
        self.numberLabel.numberOfLines = 0;
        self.numberLabel.textAlignment = NSTextAlignmentCenter;

        self.alpha = DESELECTED_BLOCK_ALPHA;

        [self addSubview:self.numberLabel];
        
    }
    return self;
}


- (void)setSelected:(BOOL)active {
    self.alpha = active ? 1.0f : DESELECTED_BLOCK_ALPHA;
}

@end
