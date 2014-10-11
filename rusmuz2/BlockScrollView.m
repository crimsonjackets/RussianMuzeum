//
//  BlockScrollView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 11/10/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "BlockScrollView.h"

#define BLOCK_WIDTH 28
#define BLOCK_HEIGHT 28

@implementation BlockScrollView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSInteger numberOfBlocks = 20000;
        CGSize contentSize;
        contentSize.width = BLOCK_WIDTH * (numberOfBlocks);
        contentSize.height = BLOCK_HEIGHT;
        
        self.contentSize = contentSize;
        
        for (int i = 0; i < numberOfBlocks; i++) {
            CGFloat totalWidth = BLOCK_WIDTH * i;
            
            BlockView *view = [[BlockView alloc] initWithImage:[UIImage imageNamed:@"block.png"]];
            
            NSString *number = [NSString stringWithFormat:@"%ld", (long)i + 1];
            view.numberLabel.text = number;
            
            CGRect frame = CGRectMake(0, 0, BLOCK_WIDTH, BLOCK_HEIGHT);
            
            frame.origin.x = totalWidth;
            view.frame = frame;
            [self addSubview:view];
        }
    }
    return self;
}

@end
