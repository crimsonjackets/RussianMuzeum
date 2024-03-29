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

@interface BlockScrollView ()
@property (strong, nonatomic) NSMutableArray *blocks;

@property (nonatomic) CGFloat minContentOffsetNormalized;
@property (nonatomic) CGFloat maxContentOffsetNormalized;
@end


@implementation BlockScrollView


- (void)setNumberOfBlocks:(NSInteger)numberOfBlocks {
    _numberOfBlocks = numberOfBlocks;
    
    _blocks = [[NSMutableArray alloc] init];
    
    CGSize contentSize;
    contentSize.width = BLOCK_WIDTH * (numberOfBlocks);
    contentSize.height = BLOCK_HEIGHT;
    
    self.contentSize = contentSize;
    
    for (int i = 0; i < numberOfBlocks; i++) {
        CGFloat totalWidth = BLOCK_WIDTH * i;
        CGRect frame = CGRectMake(0, 0, BLOCK_WIDTH, BLOCK_HEIGHT);
        
        frame.origin.x = totalWidth;
        
        BlockView *view = [[BlockView alloc] initWithFrame:frame];
        
        view.frame = frame;
        NSString *number = [NSString stringWithFormat:@"%ld", (long)i + 1];
        view.numberLabel.text = number;
        view.tag = i;
        
        [self addSubview:view];
        [_blocks addObject:view];
        
        UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:recognizer];
    }
    _minContentOffsetNormalized = (BLOCK_WIDTH * 6 - 22) / contentSize.width;
    _maxContentOffsetNormalized = (contentSize.width - (BLOCK_WIDTH * 6 + 5)) / contentSize.width;
}

 - (void)setSelectedViewNumber:(NSInteger)selectedViewNumber {
 for (int i = 0; i < selectedViewNumber; i++) {
 BlockView *blockView = _blocks[i];
 blockView.selected = NO;
 }
 
 BlockView *blockView = _blocks[selectedViewNumber];
 blockView.selected = YES;
 
 for (int i = selectedViewNumber + 1; i < _blocks.count; i++) {
 BlockView *blockView = _blocks[i];
 blockView.selected = NO;
 }

 if (selectedViewNumber <= 5) {


 } else if ((selectedViewNumber > 5) && (selectedViewNumber < (_numberOfBlocks - 6))) {

 
 } else if (selectedViewNumber > _numberOfBlocks - 6) {


 }
 
 }


- (void)scrollToContentOffsetNormalized:(CGFloat)contentOffsetNormalized animated:(BOOL)animated {
    if (contentOffsetNormalized < _minContentOffsetNormalized) {
        [self setContentOffset:CGPointZero animated:animated];
    } else if (contentOffsetNormalized > _maxContentOffsetNormalized) {
        CGPoint maxContentOffset = [self contentOffsetFromNormalized:_maxContentOffsetNormalized];
        [self setContentOffset:maxContentOffset animated:animated];
    } else {
        [self setContentOffset:[self contentOffsetFromNormalized:contentOffsetNormalized] animated:animated];
    }
}

- (CGPoint)contentOffsetFromNormalized:(CGFloat)contentOffsetNormalized {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGPoint contentOffset = CGPointMake(contentOffsetNormalized * self.contentSize.width - (screenWidth - BLOCK_WIDTH) / 2, 0);
    return contentOffset;
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    BlockView *view = (BlockView *)recognizer.view;
    NSInteger number = view.tag;
    [self.exhibitTappedDelegate exhibitSelected:number];
}

@end
