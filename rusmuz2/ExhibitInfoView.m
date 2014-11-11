//
//  ExhibitInfoView.m
//  RussianMuseum
//
//  Created by Richard Topchiy on 11/11/14.
//  Copyright (c) 2014 Richard Topchiy. All rights reserved.
//

#import "ExhibitInfoView.h"

@implementation ExhibitInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.liveBlurring = NO;
        self.blurRadius = 6.0f;
        self.alpha = 0.0f;
    }
    return self;
}

- (void)animateIn {
    [self animateBlurViewIn];
    [self animateTextViewIn];
}

- (void)animateOut {
        self.liveBlurring = YES;
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

- (void)animateBlurViewIn {
    self.liveBlurring = YES;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.liveBlurring = NO;
    }];
}

- (void)animateTextViewIn {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, self.bounds.size.width, 20)];
    [title setTextColor:[UIColor whiteColor]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName: @"Helvetica Neue" size: 24.0f]];
    title.lineBreakMode = NSLineBreakByWordWrapping;
    //title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    title.text = _title;
    [self addSubview:title];
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, self.bounds.size.width, 20)];
    [author setTextColor:[UIColor whiteColor]];
    [author setBackgroundColor:[UIColor clearColor]];
    [author setFont:[UIFont fontWithName: @"Helvetica Neue" size: 16.0f]];
    author.numberOfLines = 0;
    author.textAlignment = NSTextAlignmentCenter;
    author.text = _author;
    [self addSubview:author];
    
    
    UITextView *textview = [[UITextView alloc] initWithFrame:self.bounds];
    textview.text = _info;
    [textview setCenter:CGPointMake(textview.center.x, author.center.y + author.frame.size.height + textview.frame.size.height/2)];
    textview.backgroundColor = [UIColor clearColor];
    textview.textColor = [UIColor whiteColor];
    [self addSubview:textview];
}

@end
