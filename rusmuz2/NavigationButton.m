//
//  NavigationButton.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 04/08/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "NavigationButton.h"

@implementation NavigationButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(didTouchButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



- (void)awakeFromNib {
    NSLog(@"Yeah, it self!!!");
    [self addTarget:self action:@selector(didTouchButton) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.5 animations:^{
        NSLog(@"Animation");
    }completion:^(BOOL finished) {
    }];
}


- (void)didTouchButton {
    NSLog(@"YEAH, it works, baby!");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
